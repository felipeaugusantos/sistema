inherited frmRelCadPositivacaoClientes: TfrmRelCadPositivacaoClientes
  Left = 524
  Top = 138
  Width = 382
  Height = 490
  Caption = 'Relat'#243'rio de positiva'#231#227'o de clientes'
  ExplicitWidth = 382
  ExplicitHeight = 490
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 418
    Width = 376
    ExplicitTop = 418
    ExplicitWidth = 376
    inherited btnSair: TBitBtnLocked
      Left = 293
      Width = 78
      ExplicitLeft = 293
      ExplicitWidth = 78
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 81
      ExplicitLeft = 81
    end
  end
  inherited pnlStatus: TPanel
    Top = 446
    Width = 376
    ExplicitTop = 446
    ExplicitWidth = 376
    inherited pnlNomeForm: TPanel
      Left = 205
      ExplicitLeft = 205
    end
    inherited pnlInfo: TPanel
      Width = 205
      ExplicitWidth = 205
    end
  end
  inherited pnlDados: TPanel
    Width = 376
    Height = 411
    ExplicitWidth = 376
    ExplicitHeight = 411
    object Label3: TLabel [0]
      Left = 8
      Top = 86
      Width = 29
      Height = 14
      Caption = 'Bairro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [1]
      Left = 8
      Top = 121
      Width = 33
      Height = 14
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel [2]
      Left = 319
      Top = 121
      Width = 33
      Height = 14
      Caption = 'Estado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [3]
      Left = 8
      Top = 157
      Width = 47
      Height = 14
      Caption = 'Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [4]
      Left = 8
      Top = 192
      Width = 71
      Height = 14
      Caption = 'Representante'
    end
    object Label8: TLabel [5]
      Left = 8
      Top = 228
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel [6]
      Left = 8
      Top = 263
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel [7]
      Left = 8
      Top = 298
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Categoria'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel [8]
      Left = 8
      Top = 50
      Width = 56
      Height = 14
      Caption = 'Nome Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel [9]
      Left = 182
      Top = 50
      Width = 52
      Height = 14
      Caption = 'Nome Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [10]
      Left = 8
      Top = 11
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
    object Label2: TLabel [11]
      Left = 82
      Top = 11
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
    object lbldta2: TLabel [12]
      Left = 160
      Top = 30
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 178
      Top = 357
      Width = 187
      Height = 43
      TabOrder = 19
      ExplicitLeft = 178
      ExplicitTop = 357
      ExplicitWidth = 187
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Top = 18
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitTop = 18
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Top = 15
        ExplicitTop = 15
      end
    end
    object edtBairro: TEditFocus
      Left = 8
      Top = 100
      Width = 356
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 30
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 8
      Top = 135
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 5
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttInteiro
    end
    object edtNomCid: TEditFocus
      Left = 71
      Top = 135
      Width = 249
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Tag = 99
      Left = 322
      Top = 135
      Width = 41
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 8
      Top = 171
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 8
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 72
      Top = 171
      Width = 292
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRep: TEditFocus
      Tag = 99
      Left = 8
      Top = 207
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 10
      OnKeyPress = edtCodRepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomRep: TEditFocus
      Left = 72
      Top = 207
      Width = 292
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 8
      Top = 242
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 12
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtNomAti: TEditFocus
      Left = 72
      Top = 242
      Width = 292
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 277
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 14
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 72
      Top = 277
      Width = 292
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbStatus: TGroupBox
      Left = 8
      Top = 357
      Width = 159
      Height = 43
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 18
        Width = 116
        Height = 14
        Caption = '(A)tivo (I)nativo (T)odos'
        CorDestaque = clRed
      end
      object edtStatus: TEditFocus
        Tag = 99
        Left = 7
        Top = 15
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        OnExit = edtDestinoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtNomIni: TEditFocus
      Tag = 99
      Left = 8
      Top = 64
      Width = 173
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFin: TEditFocus
      Tag = 99
      Left = 184
      Top = 64
      Width = 180
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 25
      Width = 71
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
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
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 81
      Top = 25
      Width = 73
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
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
    object cbxCatego: TComboBox
      Left = 8
      Top = 312
      Width = 356
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 16
      Items.Strings = (
        ''
        'A'
        'B'
        'C'
        'D'
        'E'
        'F')
    end
    object chkLimExc: TCheckBox
      Left = 8
      Top = 337
      Width = 353
      Height = 17
      Caption = 'Mostrar somente Clientes com limite de cr'#233'dito excedido.'
      TabOrder = 17
    end
  end
  object pgbGerArq: TProgressBar [3]
    Left = 0
    Top = 411
    Width = 376
    Height = 7
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 168
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 48
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 136
    Top = 0
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 168
    Top = 48
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 136
    Top = 48
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 328
    Top = 0
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 296
    Top = 0
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 264
    Top = 0
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 200
    Top = 0
  end
  inherited frxGen: TfrxUserDataSet
    Left = 232
    Top = 0
  end
  inherited frxDesigner: TfrxDesigner
    Left = 232
    Top = 48
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 264
    Top = 48
  end
  object frxPaginaM: TfrxReport
    Version = '4.15.13'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40715.423472581000000000
    ReportOptions.LastChange = 40715.734235740740000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 184
    Top = 104
    Datasets = <
      item
        DataSet = frxGen
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
    object Page1: TfrxDMPPage
      PaperWidth = 345.439776903477400000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1305.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
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
          Left = 201.600000000000000000
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#27#64#15#27#80'
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 178.500000000000000000
          Width = 1296.000000000000000000
          ShowHint = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 51.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIOD]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            '[FILCID]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[FILNOM]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            '[FILEST]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            '[FILBAI]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            '[FILVEN]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            '[FILREP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 68.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FILATI]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 85.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FILEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 102.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FILCAT]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 119.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FILSTA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 136.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FILLIM]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        Height = 34.000000000000000000
        Top = 238.000000000000000000
        Width = 1305.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 412.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'LIM.CRED.OFERT')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 556.799999999999900000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'LIM.CRED.DISP')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'CTR ABERTO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'CTR VENCIDO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'MAIOR ATR(DIAS)')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1296.000000000000000000
          ShowHint = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ ABERTO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL CTR')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        Height = 17.000000000000000000
        Top = 289.000000000000000000
        Width = 1305.600000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 412.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CREOFE">]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 556.799999999999900000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CREDIS">]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CTRABE">]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CTRVEN">]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."MAIATR">]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CHQABE">]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTCTR">]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        Height = 34.000000000000000000
        Top = 340.000000000000000000
        Width = 1305.600000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 17.000000000000000000
          Width = 672.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          ShowHint = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPaginaJ: TfrxReport
    Version = '4.15.13'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40715.423472581000000000
    ReportOptions.LastChange = 40715.734235740700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 248
    Top = 104
    Datasets = <
      item
        DataSet = frxGen
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
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 278.900000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        Height = 177.559060000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 152.655504999999900000
          Top = 17.000000000000000000
          Width = 450.594990000000100000
          Height = 17.000000000000000000
          ShowHint = False
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 152.655505000000000000
          Top = 34.000000000000000000
          Width = 450.594990000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 612.400000000000000000
          Top = 17.000000000000000000
          Width = 134.702350000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
        end
        object Time: TfrxMemoView
          Left = 701.133890000000000000
          Top = 34.000000000000000000
          Width = 46.866110000000000000
          Height = 17.000000000000000000
          ShowHint = False
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 627.600000000000000000
          Top = 34.000000000000000000
          Width = 73.322819999999990000
          Height = 17.000000000000000000
          ShowHint = False
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 173.500000000000000000
          Width = 755.906000000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo17: TfrxMemoView
          Align = baCenter
          Left = 152.655505000000000000
          Top = 51.000000000000000000
          Width = 450.594990000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIOD]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 361.473840000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FILCID]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 361.473840000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FILNOM]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 361.473840000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FILEST]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 361.473840000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FILBAI]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 361.473840000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FILVEN]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 9.600000000000000000
          Top = 152.929190000000000000
          Width = 361.473840000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FILREP]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 383.400000000000000000
          Top = 68.000000000000000000
          Width = 365.253370000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FILATI]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 383.400000000000000000
          Top = 85.000000000000000000
          Width = 365.253370000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FILEMP]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 383.400000000000000000
          Top = 102.000000000000000000
          Width = 365.253370000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FILCAT]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 383.400000000000000000
          Top = 119.000000000000000000
          Width = 365.253370000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FILSTA]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 383.400000000000000000
          Top = 136.000000000000000000
          Width = 365.253370000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FILLIM]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.881880000000000000
        ParentFont = False
        Top = 257.008040000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Memo29: TfrxMemoView
          Width = 755.906000000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 207.800000000000000000
          Top = 1.000000000000000000
          Width = 81.486580000000000000
          Height = 13.220470000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'LIM.CRED.OFERT')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 292.800000000000000000
          Top = 1.000000000000000000
          Width = 73.927520000000000000
          Height = 13.220470000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'LIM.CRED.DISP')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 522.600000000000000000
          Top = 1.000000000000000000
          Width = 64.025170000000000000
          Height = 13.220470000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CTR ABERTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 593.800000000000000000
          Top = 1.000000000000000000
          Width = 67.804700000000000000
          Height = 13.220470000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CTR VENCIDO')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 667.000000000000000000
          Top = 1.000000000000000000
          Width = 83.527520000000000000
          Height = 13.220470000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'MAIOR ATR(DIAS)')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 371.800000000000000000
          Top = 1.000000000000000000
          Width = 65.763760000000000000
          Height = 13.220470000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHQ ABERTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 444.400000000000000000
          Top = 1.000000000000000000
          Width = 71.584230000000000000
          Height = 13.220470000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL CTR')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 2.600000000000000000
          Top = 1.000000000000000000
          Width = 81.486580000000000000
          Height = 13.220470000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 16.500000000000000000
          Width = 755.906000000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object rlbDetalhes: TfrxMasterData
        Height = 17.000000000000000000
        Top = 298.582870000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo7: TfrxMemoView
          Left = 2.600000000000000000
          Width = 200.843970000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 207.800000000000000000
          Width = 81.486580000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CREOFE">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 292.800000000000000000
          Width = 73.927520000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CREDIS">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 522.600000000000000000
          Width = 64.025170000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CTRABE">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 593.800000000000000000
          Width = 67.804700000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CTRVEN">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 667.000000000000000000
          Width = 83.527520000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."MAIATR">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 371.800000000000000000
          Width = 65.763760000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CHQABE">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 444.400000000000000000
          Width = 71.584230000000010000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTCTR">]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        Height = 22.661410000000000000
        Top = 377.953000000000000000
        Width = 755.906000000000000000
        object rllNomeForm: TfrxMemoView
          Left = 2.600000000000000000
          Top = 4.000000000000000000
          Width = 393.146320000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 396.000000000000000000
          Top = 4.000000000000000000
          Width = 358.299009999999800000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          ShowHint = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
    end
  end
end
