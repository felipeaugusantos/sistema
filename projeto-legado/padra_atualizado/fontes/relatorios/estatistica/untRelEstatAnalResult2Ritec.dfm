inherited frmRelEstatAnalResult2Ritec: TfrmRelEstatAnalResult2Ritec
  Left = 293
  Top = 187
  Width = 560
  Height = 659
  Caption = 'Relat'#243'rio de Analise de Resultado (Contas a Pagar) / DRE'
  OnDestroy = FormDestroy
  ExplicitWidth = 560
  ExplicitHeight = 659
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 586
    Width = 554
    ExplicitTop = 586
    ExplicitWidth = 554
    inherited FlwBotoes: TFlowPanel
      Width = 473
      ExplicitTop = 2
      ExplicitWidth = 473
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 475
      ExplicitLeft = 475
    end
  end
  inherited pnlDados: TPanel
    Width = 554
    Height = 586
    ExplicitWidth = 554
    ExplicitHeight = 586
    object Label4: TLabel [0]
      Left = 279
      Top = 3
      Width = 97
      Height = 14
      Caption = 'Empresas opcionais'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [1]
      Left = 98
      Top = 21
      Width = 58
      Height = 14
      Caption = '(ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel [2]
      Left = 98
      Top = 59
      Width = 58
      Height = 14
      Caption = '(ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDataFin: TLabel [3]
      Left = 8
      Top = 41
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
    object lblDataIni: TLabel [4]
      Left = 8
      Top = 3
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
    object Label2: TLabel [5]
      Left = 501
      Top = 3
      Width = 39
      Height = 14
      Cursor = crHandPoint
      Caption = 'Sele'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label2Click
    end
    object lblPreCus: TLabel [6]
      Left = 9
      Top = 564
      Width = 282
      Height = 15
      Caption = 'Pre'#231'o utilizado na se'#231#227'o "Estoque": Pre'#231'o de Custo'
      Font.Charset = ANSI_CHARSET
      Font.Color = 6711039
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object rdgEmpresa: TRadioGroup [7]
      Left = 8
      Top = 265
      Width = 265
      Height = 45
      Caption = 'Empresa'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Faturamento'
        'Origem')
      TabOrder = 6
    end
    object rdgTipOri: TRadioGroup [8]
      Left = 8
      Top = 193
      Width = 265
      Height = 35
      Caption = 'Tipo Orienta'#231#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Distribu'#237'do'
        'Consolidado')
      TabOrder = 4
      OnClick = rdgOrientacaoClick
    end
    object rdgOrientacao: TRadioGroup [9]
      Left = 8
      Top = 229
      Width = 265
      Height = 35
      Caption = 'Orienta'#231#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Retrato'
        'Paisagem')
      TabOrder = 5
      OnClick = rdgOrientacaoClick
    end
    object rdgTipDta: TRadioGroup [10]
      Left = 8
      Top = 131
      Width = 265
      Height = 61
      Caption = 'Contas de Resultado'
      ItemIndex = 0
      Items.Strings = (
        'Por data de Pagamento (Caixa)'
        'Por data de Cadastro'
        'Por data de Compet'#234'ncia')
      TabOrder = 3
      OnClick = rdgTipDtaClick
    end
    object rdgExibir: TRadioGroup [11]
      Left = 8
      Top = 78
      Width = 265
      Height = 47
      Caption = 'Exibir'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Conta de Resultado'
        'Plano de Contas'
        'Evento')
      TabOrder = 2
    end
    inherited gpbDestino: TGroupBox
      Left = 276
      Top = 363
      Width = 262
      Height = 49
      TabOrder = 10
      ExplicitLeft = 276
      ExplicitTop = 363
      ExplicitWidth = 262
      ExplicitHeight = 49
      inherited ColorLabel1: TColorLabel
        Left = 27
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 27
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Left = 3
        OnChange = edtDestinoChange
        ExplicitLeft = 3
      end
    end
    object lstEmpresas: TCheckListBox
      Left = 279
      Top = 17
      Width = 262
      Height = 343
      OnClickCheck = lstEmpresasClickCheck
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 14
      ParentFont = False
      PopupMenu = popSel
      TabOrder = 8
      OnEnter = lstEmpresasEnter
      OnKeyDown = lstEmpresasKeyDown
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 55
      Width = 77
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
      ValidaData = True
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 17
      Width = 78
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
      ValidaData = True
    end
    object rdgFatura: TRadioGroup
      Left = 8
      Top = 414
      Width = 531
      Height = 48
      Caption = 'Faturamento'
      ItemIndex = 0
      Items.Strings = (
        'Exibir Faturamento Resumido "A Vista" e "A Prazo"'
        'Exibir Faturamento Anal'#237'tico por Condi'#231#227'o de Pagamento')
      TabOrder = 11
    end
    object rdgSalEst: TRadioGroup
      Left = 8
      Top = 362
      Width = 265
      Height = 50
      Caption = 'Saldo de Estoque'
      ItemIndex = 0
      Items.Strings = (
        'Somente produtos com estoque maior que zero'
        'Todos os produtos')
      TabOrder = 9
    end
    object chkSalPor: TCheckBox
      Left = 8
      Top = 467
      Width = 377
      Height = 15
      Caption = 
        'Considerar saldo dos portadores no Resultado da avalia'#231#227'o das lo' +
        'jas.'
      TabOrder = 12
    end
    object chkResFor: TCheckBox
      Left = 8
      Top = 483
      Width = 377
      Height = 15
      Caption = 'Exibir Resumo de Vendas por Fornecedor'
      TabOrder = 13
    end
    object chkExibeAcreFin: TCheckBox
      Left = 8
      Top = 499
      Width = 377
      Height = 15
      Caption = 'Exibir se'#231#227'o de Acr'#233'scimo Financeiro sobre Vendas'
      TabOrder = 14
    end
    object rdgSalPor: TRadioGroup
      Left = 8
      Top = 310
      Width = 265
      Height = 50
      Caption = 'Saldo de Portadores'
      ItemIndex = 1
      Items.Strings = (
        'Exibir somente registros conciliados'
        'Exibir todos os registros')
      TabOrder = 7
    end
    object chkPerDes: TCheckBox
      Left = 8
      Top = 515
      Width = 377
      Height = 15
      Caption = 'Exibir porcentagem do Valor de Despesas'
      TabOrder = 15
    end
    object chkListaDesmembramento: TCheckBox
      Left = 8
      Top = 531
      Width = 283
      Height = 15
      Caption = 'Listar desmembramentos do contas a pagar'
      TabOrder = 16
    end
    object chkTrMarCus: TCheckBox
      Left = 8
      Top = 547
      Width = 531
      Height = 15
      Caption = 'Exibir Custo/Margem de Transfer'#234'ncia de Estoque'
      TabOrder = 17
    end
  end
  inherited pnlStatus: TPanel
    Top = 614
    Width = 554
    ExplicitTop = 614
    ExplicitWidth = 554
    inherited pnlNomeForm: TPanel
      Left = 383
      ExplicitLeft = 383
    end
    inherited pnlInfo: TPanel
      Width = 383
      ExplicitWidth = 383
      inherited shpMultSel: TShape
        Left = 358
        ExplicitLeft = 358
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 712
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1064
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 48
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 680
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 936
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 904
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 872
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 840
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 808
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = cdsRelat
    Left = 744
  end
  inherited frxGen: TfrxUserDataSet
    Left = 776
  end
  inherited frxDesigner: TfrxDesigner
    Left = 1000
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 1032
  end
  object cdsRelat: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'REL_CODREL'
    Params = <>
    Left = 456
    Top = 169
    object cdsRelatREL_CODREL: TIntegerField
      FieldName = 'REL_CODREL'
    end
    object cdsRelatREL_DESGRU: TStringField
      FieldName = 'REL_DESGRU'
      Size = 100
    end
    object cdsRelatREL_CODCAM: TStringField
      FieldName = 'REL_CODCAM'
      Size = 30
    end
    object cdsRelatREL_DESCAM: TStringField
      FieldName = 'REL_DESCAM'
      Size = 100
    end
    object cdsRelatREL_MARGEM: TFloatField
      FieldName = 'REL_MARGEM'
    end
    object cdsRelatREL_TOTAL: TFloatField
      FieldName = 'REL_TOTAL'
    end
    object cdsRelatREL_CALTOT: TBooleanField
      FieldName = 'REL_CALTOT'
    end
    object cdsRelatREL_SALPOR: TBooleanField
      FieldName = 'REL_SALPOR'
    end
  end
  object frxSalPor: TfrxDBDataset
    UserName = 'frxSalPor'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 328
    Top = 168
  end
  object frxResFor: TfrxDBDataset
    UserName = 'frxResFor'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 328
    Top = 104
  end
  object frxQckEstatAnalResult2M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41001.359722581000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  bln: Boolean;  '
      '    '
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
      'procedure rlbDadosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      '  If chkSalPorChecked Then'
      '    CSalPor.Visible := <frxRelatorio."REL_SALPOR">;    '
      ''
      '  If (<frxRelatorio."REL_CODCAM"> = '#39'MARCON'#39') Or'
      '     (<frxRelatorio."REL_CODCAM"> = '#39'MARLIQ'#39') Or'
      '     (<frxRelatorio."REL_CODCAM"> = '#39'PERREA'#39') Or'
      '     (<frxRelatorio."REL_CODCAM"> = '#39'PERDES'#39') Or         '
      '     (<frxRelatorio."REL_CODCAM"> = '#39'VAREST'#39') Then'
      
        '  Begin                                                         ' +
        '   '
      
        '    rllLoj001.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';           ' +
        '           '
      '    rllLoj002.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj003.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';    '
      '    rllLoj004.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj005.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj006.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj007.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj008.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj009.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj010.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj011.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';        '
      '    rllLoj012.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';        '
      '    rllLojTot.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    If (<frxRelatorio."REL_CODCAM"> <> '#39'VAREST'#39') Then'
      '    Begin                  '
      '      rllLojTot.Memo.Clear;'
      '      rllLojTot.Memo.Add('#39'[frxRelatorio."REL_MARGEM"]'#39');'
      '      rllPerc.Memo.Clear;'
      '      rllPerc.DataField := '#39#39';'
      '    End                    '
      '  End'
      '  Else If (<frxRelatorio."REL_CODCAM"> = '#39'PRACTR'#39') Or '
      '          (<frxRelatorio."REL_CODCAM"> = '#39'PRACOM'#39') Or'
      '          (<frxRelatorio."REL_CODCAM"> = '#39'PRAVEN'#39') Then'
      '  Begin'
      '    rllLojTot.Memo.Clear;'
      '    rllLojTot.Memo.Add('#39'[frxRelatorio."REL_MARGEM"]'#39');'
      '    rllPerc.Memo.Clear;'
      '    rllPerc.DataField := '#39#39';  '
      '  End'
      '  Else            '
      '  Begin'
      
        '    rllLoj001.DisplayFormat.FormatStr := '#39'#,##0.00'#39';            ' +
        '          '
      '    rllLoj002.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj003.DisplayFormat.FormatStr := '#39'#,##0.00'#39';    '
      '    rllLoj004.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj005.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj006.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj007.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj008.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj009.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj010.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj011.DisplayFormat.FormatStr := '#39'#,##0.00'#39';        '
      '    rllLoj012.DisplayFormat.FormatStr := '#39'#,##0.00'#39';        '
      '    rllLojTot.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLojTot.Memo.Clear;'
      
        '    rllLojTot.Memo.Add('#39'[IIF(<frxRelatorio."REL_CALTOT">, <frxRe' +
        'latorio."REL_TOTAL">,'#39');'
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ001"> + <frxRelato' +
        'rio."REL_LOJ002"> + <frxRelatorio."REL_LOJ003"> + <frxRelatorio.' +
        '"REL_LOJ004"> + <frxRelatorio."REL_LOJ005"> +'#39');       '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ006"> + <frxRelato' +
        'rio."REL_LOJ007"> + <frxRelatorio."REL_LOJ008"> + <frxRelatorio.' +
        '"REL_LOJ009"> + <frxRelatorio."REL_LOJ010"> +'#39');   '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ011"> + <frxRelato' +
        'rio."REL_LOJ012"> + <frxRelatorio."REL_LOJ013"> + <frxRelatorio.' +
        '"REL_LOJ014"> + <frxRelatorio."REL_LOJ015"> +'#39');   '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ016"> + <frxRelato' +
        'rio."REL_LOJ017"> + <frxRelatorio."REL_LOJ018"> + <frxRelatorio.' +
        '"REL_LOJ019"> + <frxRelatorio."REL_LOJ020"> +'#39');'
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ021"> + <frxRelato' +
        'rio."REL_LOJ022"> + <frxRelatorio."REL_LOJ023"> + <frxRelatorio.' +
        '"REL_LOJ024"> + <frxRelatorio."REL_LOJ025"> +'#39');   '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ026"> + <frxRelato' +
        'rio."REL_LOJ027"> + <frxRelatorio."REL_LOJ028"> + <frxRelatorio.' +
        '"REL_LOJ029"> + <frxRelatorio."REL_LOJ030"> +'#39');'
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ031"> + <frxRelato' +
        'rio."REL_LOJ032"> + <frxRelatorio."REL_LOJ033"> + <frxRelatorio.' +
        '"REL_LOJ034"> + <frxRelatorio."REL_LOJ035"> +'#39');   '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ036"> + <frxRelato' +
        'rio."REL_LOJ037"> + <frxRelatorio."REL_LOJ038"> + <frxRelatorio.' +
        '"REL_LOJ039"> + <frxRelatorio."REL_LOJ040">)]'#39');  '
      '        '
      '    rllPerc.Memo.Clear;'
      '    rllPerc.DataField := '#39'REL_MARGEM'#39';        '
      '  End;'
      ''
      '  If (bln) And (<frxRelatorio."REL_CODCAM"> = '#39'PERREA'#39') Then'
      '  Begin'
      
        '    rlbTitulo.StartNewPage := True;                             ' +
        '                    '
      '    bln := False;'
      '  End'
      '  Else'
      '    rlbTitulo.StartNewPage := False;      '
      'end;'
      ''
      'procedure CSalPorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If blnConsolidado Then'
      '    intQtdEmp := 1;'
      'end;'
      ''
      'procedure rlbSumarioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllInfSalPor.Visible := chkSalPorChecked;  '
      'end;'
      ''
      'procedure DMPMemo38OnAfterData(Sender: TfrxComponent);'
      'begin'
      
        '  If <frxRelatorio."REL_DESGRU"> = '#39'ACR'#201'SCIMO FINANCEIRO (VENDA)' +
        #39' Then'
      '    DMPMemo38.Text := '#39'% SOBRE PR.TAB'#39';  '
      'end;'
      ''
      'begin'
      '  CSalPor.Visible := True;'
      '  rllInfSalPor.Visible := False;'
      '  bln := True;'
      '    '
      'end.    ')
    OnUserFunction = frxQckEstatAnalResult2MUserFunction
    Left = 480
    Top = 32
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResFor
        DataSetName = 'frxResFor'
      end
      item
        DataSet = frxSalPor
        DataSetName = 'frxSalPor'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 581.659624344825900000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 5.079996719168786000
      RightMargin = 5.079996719168786000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 408.000000000000000000
        Width = 2160.000000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Align = baLeft
          Top = 34.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Align = baWidth
          Left = 739.200000000000000000
          Top = 34.000000000000000000
          Width = 1420.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDados)+COUNT(MasterData1)+COUNT(rlbResFor)]')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 2140.800000000000000000
          Color = clBlack
        end
        object rllInfSalPor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 864.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              '*** O valor total dos portadores esta sendo somado ao Resultado ' +
              'Total das lojas')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 2160.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 710.400000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 710.400000000000000000
          Top = 34.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Align = baRight
          Left = 1910.400000000000000000
          Top = 34.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Align = baRight
          Left = 2044.800000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Align = baRight
          Left = 1910.400000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 710.400000000000000000
          Top = 51.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PARAM1]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Align = baRight
          Left = 1392.000000000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PARAM2]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#77'
        end
        object DMPMemo4: TfrxDMPMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Align = baRight
          Left = 1392.000000000000000000
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SALPOR]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 170.000000000000000000
        Width = 2160.000000000000000000
        Condition = 'frxRelatorio."REL_CODREL"'
        ReprintOnNewPage = True
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2140.800000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 2140.800000000000000000
          Color = clBlack
        end
        object rllTitDesGru: TfrxDMPMemoView
          Align = baLeft
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_DESGRU'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."REL_DESGRU"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCabLoj01: TfrxDMPMemoView
          Align = baLeft
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-001')
          TruncOutboundText = False
        end
        object rllCabLoj02: TfrxDMPMemoView
          Align = baLeft
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-002')
          TruncOutboundText = False
        end
        object rllCabLoj03: TfrxDMPMemoView
          Align = baLeft
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-003')
          TruncOutboundText = False
        end
        object rllCabLoj04: TfrxDMPMemoView
          Align = baLeft
          Left = 700.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-004')
          TruncOutboundText = False
        end
        object rllCabLoj05: TfrxDMPMemoView
          Align = baLeft
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-005')
          TruncOutboundText = False
        end
        object rllCabLoj06: TfrxDMPMemoView
          Align = baLeft
          Left = 988.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-006')
          TruncOutboundText = False
        end
        object rllTotal: TfrxDMPMemoView
          Align = baLeft
          Left = 1996.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
        end
        object rllCabLoj07: TfrxDMPMemoView
          Align = baLeft
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-007')
          TruncOutboundText = False
        end
        object rllCabLoj08: TfrxDMPMemoView
          Align = baLeft
          Left = 1276.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-008')
          TruncOutboundText = False
        end
        object rllCabLoj09: TfrxDMPMemoView
          Align = baLeft
          Left = 1420.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-009')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCabLoj10: TfrxDMPMemoView
          Align = baLeft
          Left = 1564.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-010')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCabLoj11: TfrxDMPMemoView
          Align = baLeft
          Left = 1708.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-011')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCabLoj12: TfrxDMPMemoView
          Align = baLeft
          Left = 1852.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-012')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Align = baLeft
          Left = 2140.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'DMPMemo38OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          TruncOutboundText = False
        end
      end
      object rlbDados: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 2160.000000000000000000
        OnBeforePrint = 'rlbDadosOnBeforePrint'
        Child = frxQckEstatAnalResult2M.CSalPor
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllDesCam: TfrxDMPMemoView
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_DESCAM'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."REL_DESCAM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj001: TfrxDMPMemoView
          Align = baLeft
          Left = 268.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ001'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ001"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj002: TfrxDMPMemoView
          Align = baLeft
          Left = 412.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ002'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ002"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj003: TfrxDMPMemoView
          Align = baLeft
          Left = 556.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ003'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ003"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj004: TfrxDMPMemoView
          Align = baLeft
          Left = 700.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ004'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ004"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj005: TfrxDMPMemoView
          Align = baLeft
          Left = 844.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ005'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ005"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj006: TfrxDMPMemoView
          Align = baLeft
          Left = 988.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ006'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ006"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojTot: TfrxDMPMemoView
          Align = baLeft
          Left = 1996.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."REL_CALTOT">, <frxRelatorio."REL_TOTAL">,'
            
              '<frxRelatorio."REL_LOJ001"> + <frxRelatorio."REL_LOJ002"> + <frx' +
              'Relatorio."REL_LOJ003"> + <frxRelatorio."REL_LOJ004"> + <frxRela' +
              'torio."REL_LOJ005"> + '
            
              '<frxRelatorio."REL_LOJ006"> + <frxRelatorio."REL_LOJ007"> + <frx' +
              'Relatorio."REL_LOJ008"> + <frxRelatorio."REL_LOJ009"> + <frxRela' +
              'torio."REL_LOJ010"> + '
            
              '<frxRelatorio."REL_LOJ011"> + <frxRelatorio."REL_LOJ012"> + <frx' +
              'Relatorio."REL_LOJ013"> + <frxRelatorio."REL_LOJ014"> + <frxRela' +
              'torio."REL_LOJ015"> +'
            
              ' <frxRelatorio."REL_LOJ016"> + <frxRelatorio."REL_LOJ017"> + <fr' +
              'xRelatorio."REL_LOJ018"> + <frxRelatorio."REL_LOJ019"> + <frxRel' +
              'atorio."REL_LOJ020"> + <frxRelatorio."REL_LOJ021">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj007: TfrxDMPMemoView
          Align = baLeft
          Left = 1132.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ007'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ007"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj008: TfrxDMPMemoView
          Align = baLeft
          Left = 1276.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ008'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ008"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj009: TfrxDMPMemoView
          Align = baLeft
          Left = 1420.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ009'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ009"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj010: TfrxDMPMemoView
          Align = baLeft
          Left = 1564.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ010'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ010"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPerc: TfrxDMPMemoView
          Align = baLeft
          Left = 2140.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_MARGEM'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00%'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_MARGEM"]')
          TruncOutboundText = False
        end
        object rllLoj011: TfrxDMPMemoView
          Align = baLeft
          Left = 1708.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ011'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ011"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj012: TfrxDMPMemoView
          Align = baLeft
          Left = 1852.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ012'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ012"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumarioGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 2160.000000000000000000
      end
      object rlbSumario: TfrxFooter
        FillType = ftBrush
        Top = 306.000000000000000000
        Width = 2160.000000000000000000
        OnBeforePrint = 'rlbSumarioOnBeforePrint'
        Child = frxQckEstatAnalResult2M.CSalPor
        PrintChildIfInvisible = True
      end
      object CSalPor: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 2160.000000000000000000
        OnBeforePrint = 'CSalPorOnBeforePrint'
        Child = frxQckEstatAnalResult2M.CResFor
        PrintChildIfInvisible = True
        object qckSalPor: TfrxSubreport
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Page = frxQckEstatAnalResult2M.Page1
        end
      end
      object CResFor: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 2160.000000000000000000
        PrintChildIfInvisible = True
        object qckResFor: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxQckEstatAnalResult2M.Page2
        end
      end
    end
    object Page1: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 581.659624344825900000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 5.079996719168786000
      RightMargin = 5.079996719168786000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 2160.000000000000000000
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2150.400000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 2150.400000000000000000
          Color = clBlack
        end
        object rllSalPor: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'SALDO DE PORTADORES')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Align = baLeft
          Left = 1996.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
        end
        object rllCabLojPor01: TfrxDMPMemoView
          Align = baLeft
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-001')
          TruncOutboundText = False
        end
        object rllCabLojPor02: TfrxDMPMemoView
          Align = baLeft
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-002')
          TruncOutboundText = False
        end
        object rllCabLojPor03: TfrxDMPMemoView
          Align = baLeft
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-003')
          TruncOutboundText = False
        end
        object rllCabLojPor04: TfrxDMPMemoView
          Align = baLeft
          Left = 700.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-004')
          TruncOutboundText = False
        end
        object rllCabLojPor05: TfrxDMPMemoView
          Align = baLeft
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-005')
          TruncOutboundText = False
        end
        object rllCabLojPor06: TfrxDMPMemoView
          Align = baLeft
          Left = 988.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-006')
          TruncOutboundText = False
        end
        object rllCabLojPor07: TfrxDMPMemoView
          Align = baLeft
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-007')
          TruncOutboundText = False
        end
        object rllCabLojPor08: TfrxDMPMemoView
          Align = baLeft
          Left = 1276.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-008')
          TruncOutboundText = False
        end
        object rllCabLojPor09: TfrxDMPMemoView
          Align = baLeft
          Left = 1420.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-009')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCabLojPor10: TfrxDMPMemoView
          Align = baLeft
          Left = 1564.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-010')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCabLojPor11: TfrxDMPMemoView
          Align = baLeft
          Left = 1708.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-011')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCabLojPor12: TfrxDMPMemoView
          Align = baLeft
          Left = 1852.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-012')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 85.000000000000000000
        Width = 2160.000000000000000000
        DataSet = frxSalPor
        DataSetName = 'frxSalPor'
        RowCount = 0
        object rllCodPor: TfrxDMPMemoView
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'POR_CODPOR'
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxSalPor."POR_CODPOR"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Align = baLeft
          Left = 1996.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[<frxSalPor."REL_LOJ001"> + <frxSalPor."REL_LOJ002"> + <frxSalPo' +
              'r."REL_LOJ003"> +'
            
              ' <frxSalPor."REL_LOJ004"> + <frxSalPor."REL_LOJ005"> + <frxSalPo' +
              'r."REL_LOJ006"> +'
            
              ' <frxSalPor."REL_LOJ007"> + <frxSalPor."REL_LOJ008"> + <frxSalPo' +
              'r."REL_LOJ009"> +'
            
              ' <frxSalPor."REL_LOJ010"> + <frxSalPor."REL_LOJ011"> + <frxSalPo' +
              'r."REL_LOJ012">]')
          TruncOutboundText = False
        end
        object rllNomPor: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          Memo.UTF8W = (
            '[frxSalPor."POR_NOMPOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor001: TfrxDMPMemoView
          Align = baLeft
          Left = 268.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ001"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor002: TfrxDMPMemoView
          Align = baLeft
          Left = 412.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ002"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor003: TfrxDMPMemoView
          Align = baLeft
          Left = 556.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ003"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor004: TfrxDMPMemoView
          Align = baLeft
          Left = 700.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ004"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor005: TfrxDMPMemoView
          Align = baLeft
          Left = 844.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ005"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor006: TfrxDMPMemoView
          Align = baLeft
          Left = 988.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ006"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor007: TfrxDMPMemoView
          Align = baLeft
          Left = 1132.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ007"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor008: TfrxDMPMemoView
          Align = baLeft
          Left = 1276.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ008"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor009: TfrxDMPMemoView
          Align = baLeft
          Left = 1420.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ009"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor010: TfrxDMPMemoView
          Align = baLeft
          Left = 1564.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ010"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor011: TfrxDMPMemoView
          Align = baLeft
          Left = 1708.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ011"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor012: TfrxDMPMemoView
          Align = baLeft
          Left = 1852.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ012"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 119.000000000000000000
        Width = 2160.000000000000000000
        object DMPMemo10: TfrxDMPMemoView
          Align = baLeft
          Left = 1996.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxSalPor."REL_LOJ001"> + <frxSalPor."REL_LOJ002"> + <frxS' +
              'alPor."REL_LOJ003"> +'
            
              ' <frxSalPor."REL_LOJ004"> + <frxSalPor."REL_LOJ005"> + <frxSalPo' +
              'r."REL_LOJ006"> +'
            
              ' <frxSalPor."REL_LOJ007"> + <frxSalPor."REL_LOJ008"> + <frxSalPo' +
              'r."REL_LOJ009"> +'
            
              ' <frxSalPor."REL_LOJ010"> + <frxSalPor."REL_LOJ011"> + <frxSalPo' +
              'r."REL_LOJ012">, MasterData1)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTotPor: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'TOTAL DOS PORTADORES')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2150.400000000000000000
          Color = clBlack
        end
        object DMPLine7: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 2150.400000000000000000
          Color = clBlack
        end
        object rllLojPorTot001: TfrxDMPMemoView
          Align = baLeft
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ001">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot002: TfrxDMPMemoView
          Align = baLeft
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ002">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot003: TfrxDMPMemoView
          Align = baLeft
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ003">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot004: TfrxDMPMemoView
          Align = baLeft
          Left = 700.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ004">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot005: TfrxDMPMemoView
          Align = baLeft
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ005">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot006: TfrxDMPMemoView
          Align = baLeft
          Left = 988.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ006">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot007: TfrxDMPMemoView
          Align = baLeft
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ007">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot008: TfrxDMPMemoView
          Align = baLeft
          Left = 1276.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ008">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot009: TfrxDMPMemoView
          Align = baLeft
          Left = 1420.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ009">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot010: TfrxDMPMemoView
          Align = baLeft
          Left = 1564.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ010">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot011: TfrxDMPMemoView
          Align = baLeft
          Left = 1708.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ011">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPorTot012: TfrxDMPMemoView
          Align = baLeft
          Left = 1852.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ012">,MasterData1)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object Page2: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 581.659624344825900000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 5.079996719168786000
      RightMargin = 5.079996719168786000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = []
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 2160.000000000000000000
        object DMPMemo5: TfrxDMPMemoView
          Align = baCenter
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE FORNECEDORES')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'NOME DO FORNECEDOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% ACUM.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1344.000000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% REP.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MARGEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOT.CUSTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            'FAT. PRAZO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            'FAT. VISTA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PRZ.MEDIO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LITROS/KILOS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine10: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 2140.800000000000000000
          Color = clBlack
        end
        object DMPLine11: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 2140.800000000000000000
          Color = clBlack
        end
      end
      object rlbResFor: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 119.000000000000000000
        Width = 2160.000000000000000000
        DataSet = frxResFor
        DataSetName = 'frxResFor'
        RowCount = 0
        object DMPMemo21: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CODFOR'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          Memo.UTF8W = (
            '[frxResFor."CODFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMFOR'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          Memo.UTF8W = (
            '[frxResFor."NOMFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'PERACU'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PERACU"]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 1344.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'PERREP'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PERREP"]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'MARGEM'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."MARGEM"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTCUS'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."TOTCUS"]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataField = 'PERPRZ'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PERPRZ"]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTPRZ'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."TOTPRZ"]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataField = 'PERVIS'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PERVIS"]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTVIS'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."TOTVIS"]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'PRZMED'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PRZMED"]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'PESLIT'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PESLIT"]')
          TruncOutboundText = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 2160.000000000000000000
        object DMPMemo22: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFor."TOTCUS">,rlbResFor)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFor."TOTPRZ">,rlbResFor)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFor."TOTVIS">,rlbResFor)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFor."PESLIT">,rlbResFor)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2140.800000000000000000
          Color = clBlack
        end
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 2140.800000000000000000
          Color = clBlack
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalculaPrecoVendaInt(SUM(<frxResFor."TOTCUS">,rlbResFor), SUM(' +
              '<frxResFor."TOTVEN">,rlbResFor))]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxQckEstatAnalResult2J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42719.693382245370000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      
        '  fltPerTot : Double;                                           ' +
        '             '
      '  bln: Boolean;  '
      '    '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDadosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If chkSalPorChecked Then'
      '    CSalPor.Visible := <frxRelatorio."REL_SALPOR">;'
      ''
      
        '  If (<frxRelatorio."REL_DESGRU"> = '#39'IMOBILIZADO/PATRIMONIO'#39') an' +
        'd <frxRelatorio."REL_SALPOR"> Then      '
      '    rlbTitulo.Visible := not CSalPor.Visible;           '
      ''
      '  If shpCtaRes.Tag = 1 Then'
      '  Begin'
      
        '    If qckPagina.Orientation = poLandscape Then                 ' +
        '                        '
      '      shpCtaRes.Width := rlbDados.Width {- 10}  '
      '    Else'
      
        '      shpCtaRes.Width := rlbDados.Width {- 30};                 ' +
        '              '
      '      '
      '    If (<frxRelatorio."Rel_CODCAM"> = '#39'CTARES'#39') And'
      '       (<frxRelatorio."Rel_DESCAM"> <>'#39'TOTAIS'#39') Then'
      '      shpCtaRes.Visible := True'
      '    Else'
      '      shpCtaRes.Visible := False;'
      '  End'
      '  Else'
      '    shpCtaRes.Visible := False;        '
      '  '
      '  If <frxRelatorio."REL_CODCAM"> = '#39'***'#39' Then'
      '  Begin'
      '    Linha.Visible     := True;'
      '    rlbDados.Height   := 5;'
      '    rllLojTot.Visible := False;'
      '    rllPerc.Visible   := False;'
      '    rllLoj001.Visible := False;'
      '    rllLoj002.Visible := False;'
      '    rllLoj003.Visible := False;'
      '    rllLoj004.Visible := False;'
      '    rllLoj005.Visible := False;'
      '    rllLoj006.Visible := False;'
      '    rllLoj007.Visible := False;'
      '    rllLoj008.Visible := False;'
      '    rllLoj009.Visible := False;'
      '    rllLoj010.Visible := False;'
      '    rllLoj011.Visible := False;'
      '    rllLoj012.Visible := False;'
      '    rllLoj013.Visible := False;'
      '    rllLoj014.Visible := False;'
      '    rllLoj015.Visible := False;'
      '    rllLoj016.Visible := False;'
      '    rllLoj017.Visible := False;'
      '    rllLoj018.Visible := False;'
      '    rllLoj019.Visible := False;'
      '    rllLoj020.Visible := False;'
      '    rllLoj021.Visible := False;        '
      '  End'
      '  Else'
      '  Begin              '
      '    Linha.Visible     := False;              '
      '    rllLoj001.Visible := rllCabLoj01.Visible;        '
      '    rllLojTot.Visible := True;'
      '    rllPerc.Visible   := True;'
      '    rllLoj002.Visible := rllCabLoj02.Visible;'
      '    rllLoj003.Visible := rllCabLoj03.Visible;'
      '    rllLoj004.Visible := rllCabLoj04.Visible;'
      '    rllLoj005.Visible := rllCabLoj05.Visible;'
      '    rllLoj006.Visible := rllCabLoj06.Visible;'
      '    rllLoj007.Visible := rllCabLoj07.Visible;'
      '    rllLoj008.Visible := rllCabLoj08.Visible;'
      '    rllLoj009.Visible := rllCabLoj09.Visible;'
      '    rllLoj010.Visible := rllCabLoj10.Visible;'
      '    rllLoj011.Visible := rllCabLoj11.Visible;'
      '    rllLoj012.Visible := rllCabLoj12.Visible;'
      '    rllLoj013.Visible := rllCabLoj13.Visible;'
      '    rllLoj014.Visible := rllCabLoj14.Visible;'
      '    rllLoj015.Visible := rllCabLoj15.Visible;'
      '    rllLoj016.Visible := rllCabLoj16.Visible;'
      '    rllLoj017.Visible := rllCabLoj17.Visible;'
      '    rllLoj018.Visible := rllCabLoj18.Visible;'
      '    rllLoj019.Visible := rllCabLoj19.Visible;'
      '    rllLoj020.Visible := rllCabLoj20.Visible;'
      '    rllLoj021.Visible := rllCabLoj21.Visible;        '
      '  End;                '
      '    '
      '  If (<frxRelatorio."REL_CODCAM"> = '#39'MARCON'#39') Or'
      '     (<frxRelatorio."REL_CODCAM"> = '#39'MARLIQ'#39') Or'
      '     (<frxRelatorio."REL_CODCAM"> = '#39'PERREA'#39') Or'
      '     (<frxRelatorio."REL_CODCAM"> = '#39'PERDES'#39') Or         '
      '     (<frxRelatorio."REL_CODCAM"> = '#39'VAREST'#39') Then'
      
        '  Begin                                                         ' +
        '   '
      
        '    rllLoj001.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';           ' +
        '           '
      '    rllLoj002.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj003.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';    '
      '    rllLoj004.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj005.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj006.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj007.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj008.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj009.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj010.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj011.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';        '
      '    rllLoj012.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj013.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj014.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj015.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj016.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj017.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj018.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj019.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj020.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    rllLoj021.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';        '
      '    rllLojTot.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      '    If (<frxRelatorio."REL_CODCAM"> <> '#39'VAREST'#39') Then'
      '    Begin'
      '      rllLojTot.Memo.Clear;'
      '      rllLojTot.Memo.Add('#39'[frxRelatorio."REL_MARGEM"]'#39');'
      '      rllPerc.Memo.Clear;'
      '      rllPerc.DataField := '#39#39';        '
      '    End'
      '  End'
      '  Else If (<frxRelatorio."REL_CODCAM"> = '#39'PRACTR'#39') Or '
      '          (<frxRelatorio."REL_CODCAM"> = '#39'PRACOM'#39') Or'
      '          (<frxRelatorio."REL_CODCAM"> = '#39'PRAVEN'#39') Then'
      '  Begin'
      '    rllLojTot.Memo.Clear;'
      '    rllLojTot.Memo.Add('#39'[frxRelatorio."REL_MARGEM"]'#39');'
      '    rllPerc.Memo.Clear;'
      '    rllPerc.DataField := '#39#39';  '
      '  End'
      '  Else If(intTamFonte > 10) Then'
      '  Begin'
      
        '    rllLoj001.DisplayFormat.FormatStr := '#39'#0'#39';                  ' +
        '    '
      '    rllLoj002.DisplayFormat.FormatStr := '#39'#0'#39';  '
      '    rllLoj003.DisplayFormat.FormatStr := '#39'#0'#39';    '
      '    rllLoj004.DisplayFormat.FormatStr := '#39'#0'#39';  '
      '    rllLoj005.DisplayFormat.FormatStr := '#39'#0'#39';  '
      '    rllLoj006.DisplayFormat.FormatStr := '#39'#0'#39';  '
      '    rllLoj007.DisplayFormat.FormatStr := '#39'#0'#39';  '
      '    rllLoj008.DisplayFormat.FormatStr := '#39'#0'#39';  '
      '    rllLoj009.DisplayFormat.FormatStr := '#39'#0'#39';  '
      '    rllLoj010.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLoj011.DisplayFormat.FormatStr := '#39'#0'#39';        '
      '    rllLoj012.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLoj013.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLoj014.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLoj015.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLoj016.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLoj017.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLoj018.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLoj019.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLoj020.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLoj021.DisplayFormat.FormatStr := '#39'#0'#39';        '
      '    rllLojTot.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojTot.Memo.Clear;'
      
        '    rllLojTot.Memo.Add('#39'[IIF(<frxRelatorio."REL_CALTOT">, <frxRe' +
        'latorio."REL_TOTAL">,'#39');'
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ001"> + <frxRelato' +
        'rio."REL_LOJ002"> + <frxRelatorio."REL_LOJ003"> + <frxRelatorio.' +
        '"REL_LOJ004"> + <frxRelatorio."REL_LOJ005"> +'#39');       '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ006"> + <frxRelato' +
        'rio."REL_LOJ007"> + <frxRelatorio."REL_LOJ008"> + <frxRelatorio.' +
        '"REL_LOJ009"> + <frxRelatorio."REL_LOJ010"> +'#39');   '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ011"> + <frxRelato' +
        'rio."REL_LOJ012"> + <frxRelatorio."REL_LOJ013"> + <frxRelatorio.' +
        '"REL_LOJ014"> + <frxRelatorio."REL_LOJ015"> +'#39');   '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ016"> + <frxRelato' +
        'rio."REL_LOJ017"> + <frxRelatorio."REL_LOJ018"> + <frxRelatorio.' +
        '"REL_LOJ019"> + <frxRelatorio."REL_LOJ020"> +'#39');'
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ021"> + <frxRelato' +
        'rio."REL_LOJ022"> + <frxRelatorio."REL_LOJ023"> + <frxRelatorio.' +
        '"REL_LOJ024"> + <frxRelatorio."REL_LOJ025"> +'#39');        '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ026"> + <frxRelato' +
        'rio."REL_LOJ027"> + <frxRelatorio."REL_LOJ028"> + <frxRelatorio.' +
        '"REL_LOJ029"> + <frxRelatorio."REL_LOJ030"> +'#39');'
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ031"> + <frxRelato' +
        'rio."REL_LOJ032"> + <frxRelatorio."REL_LOJ033"> + <frxRelatorio.' +
        '"REL_LOJ034"> + <frxRelatorio."REL_LOJ035"> +'#39');   '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ036"> + <frxRelato' +
        'rio."REL_LOJ037"> + <frxRelatorio."REL_LOJ038"> + <frxRelatorio.' +
        '"REL_LOJ039"> + <frxRelatorio."REL_LOJ040">)]'#39');  '
      #9#9#9
      #9'   rllLojTot.DisplayFormat.FormatStr := '#39'#0'#39';'
      
        '    rllDetSalPor.DisplayFormat.FormatStr := '#39'#0'#39';               ' +
        '  '
      '    rllTotSalPor.DisplayFormat.FormatStr := '#39'#0'#39';'
      '      '
      '    rllPerc.Memo.Clear;'
      '    rllPerc.DataField := '#39'REL_MARGEM'#39';'
      #9#9
      #9#9'  rllLojPor001.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor002.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor003.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor004.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor005.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor006.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor007.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor008.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor009.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor010.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor011.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor012.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor013.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor014.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor015.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor016.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor017.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor018.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor019.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor020.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllLojPor021.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllDetSalPor.DisplayFormat.FormatStr := '#39'#0'#39';          '
      #9#9#9
      #9#9'  rllLojPorTot001.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'rllLojPorTot002.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'rllLojPorTot003.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'rllLojPorTot004.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'rllLojPorTot005.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'rllLojPorTot006.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'rllLojPorTot007.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot008.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot009.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot010.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'rllLojPorTot011.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot012.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot013.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot014.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot015.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot016.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot017.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot018.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot019.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot020.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllLojPorTot021.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  rllTotSalPor.DisplayFormat.FormatStr := '#39'#0'#39';'
      '    rllDetSalPor.DisplayFormat.FormatStr := '#39'#0'#39';'
      ''
      #9#9'  Memo22.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'Memo24.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'Memo25.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'Memo26.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'Memo30.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'Memo31.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'Memo32.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  Memo33.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  Memo34.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  Memo35.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9'  '#9'Memo36.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  Memo38.DisplayFormat.FormatStr := '#39'#0'#39';'
      #9#9'  Memo39.DisplayFormat.FormatStr := '#39'#0'#39';    '
      '  '
      '  End'
      '  Else            '
      '  Begin'
      
        '    rllLoj001.DisplayFormat.FormatStr := '#39'#,##0.00'#39';            ' +
        '          '
      '    rllLoj002.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj003.DisplayFormat.FormatStr := '#39'#,##0.00'#39';    '
      '    rllLoj004.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj005.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj006.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj007.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj008.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj009.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj010.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj011.DisplayFormat.FormatStr := '#39'#,##0.00'#39';        '
      '    rllLoj012.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj013.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj014.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj015.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj016.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj017.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj018.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj019.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj020.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLoj021.DisplayFormat.FormatStr := '#39'#,##0.00'#39';        '
      '    rllLojTot.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLojTot.Memo.Clear;'
      
        '    rllLojTot.Memo.Add('#39'[IIF(<frxRelatorio."REL_CALTOT">, <frxRe' +
        'latorio."REL_TOTAL">,'#39');'
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ001"> + <frxRelato' +
        'rio."REL_LOJ002"> + <frxRelatorio."REL_LOJ003"> + <frxRelatorio.' +
        '"REL_LOJ004"> + <frxRelatorio."REL_LOJ005"> +'#39');       '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ006"> + <frxRelato' +
        'rio."REL_LOJ007"> + <frxRelatorio."REL_LOJ008"> + <frxRelatorio.' +
        '"REL_LOJ009"> + <frxRelatorio."REL_LOJ010"> +'#39');   '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ011"> + <frxRelato' +
        'rio."REL_LOJ012"> + <frxRelatorio."REL_LOJ013"> + <frxRelatorio.' +
        '"REL_LOJ014"> + <frxRelatorio."REL_LOJ015"> +'#39');   '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ016"> + <frxRelato' +
        'rio."REL_LOJ017"> + <frxRelatorio."REL_LOJ018"> + <frxRelatorio.' +
        '"REL_LOJ019"> + <frxRelatorio."REL_LOJ020"> +'#39');'
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ021"> + <frxRelato' +
        'rio."REL_LOJ022"> + <frxRelatorio."REL_LOJ023"> + <frxRelatorio.' +
        '"REL_LOJ024"> + <frxRelatorio."REL_LOJ025"> +'#39');        '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ026"> + <frxRelato' +
        'rio."REL_LOJ027"> + <frxRelatorio."REL_LOJ028"> + <frxRelatorio.' +
        '"REL_LOJ029"> + <frxRelatorio."REL_LOJ030"> +'#39');'
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ031"> + <frxRelato' +
        'rio."REL_LOJ032"> + <frxRelatorio."REL_LOJ033"> + <frxRelatorio.' +
        '"REL_LOJ034"> + <frxRelatorio."REL_LOJ035"> +'#39');   '
      
        '    rllLojTot.Memo.Add('#39'<frxRelatorio."REL_LOJ036"> + <frxRelato' +
        'rio."REL_LOJ037"> + <frxRelatorio."REL_LOJ038"> + <frxRelatorio.' +
        '"REL_LOJ039"> + <frxRelatorio."REL_LOJ040">)]'#39');  '
      '          '
      '    rllPerc.Memo.Clear;'
      '    rllPerc.DataField := '#39'REL_MARGEM'#39';        '
      '  End;'
      ''
      '  If (bln) And (<frxRelatorio."REL_CODCAM"> = '#39'PERREA'#39') Then'
      '  Begin'
      
        '    rlbTitulo.StartNewPage := True;                             ' +
        '                    '
      '    bln := False;'
      '  End'
      '  Else'
      '    rlbTitulo.StartNewPage := False;'
      '    '
      '  If <frxRelatorio."REL_DESCAM"> = '#39'PRE'#199'O DE TABELA'#39' Then'
      '  Begin'
      '    rllDesCam.Color := clSilver;                              '
      '    rllLoj001.Color := clSilver;'
      '    rllLoj002.Color := clSilver;'
      '    rllLoj003.Color := clSilver;'
      '    rllLoj004.Color := clSilver;'
      '    rllLoj005.Color := clSilver;'
      '    rllLoj006.Color := clSilver;'
      '    rllLoj007.Color := clSilver;'
      '    rllLoj008.Color := clSilver;'
      '    rllLoj009.Color := clSilver;'
      '    rllLoj010.Color := clSilver;'
      '    rllLoj011.Color := clSilver;'
      '    rllLoj012.Color := clSilver;'
      '    rllLoj013.Color := clSilver;'
      '    rllLoj014.Color := clSilver;'
      '    rllLoj015.Color := clSilver;'
      '    rllLoj016.Color := clSilver;'
      '    rllLoj017.Color := clSilver;'
      '    rllLoj018.Color := clSilver;'
      '    rllLoj019.Color := clSilver;'
      '    rllLoj020.Color := clSilver;'
      '    rllLoj021.Color := clSilver;        '
      '    rllLojTot.Color := clSilver;'
      '    rllPerc.Color := clSilver;'
      ''
      '    Memo37.Visible := True;'
      ''
      
        '    rllDesCam.Font.Style := fsBold;                             ' +
        ' '
      '    rllLoj001.Font.Style := fsBold;'
      '    rllLoj002.Font.Style := fsBold;'
      '    rllLoj003.Font.Style := fsBold;'
      '    rllLoj004.Font.Style := fsBold;'
      '    rllLoj005.Font.Style := fsBold;'
      '    rllLoj006.Font.Style := fsBold;'
      '    rllLoj007.Font.Style := fsBold;'
      '    rllLoj008.Font.Style := fsBold;'
      '    rllLoj009.Font.Style := fsBold;'
      '    rllLoj010.Font.Style := fsBold;'
      '    rllLoj011.Font.Style := fsBold;'
      '    rllLoj012.Font.Style := fsBold;'
      '    rllLoj013.Font.Style := fsBold;'
      '    rllLoj014.Font.Style := fsBold;'
      '    rllLoj015.Font.Style := fsBold;'
      '    rllLoj016.Font.Style := fsBold;'
      '    rllLoj017.Font.Style := fsBold;'
      '    rllLoj018.Font.Style := fsBold;'
      '    rllLoj019.Font.Style := fsBold;'
      '    rllLoj020.Font.Style := fsBold;'
      '    rllLoj021.Font.Style := fsBold;        '
      '    rllLojTot.Font.Style := fsBold;'
      '    rllPerc.Font.Style := fsBold;             '
      '  End'
      '  Else'
      '  Begin'
      '    rllDesCam.Color := clNone;                              '
      '    rllLoj001.Color := clNone;'
      '    rllLoj002.Color := clNone;'
      '    rllLoj003.Color := clNone;'
      '    rllLoj004.Color := clNone;'
      '    rllLoj005.Color := clNone;'
      '    rllLoj006.Color := clNone;'
      '    rllLoj007.Color := clNone;'
      '    rllLoj008.Color := clNone;'
      '    rllLoj009.Color := clNone;'
      '    rllLoj010.Color := clNone;'
      '    rllLoj011.Color := clNone;'
      '    rllLoj012.Color := clNone;'
      '    rllLoj013.Color := clNone;'
      '    rllLoj014.Color := clNone;'
      '    rllLoj015.Color := clNone;'
      '    rllLoj016.Color := clNone;'
      '    rllLoj017.Color := clNone;'
      '    rllLoj018.Color := clNone;'
      '    rllLoj019.Color := clNone;'
      '    rllLoj020.Color := clNone;'
      '    rllLoj021.Color := clNone;        '
      '    rllLojTot.Color := clNone;'
      '    rllPerc.Color := clNone;'
      '      '
      '    Memo37.Visible := False;'
      ''
      '    rllDesCam.Font.Style := 0;                              '
      '    rllLoj001.Font.Style := 0;'
      '    rllLoj002.Font.Style := 0;'
      '    rllLoj003.Font.Style := 0;'
      '    rllLoj004.Font.Style := 0;'
      '    rllLoj005.Font.Style := 0;'
      '    rllLoj006.Font.Style := 0;'
      '    rllLoj007.Font.Style := 0;'
      '    rllLoj008.Font.Style := 0;'
      '    rllLoj009.Font.Style := 0;     '
      '    rllLoj010.Font.Style := 0;'
      '    rllLoj011.Font.Style := 0;'
      '    rllLoj012.Font.Style := 0;'
      '    rllLoj013.Font.Style := 0;'
      '    rllLoj014.Font.Style := 0;'
      '    rllLoj015.Font.Style := 0;'
      '    rllLoj016.Font.Style := 0;'
      '    rllLoj017.Font.Style := 0;'
      '    rllLoj018.Font.Style := 0;'
      '    rllLoj019.Font.Style := 0;'
      '    rllLoj020.Font.Style := 0;'
      '    rllLoj021.Font.Style := 0;        '
      '    rllLojTot.Font.Style := 0;'
      '    rllPerc.Font.Style := 0;                '
      '  End;              '
      'end;'
      ''
      'procedure CSalPorOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  CSalPor.Visible := False;  '
      'end;'
      ''
      'procedure CSalPorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If blnConsolidado Then'
      '    intQtdEmp := 1;'
      'end;'
      ''
      'procedure rlbSumarioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllInfSalPor.Visible := chkSalPorChecked;  '
      'end;'
      ''
      'procedure Memo10OnAfterData(Sender: TfrxComponent);'
      'begin'
      
        '  If <frxRelatorio."REL_DESGRU"> = '#39'ACR'#201'SCIMO FINANCEIRO (VENDA)' +
        #39' Then'
      
        '    Memo10.Text := '#39'% SOBRE PR.TAB'#39';                            ' +
        '                              '
      'end;'
      ''
      'procedure Footer1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbTitulo.Visible := True;   '
      'end;'
      ''
      'begin'
      '  CSalPor.Visible := True;'
      '  rllInfSalPor.Visible := False;'
      '  bln := True;'
      '    '
      'end.')
    OnUserFunction = frxQckEstatAnalResult2JUserFunction
    Left = 480
    Top = 96
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResFor
        DataSetName = 'frxResFor'
      end
      item
        DataSet = frxSalPor
        DataSetName = 'frxSalPor'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 650.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 56.677180000000000000
        Top = 487.559370000000000000
        Width = 2381.103900000000000000
        object rllNomeForm: TfrxMemoView
          Left = 7.559060000000000000
          Top = 39.440940000000010000
          Width = 739.200000000000000000
          Height = 13.220470000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baWidth
          Left = 416.126253000000000000
          Top = 39.440940000000010000
          Width = 1964.977647000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDados)+COUNT(MasterData1)+COUNT(rlbResFor)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 32.720469999999920000
          Width = 2381.103900000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo12: TfrxMemoView
          Align = baRight
          Left = 397.228603000000000000
          Top = 39.440940000000010000
          Width = 18.897650000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllInfSalPor: TfrxMemoView
          Align = baLeft
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 13.220470000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '*** O valor total dos portadores esta sendo somado ao Resultado ' +
              'Total das lojas')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Align = baLeft
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              ' (*) Dados informativos. Estes valores n'#227'o influenciam na se'#231#227'o ' +
              '"Avalia'#231#227'o das Lojas".')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 141.724490000000000000
        Top = 18.897650000000000000
        Width = 2381.103900000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 825.751950000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 826.696755000000000000
          Top = 34.000000000000000000
          Width = 727.710390000000000000
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
          VAlign = vaCenter
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 2131.806250000000000000
          Top = 34.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
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
          Left = 2256.606250000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
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
          Left = 2122.206250000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
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
          Left = 825.751950000000000000
          Top = 51.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
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
        object Memo2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PARAM1]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = -741.240940000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PARAM2]')
        end
        object Memo4: TfrxMemoView
          Align = baRight
          Left = 2362.206250000000000000
          Top = 34.015770000000010000
          Width = 18.897650000000000000
          Height = 68.031540000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 7.559060000000000000
          Top = 102.047310000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 7.559060000000000000
          Top = 120.944960000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SALPOR]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbTitulo: TfrxGroupHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 222.992270000000000000
        Width = 2381.103900000000000000
        Condition = 'frxRelatorio."REL_CODREL"'
        ReprintOnNewPage = True
        object Memo10: TfrxMemoView
          Align = baWidth
          ShiftMode = smDontShift
          Left = 2270.211021240001000000
          Top = 0.933061100000003300
          Width = 110.892878759999300000
          Height = 18.897637800000000000
          OnAfterData = 'Memo10OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          ParentFont = False
          Wysiwyg = False
          VAlign = vaCenter
        end
        object rllTitDesGru: TfrxMemoView
          Left = 7.559060000000000000
          Top = 0.933061100000003300
          Width = 267.061410000000000000
          Height = 18.897637800000000000
          DataField = 'REL_DESGRU'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            '[frxRelatorio."REL_DESGRU"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj01: TfrxMemoView
          Align = baLeft
          Left = 274.620470000000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-001')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLoj02: TfrxMemoView
          Align = baLeft
          Left = 365.329131420000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-002')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLoj03: TfrxMemoView
          Align = baLeft
          Left = 456.037792840000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-003')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLoj04: TfrxMemoView
          Align = baLeft
          Left = 546.746454260000100000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-004')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLoj05: TfrxMemoView
          Align = baLeft
          Left = 637.455115680000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-005')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLoj06: TfrxMemoView
          Align = baLeft
          Left = 728.163777100000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-006')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotal: TfrxMemoView
          Align = baLeft
          Left = 2179.502359820001000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLoj07: TfrxMemoView
          Align = baLeft
          Left = 818.872438520000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-007')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLoj08: TfrxMemoView
          Align = baLeft
          Left = 909.581099940000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-008')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLoj09: TfrxMemoView
          Align = baLeft
          Left = 1000.289761360000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-009')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj10: TfrxMemoView
          Align = baLeft
          Left = 1090.998422780000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-010')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj11: TfrxMemoView
          Align = baLeft
          Left = 1181.707084200000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-011')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj12: TfrxMemoView
          Align = baLeft
          Left = 1272.415745620000000000
          Top = 0.933061100000003300
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-012')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj13: TfrxMemoView
          Align = baLeft
          Left = 1363.124407040000000000
          Top = 1.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-013')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj14: TfrxMemoView
          Align = baLeft
          Left = 1453.833068460000000000
          Top = 1.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-014')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj15: TfrxMemoView
          Align = baLeft
          Left = 1544.541729880000000000
          Top = 1.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-015')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj16: TfrxMemoView
          Align = baLeft
          Left = 1635.250391300000000000
          Top = 1.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-016')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj17: TfrxMemoView
          Align = baLeft
          Left = 1725.959052720000000000
          Top = 1.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-017')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj18: TfrxMemoView
          Align = baLeft
          Left = 1816.667714140000000000
          Top = 1.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-018')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj19: TfrxMemoView
          Align = baLeft
          Left = 1907.376375560000000000
          Top = 1.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-019')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj20: TfrxMemoView
          Align = baLeft
          Left = 1998.085036980000000000
          Top = 1.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-020')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj21: TfrxMemoView
          Align = baLeft
          Left = 2088.793698400000000000
          Top = 1.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-021')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbDados: TfrxMasterData
        FillType = ftBrush
        Height = 22.677162910000000000
        Top = 268.346630000000000000
        Width = 2381.103900000000000000
        OnAfterPrint = 'rlbDadosOnAfterPrint'
        OnBeforePrint = 'rlbDadosOnBeforePrint'
        Child = frxQckEstatAnalResult2J.CSalPor
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object shpCtaRes: TfrxShapeView
          Top = 0.779530000000022500
          Width = 2377.324370000000000000
          Height = 18.897650000000000000
          Visible = False
        end
        object Linha: TfrxLineView
          Align = baWidth
          Top = 0.755905509999990900
          Width = 2381.103900000000000000
          Visible = False
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllDesCam: TfrxMemoView
          Left = 7.559055120000000000
          Top = 2.000000000000000000
          Width = 267.061410000000000000
          Height = 17.000000000000000000
          DataField = 'REL_DESCAM'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REL_DESCAM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj001: TfrxMemoView
          Align = baLeft
          Left = 274.620465120000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ001'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ001"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj002: TfrxMemoView
          Align = baLeft
          Left = 365.329126540000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ002'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ002"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj003: TfrxMemoView
          Align = baLeft
          Left = 456.037787960000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ003'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ003"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj004: TfrxMemoView
          Align = baLeft
          Left = 546.746449380000100000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ004'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ004"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj005: TfrxMemoView
          Align = baLeft
          Left = 637.455110800000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ005'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ005"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj006: TfrxMemoView
          Align = baLeft
          Left = 728.163772220000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ006'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ006"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojTot: TfrxMemoView
          Align = baLeft
          Left = 2179.502354930000000000
          Top = 1.889763780000010000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllLojTotOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."REL_CALTOT">, <frxRelatorio."REL_TOTAL">,'
            
              '<frxRelatorio."REL_LOJ001"> + <frxRelatorio."REL_LOJ002"> + <frx' +
              'Relatorio."REL_LOJ003"> + <frxRelatorio."REL_LOJ004"> + <frxRela' +
              'torio."REL_LOJ005"> + '
            
              '<frxRelatorio."REL_LOJ006"> + <frxRelatorio."REL_LOJ007"> + <frx' +
              'Relatorio."REL_LOJ008"> + <frxRelatorio."REL_LOJ009"> + <frxRela' +
              'torio."REL_LOJ010"> + '
            
              '<frxRelatorio."REL_LOJ011"> + <frxRelatorio."REL_LOJ012"> + <frx' +
              'Relatorio."REL_LOJ013"> + <frxRelatorio."REL_LOJ014"> + <frxRela' +
              'torio."REL_LOJ015"> +'
            
              ' <frxRelatorio."REL_LOJ016"> + <frxRelatorio."REL_LOJ017"> + <fr' +
              'xRelatorio."REL_LOJ018"> + <frxRelatorio."REL_LOJ019"> + <frxRel' +
              'atorio."REL_LOJ020"> + <frxRelatorio."REL_LOJ021"> +'
            ' <fltTotalPortadores>)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj007: TfrxMemoView
          Align = baLeft
          Left = 818.872433640000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ007'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ007"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj008: TfrxMemoView
          Align = baLeft
          Left = 909.581095060000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ008'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ008"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj009: TfrxMemoView
          Align = baLeft
          Left = 1000.289756480000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ009'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ009"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj010: TfrxMemoView
          Align = baLeft
          Left = 1090.998417900000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ010'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ010"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllPerc: TfrxMemoView
          Align = baLeft
          Left = 2270.211016350001000000
          Top = 2.000000000000000000
          Width = 95.774236430000000000
          Height = 17.000000000000000000
          DataField = 'REL_MARGEM'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00%'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_MARGEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj011: TfrxMemoView
          Align = baLeft
          Left = 1181.707079320000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ011'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ011"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj012: TfrxMemoView
          Align = baWidth
          Left = 1272.415740740000000000
          Top = 1.779530000000022000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ012'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ012"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Align = baLeft
          ShiftMode = smDontShift
          Left = 2365.985252780001000000
          Top = 1.779530000000022000
          Width = 740.787938580000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          ParentFont = False
          Wysiwyg = False
          VAlign = vaCenter
        end
        object rllLoj013: TfrxMemoView
          Align = baLeft
          Left = 1363.124402160000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ013"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj014: TfrxMemoView
          Left = 1453.833063570000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ014"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj015: TfrxMemoView
          Align = baLeft
          Left = 1544.541724990000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ015"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj016: TfrxMemoView
          Align = baLeft
          Left = 1635.250386410000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ016"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj017: TfrxMemoView
          Align = baLeft
          Left = 1725.959047830000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ017"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj018: TfrxMemoView
          Align = baLeft
          Left = 1816.667709250000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ018"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj019: TfrxMemoView
          Align = baLeft
          Left = 1907.376370670000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ019"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj020: TfrxMemoView
          Align = baLeft
          Left = 1998.085032090000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ020"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj021: TfrxMemoView
          Align = baLeft
          Left = 2088.793693510000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ021"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbSumarioGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 5.661410000000000000
        Top = 313.700990000000000000
        Width = 2381.103900000000000000
      end
      object rlbSumario: TfrxFooter
        FillType = ftBrush
        Top = 343.937230000000000000
        Width = 2381.103900000000000000
        OnBeforePrint = 'rlbSumarioOnBeforePrint'
        Child = frxQckEstatAnalResult2J.CSalPor
        PrintChildIfInvisible = True
      end
      object CSalPor: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 366.614410000000000000
        Width = 2381.103900000000000000
        OnBeforePrint = 'CSalPorOnBeforePrint'
        Child = frxQckEstatAnalResult2J.CResFor
        PrintChildIfInvisible = True
        object qckSalPor: TfrxSubreport
          Width = 737.008350000000000000
          Height = 18.897637800000000000
          Page = frxQckEstatAnalResult2J.Page1
        end
      end
      object CResFor: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 408.189240000000000000
        Width = 2381.103900000000000000
        PrintChildIfInvisible = True
        object qckResFor: TfrxSubreport
          Top = -0.000006100000007336
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxQckEstatAnalResult2J.Page2
        end
      end
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 650.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 18.897650000000000000
        Width = 2381.103900000000000000
        ReprintOnNewPage = True
        object rllSalPor: TfrxMemoView
          Left = 7.559060000000000000
          Top = 1.889763779999999000
          Width = 267.212591100000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'SALDO DE PORTADORES')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitSalPor: TfrxMemoView
          Align = baLeft
          Left = 2179.653540920000000000
          Top = 1.889763779999999000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Align = baWidth
          Left = 2270.362202340000000000
          Top = 1.889763777362209000
          Width = 110.741697660000000000
          Height = 18.897637795275600000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object rllCabLojPor01: TfrxMemoView
          Align = baLeft
          Left = 274.771651100000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-001')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLojPor02: TfrxMemoView
          Align = baLeft
          Left = 365.480312520000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-002')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLojPor03: TfrxMemoView
          Align = baLeft
          Left = 456.188973940000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-003')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLojPor04: TfrxMemoView
          Align = baLeft
          Left = 546.897635360000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-004')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLojPor05: TfrxMemoView
          Align = baLeft
          Left = 637.606296780000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-005')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLojPor06: TfrxMemoView
          Align = baLeft
          Left = 728.314958200000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-006')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLojPor07: TfrxMemoView
          Align = baLeft
          Left = 819.023619620000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-007')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLojPor08: TfrxMemoView
          Align = baLeft
          Left = 909.732281040000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-008')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLojPor09: TfrxMemoView
          Align = baLeft
          Left = 1000.440942460000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-009')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor10: TfrxMemoView
          Align = baLeft
          Left = 1091.149603880000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-010')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor11: TfrxMemoView
          Align = baLeft
          Left = 1181.858265300000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-011')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor12: TfrxMemoView
          Align = baLeft
          Left = 1272.566926720000000000
          Top = 2.000000000000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-012')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor13: TfrxMemoView
          Align = baLeft
          Left = 1363.275588140000000000
          Top = 2.066938900000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-013')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor14: TfrxMemoView
          Align = baLeft
          Left = 1453.984249560000000000
          Top = 2.066938900000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-014')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor15: TfrxMemoView
          Align = baLeft
          Left = 1544.692910980000000000
          Top = 2.066938900000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-015')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor16: TfrxMemoView
          Align = baLeft
          Left = 1635.401572400000000000
          Top = 2.066938900000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-016')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor17: TfrxMemoView
          Align = baLeft
          Left = 1726.110233820000000000
          Top = 2.066938900000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-017')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor18: TfrxMemoView
          Align = baLeft
          Left = 1816.818895240000000000
          Top = 2.066938900000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-018')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor19: TfrxMemoView
          Align = baLeft
          Left = 1907.527556660000000000
          Top = 2.066938900000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-019')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor20: TfrxMemoView
          Align = baLeft
          Left = 1998.236218080000000000
          Top = 2.066938900000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-020')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor21: TfrxMemoView
          Align = baLeft
          Left = 2088.944879500000000000
          Top = 2.066938900000000000
          Width = 90.708661420000000000
          Height = 18.897637800000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-021')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 64.252010000000000000
        Width = 2381.103900000000000000
        DataSet = frxSalPor
        DataSetName = 'frxSalPor'
        RowCount = 0
        object rllDetSalPor: TfrxMemoView
          Align = baLeft
          Left = 2179.653384700000000000
          Top = 3.779527560000000000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[<frxSalPor."REL_LOJ001"> + <frxSalPor."REL_LOJ002"> + <frxSalPo' +
              'r."REL_LOJ003"> +'
            
              ' <frxSalPor."REL_LOJ004"> + <frxSalPor."REL_LOJ005"> + <frxSalPo' +
              'r."REL_LOJ006"> +'
            
              ' <frxSalPor."REL_LOJ007"> + <frxSalPor."REL_LOJ008"> + <frxSalPo' +
              'r."REL_LOJ009"> +'
            
              ' <frxSalPor."REL_LOJ010"> + <frxSalPor."REL_LOJ011"> + <frxSalPo' +
              'r."REL_LOJ012"> +'
            
              ' <frxSalPor."REL_LOJ013"> + <frxSalPor."REL_LOJ014"> + <frxSalPo' +
              'r."REL_LOJ015"> +'
            
              ' <frxSalPor."REL_LOJ016"> + <frxSalPor."REL_LOJ017"> + <frxSalPo' +
              'r."REL_LOJ018"> +'
            
              ' <frxSalPor."REL_LOJ019"> + <frxSalPor."REL_LOJ020"> + <frxSalPo' +
              'r."REL_LOJ021">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllNomPor: TfrxMemoView
          Left = 47.999851100000000000
          Top = 3.779527560000005000
          Width = 226.771643780000000000
          Height = 15.118110240000000000
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxSalPor."POR_NOMPOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCodPor: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779527560000005000
          Width = 40.440791100000000000
          Height = 15.118110240000000000
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxSalPor."POR_CODPOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor002: TfrxMemoView
          Align = baLeft
          Left = 365.480156300000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ002"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor003: TfrxMemoView
          Align = baLeft
          Left = 456.188817720000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ003"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor004: TfrxMemoView
          Align = baLeft
          Left = 546.897479140000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ004"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor005: TfrxMemoView
          Align = baLeft
          Left = 637.606140560000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ005"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor006: TfrxMemoView
          Align = baLeft
          Left = 728.314801980000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ006"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor007: TfrxMemoView
          Align = baLeft
          Left = 819.023463400000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ007"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor008: TfrxMemoView
          Align = baLeft
          Left = 909.732124820000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ008"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor009: TfrxMemoView
          Align = baLeft
          Left = 1000.440786240000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ009"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor010: TfrxMemoView
          Align = baLeft
          Left = 1091.149447660000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ010"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor011: TfrxMemoView
          Align = baLeft
          Left = 1181.858109080000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ011"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor012: TfrxMemoView
          Align = baWidth
          Left = 1272.566770500000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ012"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor013: TfrxMemoView
          Align = baLeft
          Left = 1363.275431920000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REL_LOJ013"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor014: TfrxMemoView
          Align = baLeft
          Left = 1453.984093340000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ014"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor015: TfrxMemoView
          Align = baLeft
          Left = 1544.692754760000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ015"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor016: TfrxMemoView
          Align = baLeft
          Left = 1635.401416180000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ016"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor017: TfrxMemoView
          Align = baLeft
          Left = 1726.110077600000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ017"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor018: TfrxMemoView
          Align = baLeft
          Left = 1816.818739020000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ018"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor019: TfrxMemoView
          Align = baLeft
          Left = 1907.527400440000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ019"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor020: TfrxMemoView
          Align = baLeft
          Left = 1998.236061860000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ020"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor021: TfrxMemoView
          Align = baLeft
          Left = 2088.944723280000000000
          Top = 3.779527560000005000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ021"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor001: TfrxMemoView
          Align = baLeft
          Left = 274.771494880000000000
          Top = 3.779527560000000000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSalPor."REL_LOJ001"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 109.606370000000000000
        Width = 2381.103900000000000000
        OnBeforePrint = 'Footer1OnBeforePrint'
        object rllTotSalPor: TfrxMemoView
          Align = baLeft
          Left = 2179.653540920000000000
          Top = 3.779534880000000000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxSalPor."REL_LOJ001"> + <frxSalPor."REL_LOJ002"> + <frxS' +
              'alPor."REL_LOJ003"> +'
            
              ' <frxSalPor."REL_LOJ004"> + <frxSalPor."REL_LOJ005"> + <frxSalPo' +
              'r."REL_LOJ006"> +'
            
              ' <frxSalPor."REL_LOJ007"> + <frxSalPor."REL_LOJ008"> + <frxSalPo' +
              'r."REL_LOJ009"> +'
            
              ' <frxSalPor."REL_LOJ010"> + <frxSalPor."REL_LOJ011"> + <frxSalPo' +
              'r."REL_LOJ012"> +'
            
              ' <frxSalPor."REL_LOJ013"> + <frxSalPor."REL_LOJ014"> + <frxSalPo' +
              'r."REL_LOJ015"> +'
            
              ' <frxSalPor."REL_LOJ016"> + <frxSalPor."REL_LOJ017"> + <frxSalPo' +
              'r."REL_LOJ018"> +'
            
              ' <frxSalPor."REL_LOJ019"> + <frxSalPor."REL_LOJ020"> + <frxSalPo' +
              'r."REL_LOJ021">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotPor: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779534880000000000
          Width = 267.212591100000000000
          Height = 15.118110240000000000
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL DOS PORTADORES')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Align = baWidth
          Width = 2381.103900000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 21.897650000000000000
          Width = 2381.103900000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllLojPorTot002: TfrxMemoView
          Align = baLeft
          Left = 365.480312520000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ002">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot003: TfrxMemoView
          Align = baLeft
          Left = 456.188973940000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ003">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot004: TfrxMemoView
          Align = baLeft
          Left = 546.897635360000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ004">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot005: TfrxMemoView
          Align = baLeft
          Left = 637.606296780000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ005">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot006: TfrxMemoView
          Align = baLeft
          Left = 728.314958200000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ006">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot007: TfrxMemoView
          Align = baLeft
          Left = 819.023619620000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ007">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot008: TfrxMemoView
          Align = baLeft
          Left = 909.732281040000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ008">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot009: TfrxMemoView
          Align = baLeft
          Left = 1000.440942460000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ009">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot010: TfrxMemoView
          Align = baLeft
          Left = 1091.149603880000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ010">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot011: TfrxMemoView
          Align = baLeft
          Left = 1181.858265300000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ011">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot012: TfrxMemoView
          Align = baWidth
          Left = 1272.566926720000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ012">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot013: TfrxMemoView
          Align = baLeft
          Left = 1363.275588140000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ013">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot014: TfrxMemoView
          Align = baLeft
          Left = 1453.984249560000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ014">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot015: TfrxMemoView
          Align = baLeft
          Left = 1544.692910980000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ015">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot016: TfrxMemoView
          Align = baLeft
          Left = 1635.401572400000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ016">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot017: TfrxMemoView
          Align = baLeft
          Left = 1726.110233820000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ017">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot018: TfrxMemoView
          Align = baLeft
          Left = 1816.818895240000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ018">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot019: TfrxMemoView
          Align = baLeft
          Left = 1907.527556660000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ019">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot020: TfrxMemoView
          Align = baLeft
          Left = 1998.236218080000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ020">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot021: TfrxMemoView
          Align = baLeft
          Left = 2088.944879500000000000
          Top = 3.779529999999994000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ021">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPorTot001: TfrxMemoView
          Align = baLeft
          Left = 274.771651100000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSalPor."REL_LOJ001">,MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object Page2: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 650.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 56.692913390000000000
        Top = 18.897650000000000000
        Width = 2381.103900000000000000
        object Memo5: TfrxMemoView
          Align = baWidth
          Top = 37.015748040000000000
          Width = 2381.103900000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 5.118120000000000000
          Top = 37.015741940000000000
          Width = 56.692913390000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 67.724490000000000000
          Top = 37.015741940000000000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO FORNECEDOR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 263.425480000000000000
          Top = 37.015741940000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LIT/KIL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 364.252320000000000000
          Top = 37.015741940000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PRZ. MED')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 464.858690000000000000
          Top = 37.015741940000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'FAT.VISTA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 564.906000000000000000
          Top = 37.015741940000000000
          Width = 37.795275590000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 608.819420000000000000
          Top = 37.015741940000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'FAT.PRAZO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 708.646260000000000000
          Top = 37.015741940000000000
          Width = 37.795275590000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 751.559680000000000000
          Top = 37.015741940000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOT. CUS')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitMar: TfrxMemoView
          Left = 852.166050000000000000
          Top = 37.015741940000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MARGEM')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 952.992890000000000000
          Top = 37.015741940000000000
          Width = 56.692913390000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% REP.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 1015.803960000000000000
          Top = 37.015741940000000000
          Width = 56.692913390000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% ACUM.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Align = baCenter
          Left = 1037.480985000000000000
          Top = 7.559060000000000000
          Width = 306.141930000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE FORNECEDORES')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbResFor: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 98.267780000000000000
        Width = 2381.103900000000000000
        DataSet = frxResFor
        DataSetName = 'frxResFor'
        RowCount = 0
        object Memo28: TfrxMemoView
          Left = 5.118120000000000000
          Top = -0.000006100000000002
          Width = 56.692913390000000000
          Height = 18.897650000000000000
          DataField = 'CODFOR'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxResFor."CODFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 67.724490000000000000
          Top = -0.000006100000000002
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          DataField = 'NOMFOR'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxResFor."NOMFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 263.425480000000000000
          Top = -0.000006100000000002
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'PESLIT'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PESLIT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 364.252320000000000000
          Top = -0.000006100000000002
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'PRZMED'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PRZMED"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 464.858690000000000000
          Top = -0.000006100000000002
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'TOTVIS'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."TOTVIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 564.906000000000000000
          Top = -0.000006100000000002
          Width = 37.795275590000000000
          Height = 18.897650000000000000
          DataField = 'PERVIS'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PERVIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 608.819420000000000000
          Top = -0.000006100000000002
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'TOTPRZ'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."TOTPRZ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 708.646260000000000000
          Top = -0.000006100000000002
          Width = 37.795275590000000000
          Height = 18.897650000000000000
          DataField = 'PERPRZ'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PERPRZ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 751.559680000000000000
          Top = -0.000006100000000002
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'TOTCUS'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."TOTCUS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbMargem: TfrxMemoView
          Left = 852.166050000000000000
          Top = -0.000006100000000002
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'MARGEM'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."MARGEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 952.992890000000000000
          Top = -0.000006100000000002
          Width = 56.692913390000000000
          Height = 18.897650000000000000
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PERREP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 1015.803960000000000000
          Top = -0.000006100000000002
          Width = 56.692913390000000000
          Height = 18.897650000000000000
          DataField = 'PERACU'
          DataSet = frxResFor
          DataSetName = 'frxResFor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFor."PERACU"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 139.842610000000000000
        Width = 2381.103900000000000000
        object Memo19: TfrxMemoView
          Align = baClient
          Width = 2381.103900000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 263.425480000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFor."PESLIT">,rlbResFor)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 364.252320000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 464.858690000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFor."TOTVIS">,rlbResFor)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 608.819420000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFor."TOTPRZ">,rlbResFor)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 751.559680000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFor."TOTCUS">,rlbResFor)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbTotMar: TfrxMemoView
          Left = 852.166050000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalculaPrecoVendaInt(SUM(<frxResFor."TOTCUS">,rlbResFor), SUM(' +
              '<frxResFor."TOTVEN">,rlbResFor))]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
  object popSel: TPopupMenu
    Left = 384
    Top = 232
    object mnuSelTudo: TMenuItem
      Caption = '&Marcar Tudo'
      OnClick = mnuSelTudoClick
    end
    object DesmarcarTudo1: TMenuItem
      Caption = '&Desmarcar Tudo'
      OnClick = DesmarcarTudo1Click
    end
  end
end
