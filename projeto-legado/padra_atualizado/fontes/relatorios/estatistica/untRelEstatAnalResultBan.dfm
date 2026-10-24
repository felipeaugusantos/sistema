inherited frmRelEstatAnalResultBan: TfrmRelEstatAnalResultBan
  Left = 365
  Top = 205
  Width = 555
  Height = 473
  Caption = 'Relat'#243'rio de An'#225'lise de Resultado (Movimento Banc'#225'rio)'
  OnDestroy = FormDestroy
  ExplicitWidth = 555
  ExplicitHeight = 473
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 402
    Width = 549
    Anchors = [akBottom]
    ExplicitTop = 399
    ExplicitWidth = 546
    inherited FlwBotoes: TFlowPanel
      Width = 443
      Align = alLeft
      Anchors = [akTop, akBottom]
      ExplicitTop = 2
      ExplicitWidth = 443
      inherited btnImprimir: TBitBtnLocked
        Anchors = [akLeft, akRight, akBottom]
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 470
      ExplicitLeft = 467
    end
  end
  inherited pnlDados: TPanel
    Width = 549
    Height = 402
    ExplicitWidth = 546
    ExplicitHeight = 399
    object Label4: TLabel [0]
      Left = 279
      Top = 2
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
      Top = 20
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
      Top = 58
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
    object Label6: TLabel [3]
      Left = 8
      Top = 40
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
    object Label5: TLabel [4]
      Left = 8
      Top = 2
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
    object Label1: TLabel [5]
      Left = 8
      Top = 79
      Width = 268
      Height = 14
      Caption = 'Composi'#231#227'o do Pre'#231'o de Custo para Custo de Produtos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [6]
      Left = 492
      Top = 2
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
    object lblPreCus: TLabel [7]
      Left = 8
      Top = 379
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
    object rdgFatura: TRadioGroup [8]
      Left = 8
      Top = 290
      Width = 313
      Height = 53
      Caption = 'Faturamento'
      ItemIndex = 0
      Items.Strings = (
        'Exibir Faturamento Resumido "A Vista" e "A Prazo"'
        'Exibir Faturamento Anal'#237'tico por Condi'#231#227'o de Pagamento')
      TabOrder = 8
    end
    object rdgOrientacao: TRadioGroup [9]
      Left = 8
      Top = 237
      Width = 265
      Height = 51
      Caption = 'Orienta'#231#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Retrato'
        'Paisagem')
      TabOrder = 6
      OnClick = rdgOrientacaoClick
    end
    object rdgTipOri: TRadioGroup [10]
      Left = 8
      Top = 184
      Width = 265
      Height = 51
      Caption = 'Tipo Orienta'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Distribu'#237'do'
        'Consolidado')
      TabOrder = 4
      OnClick = rdgOrientacaoClick
    end
    object rdgExibir: TRadioGroup [11]
      Left = 8
      Top = 117
      Width = 265
      Height = 66
      Caption = 'Exibir'
      ItemIndex = 0
      Items.Strings = (
        'Conta de Resultado'
        'Plano de Contas'
        'Centro de Custo')
      TabOrder = 3
    end
    inherited gpbDestino: TGroupBox
      Left = 279
      Top = 237
      Width = 259
      Height = 51
      TabOrder = 7
      ExplicitLeft = 279
      ExplicitTop = 237
      ExplicitWidth = 259
      ExplicitHeight = 51
      inherited ColorLabel1: TColorLabel
        Top = 23
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitTop = 23
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Left = 8
        Top = 19
        OnChange = edtDestinoChange
        ExplicitLeft = 8
        ExplicitTop = 19
      end
    end
    object lstEmpresas: TCheckListBox
      Left = 279
      Top = 16
      Width = 259
      Height = 219
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
      TabOrder = 5
      OnEnter = lstEmpresasEnter
      OnKeyDown = lstEmpresasKeyDown
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 54
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
      Top = 16
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
    object cbbComCus: TComboBoxFocus
      Tag = 99
      Left = 8
      Top = 94
      Width = 265
      Height = 22
      Style = csDropDownList
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkExibeAcreFin: TCheckBox
      Left = 8
      Top = 346
      Width = 380
      Height = 17
      Caption = 'Exibir se'#231#227'o de Acr'#233'scimo Financeiro sobre Vendas'
      TabOrder = 10
    end
    object rdgSalPor: TRadioGroup
      Left = 326
      Top = 290
      Width = 212
      Height = 53
      Caption = 'Saldo de Portadores'
      ItemIndex = 1
      Items.Strings = (
        'Exibir somente registros conciliados'
        'Exibir todos os registros')
      TabOrder = 9
    end
    object chkPerDes: TCheckBox
      Left = 8
      Top = 362
      Width = 380
      Height = 17
      Caption = 'Exibir porcentagem do Valor de Despesas'
      TabOrder = 11
    end
  end
  inherited pnlStatus: TPanel
    Top = 428
    Width = 549
    ExplicitTop = 425
    ExplicitWidth = 546
    inherited pnlNomeForm: TPanel
      Left = 378
      ExplicitLeft = 375
    end
    inherited pnlInfo: TPanel
      Width = 378
      ExplicitWidth = 375
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 712
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
  inherited ApplicationEvents: TApplicationEvents
    Left = 1064
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 32
  end
  object cdsRelat: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'REL_CODREL'
    Params = <>
    Left = 328
    Top = 80
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
    object cdsRelatREL_LOJ001: TFloatField
      FieldName = 'REL_LOJ001'
    end
    object cdsRelatREL_LOJ002: TFloatField
      FieldName = 'REL_LOJ002'
    end
    object cdsRelatREL_LOJ003: TFloatField
      FieldName = 'REL_LOJ003'
    end
    object cdsRelatREL_LOJ004: TFloatField
      FieldName = 'REL_LOJ004'
    end
    object cdsRelatREL_LOJ005: TFloatField
      FieldName = 'REL_LOJ005'
    end
    object cdsRelatREL_LOJ006: TFloatField
      FieldName = 'REL_LOJ006'
    end
    object cdsRelatREL_LOJ007: TFloatField
      FieldName = 'REL_LOJ007'
    end
    object cdsRelatREL_LOJ008: TFloatField
      FieldName = 'REL_LOJ008'
    end
    object cdsRelatREL_LOJ009: TFloatField
      FieldName = 'REL_LOJ009'
    end
    object cdsRelatREL_LOJ010: TFloatField
      FieldName = 'REL_LOJ010'
    end
    object cdsRelatREL_LOJ011: TFloatField
      FieldName = 'REL_LOJ011'
    end
    object cdsRelatREL_LOJ012: TFloatField
      FieldName = 'REL_LOJ012'
    end
    object cdsRelatREL_LOJ013: TFloatField
      FieldName = 'REL_LOJ013'
    end
    object cdsRelatREL_LOJ014: TFloatField
      FieldName = 'REL_LOJ014'
    end
    object cdsRelatREL_LOJ015: TFloatField
      FieldName = 'REL_LOJ015'
    end
    object cdsRelatREL_LOJ016: TFloatField
      FieldName = 'REL_LOJ016'
    end
    object cdsRelatREL_LOJ017: TFloatField
      FieldName = 'REL_LOJ017'
    end
    object cdsRelatREL_LOJ018: TFloatField
      FieldName = 'REL_LOJ018'
    end
    object cdsRelatREL_LOJ019: TFloatField
      FieldName = 'REL_LOJ019'
    end
    object cdsRelatREL_LOJ020: TFloatField
      FieldName = 'REL_LOJ020'
    end
    object cdsRelatREL_LOJ021: TFloatField
      FieldName = 'REL_LOJ021'
    end
    object cdsRelatREL_LOJ022: TFloatField
      FieldName = 'REL_LOJ022'
    end
    object cdsRelatREL_LOJ023: TFloatField
      FieldName = 'REL_LOJ023'
    end
    object cdsRelatREL_LOJ024: TFloatField
      FieldName = 'REL_LOJ024'
    end
    object cdsRelatREL_LOJ025: TFloatField
      FieldName = 'REL_LOJ025'
    end
    object cdsRelatREL_LOJ026: TFloatField
      FieldName = 'REL_LOJ026'
    end
    object cdsRelatREL_LOJ027: TFloatField
      FieldName = 'REL_LOJ027'
    end
    object cdsRelatREL_LOJ028: TFloatField
      FieldName = 'REL_LOJ028'
    end
    object cdsRelatREL_LOJ029: TFloatField
      FieldName = 'REL_LOJ029'
    end
    object cdsRelatREL_LOJ030: TFloatField
      FieldName = 'REL_LOJ030'
    end
    object cdsRelatREL_MARGEM: TFloatField
      FieldName = 'REL_MARGEM'
    end
    object cdsRelatREL_MAR001: TFloatField
      FieldName = 'REL_MAR001'
    end
    object cdsRelatREL_MAR002: TFloatField
      FieldName = 'REL_MAR002'
    end
    object cdsRelatREL_MAR003: TFloatField
      FieldName = 'REL_MAR003'
    end
    object cdsRelatREL_MAR004: TFloatField
      FieldName = 'REL_MAR004'
    end
    object cdsRelatREL_MAR005: TFloatField
      FieldName = 'REL_MAR005'
    end
    object cdsRelatREL_MAR006: TFloatField
      FieldName = 'REL_MAR006'
    end
    object cdsRelatREL_MAR007: TFloatField
      FieldName = 'REL_MAR007'
    end
    object cdsRelatREL_MAR008: TFloatField
      FieldName = 'REL_MAR008'
    end
    object cdsRelatREL_MAR009: TFloatField
      FieldName = 'REL_MAR009'
    end
    object cdsRelatREL_MAR010: TFloatField
      FieldName = 'REL_MAR010'
    end
    object cdsRelatREL_MAR011: TFloatField
      FieldName = 'REL_MAR011'
    end
    object cdsRelatREL_MAR012: TFloatField
      FieldName = 'REL_MAR012'
    end
    object cdsRelatREL_MAR013: TFloatField
      FieldName = 'REL_MAR013'
    end
    object cdsRelatREL_MAR014: TFloatField
      FieldName = 'REL_MAR014'
    end
    object cdsRelatREL_MAR015: TFloatField
      FieldName = 'REL_MAR015'
    end
    object cdsRelatREL_MAR016: TFloatField
      FieldName = 'REL_MAR016'
    end
    object cdsRelatREL_MAR017: TFloatField
      FieldName = 'REL_MAR017'
    end
    object cdsRelatREL_MAR018: TFloatField
      FieldName = 'REL_MAR018'
    end
    object cdsRelatREL_MAR019: TFloatField
      FieldName = 'REL_MAR019'
    end
    object cdsRelatREL_MAR020: TFloatField
      FieldName = 'REL_MAR020'
    end
    object cdsRelatREL_MAR021: TFloatField
      FieldName = 'REL_MAR021'
    end
    object cdsRelatREL_MAR022: TFloatField
      FieldName = 'REL_MAR022'
    end
    object cdsRelatREL_MAR023: TFloatField
      FieldName = 'REL_MAR023'
    end
    object cdsRelatREL_MAR024: TFloatField
      FieldName = 'REL_MAR024'
    end
    object cdsRelatREL_MAR025: TFloatField
      FieldName = 'REL_MAR025'
    end
    object cdsRelatREL_MAR026: TFloatField
      FieldName = 'REL_MAR026'
    end
    object cdsRelatREL_MAR027: TFloatField
      FieldName = 'REL_MAR027'
    end
    object cdsRelatREL_MAR028: TFloatField
      FieldName = 'REL_MAR028'
    end
    object cdsRelatREL_MAR029: TFloatField
      FieldName = 'REL_MAR029'
    end
    object cdsRelatREL_MAR030: TFloatField
      FieldName = 'REL_MAR030'
    end
  end
  object frxSalPor: TfrxDBDataset
    UserName = 'frxSalPor'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 328
    Top = 136
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
    ReportOptions.LastChange = 40877.746708622690000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  bln: Boolean;'
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
      '  If (<frxRelatorio."REL_CODCAM"> = '#39'MARCON'#39') Or'
      '     (<frxRelatorio."REL_CODCAM"> = '#39'MARLIQ'#39') Or'
      '     (<frxRelatorio."REL_CODCAM"> = '#39'PERREA'#39') Or         '
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
      ''
      '    If (<frxRelatorio."REL_CODCAM"> <> '#39'VAREST'#39') Then'
      '    Begin                  '
      '      rllLojTot.Memo.Clear;'
      '      rllLojTot.Memo.Add('#39'[frxRelatorio."REL_MARGEM"]'#39');'
      '      rllPerc.Memo.Clear;'
      '      rllPerc.DataField := '#39#39';'
      '    End'
      '    Else'
      '      rllLojTot.Text := fRetTotalVariacao;        '
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
      
        '    rllLojTot.Memo.Add('#39'[(<frxRelatorio."REL_LOJ001"> + <frxRela' +
        'torio."REL_LOJ002"> + <frxRelatorio."REL_LOJ003"> + <frxRelatori' +
        'o."REL_LOJ004"> + <frxRelatorio."REL_LOJ005"> + <frxRelatorio."R' +
        'EL_LOJ006"> + <frxRelatorio."REL_LOJ007"> + <frxRelatorio."REL_L' +
        'OJ008"> + <frxRelatorio."REL_LOJ009"> + <frxRelatorio."REL_LOJ01' +
        '0"> + <frxRelatorio."REL_LOJ011"> + <frxRelatorio."REL_LOJ012"> ' +
        '+ <frxRelatorio."REL_LOJ013"> + <frxRelatorio."REL_LOJ014"> + <f' +
        'rxRelatorio."REL_LOJ015"> + <frxRelatorio."REL_LOJ016"> + <frxRe' +
        'latorio."REL_LOJ017"> + <frxRelatorio."REL_LOJ018"> + <frxRelato' +
        'rio."REL_LOJ019"> + <frxRelatorio."REL_LOJ020">)]'#39');          '
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
      'procedure DMPMemo38OnAfterData(Sender: TfrxComponent);'
      'begin'
      
        '  If <frxRelatorio."REL_DESGRU"> = '#39'ACR'#201'SCIMO FINANCEIRO (VENDA)' +
        #39' Then'
      '    DMPMemo38.Text := '#39'% SOBRE PR.TAB'#39';    '
      'end;'
      ''
      'begin'
      '  bln := True;'
      '    '
      'end.')
    OnUserFunction = frxQckEstatAnalResult2MUserFunction
    Left = 240
    Top = 56
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
      PaperWidth = 581.659624344826000000
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
        Height = 34.000000000000000000
        Top = 357.000000000000000000
        Width = 2160.000000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Align = baLeft
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            ' [frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Align = baWidth
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 1420.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDados)] ')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 2140.800000000000000000
          Color = clBlack
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
          Left = 835.200000000000000000
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
          Width = 96.000000000000000000
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
          Left = 9.600000000000000000
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
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[SALPOR]')
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
          Width = 134.400000000000000000
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
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 672.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1881.600000000000000000
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
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1209.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1344.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1478.400000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1612.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1747.200000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 2025.600000000000000000
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
          Width = 134.400000000000000000
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
          Left = 403.200000000000000000
          Width = 134.400000000000000000
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
          Left = 537.600000000000000000
          Width = 134.400000000000000000
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
          Left = 672.000000000000000000
          Width = 134.400000000000000000
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
          Left = 806.400000000000000000
          Width = 134.400000000000000000
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
          Left = 940.800000000000000000
          Width = 134.400000000000000000
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
          Left = 1881.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."REL_LOJ001"> + <frxRelatorio."REL_LOJ002"> + <f' +
              'rxRelatorio."REL_LOJ003"> + <frxRelatorio."REL_LOJ004"> + <frxRe' +
              'latorio."REL_LOJ005"> + <frxRelatorio."REL_LOJ006"> + <frxRelato' +
              'rio."REL_LOJ007"> + <frxRelatorio."REL_LOJ008"> + <frxRelatorio.' +
              '"REL_LOJ009"> + <frxRelatorio."REL_LOJ010"> + <frxRelatorio."REL' +
              '_LOJ011"> + <frxRelatorio."REL_LOJ012"> + <frxRelatorio."REL_LOJ' +
              '013"> + <frxRelatorio."REL_LOJ014"> + <frxRelatorio."REL_LOJ015"' +
              '> + <frxRelatorio."REL_LOJ016"> + <frxRelatorio."REL_LOJ017"> + ' +
              '<frxRelatorio."REL_LOJ018"> + <frxRelatorio."REL_LOJ019"> + <frx' +
              'Relatorio."REL_LOJ020">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLoj007: TfrxDMPMemoView
          Align = baLeft
          Left = 1075.200000000000000000
          Width = 134.400000000000000000
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
          Left = 1209.600000000000000000
          Width = 134.400000000000000000
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
          Left = 1344.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1478.400000000000000000
          Width = 134.400000000000000000
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
          Left = 2025.600000000000000000
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
          Left = 1612.800000000000000000
          Width = 134.400000000000000000
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
          Left = 1747.200000000000000000
          Width = 134.400000000000000000
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
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 2160.000000000000000000
        object qckSalPor: TfrxSubreport
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Page = frxQckEstatAnalResult2M.Page1
        end
      end
    end
    object Page1: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 581.659624344826000000
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
        object DMPMemo5: TfrxDMPMemoView
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
          Left = 1881.600000000000000000
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
          Width = 134.400000000000000000
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
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 672.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1209.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1344.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1478.400000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1612.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1747.200000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
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
        object DMPMemo7: TfrxDMPMemoView
          Width = 48.000000000000000000
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
          Left = 1881.600000000000000000
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
        object DMPMemo9: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataField = 'POR_NOMPOR'
          DataSet = frxSalPor
          DataSetName = 'frxSalPor'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxSalPor."POR_NOMPOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLojPor001: TfrxDMPMemoView
          Align = baLeft
          Left = 268.800000000000000000
          Width = 134.400000000000000000
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
          Left = 403.200000000000000000
          Width = 134.400000000000000000
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
          Left = 537.600000000000000000
          Width = 134.400000000000000000
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
          Left = 672.000000000000000000
          Width = 134.400000000000000000
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
          Left = 806.400000000000000000
          Width = 134.400000000000000000
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
          Left = 940.800000000000000000
          Width = 134.400000000000000000
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
          Left = 1075.200000000000000000
          Width = 134.400000000000000000
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
          Left = 1209.600000000000000000
          Width = 134.400000000000000000
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
          Left = 1344.000000000000000000
          Width = 134.400000000000000000
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
          Left = 1478.400000000000000000
          Width = 134.400000000000000000
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
          Left = 1612.800000000000000000
          Width = 134.400000000000000000
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
          Left = 1747.200000000000000000
          Width = 134.400000000000000000
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
    ReportOptions.LastChange = 40877.751425960600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      
        '  bln: Boolean;                                                 ' +
        '            '
      '  '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin                                                   '
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '              '
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
      '    '
      '  If <frxRelatorio."REL_CODCAM"> = '#39'***'#39' Then'
      '  Begin'
      '    Linha.Visible     := True;'
      '    rllLojTot.Visible := False;'
      '    rllPerc.Visible   := False;'
      '    rllLoj001.Visible := False;            '
      '  End'
      '  Else'
      '  Begin              '
      '    Linha.Visible     := False;              '
      '    rllLoj001.Visible := True;        '
      '    rllLojTot.Visible := True;'
      
        '    rllPerc.Visible   := True;                                  ' +
        '                          '
      '  End;      '
      '    '
      '  If (<frxRelatorio."REL_CODCAM"> = '#39'MARCON'#39') Or'
      '     (<frxRelatorio."REL_CODCAM"> = '#39'MARLIQ'#39') Or'
      '     (<frxRelatorio."REL_CODCAM"> = '#39'PERREA'#39') Or'
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
      '    rllLoj010.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj011.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLoj012.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';  '
      '    rllLojTot.DisplayFormat.FormatStr := '#39'#,##0.00%'#39';'
      ''
      '    If (<frxRelatorio."REL_CODCAM"> <> '#39'VAREST'#39') Then'
      '    Begin                '
      '      rllLojTot.Memo.Clear;'
      '      rllLojTot.Memo.Add('#39'[frxRelatorio."REL_MARGEM"]'#39');'
      '      rllPerc.Memo.Clear;'
      '      rllPerc.DataField := '#39#39';'
      '    End'
      '    Else'
      
        '      rllLojTot.Text := fRetTotalVariacao;                      ' +
        '                                                       '
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
      '    rllLoj010.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj011.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLoj012.DisplayFormat.FormatStr := '#39'#,##0.00'#39';  '
      '    rllLojTot.DisplayFormat.FormatStr := '#39'#,##0.00'#39';'
      '    rllLojTot.Memo.Clear;'
      
        '    rllLojTot.Memo.Add('#39'[(<frxRelatorio."REL_LOJ001"> + <frxRela' +
        'torio."REL_LOJ002"> + <frxRelatorio."REL_LOJ003"> + <frxRelatori' +
        'o."REL_LOJ004"> + <frxRelatorio."REL_LOJ005"> + <frxRelatorio."R' +
        'EL_LOJ006"> + <frxRelatorio."REL_LOJ007"> + <frxRelatorio."REL_L' +
        'OJ008"> + <frxRelatorio."REL_LOJ009"> + <frxRelatorio."REL_LOJ01' +
        '0"> + <frxRelatorio."REL_LOJ011"> + <frxRelatorio."REL_LOJ012"> ' +
        '+ <frxRelatorio."REL_LOJ013"> + <frxRelatorio."REL_LOJ014"> + <f' +
        'rxRelatorio."REL_LOJ015"> + <frxRelatorio."REL_LOJ016"> + <frxRe' +
        'latorio."REL_LOJ017"> + <frxRelatorio."REL_LOJ018"> + <frxRelato' +
        'rio."REL_LOJ019"> + <frxRelatorio."REL_LOJ020">)]'#39');'
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
      ''
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
      '    rllLojTot.Font.Style := 0;'
      '    rllPerc.Font.Style := 0;                '
      '  End;        '
      'end;'
      ''
      'procedure rlbDadosOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      
        '                                                                ' +
        '                                       '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    '
      'end;'
      ''
      'procedure rlbSumarioGrupoOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '    '
      'end;'
      ''
      'procedure rlbSumarioGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure Memo10OnAfterData(Sender: TfrxComponent);'
      'begin'
      
        '  If <frxRelatorio."REL_DESGRU"> = '#39'ACR'#201'SCIMO FINANCEIRO (VENDA)' +
        #39' Then'
      '    Memo10.Text := '#39'% SOBRE PR.TAB'#39';  '
      'end;'
      ''
      'begin'
      '  bln := True;    '
      'end.')
    OnUserFunction = frxQckEstatAnalResult2JUserFunction
    Left = 240
    Top = 88
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
      PaperWidth = 430.100000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 2.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 41.574817800000000000
        Top = 400.630180000000000000
        Width = 1549.985253000000000000
        object rllNomeForm: TfrxMemoView
          Align = baLeft
          Top = 20.728348900000020000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baWidth
          Left = 739.200000000000000000
          Top = 20.728348900000020000
          Width = 810.785253000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDados)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Top = 1.220469999999977000
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
        Height = 128.503951650000000000
        Top = 18.897650000000000000
        Width = 1549.985253000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 410.192626500000000000
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
          Left = 410.192626500000000000
          Top = 34.000000000000000000
          Width = 729.600000000000000000
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
          Left = 1319.585253000000000000
          Top = 17.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
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
          Left = 1444.385253000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
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
          Left = 1309.985253000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
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
          Left = 410.192626500000000000
          Top = 68.031496062992100000
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
          Width = 714.708661420000000000
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
          Left = 835.201023000000100000
          Top = 85.000000000000000000
          Width = 714.784230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PARAM2]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 7.559060000000000000
          Top = 105.826840000000000000
          Width = 714.708661420000000000
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
      object rlbDados: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 249.448980000000000000
        Width = 1549.985253000000000000
        OnAfterPrint = 'rlbDadosOnAfterPrint'
        OnBeforePrint = 'rlbDadosOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object shpCtaRes: TfrxShapeView
          Align = baClient
          Width = 1549.985253000000000000
          Height = 18.897637800000000000
          Visible = False
        end
        object rllDesCam: TfrxMemoView
          Left = 0.559060000000000000
          Top = 0.948818899999992100
          Width = 264.566929130000000000
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
          Left = 265.125989130000000000
          Top = 0.948818899999992100
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
            '[frxRelatorio."REL_LOJ001"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj002: TfrxMemoView
          Align = baLeft
          Left = 355.834650550000000000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
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
          Left = 446.543311967322800000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
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
          Left = 537.251973384645600000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
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
          Left = 627.960634801968400000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
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
          Left = 718.669296219291100000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
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
          Left = 1353.629926151260000000
          Top = 0.948818899999992100
          Width = 98.645669290000000000
          Height = 17.000000000000000000
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
            
              '[(<frxRelatorio."REL_LOJ001"> + <frxRelatorio."REL_LOJ002"> + <f' +
              'rxRelatorio."REL_LOJ003"> + <frxRelatorio."REL_LOJ004"> + <frxRe' +
              'latorio."REL_LOJ005"> + <frxRelatorio."REL_LOJ006"> + <frxRelato' +
              'rio."REL_LOJ007"> + <frxRelatorio."REL_LOJ008"> + <frxRelatorio.' +
              '"REL_LOJ009"> + <frxRelatorio."REL_LOJ010"> + <frxRelatorio."REL' +
              '_LOJ011"> + <frxRelatorio."REL_LOJ012"> + <frxRelatorio."REL_LOJ' +
              '013"> + <frxRelatorio."REL_LOJ014"> + <frxRelatorio."REL_LOJ015"' +
              '> + <frxRelatorio."REL_LOJ016"> + <frxRelatorio."REL_LOJ017"> + ' +
              '<frxRelatorio."REL_LOJ018"> + <frxRelatorio."REL_LOJ019"> + <frx' +
              'Relatorio."REL_LOJ020">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj007: TfrxMemoView
          Align = baLeft
          Left = 809.377957636613900000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
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
          Left = 900.086619053936800000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
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
          Left = 990.795280471259500000
          Top = 0.948818899999992100
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
        object rllPerc: TfrxMemoView
          Align = baLeft
          Left = 1452.275595441260000000
          Top = 0.948818899999992100
          Width = 99.401589450000000000
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
        object Linha: TfrxLineView
          Align = baClient
          Width = 1549.985253000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllLoj010: TfrxMemoView
          Align = baLeft
          Left = 1081.503941891260000000
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
        object rllLoj011: TfrxMemoView
          Align = baLeft
          Left = 1172.212603311260000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ011'
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
            '[frxRelatorio."REL_LOJ011"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLoj012: TfrxMemoView
          Align = baLeft
          Left = 1262.921264731260000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DataField = 'REL_LOJ012'
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
            '[frxRelatorio."REL_LOJ012"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Align = baWidth
          ShiftMode = smDontShift
          Left = 1551.677184891260000000
          Top = 1.000000000000000000
          Width = -1.691931891259401000
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
      end
      object rlbSumarioGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 5.669291338582680000
        Top = 291.023810000000000000
        Width = 1549.985253000000000000
        OnAfterPrint = 'rlbSumarioGrupoOnAfterPrint'
        OnBeforePrint = 'rlbSumarioGrupoOnBeforePrint'
      end
      object rlbSumario: TfrxFooter
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 321.260050000000000000
        Width = 1549.985253000000000000
        object qckSalPor: TfrxSubreport
          Width = 759.685530000000000000
          Height = 17.007874015748000000
          Page = frxQckEstatAnalResult2J.Page1
        end
      end
      object rlbTitulo: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 207.874150000000000000
        Width = 1549.985253000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        Condition = 'frxRelatorio."REL_CODREL"'
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1549.985253000000000000
          Height = 18.897637800000000000
          Fill.BackColor = clSilver
        end
        object rllCabLoj06: TfrxMemoView
          Align = baLeft
          Left = 718.669291336613900000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-006')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj02: TfrxMemoView
          Align = baLeft
          Left = 355.834645667322800000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-002')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj07: TfrxMemoView
          Align = baLeft
          Left = 809.377952753936800000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-007')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotal: TfrxMemoView
          Align = baLeft
          Left = 1353.629921263228000000
          Top = 0.948818899999992100
          Width = 98.645669290000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj09: TfrxMemoView
          Align = baLeft
          Left = 990.795275588582300000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-009')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj08: TfrxMemoView
          Align = baLeft
          Left = 900.086614171259500000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-008')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj05: TfrxMemoView
          Align = baLeft
          Left = 627.960629919291100000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-005')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj04: TfrxMemoView
          Align = baLeft
          Left = 537.251968501968300000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-004')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj03: TfrxMemoView
          Align = baLeft
          Left = 446.543307084645600000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-003')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTitDesGru: TfrxMemoView
          Left = 0.559055120000000000
          Top = 0.948818899999992100
          Width = 264.566929130000000000
          Height = 17.000000000000000000
          DataField = 'REL_DESGRU'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."REL_DESGRU"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj01: TfrxMemoView
          Align = baLeft
          Left = 265.125984250000000000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-001')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj10: TfrxMemoView
          Align = baLeft
          Left = 1081.503937005905000000
          Top = 0.948818899999992100
          Width = 90.708661417322800000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-010')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj11: TfrxMemoView
          Align = baLeft
          Left = 1172.212598423228000000
          Top = 0.948818899999992100
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-011')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLoj12: TfrxMemoView
          Align = baLeft
          Left = 1262.921259843228000000
          Top = 0.948818899999992100
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-012')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Align = baWidth
          ShiftMode = smDontShift
          Left = 1452.275590553228000000
          Top = 1.000000000000000000
          Width = 97.709662446772200000
          Height = 17.007874020000000000
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
      end
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 430.100000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 2.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 18.897637795275600000
        Top = 18.897650000000000000
        Width = 1549.985253000000000000
        ReprintOnNewPage = True
        object Memo11: TfrxMemoView
          Align = baClient
          Width = 1549.985253000000000000
          Height = 18.897637795275600000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 0.377952760000000000
          Top = 0.755905510000002000
          Width = 264.566929133858000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'SALDO DE PORTADORES')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Left = 1353.448818933860000000
          Top = 0.755905510000002000
          Width = 98.645669290000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCabLojPor06: TfrxMemoView
          Align = baLeft
          Left = 718.488188993858000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-006')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor02: TfrxMemoView
          Align = baLeft
          Left = 355.653543313858000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-002')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor07: TfrxMemoView
          Align = baLeft
          Left = 809.196850413858000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-007')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor09: TfrxMemoView
          Align = baLeft
          Left = 990.614173253858000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-009')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor08: TfrxMemoView
          Align = baLeft
          Left = 899.905511833858000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-008')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor05: TfrxMemoView
          Align = baLeft
          Left = 627.779527573858000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-005')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor04: TfrxMemoView
          Align = baLeft
          Left = 537.070866153858000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-004')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor03: TfrxMemoView
          Align = baLeft
          Left = 446.362204733858000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-003')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor01: TfrxMemoView
          Align = baLeft
          Left = 264.944881893858000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-001')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor10: TfrxMemoView
          Align = baLeft
          Left = 1081.322834673860000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-010')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor11: TfrxMemoView
          Align = baLeft
          Left = 1172.031496093860000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-011')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCabLojPor12: TfrxMemoView
          Align = baLeft
          Left = 1262.740157513860000000
          Top = 0.755905510000002000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LOJA-012')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 60.472480000000000000
        Width = 1549.985253000000000000
        DataSet = frxSalPor
        DataSetName = 'frxSalPor'
        RowCount = 0
        object Memo7: TfrxMemoView
          Left = 0.377952760000000000
          Top = 0.755905511811022000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'POR_CODPOR'
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
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 1353.560632390000000000
          Top = 0.755905509999998000
          Width = 98.645669290000000000
          Height = 15.118120000000000000
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
              'r."REL_LOJ012">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 50.379530000000000000
          Top = 0.755905509999998000
          Width = 214.677165350000000000
          Height = 15.118110240000000000
          DataField = 'POR_NOMPOR'
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
        object rllLojPor001: TfrxMemoView
          Align = baLeft
          Left = 265.056695350000000000
          Top = 0.755905509999998000
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
        object rllLojPor002: TfrxMemoView
          Align = baLeft
          Left = 355.765356770000000000
          Top = 0.755905509999998000
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
          Left = 446.474018190000000000
          Top = 0.755905509999998000
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
          Left = 537.182679610000000000
          Top = 0.755905509999998000
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
          Left = 627.891341030000000000
          Top = 0.755905509999998000
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
          Left = 718.600002450000000000
          Top = 0.755905509999998000
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
          Left = 809.308663870000000000
          Top = 0.755905509999998000
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
          Left = 900.017325290000000000
          Top = 0.755905509999998000
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
          Left = 990.725986710000000000
          Top = 0.755905509999998000
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
          Left = 1081.434648130000000000
          Top = 0.755905509999998000
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
          Left = 1172.143309550000000000
          Top = 0.755905509999998000
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
            '[frxSalPor."REL_LOJ011"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLojPor012: TfrxMemoView
          Align = baLeft
          Left = 1262.851970970000000000
          Top = 0.755905509999998000
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
            '[frxSalPor."REL_LOJ012"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
  object popSel: TPopupMenu
    Left = 457
    Top = 136
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
