inherited frmRelSituacaoVendasCRM: TfrmRelSituacaoVendasCRM
  Width = 512
  Height = 486
  Caption = 'Relat'#243'rio de situa'#231#227'o de vendas'
  OnDestroy = FormDestroy
  ExplicitWidth = 512
  ExplicitHeight = 486
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 414
    Width = 506
    ExplicitTop = 414
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
    Height = 414
    ExplicitWidth = 506
    ExplicitHeight = 414
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
      Top = 218
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
      Top = 218
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label9: TLabel [3]
      Left = 75
      Top = 312
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
      Top = 148
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
      Top = 171
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
      Top = 101
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
      Top = 124
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
      Top = 265
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
    object Label5: TLabel [9]
      Left = 16
      Top = 242
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
    object Label8: TLabel [10]
      Left = 203
      Top = 242
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label12: TLabel [11]
      Left = 43
      Top = 334
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
      Top = 195
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
    object Label4: TLabel [13]
      Left = 30
      Top = 289
      Width = 93
      Height = 14
      Caption = 'Situa'#231#227'o da venda:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel [14]
      Left = 87
      Top = 34
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label15: TLabel [15]
      Left = 75
      Top = 56
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade:'
    end
    object Label25: TLabel [16]
      Left = 28
      Top = 78
      Width = 95
      Height = 14
      Caption = 'Grupo de Atividade:'
    end
    inherited gpbDestino: TGroupBox
      Left = 127
      Top = 357
      Width = 199
      TabOrder = 17
      ExplicitLeft = 127
      ExplicitTop = 357
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
      Top = 215
      Width = 71
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
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 215
      Top = 215
      Width = 72
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
    object edtProtoc: TEditFocus
      Tag = 99
      Left = 128
      Top = 309
      Width = 198
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 15
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
      Top = 144
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 6
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
      Top = 144
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
      Top = 167
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
      Top = 168
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 7
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
      Top = 98
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 4
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
      Top = 121
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 5
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
      Top = 98
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
      Top = 121
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
      Top = 262
      Width = 110
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 13
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
      Top = 238
      Width = 70
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
    object mskConFin: TMaskEditFocus
      Tag = 99
      Left = 215
      Top = 239
      Width = 72
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 12
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object cmbTipRel: TComboBoxFocus
      Left = 128
      Top = 332
      Width = 198
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 16
      Text = 'Anal'#237'tico'
      Items.Strings = (
        'Anal'#237'tico'
        'Sint'#233'tico')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtCodSit: TEditFocus
      Tag = 99
      Left = 128
      Top = 191
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
      TabOrder = 8
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
      Top = 191
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
    object cmbSitVen: TComboBoxFocus
      Left = 128
      Top = 286
      Width = 198
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 3
      TabOrder = 14
      Text = 'Todos'
      Items.Strings = (
        'Faturados'
        'N'#227'o Faturados'
        'Baixados n'#227'o Faturados'
        'Todos')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 128
      Top = 30
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 1
      OnExit = edtCodCidExit
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomCid: TEditFocus
      Left = 201
      Top = 30
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
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 129
      Top = 52
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
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
      Top = 52
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
    object edtCodGat: TEditFocus
      Tag = 99
      Left = 128
      Top = 75
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 3
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
      Top = 75
      Width = 289
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 26
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
    Top = 442
    Width = 506
    ExplicitTop = 442
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
