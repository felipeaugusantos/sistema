inherited frmApuracaoLucroRealRelatorio: TfrmApuracaoLucroRealRelatorio
  Width = 553
  Height = 318
  Caption = 'Relat'#243'rio Apura'#231#227'o do Lucro Real'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 553
  ExplicitHeight = 318
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 245
    Width = 547
    TabOrder = 5
    ExplicitTop = 245
    ExplicitWidth = 547
    inherited FlwBotoes: TFlowPanel
      Width = 543
      ExplicitWidth = 543
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 467
      Caption = 'C&ancela'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ExplicitLeft = 467
    end
  end
  inherited pnlStatus: TPanel
    Top = 273
    Width = 547
    TabOrder = 6
    ExplicitTop = 273
    ExplicitWidth = 547
    inherited pnlNomeForm: TPanel
      Left = 376
      ExplicitLeft = 376
    end
    inherited pnlInfo: TPanel
      Width = 376
      ExplicitWidth = 376
    end
  end
  object cxLabel1: TcxLabel [2]
    Left = 37
    Top = 17
    Caption = 'Exercicio:'
  end
  object edtExercicio: TEditFocus [3]
    Left = 92
    Top = 18
    Width = 121
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 4
    TabOrder = 0
    OnChange = edtExercicioChange
    OnExit = edtEmpSelExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttInteiro
  end
  object cxLabel4: TcxLabel [4]
    Left = 16
    Top = 72
    Caption = 'Periodo Inicial:'
  end
  object edtPeriodoInicial: TcxComboBox [5]
    Left = 92
    Top = 68
    Properties.DropDownListStyle = lsEditFixedList
    Properties.DropDownRows = 12
    Properties.OnChange = edtPeriodoInicialPropertiesChange
    TabOrder = 2
    Width = 121
  end
  object cxLabel2: TcxLabel [6]
    Left = 16
    Top = 100
    Caption = 'Periodo Final:'
  end
  object edtPeriodoFinal: TcxComboBox [7]
    Left = 92
    Top = 96
    Properties.DropDownListStyle = lsEditFixedList
    Properties.DropDownRows = 12
    Properties.OnChange = edtPeriodoFinalPropertiesChange
    TabOrder = 3
    Width = 121
  end
  object checkLacsLalur: TcxCheckGroup [8]
    Left = 16
    Top = 127
    Caption = 'Op'#231#245'es'
    Properties.Columns = 2
    Properties.Items = <
      item
        Caption = 'Lacs Parte A'
      end
      item
        Caption = 'Lacs Parte B'
      end
      item
        Caption = 'Lacs Apura'#231#227'o'
      end
      item
        Caption = 'Lair Parte A'
      end
      item
        Caption = 'Lair Parte B'
      end
      item
        Caption = 'Lair Apura'#231#227'o'
      end>
    TabOrder = 4
    Height = 105
    Width = 523
  end
  object cxLabel7: TcxLabel [9]
    Left = 36
    Top = 43
    Caption = 'Empresa:'
  end
  object edtEmpSel: TEditFocus [10]
    Tag = 99
    Left = 92
    Top = 42
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 1
    OnChange = edtEmpSelChange
    OnExit = edtEmpSelExit
    OnKeyPress = edtEmpSelKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmpSel: TEditFocus [11]
    Left = 153
    Top = 43
    Width = 386
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 11
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object RelatorioLucroReal: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44595.594633969900000000
    ReportOptions.LastChange = 45842.488542395830000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var  '
      ' FfltValorExclusaoLacsCredito: extended ;'
      ' FfltValorAdicaoLacsCredito: extended ;'
      ' FfltValorExclusaoLacsDebito: extended ;'
      ' FfltValorAdicaoLacsDebito: extended ;  '
      '   '
      ' FfltValorExclusaoLalurCredito: extended ;'
      ' FfltValorAdicaoLalurCredito: extended ;'
      ' FfltValorExclusaoLalurDebito: extended ;'
      ' FfltValorAdicaoLalurDebito: extended ;     '
      ''
      
        'procedure AjustesLacsParteAVAL_ADICAOOnBeforePrint(Sender: TfrxC' +
        'omponent);'
      'begin'
      
        '  TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', abs(<Ajus' +
        'tesLacsParteA."VAL_ADICAO">)) ;'
      
        '  if <AjustesLacsParteA."CREDEB_ADICAO"> = '#39'D'#39' then             ' +
        '                       '
      
        '    FfltValorAdicaoLacsDebito := FfltValorAdicaoLacsDebito + <Aj' +
        'ustesLacsParteA."VAL_ADICAO"> ;'
      
        '  if <AjustesLacsParteA."CREDEB_ADICAO"> = '#39'C'#39' then             ' +
        '                       '
      
        '    FfltValorAdicaoLacsCredito := FfltValorAdicaoLacsCredito + <' +
        'AjustesLacsParteA."VAL_ADICAO"> ;            '
      'end;'
      ''
      
        'procedure AjustesLacsParteAVAL_EXCLUSAOOnBeforePrint(Sender: Tfr' +
        'xComponent);'
      'begin'
      
        '  TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', abs(<Ajus' +
        'tesLacsParteA."VAL_EXCLUSAO">)) ;     '
      '  if <AjustesLacsParteA."CREDEB_EXCLUSAO"> = '#39'D'#39' then    '
      
        '    FfltValorExclusaoLacsDebito := FfltValorExclusaoLacsDebito +' +
        ' <AjustesLacsParteA."VAL_EXCLUSAO"> ;'
      '  if <AjustesLacsParteA."CREDEB_EXCLUSAO"> = '#39'C'#39' then    '
      
        '    FfltValorExclusaoLacsCredito := FfltValorExclusaoLacsCredito' +
        ' + <AjustesLacsParteA."VAL_EXCLUSAO"> ;            '
      'end;'
      ''
      
        'procedure pgAjustesLacsParteAOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      '  FfltValorExclusaoLacsCredito := 0.00 ;'
      '  FfltValorAdicaoLacsCredito := 0.00 ;'
      '  FfltValorExclusaoLacsDebito := 0.00 ;'
      '  FfltValorAdicaoLacsDebito := 0.00 ;  '
      '   '
      '  FfltValorExclusaoLalurCredito := 0.00 ;'
      '  FfltValorAdicaoLalurCredito := 0.00 ;'
      '  FfltValorExclusaoLalurDebito := 0.00 ;'
      '  FfltValorAdicaoLalurDebito := 0.00 ;      '
      'end;'
      ''
      'procedure meSubTotalAdicaoOnBeforePrint(Sender: TfrxComponent);'
      'var'
      
        '  LfltAdicao: extended ;                                        ' +
        '               '
      'begin'
      
        '  LfltAdicao := FfltValorAdicaoLacsDebito - FfltValorAdicaoLacsC' +
        'redito ;    '
      
        '  TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', abs(LfltA' +
        'dicao)) ;        '
      '  if (LfltAdicao < 0.00) then'
      '    meSubTotalAdicaoLacsCreDeb.Text := '#39'C'#39'         '
      '  else'
      '    meSubTotalAdicaoLacsCreDeb.Text := '#39'D'#39' ;        '
      '    '
      '  FfltValorAdicaoLacsDebito :=  0.00 ;'
      
        '  FfltValorAdicaoLacsCredito := 0.00 ;                          ' +
        '   '
      'end;'
      ''
      
        'procedure meSubTotalExclusaoOnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'var'
      
        '  LfltExclusao: extended ;                                      ' +
        '                     '
      'begin'
      
        '  LfltExclusao := FfltValorExclusaoLacsCredito - FfltValorExclus' +
        'aoLacsDebito ;  '
      
        '  TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', abs(LfltE' +
        'xclusao)) ;         '
      '  if (LfltExclusao < 0.00) then'
      '    meSubTotalExclusaoLacsCreDeb.Text := '#39'D'#39'       '
      '  else'
      '    meSubTotalExclusaoLacsCreDeb.Text := '#39'C'#39' ;      '
      '    '
      '  FfltValorExclusaoLacsDebito :=  0.00 ;'
      '  FfltValorExclusaoLacsCredito := 0.00 ;  '
      'end;'
      ''
      
        'procedure AjustesLalurParteAVAL_ADICAOOnBeforePrint(Sender: Tfrx' +
        'Component);'
      'begin'
      
        '  TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', abs(<Ajus' +
        'tesLalurParteA."VAL_ADICAO">)) ;'
      '  if <AjustesLalurParteA."CREDEB_ADICAO"> = '#39'D'#39' then      '
      
        '    FfltValorAdicaoLalurDebito := FfltValorAdicaoLalurDebito + <' +
        'AjustesLalurParteA."VAL_ADICAO"> ;'
      '  if <AjustesLalurParteA."CREDEB_ADICAO"> = '#39'C'#39' then      '
      
        '    FfltValorAdicaoLalurCredito := FfltValorAdicaoLalurCredito +' +
        ' <AjustesLalurParteA."VAL_ADICAO"> ;            '
      'end;'
      ''
      
        'procedure AjustesLalurParteAVAL_EXCLUSAOOnBeforePrint(Sender: Tf' +
        'rxComponent);'
      'begin'
      
        '  TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', abs(<Ajus' +
        'tesLalurParteA."VAL_EXCLUSAO">)) ;                 '
      '  if <AjustesLalurParteA."CREDEB_EXCLUSAO"> = '#39'D'#39' then    '
      
        '    FfltValorExclusaoLalurDebito := FfltValorExclusaoLalurDebito' +
        ' + <AjustesLalurParteA."VAL_EXCLUSAO"> ;'
      '  if <AjustesLalurParteA."CREDEB_EXCLUSAO"> = '#39'C'#39' then    '
      
        '    FfltValorExclusaoLalurCredito := FfltValorExclusaoLalurCredi' +
        'to + <AjustesLalurParteA."VAL_EXCLUSAO"> ;            '
      'end;'
      ''
      
        'procedure meSubTotalLalurAdicaoOnBeforePrint(Sender: TfrxCompone' +
        'nt);'
      'var'
      
        '  LfltAdicao: extended ;                                        ' +
        '               '
      'begin'
      
        '  LfltAdicao := FfltValorAdicaoLalurDebito - FfltValorAdicaoLalu' +
        'rCredito ;'
      
        '  TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', abs(LfltA' +
        'dicao)) ;           '
      '  if (LfltAdicao < 0.00) then          '
      '     meSubTotalAdicaoLalurCreDeb.Text := '#39'C'#39' '
      '  else'
      '    meSubTotalAdicaoLalurCreDeb.Text := '#39'D'#39' ;'
      '      '
      '  FfltValorAdicaoLalurDebito :=  0.00 ;'
      '  FfltValorAdicaoLalurCredito := 0.00 ;  '
      'end;'
      ''
      
        'procedure meSubTotalLalurExclusaoOnBeforePrint(Sender: TfrxCompo' +
        'nent);'
      'var'
      
        '  LfltExclusao: extended ;                                      ' +
        '                     '
      'begin'
      
        '  LfltExclusao := FfltValorExclusaoLalurCredito - FfltValorExclu' +
        'saoLalurDebito ;'
      
        '  TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', abs(LfltE' +
        'xclusao)) ;           '
      '  if (LfltExclusao < 0.00) then          '
      '    meSubTotalExclusaoLalurCreDeb.Text := '#39'D'#39' '
      '  else'
      '    meSubTotalExclusaoLalurCreDeb.Text := '#39'C'#39' ;    '
      ''
      '  FfltValorExclusaoLalurDebito :=  0.00 ;'
      '  FfltValorExclusaoLalurCredito := 0.00 ;  '
      'end;'
      ''
      
        'procedure DemonstrativoLacsParteAVALOR_OnBeforePrint(Sender: Tfr' +
        'xComponent);'
      'begin'
      '  if <DemonstrativoLacsParteA."VALOR_"> = 0.00 then'
      '  begin'
      '    TfrxMemoView(Sender).Text := '#39#39' ;              '
      '  end'
      '  else            '
      '  begin              '
      '    if (<DemonstrativoLacsParteA."VALOR_"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<DemonstrativoLacsParteA."VALOR_">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Demo' +
        'nstrativoLacsParteA."VALOR_">) ;'
      '  end ;                             '
      'end;'
      ''
      
        'procedure DemonstrativoLacsParteATOTAL_OnBeforePrint(Sender: Tfr' +
        'xComponent);'
      'begin'
      '  if <DemonstrativoLacsParteA."TOTAL_"> = 0.00 then'
      '  begin'
      '    TfrxMemoView(Sender).Text := '#39#39' ;  '
      '  end'
      '  else            '
      '  begin              '
      '    if (<DemonstrativoLacsParteA."TOTAL_"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<DemonstrativoLacsParteA."TOTAL_">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Demo' +
        'nstrativoLacsParteA."TOTAL_">) ;'
      '  end ;  '
      'end;'
      ''
      
        'procedure DemonstrativoLalurParteAVALOR_OnBeforePrint(Sender: Tf' +
        'rxComponent);'
      'begin'
      '  if <DemonstrativoLalurParteA."VALOR_"> = 0.00 then'
      '  begin'
      '    TfrxMemoView(Sender).Text := '#39#39' ;              '
      '  end'
      '  else            '
      '  begin              '
      '    if (<DemonstrativoLalurParteA."VALOR_"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<DemonstrativoLalurParteA."VALOR_">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Demo' +
        'nstrativoLalurParteA."VALOR_">) ;'
      '  end ;  '
      'end;'
      ''
      
        'procedure DemonstrativoLalurParteATOTAL_OnBeforePrint(Sender: Tf' +
        'rxComponent);'
      'begin'
      '  if <DemonstrativoLalurParteA."TOTAL_"> = 0.00 then'
      '  begin'
      '    TfrxMemoView(Sender).Text := '#39#39' ;  '
      '  end'
      '  else            '
      '  begin              '
      '    if (<DemonstrativoLalurParteA."TOTAL_"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<DemonstrativoLalurParteA."TOTAL_">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Demo' +
        'nstrativoLalurParteA."TOTAL_">) ;'
      '  end ;  '
      'end;'
      ''
      
        'procedure ApuracaoLacsMestreLUCRO_LIQUIDOOnBeforePrint(Sender: T' +
        'frxComponent);'
      'begin'
      '  if (<ApuracaoLacsMestre."LUCRO_LIQUIDO"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ApuracaoLacsMestre."LUCRO_LIQUIDO">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apur' +
        'acaoLacsMestre."LUCRO_LIQUIDO">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLacsMestreVRE_VLADICOnBeforePrint(Sender: Tfrx' +
        'Component);'
      'begin'
      '  if (<ApuracaoLacsMestre."VRE_VLADIC"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ApuracaoLacsMestre."VRE_VLADIC">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apur' +
        'acaoLacsMestre."VRE_VLADIC">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLacsMestreVRE_VLEXCLOnBeforePrint(Sender: Tfrx' +
        'Component);'
      'begin'
      '  if (<ApuracaoLacsMestre."VRE_VLEXCL"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ApuracaoLacsMestre."VRE_VLEXCL">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apur' +
        'acaoLacsMestre."VRE_VLEXCL">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLacsMestreVRE_VLBCNGOnBeforePrint(Sender: Tfrx' +
        'Component);'
      'begin'
      '  if (<ApuracaoLacsMestre."VRE_VLBCNG"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ApuracaoLacsMestre."VRE_VLBCNG">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apur' +
        'acaoLacsMestre."VRE_VLBCNG">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLacsMestreVRE_VLCOMPOnBeforePrint(Sender: Tfrx' +
        'Component);'
      'begin'
      '  if (<ApuracaoLacsMestre."VRE_VLCOMP"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ApuracaoLacsMestre."VRE_VLCOMP">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apur' +
        'acaoLacsMestre."VRE_VLCOMP">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLacsMestreVRE_VLRBASOnBeforePrint(Sender: Tfrx' +
        'Component);'
      'begin'
      '  if (<ApuracaoLacsMestre."VRE_VLRBAS"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ApuracaoLacsMestre."VRE_VLRBAS">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apur' +
        'acaoLacsMestre."VRE_VLRBAS">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLacsDetalheVLRBALOnBeforePrint(Sender: TfrxCom' +
        'ponent);'
      'begin'
      
        '  if (<ApuracaoLacsDetalhe."DESCRI"> = '#39#39') or (<ApuracaoLacsDeta' +
        'lhe."TITULO"> = 1) then'
      '  begin'
      '    TfrxMemoView(Sender).Text := '#39#39' ;              '
      '  end'
      '  else'
      '  begin              '
      '    if (<ApuracaoLacsDetalhe."VLRBAL"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ApuracaoLacsDetalhe."VLRBAL">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apur' +
        'acaoLacsDetalhe."VLRBAL">) ;'
      '  end ;                             '
      'end;'
      ''
      
        'procedure ApuracaoLacsDetalheVLRRECOnBeforePrint(Sender: TfrxCom' +
        'ponent);'
      'begin'
      
        '  if (<ApuracaoLacsDetalhe."DESCRI"> = '#39#39') or (<ApuracaoLacsDeta' +
        'lhe."TITULO"> = 1) then'
      '  begin'
      '    TfrxMemoView(Sender).Text := '#39#39' ;              '
      '  end'
      '  else'
      '  begin  '
      '    if (<ApuracaoLacsDetalhe."VLRREC"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ApuracaoLacsDetalhe."VLRREC">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apur' +
        'acaoLacsDetalhe."VLRREC">) ;'
      '  end ;                                     '
      'end;'
      ''
      
        'procedure ApuracaoLalurMestreLUCRO_LIQUIDOOnBeforePrint(Sender: ' +
        'TfrxComponent);'
      'begin'
      '  if (<ApuracaoLalurMestre."LUCRO_LIQUIDO"> < 0.00) then'
      
        '    TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39', a' +
        'bs(<ApuracaoLalurMestre."LUCRO_LIQUIDO">)) + '#39')'#39' '
      '  else'
      
        '    TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apurac' +
        'aoLalurMestre."LUCRO_LIQUIDO">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLalurMestreVRE_VLADICOnBeforePrint(Sender: Tfr' +
        'xComponent);'
      'begin'
      '  if (<ApuracaoLalurMestre."VRE_VLADIC"> < 0.00) then'
      
        '    TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39', a' +
        'bs(<ApuracaoLalurMestre."VRE_VLADIC">)) + '#39')'#39' '
      '  else'
      
        '    TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apurac' +
        'aoLalurMestre."VRE_VLADIC">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLalurMestreVRE_VLEXCLOnBeforePrint(Sender: Tfr' +
        'xComponent);'
      'begin'
      '  if (<ApuracaoLalurMestre."VRE_VLEXCL"> < 0.00) then'
      
        '    TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39', a' +
        'bs(<ApuracaoLalurMestre."VRE_VLEXCL">)) + '#39')'#39' '
      '  else'
      
        '    TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apurac' +
        'aoLalurMestre."VRE_VLEXCL">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLalurMestreVRE_VLBCNGOnBeforePrint(Sender: Tfr' +
        'xComponent);'
      'begin'
      '  if (<ApuracaoLalurMestre."VRE_VLBCNG"> < 0.00) then'
      
        '    TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39', a' +
        'bs(<ApuracaoLalurMestre."VRE_VLBCNG">)) + '#39')'#39' '
      '  else'
      
        '    TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apurac' +
        'aoLalurMestre."VRE_VLBCNG">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLalurMestreVRE_VLCOMPOnBeforePrint(Sender: Tfr' +
        'xComponent);'
      'begin'
      '  if (<ApuracaoLalurMestre."VRE_VLCOMP"> < 0.00) then'
      
        '    TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39', a' +
        'bs(<ApuracaoLalurMestre."VRE_VLCOMP">)) + '#39')'#39' '
      '  else'
      
        '    TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apurac' +
        'aoLalurMestre."VRE_VLCOMP">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLalurMestreVRE_VLRBASOnBeforePrint(Sender: Tfr' +
        'xComponent);'
      'begin'
      '  if (<ApuracaoLalurMestre."VRE_VLRBAS"> < 0.00) then'
      
        '    TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39', a' +
        'bs(<ApuracaoLalurMestre."VRE_VLRBAS">)) + '#39')'#39' '
      '  else'
      
        '    TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apurac' +
        'aoLalurMestre."VRE_VLRBAS">) ;  '
      'end;'
      ''
      
        'procedure ApuracaoLalurDetalheVLRBALOnBeforePrint(Sender: TfrxCo' +
        'mponent);'
      'begin'
      
        '  if (<ApuracaoLalurDetalhe."DESCRI"> = '#39#39') or (<ApuracaoLalurDe' +
        'talhe."TITULO"> = 1) then'
      '  begin'
      '    TfrxMemoView(Sender).Text := '#39#39' ;              '
      '  end'
      '  else'
      '  begin  '
      '    if (<ApuracaoLalurDetalhe."VLRBAL"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ApuracaoLalurDetalhe."VLRBAL">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apur' +
        'acaoLalurDetalhe."VLRBAL">) ;'
      '  end ;  '
      'end;'
      ''
      
        'procedure ApuracaoLalurDetalheVLRRECOnBeforePrint(Sender: TfrxCo' +
        'mponent);'
      'begin'
      
        '  if (<ApuracaoLalurDetalhe."DESCRI"> = '#39#39') or (<ApuracaoLalurDe' +
        'talhe."TITULO"> = 1) then'
      '  begin'
      '    TfrxMemoView(Sender).Text := '#39#39' ;              '
      '  end'
      '  else'
      '  begin  '
      '    if (<ApuracaoLalurDetalhe."VLRREC"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ApuracaoLalurDetalhe."VLRREC">)) + '#39')'#39' '
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Apur' +
        'acaoLalurDetalhe."VLRREC">) ;'
      '  end ;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 312
    Top = 128
    Datasets = <
      item
        DataSet = frxDBAjustesLacsParteA
        DataSetName = 'AjustesLacsParteA'
      end
      item
        DataSet = frxDBAjustesLalurParteA
        DataSetName = 'AjustesLalurParteA'
      end
      item
        DataSet = frxDBApuracaoLacsDetalhe
        DataSetName = 'ApuracaoLacsDetalhe'
      end
      item
        DataSet = frxDBApuracaoLacsMestre
        DataSetName = 'ApuracaoLacsMestre'
      end
      item
        DataSet = frxDBApuracaoLalurDetalhe
        DataSetName = 'ApuracaoLalurDetalhe'
      end
      item
        DataSet = frxDBApuracaoLalurMestre
        DataSetName = 'ApuracaoLalurMestre'
      end
      item
        DataSet = frxDBBaseNegativaLacsParteB
        DataSetName = 'BaseNegativaLacsParteB'
      end
      item
        DataSet = frxDBBaseNegativaLalurParteB
        DataSetName = 'BaseNegativaLalurParteB'
      end
      item
        DataSet = frxDBDemonstrativoLacsParteA
        DataSetName = 'DemonstrativoLacsParteA'
      end
      item
        DataSet = frxDBDemonstrativoLalurParteA
        DataSetName = 'DemonstrativoLalurParteA'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object pgAjustesLacsParteA: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'pgAjustesLacsParteAOnBeforePrint'
      object MDAjustesLacsParteA: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 120.944960000000000000
        Width = 718.110700000000000000
        DataSet = frxDBAjustesLacsParteA
        DataSetName = 'AjustesLacsParteA'
        RowCount = 0
        object AjustesLacsParteAARE_DTALAN: TfrxMemoView
          Left = 3.779530000000000000
          Width = 60.472480000000000000
          Height = 13.228344020000000000
          DataField = 'ARE_DTALAN'
          DataSet = frxDBAjustesLacsParteA
          DataSetName = 'AjustesLacsParteA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[AjustesLacsParteA."ARE_DTALAN"]')
          ParentFont = False
        end
        object AjustesLacsParteAHISTOR: TfrxMemoView
          Left = 68.149660000000000000
          Width = 434.645950000000000000
          Height = 13.228344020000000000
          DataField = 'HISTOR'
          DataSet = frxDBAjustesLacsParteA
          DataSetName = 'AjustesLacsParteA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[AjustesLacsParteA."HISTOR"]')
          ParentFont = False
        end
        object AjustesLacsParteAVAL_ADICAO: TfrxMemoView
          Left = 508.929500000000000000
          Width = 86.929190000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'AjustesLacsParteAVAL_ADICAOOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLacsParteA."VAL_ADICAO"]')
          ParentFont = False
        end
        object AjustesLacsParteAVAL_EXCLUSAO: TfrxMemoView
          Left = 619.842920000000000000
          Width = 86.929190000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'AjustesLacsParteAVAL_EXCLUSAOOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLacsParteA."VAL_EXCLUSAO"]')
          ParentFont = False
        end
        object AjustesLacsParteACREDEB_ADICAO: TfrxMemoView
          Left = 588.299630000000000000
          Width = 18.897650000000000000
          Height = 13.228344020000000000
          DataField = 'CREDEB_ADICAO'
          DataSet = frxDBAjustesLacsParteA
          DataSetName = 'AjustesLacsParteA'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLacsParteA."CREDEB_ADICAO"]')
          ParentFont = False
        end
        object AjustesLacsParteACREDEB_EXCLUSAO: TfrxMemoView
          Left = 699.213050000000000000
          Width = 18.897650000000000000
          Height = 13.228344020000000000
          DataField = 'CREDEB_EXCLUSAO'
          DataSet = frxDBAjustesLacsParteA
          DataSetName = 'AjustesLacsParteA'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLacsParteA."CREDEB_EXCLUSAO"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 79.811070000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'AjustesLacsParteA."PRE_DTAFIN"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.913420000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 68.149660000000000000
          Top = 56.913420000000000000
          Width = 434.645950000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Hist'#243'rico')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 508.929500000000000000
          Top = 56.913420000000000000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Adi'#231#245'es')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 619.842920000000000000
          Top = 57.133890000000000000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Exclus'#245'es')
          ParentFont = False
        end
        object memoCabecalho: TfrxMemoView
          Align = baWidth
          Top = 2.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RepTitAjustesLacsParteA]')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 0.377952760000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo14: TfrxMemoView
          Left = 3.779530000000000000
          Top = 41.015770000000000000
          Width = 419.527830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Per'#237'odo: [AjustesLacsParteA."PRE_DTAINI"] a [AjustesLacsParteA."' +
              'PRE_DTAFIN"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Empresa: [EmpCnpj] [EmpNome]')
        end
        object LinhaCabecalho: TfrxLineView
          Align = baWidth
          Top = 76.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 23.677180000000000000
        Top = 162.519790000000000000
        Width = 718.110700000000000000
        object Line16: TfrxLineView
          Top = 0.755905510000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo16: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totais:')
          ParentFont = False
        end
        object meSubTotalAdicao: TfrxMemoView
          Left = 459.795610000000000000
          Top = 1.000000000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'meSubTotalAdicaoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
        end
        object meSubTotalExclusao: TfrxMemoView
          Left = 612.283860000000000000
          Top = 1.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'meSubTotalExclusaoOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
        end
        object meSubTotalAdicaoLacsCreDeb: TfrxMemoView
          Left = 588.299630000000000000
          Top = 1.000000000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLacsParteA."CREDEB_ADICAO"]')
          ParentFont = False
        end
        object meSubTotalExclusaoLacsCreDeb: TfrxMemoView
          Left = 699.213050000000000000
          Top = 1.000000000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLacsParteA."CREDEB_ADICAO"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 245.669450000000000000
        Width = 718.110700000000000000
        object Memo74: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VersaoDataHora]')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Align = baCenter
          Left = 321.260050000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
      end
    end
    object pgDemonstrativoLacsParteA: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 79.811070000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'DemonstrativoLacsParteA."DTAFIN"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.913420000000000000
          Width = 517.795610000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 521.929500000000000000
          Top = 56.913420000000000000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
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
        object Memo26: TfrxMemoView
          Left = 619.842920000000000000
          Top = 57.133890000000000000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Align = baWidth
          Top = 2.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RepTitDemonstrativoLacsParteA]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 0.377952760000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo28: TfrxMemoView
          Left = 3.779530000000000000
          Top = 41.015770000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Per'#237'odo: [DemonstrativoLacsParteA."DTAINI"] a [DemonstrativoLacs' +
              'ParteA."DTAFIN"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo29: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Empresa: [EmpCnpj] [EmpNome]')
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 76.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 120.944960000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDemonstrativoLacsParteA
        DataSetName = 'DemonstrativoLacsParteA'
        RowCount = 0
        object DemonstrativoLacsParteADESCRI: TfrxMemoView
          Left = 3.779530000000000000
          Width = 517.795610000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRI'
          DataSet = frxDBDemonstrativoLacsParteA
          DataSetName = 'DemonstrativoLacsParteA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DemonstrativoLacsParteA."DESCRI"]')
          ParentFont = False
        end
        object DemonstrativoLacsParteAVALOR_: TfrxMemoView
          Left = 521.929500000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'DemonstrativoLacsParteAVALOR_OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DemonstrativoLacsParteA."VALOR_"]')
          ParentFont = False
        end
        object DemonstrativoLacsParteATOTAL_: TfrxMemoView
          Left = 619.842920000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'DemonstrativoLacsParteATOTAL_OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DemonstrativoLalurParteA."TOTAL_"]')
          ParentFont = False
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        object Memo76: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VersaoDataHora]')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Align = baCenter
          Left = 294.803340000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
      end
    end
    object pgLancamentosCtaConLacsParteB: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object GroupHeader5: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 79.811070000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'BaseNegativaLacsParteB."CTACON"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo4: TfrxMemoView
          Left = 72.779530000000000000
          Top = 56.692950000000000000
          Width = 347.716760000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Hist'#243'rico')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 424.441250000000000000
          Top = 56.692950000000000000
          Width = 86.929190000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'D'#233'bito')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 597.842920000000000000
          Top = 56.692950000000000000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Saldo')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Align = baWidth
          Top = 2.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RepTitLancamentosCtaConLacsParteB]')
          ParentFont = False
        end
        object Line8: TfrxLineView
          Align = baWidth
          Top = 0.377952760000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo38: TfrxMemoView
          Left = 3.779530000000000000
          Top = 40.015770000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'C'#243'digo: [BaseNegativaLacsParteB."CTACON"] - [BaseNegativaLacsPar' +
              'teB."DESCRI"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo39: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Empresa: [EmpCnpj] [EmpNome]')
        end
        object Line9: TfrxLineView
          Align = baWidth
          Top = 76.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo40: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.692950000000000000
          Width = 68.031540000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 511.016080000000000000
          Top = 56.692950000000000000
          Width = 86.929190000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cr'#233'dito')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 699.213050000000000000
          Top = 56.692950000000000000
          Width = 18.897650000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DC')
          ParentFont = False
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 120.944960000000000000
        Width = 718.110700000000000000
        DataSet = frxDBBaseNegativaLacsParteB
        DataSetName = 'BaseNegativaLacsParteB'
        RowCount = 0
        object BaseNegativaLacsParteBDTALAN: TfrxMemoView
          Left = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'DTALAN'
          DataSet = frxDBBaseNegativaLacsParteB
          DataSetName = 'BaseNegativaLacsParteB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BaseNegativaLacsParteB."DTALAN"]')
          ParentFont = False
        end
        object BaseNegativaLacsParteBHISTOR: TfrxMemoView
          Left = 72.779530000000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          DataField = 'HISTOR'
          DataSet = frxDBBaseNegativaLacsParteB
          DataSetName = 'BaseNegativaLacsParteB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BaseNegativaLacsParteB."HISTOR"]')
          ParentFont = False
        end
        object BaseNegativaLacsParteBDEBITO: TfrxMemoView
          Left = 424.441250000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'DEBITO'
          DataSet = frxDBBaseNegativaLacsParteB
          DataSetName = 'BaseNegativaLacsParteB'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseNegativaLacsParteB."DEBITO"]')
          ParentFont = False
        end
        object BaseNegativaLacsParteBCREDIT: TfrxMemoView
          Left = 511.016080000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'CREDIT'
          DataSet = frxDBBaseNegativaLacsParteB
          DataSetName = 'BaseNegativaLacsParteB'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseNegativaLacsParteB."CREDIT"]')
          ParentFont = False
        end
        object BaseNegativaLacsParteBSALDO_: TfrxMemoView
          Left = 597.842920000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'SALDO_'
          DataSet = frxDBBaseNegativaLacsParteB
          DataSetName = 'BaseNegativaLacsParteB'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseNegativaLacsParteB."SALDO_"]')
          ParentFont = False
        end
        object BaseNegativaLacsParteBCREDEB: TfrxMemoView
          Left = 699.213050000000000000
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          DataField = 'CREDEB'
          DataSet = frxDBBaseNegativaLacsParteB
          DataSetName = 'BaseNegativaLacsParteB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BaseNegativaLacsParteB."CREDEB"]')
          ParentFont = False
        end
      end
      object PageFooter3: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        object Memo78: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VersaoDataHora]')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Align = baCenter
          Left = 294.803340000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
      end
    end
    object pgLacsApuracao: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object GroupHeader7: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 68.472480000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'ApuracaoLacsMestre."PRE_DTAFIN"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo53: TfrxMemoView
          Align = baWidth
          Top = 2.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RepTitLacsApuracao]')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Align = baWidth
          Top = 0.377952760000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo54: TfrxMemoView
          Left = 3.779530000000000000
          Top = 41.015770000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Per'#237'odo: [ApuracaoLacsMestre."PRE_DTAINI"] a [ApuracaoLacsMestre' +
              '."PRE_DTAFIN"]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Empresa: [EmpCnpj] [EmpNome]')
        end
        object Line13: TfrxLineView
          Align = baWidth
          Top = 65.252010000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData5: TfrxMasterData
        FillType = ftBrush
        Height = 234.551330000000000000
        Top = 109.606370000000000000
        Width = 718.110700000000000000
        DataSet = frxDBApuracaoLacsMestre
        DataSetName = 'ApuracaoLacsMestre'
        RowCount = 0
        object Memo56: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Base de C'#225'lculo da Contribui'#231#227'o Social')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 582.047620000000000000
          Top = 7.559060000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
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
        object Memo58: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.795300000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Lucro l'#237'quido antes da CSLL')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Adi'#231#245'es')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 3.779530000000000000
          Top = 93.826840000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Exclus'#245'es')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 3.779530000000000000
          Top = 127.842610000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Base de c'#225'lculo antes da compensa'#231#227'o da BC negativa')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 3.779530000000000000
          Top = 149.858380000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Compensa'#231#227'o da BC negativa')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 3.779530000000000000
          Top = 184.874150000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Base de c'#225'lculo da CSLL')
          ParentFont = False
        end
        object ApuracaoLacsMestreLUCRO_LIQUIDO: TfrxMemoView
          Left = 582.047620000000000000
          Top = 37.795300000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLacsMestreLUCRO_LIQUIDOOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."LUCRO_LIQUIDO"]')
          ParentFont = False
        end
        object ApuracaoLacsMestreVRE_VLADIC: TfrxMemoView
          Left = 582.047620000000000000
          Top = 71.811070000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLacsMestreVRE_VLADICOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."VRE_VLADIC"]')
          ParentFont = False
        end
        object ApuracaoLacsMestreVRE_VLEXCL: TfrxMemoView
          Left = 582.047620000000000000
          Top = 93.826840000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLacsMestreVRE_VLEXCLOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."VRE_VLEXCL"]')
          ParentFont = False
        end
        object ApuracaoLacsMestreVRE_VLBCNG: TfrxMemoView
          Left = 582.047620000000000000
          Top = 127.842610000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLacsMestreVRE_VLBCNGOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."VRE_VLBCNG"]')
          ParentFont = False
        end
        object ApuracaoLacsMestreVRE_VLCOMP: TfrxMemoView
          Left = 582.047620000000000000
          Top = 149.858380000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLacsMestreVRE_VLCOMPOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."VRE_VLCOMP"]')
          ParentFont = False
        end
        object ApuracaoLacsMestreVRE_VLRBAS: TfrxMemoView
          Left = 582.047620000000000000
          Top = 184.874150000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLacsMestreVRE_VLRBASOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."VRE_VLRBAS"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 215.653680000000000000
          Width = 445.984540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Apura'#231#227'o da Contribui'#231#227'o Social')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 453.291590000000000000
          Top = 215.653680000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Lucro Real/Balancete')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 582.047620000000000000
          Top = 215.653680000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Receita Bruta')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 366.614410000000000000
        Width = 718.110700000000000000
        DataSet = frxDBApuracaoLacsDetalhe
        DataSetName = 'ApuracaoLacsDetalhe'
        RowCount = 0
        object ApuracaoLacsDetalheDESCRI: TfrxMemoView
          Left = 3.779530000000000000
          Width = 445.984540000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRI'
          DataSet = frxDBApuracaoLacsDetalhe
          DataSetName = 'ApuracaoLacsDetalhe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ApuracaoLacsDetalhe."DESCRI"]')
          ParentFont = False
        end
        object ApuracaoLacsDetalheVLRBAL: TfrxMemoView
          Left = 453.291590000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'ApuracaoLacsDetalheVLRBALOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsDetalhe."VLRBAL"]')
          ParentFont = False
        end
        object ApuracaoLacsDetalheVLRREC: TfrxMemoView
          Left = 582.047620000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'ApuracaoLacsDetalheVLRRECOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsDetalhe."VLRREC"]')
          ParentFont = False
        end
      end
      object PageFooter4: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 442.205010000000000000
        Width = 718.110700000000000000
        object Memo84: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VersaoDataHora]')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Align = baCenter
          Left = 294.803340000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
      end
    end
    object pgAjustesLalurParteA: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MDAjustesLalurParteA: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 120.944960000000000000
        Width = 718.110700000000000000
        DataSet = frxDBAjustesLalurParteA
        DataSetName = 'AjustesLalurParteA'
        RowCount = 0
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          DataField = 'ARE_DTALAN'
          DataSet = frxDBAjustesLalurParteA
          DataSetName = 'AjustesLalurParteA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[AjustesLalurParteA."ARE_DTALAN"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 68.031496060000000000
          Width = 453.543307090000000000
          Height = 13.228344020000000000
          DataField = 'HISTOR'
          DataSet = frxDBAjustesLalurParteA
          DataSetName = 'AjustesLalurParteA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[AjustesLalurParteA."HISTOR"]')
          ParentFont = False
        end
        object AjustesLalurParteAVAL_ADICAO: TfrxMemoView
          Left = 521.929500000000000000
          Width = 83.149660000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'AjustesLalurParteAVAL_ADICAOOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLalurParteA."VAL_ADICAO"]')
          ParentFont = False
        end
        object AjustesLalurParteAVAL_EXCLUSAO: TfrxMemoView
          Left = 619.842920000000000000
          Width = 83.149660000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'AjustesLalurParteAVAL_EXCLUSAOOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLalurParteA."VAL_EXCLUSAO"]')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 601.299630000000000000
          Width = 18.897650000000000000
          Height = 13.228344020000000000
          DataField = 'CREDEB_ADICAO'
          DataSet = frxDBAjustesLalurParteA
          DataSetName = 'AjustesLalurParteA'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLalurParteA."CREDEB_ADICAO"]')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 699.213050000000000000
          Width = 18.897650000000000000
          Height = 13.228344020000000000
          DataField = 'CREDEB_EXCLUSAO'
          DataSet = frxDBAjustesLalurParteA
          DataSetName = 'AjustesLalurParteA'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLalurParteA."CREDEB_EXCLUSAO"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 79.811070000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'AjustesLalurParteA."PRE_DTAFIN"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.913420000000000000
          Width = 60.472440940000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 68.031496060000000000
          Top = 56.913420000000000000
          Width = 453.543307090000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Hist'#243'rico')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 521.929500000000000000
          Top = 56.913420000000000000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Adi'#231#245'es')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 619.842920000000000000
          Top = 57.133890000000000000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Exclus'#245'es')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Align = baWidth
          Top = 2.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RepTitAjustesLalurParteA]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 0.377952760000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 41.015770000000000000
          Width = 419.527830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Per'#237'odo: [AjustesLalurParteA."PRE_DTAINI"] a [AjustesLalurParteA' +
              '."PRE_DTAFIN"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Empresa: [EmpCnpj] [EmpNome]')
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 76.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 23.677180000000000000
        Top = 162.519790000000000000
        Width = 718.110700000000000000
        object Line17: TfrxLineView
          Top = 0.755905511811000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo25: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totais:')
          ParentFont = False
        end
        object meSubTotalLalurAdicao: TfrxMemoView
          Left = 469.016080000000000000
          Top = 1.000000000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'meSubTotalLalurAdicaoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
        end
        object meSubTotalLalurExclusao: TfrxMemoView
          Left = 566.929500000000000000
          Top = 1.000000000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'meSubTotalLalurExclusaoOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
        end
        object meSubTotalAdicaoLalurCreDeb: TfrxMemoView
          Left = 601.299630000000000000
          Top = 1.000000000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLacsParteA."CREDEB_ADICAO"]')
          ParentFont = False
        end
        object meSubTotalExclusaoLalurCreDeb: TfrxMemoView
          Left = 699.213050000000000000
          Top = 1.000000000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[AjustesLacsParteA."CREDEB_ADICAO"]')
          ParentFont = False
        end
      end
      object PageFooter5: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 245.669450000000000000
        Width = 718.110700000000000000
        object Memo86: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VersaoDataHora]')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Align = baCenter
          Left = 294.803340000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
      end
    end
    object pgDemonstrativoLalurParteA: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 79.811070000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'DemonstrativoLalurParteA."DTAFIN"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.913420000000000000
          Width = 517.795610000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 521.929500000000000000
          Top = 56.913420000000000000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
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
        object Memo30: TfrxMemoView
          Left = 619.842920000000000000
          Top = 57.133890000000000000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Align = baWidth
          Top = 2.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RepTitDemonstrativoLalurParteA]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Align = baWidth
          Top = 0.377952760000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo32: TfrxMemoView
          Left = 3.779530000000000000
          Top = 41.015770000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Per'#237'odo: [DemonstrativoLalurParteA."DTAINI"] a [DemonstrativoLal' +
              'urParteA."DTAFIN"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Empresa: [EmpCnpj] [EmpNome]')
        end
        object Line7: TfrxLineView
          Align = baWidth
          Top = 76.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 120.944960000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDemonstrativoLalurParteA
        DataSetName = 'DemonstrativoLalurParteA'
        RowCount = 0
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Width = 517.795610000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRI'
          DataSet = frxDBDemonstrativoLalurParteA
          DataSetName = 'DemonstrativoLalurParteA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DemonstrativoLalurParteA."DESCRI"]')
          ParentFont = False
        end
        object DemonstrativoLalurParteAVALOR_: TfrxMemoView
          Left = 521.929500000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'DemonstrativoLalurParteAVALOR_OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DemonstrativoLacsParteA."VALOR_"]')
          ParentFont = False
        end
        object DemonstrativoLalurParteATOTAL_: TfrxMemoView
          Left = 619.842920000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'DemonstrativoLalurParteATOTAL_OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DemonstrativoLalurParteA."TOTAL_"]')
          ParentFont = False
        end
      end
      object PageFooter6: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        object Memo88: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VersaoDataHora]')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Align = baCenter
          Left = 294.803340000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
      end
    end
    object pgLancamentosCtaConLalurParteB: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object GroupHeader6: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 79.811070000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'BaseNegativaLalurParteB."CTACON"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo5: TfrxMemoView
          Left = 72.779530000000000000
          Top = 56.692950000000000000
          Width = 347.716760000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Hist'#243'rico')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 424.441250000000000000
          Top = 56.692950000000000000
          Width = 86.929190000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'D'#233'bito')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 597.842920000000000000
          Top = 56.692950000000000000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Saldo')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Align = baWidth
          Top = 2.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RepTitLancamentosCtaConLalurParteB]')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Align = baWidth
          Top = 0.377952760000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo46: TfrxMemoView
          Left = 3.779530000000000000
          Top = 40.015770000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'C'#243'digo: [BaseNegativaLalurParteB."CTACON"] - [BaseNegativaLalurP' +
              'arteB."DESCRI"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo47: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Empresa: [EmpCnpj] [EmpNome]')
        end
        object Line11: TfrxLineView
          Align = baWidth
          Top = 76.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo48: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.692950000000000000
          Width = 68.031540000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 511.016080000000000000
          Top = 56.692950000000000000
          Width = 86.929190000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cr'#233'dito')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 699.213050000000000000
          Top = 56.692950000000000000
          Width = 18.897650000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DC')
          ParentFont = False
        end
      end
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 120.944960000000000000
        Width = 718.110700000000000000
        DataSet = frxDBBaseNegativaLalurParteB
        DataSetName = 'BaseNegativaLalurParteB'
        RowCount = 0
        object BaseNegativaLalurParteBDTALAN: TfrxMemoView
          Left = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'DTALAN'
          DataSet = frxDBBaseNegativaLalurParteB
          DataSetName = 'BaseNegativaLalurParteB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BaseNegativaLalurParteB."DTALAN"]')
          ParentFont = False
        end
        object BaseNegativaLalurParteBHISTOR: TfrxMemoView
          Left = 72.779530000000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          DataField = 'HISTOR'
          DataSet = frxDBBaseNegativaLalurParteB
          DataSetName = 'BaseNegativaLalurParteB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BaseNegativaLalurParteB."HISTOR"]')
          ParentFont = False
        end
        object BaseNegativaLalurParteBDEBITO: TfrxMemoView
          Left = 424.441250000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'DEBITO'
          DataSet = frxDBBaseNegativaLalurParteB
          DataSetName = 'BaseNegativaLalurParteB'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseNegativaLalurParteB."DEBITO"]')
          ParentFont = False
        end
        object BaseNegativaLalurParteBCREDIT: TfrxMemoView
          Left = 511.016080000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'CREDIT'
          DataSet = frxDBBaseNegativaLalurParteB
          DataSetName = 'BaseNegativaLalurParteB'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseNegativaLalurParteB."CREDIT"]')
          ParentFont = False
        end
        object BaseNegativaLalurParteBSALDO_: TfrxMemoView
          Left = 597.842920000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'SALDO_'
          DataSet = frxDBBaseNegativaLalurParteB
          DataSetName = 'BaseNegativaLalurParteB'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseNegativaLalurParteB."SALDO_"]')
          ParentFont = False
        end
        object BaseNegativaLalurParteBCREDEB: TfrxMemoView
          Left = 699.213050000000000000
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          DataField = 'CREDEB'
          DataSet = frxDBBaseNegativaLalurParteB
          DataSetName = 'BaseNegativaLalurParteB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BaseNegativaLalurParteB."CREDEB"]')
          ParentFont = False
        end
      end
      object PageFooter7: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        object Memo90: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VersaoDataHora]')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Align = baCenter
          Left = 294.803340000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
      end
    end
    object pgLalurApuracao: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object GroupHeader8: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 68.472480000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'ApuracaoLalurMestre."PRE_DTAFIN"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo7: TfrxMemoView
          Align = baWidth
          Top = 2.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RepTitLalurApuracao]')
          ParentFont = False
        end
        object Line14: TfrxLineView
          Align = baWidth
          Top = 0.377952760000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo64: TfrxMemoView
          Left = 3.779530000000000000
          Top = 41.015770000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Per'#237'odo: [ApuracaoLalurMestre."PRE_DTAINI"] a [ApuracaoLalurMest' +
              're."PRE_DTAFIN"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo65: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Empresa: [EmpCnpj] [EmpNome]')
        end
        object Line15: TfrxLineView
          Align = baWidth
          Top = 65.252010000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData6: TfrxMasterData
        FillType = ftBrush
        Height = 234.551330000000000000
        Top = 109.606370000000000000
        Width = 718.110700000000000000
        DataSet = frxDBApuracaoLalurMestre
        DataSetName = 'ApuracaoLalurMestre'
        RowCount = 0
        object Memo66: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Base de C'#225'lculo do Imposto de Renda')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 582.047620000000000000
          Top = 7.559060000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
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
        object Memo68: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.795300000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Lucro l'#237'quido antes da IRPJ')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.811070000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(+) Adi'#231#245'es')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 3.779530000000000000
          Top = 93.826840000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Exclus'#245'es')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 3.779530000000000000
          Top = 127.842610000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '(=) Base de c'#225'lculo antes da compensa'#231#227'o dos preju'#237'zos acumulado' +
              's')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 3.779530000000000000
          Top = 149.858380000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(-) Compensa'#231#227'o dos preju'#237'zos acumulados')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 3.779530000000000000
          Top = 184.874150000000000000
          Width = 366.614410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(=) Base de c'#225'lculo do IRPJ')
          ParentFont = False
        end
        object ApuracaoLalurMestreLUCRO_LIQUIDO: TfrxMemoView
          Left = 582.047620000000000000
          Top = 37.795300000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLalurMestreLUCRO_LIQUIDOOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."LUCRO_LIQUIDO"]')
          ParentFont = False
        end
        object ApuracaoLalurMestreVRE_VLADIC: TfrxMemoView
          Left = 582.047620000000000000
          Top = 71.811070000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLalurMestreVRE_VLADICOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."VRE_VLADIC"]')
          ParentFont = False
        end
        object ApuracaoLalurMestreVRE_VLEXCL: TfrxMemoView
          Left = 582.047620000000000000
          Top = 93.826840000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLalurMestreVRE_VLEXCLOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."VRE_VLEXCL"]')
          ParentFont = False
        end
        object ApuracaoLalurMestreVRE_VLBCNG: TfrxMemoView
          Left = 582.047620000000000000
          Top = 127.842610000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLalurMestreVRE_VLBCNGOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."VRE_VLBCNG"]')
          ParentFont = False
        end
        object ApuracaoLalurMestreVRE_VLCOMP: TfrxMemoView
          Left = 582.047620000000000000
          Top = 149.858380000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLalurMestreVRE_VLCOMPOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."VRE_VLCOMP"]')
          ParentFont = False
        end
        object ApuracaoLalurMestreVRE_VLRBAS: TfrxMemoView
          Left = 582.047620000000000000
          Top = 184.874150000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'ApuracaoLalurMestreVRE_VLRBASOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsMestre."VRE_VLRBAS"]')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Left = 3.779530000000000000
          Top = 215.653680000000000000
          Width = 445.984540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Apura'#231#227'o do Imposto de Renda')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 453.291590000000000000
          Top = 215.653680000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Lucro Real/Balancete')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 582.047620000000000000
          Top = 215.653680000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Receita Bruta')
          ParentFont = False
        end
      end
      object DetailData2: TfrxDetailData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 366.614410000000000000
        Width = 718.110700000000000000
        DataSet = frxDBApuracaoLalurDetalhe
        DataSetName = 'ApuracaoLalurDetalhe'
        RowCount = 0
        object Memo83: TfrxMemoView
          Left = 3.779530000000000000
          Width = 445.984540000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRI'
          DataSet = frxDBApuracaoLalurDetalhe
          DataSetName = 'ApuracaoLalurDetalhe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ApuracaoLalurDetalhe."DESCRI"]')
          ParentFont = False
        end
        object ApuracaoLalurDetalheVLRBAL: TfrxMemoView
          Left = 453.291590000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'ApuracaoLalurDetalheVLRBALOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsDetalhe."VLRBAL"]')
          ParentFont = False
        end
        object ApuracaoLalurDetalheVLRREC: TfrxMemoView
          Left = 582.047620000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'ApuracaoLalurDetalheVLRRECOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ApuracaoLacsDetalhe."VLRREC"]')
          ParentFont = False
        end
      end
      object PageFooter8: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 442.205010000000000000
        Width = 718.110700000000000000
        object Memo92: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VersaoDataHora]')
          ParentFont = False
        end
        object Memo93: TfrxMemoView
          Align = baCenter
          Left = 294.803340000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
      end
    end
  end
  object frxPDFExport: TfrxPDFExport
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
    Left = 312
    Top = 176
  end
  object frxDBAjustesLacsParteA: TfrxDBDataset
    UserName = 'AjustesLacsParteA'
    CloseDataSource = False
    DataSet = cdsAjustesParteA
    BCDToCurrency = False
    Left = 168
    Top = 24
  end
  object frxDBDemonstrativoLacsParteA: TfrxDBDataset
    UserName = 'DemonstrativoLacsParteA'
    CloseDataSource = False
    DataSet = cdsDemonstrativoParteA
    BCDToCurrency = False
    Left = 168
    Top = 72
  end
  object frxDBAjustesLalurParteA: TfrxDBDataset
    UserName = 'AjustesLalurParteA'
    CloseDataSource = False
    DataSet = cdsAjustesParteA
    BCDToCurrency = False
    Left = 200
    Top = 24
  end
  object frxDBDemonstrativoLalurParteA: TfrxDBDataset
    UserName = 'DemonstrativoLalurParteA'
    CloseDataSource = False
    DataSet = cdsDemonstrativoParteA
    BCDToCurrency = False
    Left = 200
    Top = 72
  end
  object cdsAjustesParteA: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 8
    object cdsAjustesParteAAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsAjustesParteAPRE_DTAINI: TDateField
      FieldName = 'PRE_DTAINI'
    end
    object cdsAjustesParteAPRE_DTAFIN: TDateField
      FieldName = 'PRE_DTAFIN'
    end
    object cdsAjustesParteAARE_DTALAN: TDateField
      FieldName = 'ARE_DTALAN'
    end
    object cdsAjustesParteAHISTOR: TStringField
      FieldName = 'HISTOR'
      Size = 2048
    end
    object cdsAjustesParteAVAL_ADICAO: TFloatField
      FieldName = 'VAL_ADICAO'
    end
    object cdsAjustesParteAVAL_EXCLUSAO: TFloatField
      FieldName = 'VAL_EXCLUSAO'
    end
    object cdsAjustesParteACREDEB_ADICAO: TStringField
      FieldName = 'CREDEB_ADICAO'
      Size = 1
    end
    object cdsAjustesParteACREDEB_EXCLUSAO: TStringField
      FieldName = 'CREDEB_EXCLUSAO'
      Size = 1
    end
  end
  object cdsDemonstrativoParteA: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 56
    object cdsDemonstrativoParteACODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsDemonstrativoParteAAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsDemonstrativoParteADTAINI: TDateField
      FieldName = 'DTAINI'
    end
    object cdsDemonstrativoParteADTAFIN: TDateField
      FieldName = 'DTAFIN'
    end
    object cdsDemonstrativoParteADESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 125
    end
    object cdsDemonstrativoParteAVALOR_: TFloatField
      FieldName = 'VALOR_'
    end
    object cdsDemonstrativoParteATOTAL_: TFloatField
      FieldName = 'TOTAL_'
    end
  end
  object cdsBaseNegativaParteB: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 104
    object cdsBaseNegativaParteBCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsBaseNegativaParteBCTACON: TStringField
      FieldName = 'CTACON'
      Size = 5
    end
    object cdsBaseNegativaParteBDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 100
    end
    object cdsBaseNegativaParteBDTALAN: TDateField
      FieldName = 'DTALAN'
    end
    object cdsBaseNegativaParteBHISTOR: TStringField
      FieldName = 'HISTOR'
      Size = 2048
    end
    object cdsBaseNegativaParteBDEBITO: TFloatField
      FieldName = 'DEBITO'
    end
    object cdsBaseNegativaParteBCREDIT: TFloatField
      FieldName = 'CREDIT'
    end
    object cdsBaseNegativaParteBSALDO_: TFloatField
      FieldName = 'SALDO_'
    end
    object cdsBaseNegativaParteBCREDEB: TStringField
      FieldName = 'CREDEB'
      Size = 1
    end
  end
  object frxDBBaseNegativaLacsParteB: TfrxDBDataset
    UserName = 'BaseNegativaLacsParteB'
    CloseDataSource = False
    DataSet = cdsBaseNegativaParteB
    BCDToCurrency = False
    Left = 168
    Top = 120
  end
  object frxDBBaseNegativaLalurParteB: TfrxDBDataset
    UserName = 'BaseNegativaLalurParteB'
    CloseDataSource = False
    DataSet = cdsBaseNegativaParteB
    BCDToCurrency = False
    Left = 200
    Top = 120
  end
  object cdsApuracaoMestre: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 152
    object cdsApuracaoMestreAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsApuracaoMestrePRE_DTAINI: TDateField
      FieldName = 'PRE_DTAINI'
    end
    object cdsApuracaoMestrePRE_DTAFIN: TDateField
      FieldName = 'PRE_DTAFIN'
    end
    object cdsApuracaoMestreLUCRO_LIQUIDO: TFloatField
      FieldName = 'LUCRO_LIQUIDO'
    end
    object cdsApuracaoMestreVRE_VLADIC: TFloatField
      FieldName = 'VRE_VLADIC'
    end
    object cdsApuracaoMestreVRE_VLEXCL: TFloatField
      FieldName = 'VRE_VLEXCL'
    end
    object cdsApuracaoMestreVRE_VLBCNG: TFloatField
      FieldName = 'VRE_VLBCNG'
    end
    object cdsApuracaoMestreVRE_VLCOMP: TFloatField
      FieldName = 'VRE_VLCOMP'
    end
    object cdsApuracaoMestreVRE_VLRBAS: TFloatField
      FieldName = 'VRE_VLRBAS'
    end
  end
  object cdsApuracaoDetalhe: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 200
    object cdsApuracaoDetalheCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsApuracaoDetalheAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsApuracaoDetalheDTAINI: TDateField
      FieldName = 'DTAINI'
    end
    object cdsApuracaoDetalheDTAFIN: TDateField
      FieldName = 'DTAFIN'
    end
    object cdsApuracaoDetalheDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 125
    end
    object cdsApuracaoDetalheVLRBAL: TFloatField
      FieldName = 'VLRBAL'
    end
    object cdsApuracaoDetalheVLRREC: TFloatField
      FieldName = 'VLRREC'
    end
    object cdsApuracaoDetalheTITULO: TIntegerField
      FieldName = 'TITULO'
    end
  end
  object frxDBApuracaoLacsMestre: TfrxDBDataset
    UserName = 'ApuracaoLacsMestre'
    CloseDataSource = False
    DataSet = cdsApuracaoMestre
    BCDToCurrency = False
    Left = 168
    Top = 168
  end
  object frxDBApuracaoLalurMestre: TfrxDBDataset
    UserName = 'ApuracaoLalurMestre'
    CloseDataSource = False
    DataSet = cdsApuracaoMestre
    BCDToCurrency = False
    Left = 168
    Top = 216
  end
  object frxDBApuracaoLacsDetalhe: TfrxDBDataset
    UserName = 'ApuracaoLacsDetalhe'
    CloseDataSource = False
    DataSet = cdsApuracaoDetalhe
    BCDToCurrency = False
    Left = 200
    Top = 168
  end
  object frxDBApuracaoLalurDetalhe: TfrxDBDataset
    UserName = 'ApuracaoLalurDetalhe'
    CloseDataSource = False
    DataSet = cdsApuracaoDetalhe
    BCDToCurrency = False
    Left = 200
    Top = 216
  end
end
