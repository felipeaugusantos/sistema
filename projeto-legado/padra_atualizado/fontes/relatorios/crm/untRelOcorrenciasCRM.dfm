inherited frmRelOcorrenciasCRM: TfrmRelOcorrenciasCRM
  Width = 512
  Height = 484
  Caption = 'Relat'#243'rio de ocorr'#234'ncias'
  OnDestroy = FormDestroy
  ExplicitWidth = 512
  ExplicitHeight = 484
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 412
    Width = 506
    ExplicitTop = 368
    ExplicitWidth = 506
    inherited btnSair: TBitBtnLocked
      Left = 424
      ExplicitLeft = 424
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 81
      ExplicitLeft = 81
    end
  end
  inherited pnlDados: TPanel
    Width = 506
    Height = 412
    ExplicitWidth = 506
    ExplicitHeight = 368
    object lblCliente: TLabel [0]
      Left = 88
      Top = 11
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [1]
      Left = 26
      Top = 197
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo de inclus'#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [2]
      Left = 204
      Top = 197
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label9: TLabel [3]
      Left = 75
      Top = 289
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Protocolo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel [4]
      Left = 18
      Top = 127
      Width = 105
      Height = 14
      Caption = 'Grupo de Ocorr'#234'ncia:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel [5]
      Left = 28
      Top = 150
      Width = 95
      Height = 14
      Caption = 'Tipo de Ocorr'#234'ncia:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [6]
      Left = 37
      Top = 80
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador Origem:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [7]
      Left = 35
      Top = 103
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador Destino:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [8]
      Left = 78
      Top = 244
      Width = 45
      Height = 14
      Caption = 'Situa'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [9]
      Left = 105
      Top = 265
      Width = 18
      Height = 14
      Alignment = taRightJustify
      Caption = 'AD:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel [10]
      Left = 203
      Top = 221
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label12: TLabel [11]
      Left = 43
      Top = 311
      Width = 80
      Height = 14
      Caption = 'Tipo de relat'#243'rio:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel [12]
      Left = 6
      Top = 174
      Width = 115
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o da ocorr'#234'ncia:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel [13]
      Left = 48
      Top = 337
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de quebra:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel [14]
      Left = 16
      Top = 221
      Width = 107
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo de conclus'#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel [15]
      Left = 75
      Top = 34
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade:'
    end
    object Label25: TLabel [16]
      Left = 28
      Top = 57
      Width = 95
      Height = 14
      Caption = 'Grupo de Atividade:'
    end
    inherited gpbDestino: TGroupBox
      Left = 127
      Top = 358
      Width = 199
      TabOrder = 17
      ExplicitLeft = 127
      ExplicitTop = 358
      ExplicitWidth = 199
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 128
      Top = 8
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 128
      Top = 194
      Width = 71
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 215
      Top = 194
      Width = 72
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 9
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtProtoc: TEditFocus
      Tag = 99
      Left = 128
      Top = 286
      Width = 198
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtDesCli: TEditFocus
      Left = 201
      Top = 8
      Width = 289
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodGoc: TEditFocus
      Tag = 99
      Left = 128
      Top = 123
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 5
      OnExit = edtCodGocExit
      OnKeyPress = edtCodGocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesGoc: TEditFocus
      Left = 201
      Top = 123
      Width = 289
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesToc: TEditFocus
      Left = 201
      Top = 146
      Width = 289
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodToc: TEditFocus
      Tag = 99
      Left = 128
      Top = 147
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 6
      OnExit = edtCodTocExit
      OnKeyPress = edtCodTocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtOpeOco: TEditFocus
      Tag = 99
      Left = 128
      Top = 77
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 3
      OnExit = edtOpeOcoExit
      OnKeyPress = edtOpeOcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 128
      Top = 100
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 4
      OnExit = edtCodOpeExit
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesOpeOco: TEditFocus
      Left = 201
      Top = 77
      Width = 289
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 21
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesCodOpe: TEditFocus
      Left = 201
      Top = 100
      Width = 289
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 22
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbStatus: TComboBoxFocus
      Left = 128
      Top = 240
      Width = 158
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 12
      Text = 'Todas'
      Items.Strings = (
        'Todas'
        'Em aberto'
        'Conclu'#237'da')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object mskConIni: TMaskEditFocus
      Tag = 99
      Left = 128
      Top = 217
      Width = 70
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 10
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskConFin: TMaskEditFocus
      Tag = 99
      Left = 215
      Top = 218
      Width = 72
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 11
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object cmbTipRel: TComboBoxFocus
      Left = 128
      Top = 309
      Width = 199
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 15
      Text = 'Anal'#237'tico'
      OnChange = cmbTipRelChange
      Items.Strings = (
        'Anal'#237'tico'
        'Sint'#233'tico por tipo de ocorr'#234'ncia'
        'Sint'#233'tico por situa'#231#227'o da ocorr'#234'ncia')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtCodSit: TEditFocus
      Tag = 99
      Left = 128
      Top = 170
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 7
      OnExit = edtCodSitExit
      OnKeyPress = edtCodSitKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesSit: TEditFocus
      Left = 201
      Top = 170
      Width = 289
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 23
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cmbTipQue: TComboBoxFocus
      Left = 128
      Top = 332
      Width = 159
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 3
      TabOrder = 16
      Text = 'Grupo de ocorr'#234'ncia'
      Items.Strings = (
        'Cliente'
        'Operador origem'
        'Operador destino'
        'Grupo de ocorr'#234'ncia'
        'Situa'#231#227'o da ocorr'#234'ncia')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtAutDev: TEditFocus
      Tag = 99
      Left = 128
      Top = 263
      Width = 159
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 128
      Top = 31
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 1
      OnExit = edtCodAtiExit
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAti: TEditFocus
      Left = 201
      Top = 31
      Width = 289
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 24
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodGat: TEditFocus
      Tag = 99
      Left = 128
      Top = 54
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
      OnExit = edtCodGatExit
      OnKeyPress = edtCodGatKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesGat: TEditFocus
      Left = 201
      Top = 54
      Width = 289
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 25
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 440
    Width = 506
    ExplicitTop = 396
    ExplicitWidth = 506
    inherited pnlNomeForm: TPanel
      Left = 335
      ExplicitLeft = 335
    end
    inherited pnlInfo: TPanel
      Width = 335
      ExplicitWidth = 335
      inherited shpMultSel: TShape
        Visible = True
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 56
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 292
    Top = 56
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 404
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 376
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 348
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 320
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 292
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 264
    Top = 56
  end
  inherited frxGen: TfrxUserDataSet
    Left = 264
  end
  inherited frxDesigner: TfrxDesigner
    Left = 432
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 460
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 348
    Top = 56
  end
  object frxReportCfgImp: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42341.736382395830000000
    ReportOptions.LastChange = 42341.736382395830000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 356
    Top = 168
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 355.600000000000000000
      PaperSize = 5
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
    end
  end
end
