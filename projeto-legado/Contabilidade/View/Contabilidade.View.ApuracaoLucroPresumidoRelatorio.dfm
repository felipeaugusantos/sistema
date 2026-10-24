inherited frmApuracaoLucroPresumidoRelatorio: TfrmApuracaoLucroPresumidoRelatorio
  Width = 559
  Height = 285
  Caption = 'Relat'#243'rio Apura'#231#227'o do Lucro Presumido'
  Position = poDesktopCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 559
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 212
    Width = 553
    TabOrder = 5
    ExplicitTop = 212
    ExplicitWidth = 553
    inherited FlwBotoes: TFlowPanel
      Width = 549
      ExplicitWidth = 549
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
      Left = 473
      ExplicitLeft = 473
    end
  end
  inherited pnlStatus: TPanel
    Top = 240
    Width = 553
    TabOrder = 6
    ExplicitTop = 240
    ExplicitWidth = 553
    inherited pnlNomeForm: TPanel
      Left = 382
      ExplicitLeft = 382
    end
    inherited pnlInfo: TPanel
      Width = 382
      ExplicitWidth = 382
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
    OnExit = edtExercicioExit
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
    TabOrder = 3
    Width = 121
  end
  object cckApuracao: TcxCheckGroup [8]
    Left = 16
    Top = 127
    Caption = 'Op'#231#245'es'
    Properties.Items = <
      item
        Caption = 'Apura'#231#227'o da CSLL'
      end
      item
        Caption = 'Apura'#231#227'o da IRPJ'
      end>
    TabOrder = 4
    Height = 74
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
  object cdsBaseCalculoCSLL: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 456
    object cdsBaseCalculoCSLLAUTOINCREM: TLargeintField
      FieldName = 'AUTOINCREM'
    end
    object cdsBaseCalculoCSLLCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsBaseCalculoCSLLDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 512
    end
    object cdsBaseCalculoCSLLTRIM01: TFloatField
      FieldName = 'TRIM01'
    end
    object cdsBaseCalculoCSLLTRIM02: TFloatField
      FieldName = 'TRIM02'
    end
    object cdsBaseCalculoCSLLTRIM03: TFloatField
      FieldName = 'TRIM03'
    end
    object cdsBaseCalculoCSLLTRIM04: TFloatField
      FieldName = 'TRIM04'
    end
    object cdsBaseCalculoCSLLTRIMTT: TFloatField
      FieldName = 'TRIMTT'
    end
    object cdsBaseCalculoCSLLGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
  end
  object cdsValorApuradoCSLL: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 456
    Top = 48
    object cdsValorApuradoCSLLAUTOINCREM: TLargeintField
      FieldName = 'AUTOINCREM'
    end
    object cdsValorApuradoCSLLCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsValorApuradoCSLLDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 512
    end
    object cdsValorApuradoCSLLTRIM01: TFloatField
      FieldName = 'TRIM01'
    end
    object cdsValorApuradoCSLLTRIM02: TFloatField
      FieldName = 'TRIM02'
    end
    object cdsValorApuradoCSLLTRIM03: TFloatField
      FieldName = 'TRIM03'
    end
    object cdsValorApuradoCSLLTRIM04: TFloatField
      FieldName = 'TRIM04'
    end
    object cdsValorApuradoCSLLTRIMTT: TFloatField
      FieldName = 'TRIMTT'
    end
    object cdsValorApuradoCSLLGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
  end
  object cdsBaseCalculoIRPJ: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 456
    Top = 96
    object cdsBaseCalculoIRPJAUTOINCREM: TLargeintField
      FieldName = 'AUTOINCREM'
    end
    object cdsBaseCalculoIRPJCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsBaseCalculoIRPJDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 512
    end
    object cdsBaseCalculoIRPJTRIM01: TFloatField
      FieldName = 'TRIM01'
    end
    object cdsBaseCalculoIRPJTRIM02: TFloatField
      FieldName = 'TRIM02'
    end
    object cdsBaseCalculoIRPJTRIM03: TFloatField
      FieldName = 'TRIM03'
    end
    object cdsBaseCalculoIRPJTRIM04: TFloatField
      FieldName = 'TRIM04'
    end
    object cdsBaseCalculoIRPJTRIMTT: TFloatField
      FieldName = 'TRIMTT'
    end
    object cdsBaseCalculoIRPJGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
  end
  object cdsValorApuradoIRPJ: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 456
    Top = 144
    object cdsValorApuradoIRPJAUTOINCREM: TLargeintField
      FieldName = 'AUTOINCREM'
    end
    object cdsValorApuradoIRPJCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsValorApuradoIRPJDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 512
    end
    object cdsValorApuradoIRPJTRIM01: TFloatField
      FieldName = 'TRIM01'
    end
    object cdsValorApuradoIRPJTRIM02: TFloatField
      FieldName = 'TRIM02'
    end
    object cdsValorApuradoIRPJTRIM03: TFloatField
      FieldName = 'TRIM03'
    end
    object cdsValorApuradoIRPJTRIM04: TFloatField
      FieldName = 'TRIM04'
    end
    object cdsValorApuradoIRPJTRIMTT: TFloatField
      FieldName = 'TRIMTT'
    end
    object cdsValorApuradoIRPJGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
  end
  object frxDBBaseCalculoCSLL: TfrxDBDataset
    UserName = 'BaseCalculoCSLL'
    CloseDataSource = False
    DataSet = cdsBaseCalculoCSLL
    BCDToCurrency = False
    Left = 368
  end
  object frxDBValorApuradoCSLL: TfrxDBDataset
    UserName = 'ValorApuradoCSLL'
    CloseDataSource = False
    DataSet = cdsValorApuradoCSLL
    BCDToCurrency = False
    Left = 368
    Top = 48
  end
  object frxDBBaseCalculoIRPJ: TfrxDBDataset
    UserName = 'BaseCalculoIRPJ'
    CloseDataSource = False
    DataSet = cdsBaseCalculoIRPJ
    BCDToCurrency = False
    Left = 368
    Top = 96
  end
  object frxDBValorApuradoIRPJ: TfrxDBDataset
    UserName = 'ValorApuradoIRPJ'
    CloseDataSource = False
    DataSet = cdsValorApuradoIRPJ
    BCDToCurrency = False
    Left = 368
    Top = 144
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
    Left = 232
    Top = 96
  end
  object RelatorioLucroPresumido: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45195.682610520800000000
    ReportOptions.LastChange = 45196.653934213000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure cmpTrim01OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<BaseCalculoCSLL."CODIGO">) <> '#39'1'#39' then'
      '    if (<BaseCalculoCSLL."TRIM01"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<BaseCalculoCSLL."TRIM01">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Base' +
        'CalculoCSLL."TRIM01">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<BaseCalculoCSLL."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloCSLL."CODIGO">) = '#39'21'#39') or (trim(<BaseCalculoCSLL."CODIGO">) ' +
        '= '#39'6'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpTrim02OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<BaseCalculoCSLL."CODIGO">) <> '#39'1'#39' then'
      '    if (<BaseCalculoCSLL."TRIM02"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<BaseCalculoCSLL."TRIM02">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Base' +
        'CalculoCSLL."TRIM02">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<BaseCalculoCSLL."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloCSLL."CODIGO">) = '#39'21'#39') or (trim(<BaseCalculoCSLL."CODIGO">) ' +
        '= '#39'6'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpTrim03OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<BaseCalculoCSLL."CODIGO">) <> '#39'1'#39' then'
      '    if (<BaseCalculoCSLL."TRIM03"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<BaseCalculoCSLL."TRIM03">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Base' +
        'CalculoCSLL."TRIM03">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<BaseCalculoCSLL."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloCSLL."CODIGO">) = '#39'21'#39') or (trim(<BaseCalculoCSLL."CODIGO">) ' +
        '= '#39'6'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpTrim04OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<BaseCalculoCSLL."CODIGO">) <> '#39'1'#39' then'
      '    if (<BaseCalculoCSLL."TRIM04"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<BaseCalculoCSLL."TRIM04">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Base' +
        'CalculoCSLL."TRIM04">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<BaseCalculoCSLL."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloCSLL."CODIGO">) = '#39'21'#39') or (trim(<BaseCalculoCSLL."CODIGO">) ' +
        '= '#39'6'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpTotalOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<BaseCalculoCSLL."CODIGO">) <> '#39'1'#39' then'
      '    if (<BaseCalculoCSLL."TRIMTT"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<BaseCalculoCSLL."TRIMTT">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Base' +
        'CalculoCSLL."TRIMTT">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<BaseCalculoCSLL."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloCSLL."CODIGO">) = '#39'21'#39') or (trim(<BaseCalculoCSLL."CODIGO">) ' +
        '= '#39'6'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpDescricaoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (trim(<BaseCalculoCSLL."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloCSLL."CODIGO">) = '#39'21'#39') or (trim(<BaseCalculoCSLL."CODIGO">) ' +
        '= '#39'6'#39')  then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (trim(<BaseCalculoCSLL."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloCSLL."CODIGO">) = '#39'21'#39') or (trim(<BaseCalculoCSLL."CODIGO">) ' +
        '= '#39'6'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      
        'procedure LinhaTotalSuperiorOnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      '  if trim(<BaseCalculoCSLL."CODIGO">) = '#39'21'#39' then'
      '    LinhaTotalSuperior.Visible := True'
      '  else'
      '    LinhaTotalSuperior.Visible := False ;'
      'end;'
      ''
      
        'procedure LinhaTotalInferiorOnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      '  if trim(<BaseCalculoCSLL."CODIGO">) = '#39'21'#39' then'
      '    LinhaTotalInferior.Visible := True'
      '  else'
      '    LinhaTotalInferior.Visible := False ;'
      'end;'
      ''
      'procedure cmpTrim01VlCsllOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<ValorApuradoCSLL."CODIGO">) <> '#39'5'#39' then    '
      '    if (<ValorApuradoCSLL."TRIM01"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ValorApuradoCSLL."TRIM01">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Valo' +
        'rApuradoCSLL."TRIM01">)'
      '  else'
      
        '    TfrxMemoView(Sender).Text := '#39#39' ;                           ' +
        '  '
      ''
      
        '  if (trim(<ValorApuradoCSLL."CODIGO">) = '#39'4'#39') or (trim(<ValorAp' +
        'uradoCSLL."CODIGO">) = '#39'13'#39') or (trim(<ValorApuradoCSLL."CODIGO"' +
        '>) = '#39'5'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpTrim02VlCsllOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<ValorApuradoCSLL."CODIGO">) <> '#39'5'#39' then    '
      '    if (<ValorApuradoCSLL."TRIM02"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ValorApuradoCSLL."TRIM02">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Valo' +
        'rApuradoCSLL."TRIM02">)'
      '  else'
      
        '    TfrxMemoView(Sender).Text := '#39#39' ;                           ' +
        '  '
      ''
      
        '  if (trim(<ValorApuradoCSLL."CODIGO">) = '#39'4'#39') or (trim(<ValorAp' +
        'uradoCSLL."CODIGO">) = '#39'13'#39') or (trim(<ValorApuradoCSLL."CODIGO"' +
        '>) = '#39'5'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpTrim03VlCsllOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<ValorApuradoCSLL."CODIGO">) <> '#39'5'#39' then    '
      '    if (<ValorApuradoCSLL."TRIM03"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ValorApuradoCSLL."TRIM03">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Valo' +
        'rApuradoCSLL."TRIM03">)'
      '  else'
      
        '    TfrxMemoView(Sender).Text := '#39#39' ;                           ' +
        '  '
      ''
      '    '
      
        '  if (trim(<ValorApuradoCSLL."CODIGO">) = '#39'4'#39') or (trim(<ValorAp' +
        'uradoCSLL."CODIGO">) = '#39'13'#39') or (trim(<ValorApuradoCSLL."CODIGO"' +
        '>) = '#39'5'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpTrim04VlCsllOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<ValorApuradoCSLL."CODIGO">) <> '#39'5'#39' then    '
      '    if (<ValorApuradoCSLL."TRIM04"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ValorApuradoCSLL."TRIM04">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Valo' +
        'rApuradoCSLL."TRIM04">) '
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;                 '
      ''
      '    '
      
        '  if (trim(<ValorApuradoCSLL."CODIGO">) = '#39'4'#39') or (trim(<ValorAp' +
        'uradoCSLL."CODIGO">) = '#39'13'#39') or (trim(<ValorApuradoCSLL."CODIGO"' +
        '>) = '#39'5'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpTotalVlCsllOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<ValorApuradoCSLL."CODIGO">) <> '#39'5'#39' then    '
      '    if (<ValorApuradoCSLL."TRIMTT"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ValorApuradoCSLL."TRIMTT">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Valo' +
        'rApuradoCSLL."TRIMTT">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;                 '
      '       '
      
        '  if (trim(<ValorApuradoCSLL."CODIGO">) = '#39'4'#39') or (trim(<ValorAp' +
        'uradoCSLL."CODIGO">) = '#39'13'#39') or (trim(<ValorApuradoCSLL."CODIGO"' +
        '>) = '#39'5'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      
        'procedure LinhaInferiorVlCsllOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      '  if trim(<ValorApuradoCSLL."CODIGO">) = '#39'13'#39' then'
      '    LinhaInferiorVlCsll.Visible := True'
      '  else'
      '    LinhaInferiorVlCsll.Visible := False ;'
      'end;'
      ''
      
        'procedure cmpDescricaoVlCsllOnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      
        '  if (trim(<ValorApuradoCSLL."CODIGO">) = '#39'4'#39') or (trim(<ValorAp' +
        'uradoCSLL."CODIGO">) = '#39'13'#39') or (trim(<ValorApuradoCSLL."CODIGO"' +
        '>) = '#39'5'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      
        'procedure LinhaSuperiorVlCsllOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      '  if trim(<ValorApuradoCSLL."CODIGO">) = '#39'13'#39' then'
      '    LinhaSuperiorVlCsll.Visible := True'
      '  else'
      '    LinhaSuperiorVlCsll.Visible := False ;'
      'end;'
      ''
      'procedure cmpCodigoVlCsllOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (trim(<ValorApuradoCSLL."CODIGO">) = '#39'4'#39') or (trim(<ValorAp' +
        'uradoCSLL."CODIGO">) = '#39'13'#39') or (trim(<ValorApuradoCSLL."CODIGO"' +
        '>) = '#39'5'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;'
      'end;'
      ''
      'procedure cmpTrim01BcIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<BaseCalculoIRPJ."CODIGO">) <> '#39'1'#39' then'
      '    if (<BaseCalculoIRPJ."TRIM01"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<BaseCalculoIRPJ."TRIM01">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Base' +
        'CalculoIRPJ."TRIM01">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<BaseCalculoIRPJ."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloIRPJ."CODIGO">) = '#39'10'#39') or (trim(<BaseCalculoIRPJ."CODIGO">) ' +
        '= '#39'26'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      'procedure cmpTrim02BcIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<BaseCalculoIRPJ."CODIGO">) <> '#39'1'#39' then'
      '    if (<BaseCalculoIRPJ."TRIM02"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<BaseCalculoIRPJ."TRIM02">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Base' +
        'CalculoIRPJ."TRIM02">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<BaseCalculoIRPJ."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloIRPJ."CODIGO">) = '#39'10'#39') or (trim(<BaseCalculoIRPJ."CODIGO">) ' +
        '= '#39'26'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      'procedure cmpTrim03BcIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<BaseCalculoIRPJ."CODIGO">) <> '#39'1'#39' then'
      '    if (<BaseCalculoIRPJ."TRIM03"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<BaseCalculoIRPJ."TRIM03">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Base' +
        'CalculoIRPJ."TRIM03">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<BaseCalculoIRPJ."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloIRPJ."CODIGO">) = '#39'10'#39') or (trim(<BaseCalculoIRPJ."CODIGO">) ' +
        '= '#39'26'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      'procedure cmpTrim04BcIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<BaseCalculoIRPJ."CODIGO">) <> '#39'1'#39' then'
      '    if (<BaseCalculoIRPJ."TRIM04"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<BaseCalculoIRPJ."TRIM04">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Base' +
        'CalculoIRPJ."TRIM04">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<BaseCalculoIRPJ."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloIRPJ."CODIGO">) = '#39'10'#39') or (trim(<BaseCalculoIRPJ."CODIGO">) ' +
        '= '#39'26'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      'procedure cmpTotalBcIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if trim(<BaseCalculoIRPJ."CODIGO">) <> '#39'1'#39' then'
      '    if (<BaseCalculoIRPJ."TRIMTT"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<BaseCalculoIRPJ."TRIMTT">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Base' +
        'CalculoIRPJ."TRIMTT">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<BaseCalculoIRPJ."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloIRPJ."CODIGO">) = '#39'10'#39') or (trim(<BaseCalculoIRPJ."CODIGO">) ' +
        '= '#39'26'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      'procedure cmpCodigoBcIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (trim(<BaseCalculoIRPJ."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloIRPJ."CODIGO">) = '#39'10'#39') or (trim(<BaseCalculoIRPJ."CODIGO">) ' +
        '= '#39'26'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      
        'procedure cmpDescricaoBcIrpjOnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      
        '  if (trim(<BaseCalculoIRPJ."CODIGO">) = '#39'1'#39') or (trim(<BaseCalc' +
        'uloIRPJ."CODIGO">) = '#39'10'#39') or (trim(<BaseCalculoIRPJ."CODIGO">) ' +
        '= '#39'26'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      
        'procedure LinhaInferiorBcIrpjOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      '  if trim(<BaseCalculoIRPJ."CODIGO">) = '#39'26'#39' then'
      '    LinhaInferiorBcIrpj.Visible := True'
      '  else'
      '    LinhaInferiorBcIrpj.Visible := False ;  '
      'end;'
      ''
      
        'procedure LinhaSuperiorBcIrpjOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      '  if trim(<BaseCalculoIRPJ."CODIGO">) = '#39'26'#39' then'
      '    LinhaSuperiorBcIrpj.Visible := True'
      '  else'
      '    LinhaSuperiorBcIrpj.Visible := False ;  '
      'end;'
      ''
      'procedure cmpTrim01VlIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) <> '#39'2'#39') and (trim(<Valor' +
        'ApuradoIRPJ."CODIGO">) <> '#39'6'#39') then'
      '    if (<ValorApuradoIRPJ."TRIM01"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ValorApuradoIRPJ."TRIM01">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Valo' +
        'rApuradoIRPJ."TRIM01">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) = '#39'2'#39') or (trim(<ValorAp' +
        'uradoIRPJ."CODIGO">) = '#39'6'#39') or (trim(<ValorApuradoIRPJ."CODIGO">' +
        ') = '#39'15'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      'procedure cmpTrim02VlIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) <> '#39'2'#39') and (trim(<Valor' +
        'ApuradoIRPJ."CODIGO">) <> '#39'6'#39') then'
      '    if (<ValorApuradoIRPJ."TRIM02"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ValorApuradoIRPJ."TRIM02">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Valo' +
        'rApuradoIRPJ."TRIM02">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) = '#39'2'#39') or (trim(<ValorAp' +
        'uradoIRPJ."CODIGO">) = '#39'6'#39') or (trim(<ValorApuradoIRPJ."CODIGO">' +
        ') = '#39'15'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      'procedure cmpTrim03VlIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) <> '#39'2'#39') and (trim(<Valor' +
        'ApuradoIRPJ."CODIGO">) <> '#39'6'#39') then'
      '    if (<ValorApuradoIRPJ."TRIM03"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ValorApuradoIRPJ."TRIM03">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Valo' +
        'rApuradoIRPJ."TRIM03">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) = '#39'2'#39') or (trim(<ValorAp' +
        'uradoIRPJ."CODIGO">) = '#39'6'#39') or (trim(<ValorApuradoIRPJ."CODIGO">' +
        ') = '#39'15'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      'procedure cmpTrim04VlIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) <> '#39'2'#39') and (trim(<Valor' +
        'ApuradoIRPJ."CODIGO">) <> '#39'6'#39') then'
      '    if (<ValorApuradoIRPJ."TRIM04"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ValorApuradoIRPJ."TRIM04">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Valo' +
        'rApuradoIRPJ."TRIM04">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) = '#39'2'#39') or (trim(<ValorAp' +
        'uradoIRPJ."CODIGO">) = '#39'6'#39') or (trim(<ValorApuradoIRPJ."CODIGO">' +
        ') = '#39'15'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      'procedure cmpTotalVlIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) <> '#39'2'#39') and (trim(<Valor' +
        'ApuradoIRPJ."CODIGO">) <> '#39'6'#39') then'
      '    if (<ValorApuradoIRPJ."TRIMTT"> < 0.00) then'
      
        '      TfrxMemoView(Sender).Text := '#39'('#39' + formatFloat('#39'#,##0.00'#39',' +
        ' abs(<ValorApuradoIRPJ."TRIMTT">)) + '#39')'#39
      '    else'
      
        '      TfrxMemoView(Sender).Text := formatFloat('#39'#,##0.00'#39', <Valo' +
        'rApuradoIRPJ."TRIMTT">)'
      '  else'
      '    TfrxMemoView(Sender).Text := '#39#39' ;'
      ''
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) = '#39'2'#39') or (trim(<ValorAp' +
        'uradoIRPJ."CODIGO">) = '#39'6'#39') or (trim(<ValorApuradoIRPJ."CODIGO">' +
        ') = '#39'15'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      'procedure cmpCodigoVlIrpjOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) = '#39'2'#39') or (trim(<ValorAp' +
        'uradoIRPJ."CODIGO">) = '#39'6'#39') or (trim(<ValorApuradoIRPJ."CODIGO">' +
        ') = '#39'15'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      
        'procedure cmpDescricaoVlIrpjOnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      
        '  if (trim(<ValorApuradoIRPJ."CODIGO">) = '#39'2'#39') or (trim(<ValorAp' +
        'uradoIRPJ."CODIGO">) = '#39'6'#39') or (trim(<ValorApuradoIRPJ."CODIGO">' +
        ') = '#39'15'#39') then'
      '    TfrxMemoView(Sender).Font.Style := fsBold'
      '  else'
      '    TfrxMemoView(Sender).Font.Style := 0 ;  '
      'end;'
      ''
      
        'procedure LinhaInferiorVlIrpjOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      '  if trim(<ValorApuradoIRPJ."CODIGO">) = '#39'15'#39' then'
      '    LinhaInferiorVlIrpj.Visible := True'
      '  else'
      '    LinhaInferiorVlIrpj.Visible := False ;  '
      'end;'
      ''
      
        'procedure LinhaSuperiorVlIrpjOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      '  if trim(<ValorApuradoIRPJ."CODIGO">) = '#39'15'#39' then'
      '    LinhaSuperiorVlIrpj.Visible := True'
      '  else'
      '    LinhaSuperiorVlIrpj.Visible := False ;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 232
    Top = 144
    Datasets = <
      item
        DataSet = frxDBBaseCalculoCSLL
        DataSetName = 'BaseCalculoCSLL'
      end
      item
        DataSet = frxDBBaseCalculoIRPJ
        DataSetName = 'BaseCalculoIRPJ'
      end
      item
        DataSet = frxDBValorApuradoCSLL
        DataSetName = 'ValorApuradoCSLL'
      end
      item
        DataSet = frxDBValorApuradoIRPJ
        DataSetName = 'ValorApuradoIRPJ'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object pgBaseCalculoCsll: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MDAjustesLacsParteA: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 147.401670000000000000
        Width = 718.110700000000000000
        DataSet = frxDBBaseCalculoCSLL
        DataSetName = 'BaseCalculoCSLL'
        RowCount = 0
        Stretched = True
        object cmpCodigo: TfrxMemoView
          Left = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpCodigoOnBeforePrint'
          DataField = 'CODIGO'
          DataSet = frxDBBaseCalculoCSLL
          DataSetName = 'BaseCalculoCSLL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BaseCalculoCSLL."CODIGO"]')
          ParentFont = False
        end
        object cmpDescricao: TfrxMemoView
          Left = 46.149660000000000000
          Width = 340.157480310000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpDescricaoOnBeforePrint'
          StretchMode = smMaxHeight
          DataField = 'DESCRI'
          DataSet = frxDBBaseCalculoCSLL
          DataSetName = 'BaseCalculoCSLL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BaseCalculoCSLL."DESCRI"]')
          ParentFont = False
        end
        object cmpTrim01: TfrxMemoView
          Left = 388.929500000000000000
          Width = 60.472480000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim01OnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM01"]')
          ParentFont = False
        end
        object cmpTrim02: TfrxMemoView
          Left = 452.827150000000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim02OnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM02"]')
          ParentFont = False
        end
        object cmpTrim03: TfrxMemoView
          Left = 514.771653540000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim03OnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM03"]')
          ParentFont = False
        end
        object cmpTrim04: TfrxMemoView
          Left = 578.267716540000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim04OnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM04"]')
          ParentFont = False
        end
        object cmpTotal: TfrxMemoView
          Left = 642.519685040000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTotalOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIMTT"]')
          ParentFont = False
        end
        object LinhaTotalSuperior: TfrxLineView
          Align = baWidth
          Top = 15.118120000000000000
          Width = 718.110700000000000000
          OnBeforePrint = 'LinhaTotalSuperiorOnBeforePrint'
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object LinhaTotalInferior: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          OnBeforePrint = 'LinhaTotalInferiorOnBeforePrint'
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 106.267780000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'BaseCalculoCSLL."GRUPO"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 80.913420000000000000
          Width = 41.574830000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 46.149660000000000000
          Top = 80.913420000000000000
          Width = 340.157700000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 388.929500000000000000
          Top = 80.913420000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '1'#186' Trimestre')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 452.827150000000000000
          Top = 81.133890000000000000
          Width = 60.472440940000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '2'#186' Trimestre')
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
            '[RepTitBaseCalculoCsll]')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 0.377952759999999000
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
            'Per'#237'odo: [DtaIni] a [DtaFin]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
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
          Top = 100.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo1: TfrxMemoView
          Left = 514.795610000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '3'#186' Trimestre')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 578.268090000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '4'#186' Trimestre')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 642.520100000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Totais')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 61.692950000000000000
          Width = 419.527830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Base de C'#225'lculo da CSLL')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 226.771800000000000000
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
    object pgValorApuradoCsll: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 147.401670000000000000
        Width = 718.110700000000000000
        DataSet = frxDBValorApuradoCSLL
        DataSetName = 'ValorApuradoCSLL'
        RowCount = 0
        Stretched = True
        object cmpCodigoVlCsll: TfrxMemoView
          Left = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpCodigoVlCsllOnBeforePrint'
          DataField = 'CODIGO'
          DataSet = frxDBValorApuradoCSLL
          DataSetName = 'ValorApuradoCSLL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ValorApuradoCSLL."CODIGO"]')
          ParentFont = False
        end
        object cmpDescricaoVlCsll: TfrxMemoView
          Left = 46.149660000000000000
          Width = 340.157480310000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpDescricaoVlCsllOnBeforePrint'
          StretchMode = smMaxHeight
          DataField = 'DESCRI'
          DataSet = frxDBValorApuradoCSLL
          DataSetName = 'ValorApuradoCSLL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ValorApuradoCSLL."DESCRI"]')
          ParentFont = False
        end
        object cmpTrim01VlCsll: TfrxMemoView
          Left = 388.929500000000000000
          Width = 60.472480000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim01VlCsllOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM01"]')
          ParentFont = False
        end
        object cmpTrim02VlCsll: TfrxMemoView
          Left = 452.827150000000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim02VlCsllOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM02"]')
          ParentFont = False
        end
        object cmpTrim03VlCsll: TfrxMemoView
          Left = 514.771653540000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim03VlCsllOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM03"]')
          ParentFont = False
        end
        object cmpTrim04VlCsll: TfrxMemoView
          Left = 578.267716540000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim04VlCsllOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM04"]')
          ParentFont = False
        end
        object cmpTotalVlCsll: TfrxMemoView
          Left = 642.519685040000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTotalVlCsllOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIMTT"]')
          ParentFont = False
        end
        object LinhaSuperiorVlCsll: TfrxLineView
          Align = baWidth
          Top = 15.118120000000000000
          Width = 718.110700000000000000
          OnBeforePrint = 'LinhaSuperiorVlCsllOnBeforePrint'
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object LinhaInferiorVlCsll: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          OnBeforePrint = 'LinhaInferiorVlCsllOnBeforePrint'
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 106.267780000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'ValorApuradoCSLL."GRUPO"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 80.913420000000000000
          Width = 41.574830000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 46.149660000000000000
          Top = 80.913420000000000000
          Width = 340.157700000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 388.929500000000000000
          Top = 80.913420000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '1'#186' Trimestre')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 452.827150000000000000
          Top = 81.133890000000000000
          Width = 60.472440940000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '2'#186' Trimestre')
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
            '[RepTitBaseCalculoCsll]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 0.377952759999999000
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
            'Per'#237'odo: [DtaIni] a [DtaFin]')
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
          Top = 100.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo25: TfrxMemoView
          Left = 514.795610000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '3'#186' Trimestre')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 578.268090000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '4'#186' Trimestre')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 642.520100000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Totais')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 3.779530000000000000
          Top = 61.692950000000000000
          Width = 419.527830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#225'lculo da CSLL')
          ParentFont = False
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 226.771800000000000000
        Width = 718.110700000000000000
        object Memo29: TfrxMemoView
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
        object Memo30: TfrxMemoView
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
    object pgBaseCalculoIrpj: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 147.401670000000000000
        Width = 718.110700000000000000
        DataSet = frxDBBaseCalculoIRPJ
        DataSetName = 'BaseCalculoIRPJ'
        RowCount = 0
        Stretched = True
        object cmpCodigoBcIrpj: TfrxMemoView
          Left = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpCodigoBcIrpjOnBeforePrint'
          DataField = 'CODIGO'
          DataSet = frxDBBaseCalculoIRPJ
          DataSetName = 'BaseCalculoIRPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BaseCalculoIRPJ."CODIGO"]')
          ParentFont = False
        end
        object cmpDescricaoBcIrpj: TfrxMemoView
          Left = 46.149660000000000000
          Width = 340.157480310000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpDescricaoBcIrpjOnBeforePrint'
          StretchMode = smMaxHeight
          DataField = 'DESCRI'
          DataSet = frxDBBaseCalculoIRPJ
          DataSetName = 'BaseCalculoIRPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BaseCalculoIRPJ."DESCRI"]')
          ParentFont = False
        end
        object cmpTrim01BcIrpj: TfrxMemoView
          Left = 388.929500000000000000
          Width = 60.472480000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim01BcIrpjOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM01"]')
          ParentFont = False
        end
        object cmpTrim02BcIrpj: TfrxMemoView
          Left = 452.827150000000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim02BcIrpjOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM02"]')
          ParentFont = False
        end
        object cmpTrim03BcIrpj: TfrxMemoView
          Left = 514.771653540000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim03BcIrpjOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM03"]')
          ParentFont = False
        end
        object cmpTrim04BcIrpj: TfrxMemoView
          Left = 578.267716540000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim04BcIrpjOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM04"]')
          ParentFont = False
        end
        object cmpTotalBcIrpj: TfrxMemoView
          Left = 642.519685040000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTotalBcIrpjOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIMTT"]')
          ParentFont = False
        end
        object LinhaInferiorBcIrpj: TfrxLineView
          Align = baWidth
          Top = 15.118120000000000000
          Width = 718.110700000000000000
          OnBeforePrint = 'LinhaInferiorBcIrpjOnBeforePrint'
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object LinhaSuperiorBcIrpj: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          OnBeforePrint = 'LinhaSuperiorBcIrpjOnBeforePrint'
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 106.267780000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'BaseCalculoIRPJ."GRUPO"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 80.913420000000000000
          Width = 41.574830000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 46.149660000000000000
          Top = 80.913420000000000000
          Width = 340.157700000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 388.929500000000000000
          Top = 80.913420000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '1'#186' Trimestre')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 452.827150000000000000
          Top = 81.133890000000000000
          Width = 60.472440940000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '2'#186' Trimestre')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
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
            '[RepTitBaseCalculoIrpj]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Align = baWidth
          Top = 0.377952759999999000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo36: TfrxMemoView
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
            'Per'#237'odo: [DtaIni] a [DtaFin]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Empresa: [EmpCnpj] [EmpNome]')
        end
        object Line7: TfrxLineView
          Align = baWidth
          Top = 100.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo38: TfrxMemoView
          Left = 514.795610000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '3'#186' Trimestre')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 578.268090000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '4'#186' Trimestre')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 642.520100000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Totais')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 61.692950000000000000
          Width = 419.527830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Base de C'#225'lculo do IRPJ')
          ParentFont = False
        end
      end
      object PageFooter3: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 226.771800000000000000
        Width = 718.110700000000000000
        object Memo42: TfrxMemoView
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
        object Memo43: TfrxMemoView
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
    object pgValorApuradoIrpj: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 147.401670000000000000
        Width = 718.110700000000000000
        DataSet = frxDBValorApuradoIRPJ
        DataSetName = 'ValorApuradoIRPJ'
        RowCount = 0
        Stretched = True
        object cmpCodigoVlIrpj: TfrxMemoView
          Left = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpCodigoVlIrpjOnBeforePrint'
          DataField = 'CODIGO'
          DataSet = frxDBValorApuradoIRPJ
          DataSetName = 'ValorApuradoIRPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ValorApuradoIRPJ."CODIGO"]')
          ParentFont = False
        end
        object cmpDescricaoVlIrpj: TfrxMemoView
          Left = 46.149660000000000000
          Width = 340.157480310000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpDescricaoVlIrpjOnBeforePrint'
          StretchMode = smMaxHeight
          DataField = 'DESCRI'
          DataSet = frxDBValorApuradoIRPJ
          DataSetName = 'ValorApuradoIRPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ValorApuradoIRPJ."DESCRI"]')
          ParentFont = False
        end
        object cmpTrim01VlIrpj: TfrxMemoView
          Left = 388.929500000000000000
          Width = 60.472480000000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim01VlIrpjOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM01"]')
          ParentFont = False
        end
        object cmpTrim02VlIrpj: TfrxMemoView
          Left = 452.827150000000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim02VlIrpjOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM02"]')
          ParentFont = False
        end
        object cmpTrim03VlIrpj: TfrxMemoView
          Left = 514.771653540000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim03VlIrpjOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM03"]')
          ParentFont = False
        end
        object cmpTrim04VlIrpj: TfrxMemoView
          Left = 578.267716540000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTrim04VlIrpjOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIM04"]')
          ParentFont = False
        end
        object cmpTotalVlIrpj: TfrxMemoView
          Left = 642.519685040000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          OnBeforePrint = 'cmpTotalVlIrpjOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[BaseCalculoCSLL."TRIMTT"]')
          ParentFont = False
        end
        object LinhaInferiorVlIrpj: TfrxLineView
          Align = baWidth
          Top = 15.118120000000000000
          Width = 718.110700000000000000
          OnBeforePrint = 'LinhaInferiorVlIrpjOnBeforePrint'
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object LinhaSuperiorVlIrpj: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          OnBeforePrint = 'LinhaSuperiorVlIrpjOnBeforePrint'
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader4: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 106.267780000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Condition = 'ValorApuradoIRPJ."GRUPO"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo51: TfrxMemoView
          Left = 3.779530000000000000
          Top = 80.913420000000000000
          Width = 41.574830000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 46.149660000000000000
          Top = 80.913420000000000000
          Width = 340.157700000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 388.929500000000000000
          Top = 80.913420000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '1'#186' Trimestre')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 452.827150000000000000
          Top = 81.133890000000000000
          Width = 60.472440940000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '2'#186' Trimestre')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
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
            '[RepTitBaseCalculoIrpj]')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Align = baWidth
          Top = 0.377952759999999000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo56: TfrxMemoView
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
            'Per'#237'odo: [DtaIni] a [DtaFin]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo57: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 532.913730000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Empresa: [EmpCnpj] [EmpNome]')
        end
        object Line11: TfrxLineView
          Align = baWidth
          Top = 100.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo58: TfrxMemoView
          Left = 514.795610000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '3'#186' Trimestre')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 578.268090000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '4'#186' Trimestre')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 642.520100000000000000
          Top = 80.692950000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Totais')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 3.779530000000000000
          Top = 61.692950000000000000
          Width = 419.527830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#225'lculo do IRPJ')
          ParentFont = False
        end
      end
      object PageFooter4: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 226.771800000000000000
        Width = 718.110700000000000000
        object Memo62: TfrxMemoView
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
        object Memo63: TfrxMemoView
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
  end
end
