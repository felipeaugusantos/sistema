inherited frmRelCtpTitContasAno: TfrmRelCtpTitContasAno
  Left = 333
  Top = 304
  Width = 422
  Height = 452
  Caption = 'Relat'#243'rio de Titulos por Plano de Contas Anual'
  OnDestroy = FormDestroy
  ExplicitWidth = 422
  ExplicitHeight = 452
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 380
    Width = 416
    ExplicitTop = 380
    ExplicitWidth = 416
    inherited btnSair: TBitBtnLocked
      Left = 333
      ExplicitLeft = 333
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 6
      ExplicitLeft = 6
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 84
      ExplicitLeft = 84
    end
  end
  inherited pnlDados: TPanel
    Width = 416
    Height = 380
    ExplicitWidth = 416
    ExplicitHeight = 380
    object Label1: TLabel [0]
      Left = 3
      Top = 7
      Width = 48
      Height = 14
      Caption = 'M'#234's Base'
    end
    object Label27: TLabel [1]
      Left = 3
      Top = 80
      Width = 107
      Height = 14
      Caption = 'Plano de Contas Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [2]
      Left = 3
      Top = 191
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
    object Label2: TLabel [3]
      Left = 3
      Top = 154
      Width = 39
      Height = 14
      Caption = 'Eventos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [4]
      Left = 58
      Top = 7
      Width = 105
      Height = 14
      Caption = 'Quantidade de Meses'
    end
    object lbl1: TLabel [5]
      Left = 3
      Top = 117
      Width = 103
      Height = 14
      Caption = 'Plano de Contas Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel [6]
      Left = 3
      Top = 43
      Width = 62
      Height = 14
      Caption = 'Compet'#234'ncia'
      WordWrap = True
    end
    inherited gpbDestino: TGroupBox
      Left = 3
      Top = 327
      Width = 210
      Height = 46
      TabOrder = 13
      ExplicitLeft = 3
      ExplicitTop = 327
      ExplicitWidth = 210
      ExplicitHeight = 46
      inherited ColorLabel1: TColorLabel
        Top = 19
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitTop = 19
        ExplicitWidth = 138
      end
    end
    object mskMesBas: TMaskEditFocus
      Tag = 99
      Left = 3
      Top = 21
      Width = 54
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 0
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskContaIni: TMaskEditFocus
      Tag = 99
      Left = 3
      Top = 94
      Width = 61
      Height = 22
      EditMask = '99.99.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ParentFont = False
      TabOrder = 4
      Text = ''
      OnExit = mskContaIniExit
      OnKeyPress = mskContaIniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 3
      Top = 205
      Width = 61
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
      TabOrder = 7
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
    object edtDesContaIni: TEditFocus
      Left = 67
      Top = 94
      Width = 343
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 67
      Top = 205
      Width = 343
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEve: TEditFocus
      Left = 3
      Top = 168
      Width = 61
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 6
      OnExit = edtCodEveExit
      OnKeyPress = edtCodEveKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesEve: TEditFocus
      Left = 67
      Top = 168
      Width = 343
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdMes: TEditFocus
      Tag = 99
      Left = 59
      Top = 21
      Width = 25
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 1
      Text = '12'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 2
      TipoTexto = ttNumerico
    end
    object rdgTipRel: TRadioGroup
      Left = 3
      Top = 229
      Width = 210
      Height = 46
      Caption = 'Tipo de Relat'#243'rio'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Anal'#237'tico'
        'Sint'#233'tico')
      TabOrder = 8
      OnClick = rdgTipRelClick
    end
    object rdgTipQue: TRadioGroup
      Left = 3
      Top = 279
      Width = 210
      Height = 46
      Caption = 'Tipo de Quebra'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Plano de Contas'
        'Evento')
      TabOrder = 10
      OnClick = rdgTipQueClick
    end
    object chkQuePag: TCheckBox
      Left = 227
      Top = 302
      Width = 155
      Height = 17
      Caption = 'Quebrar p'#225'gina por Evento'
      Enabled = False
      TabOrder = 12
    end
    object chkMosEve: TCheckBox
      Left = 227
      Top = 286
      Width = 155
      Height = 17
      Caption = 'Mostrar Eventos'
      TabOrder = 11
    end
    object mskContaFin: TMaskEditFocus
      Tag = 99
      Left = 3
      Top = 131
      Width = 61
      Height = 22
      EditMask = '99.99.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ParentFont = False
      TabOrder = 5
      Text = ''
      OnExit = mskContaFinExit
      OnKeyPress = mskContaFinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesContaFin: TEditFocus
      Left = 67
      Top = 131
      Width = 343
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 373
      Width = 414
      Height = 6
      Align = alBottom
      Smooth = True
      TabOrder = 18
      Visible = False
    end
    object mskCompet: TMaskEditFocus
      Tag = 99
      Left = 3
      Top = 57
      Width = 54
      Height = 22
      EditMask = '99/9999;1;_'
      MaxLength = 7
      TabOrder = 3
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object rdgTipoData: TRadioGroup
      Left = 171
      Top = 7
      Width = 239
      Height = 43
      Caption = 'Data de'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Cadastro'
        'Vencimento'
        'Pagamento')
      TabOrder = 2
      OnClick = rdgTipQueClick
    end
    object gpbContas: TGroupBox
      Left = 216
      Top = 229
      Width = 193
      Height = 46
      Caption = 'Contas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 19
        Width = 136
        Height = 14
        Caption = '(T)odos (A)berto (Q)uitados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object edtContas: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
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
        MaxLength = 1
        ParentFont = False
        TabOrder = 0
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 408
    Width = 416
    ExplicitTop = 408
    ExplicitWidth = 416
    inherited pnlNomeForm: TPanel
      Left = 245
      ExplicitLeft = 245
    end
    inherited pnlInfo: TPanel
      Width = 245
      ExplicitWidth = 245
      inherited shpMultSel: TShape
        Left = 226
        Visible = True
        ExplicitLeft = 226
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 512
    Top = 40
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 768
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 736
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 704
    Top = 40
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 672
    Top = 40
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 640
    Top = 40
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 576
    Top = 40
  end
  inherited frxGen: TfrxUserDataSet
    Left = 608
    Top = 40
  end
  inherited frxDesigner: TfrxDesigner
    Left = 832
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 864
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 768
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 256
    Top = 56
  end
end
