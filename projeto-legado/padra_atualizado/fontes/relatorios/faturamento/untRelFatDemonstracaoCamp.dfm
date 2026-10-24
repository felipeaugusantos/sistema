inherited frmRelFatDemostracaoCamp: TfrmRelFatDemostracaoCamp
  Left = 426
  Top = 293
  Width = 449
  Height = 394
  ActiveControl = mskDtaIni
  Caption = 'Relat'#243'rio de Demonstra'#231#227'o de Campanhas'
  ExplicitWidth = 449
  ExplicitHeight = 394
  PixelsPerInch = 96
  TextHeight = 14
  object Label3: TLabel [0]
    Left = 7
    Top = 157
    Width = 32
    Height = 14
    Caption = 'Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 325
    Width = 443
    ExplicitTop = 322
    ExplicitWidth = 443
    inherited btnSair: TBitBtnLocked
      Left = 360
      ExplicitLeft = 360
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 81
      ExplicitLeft = 81
    end
  end
  inherited pnlStatus: TPanel
    Top = 353
    Width = 443
    ExplicitTop = 350
    ExplicitWidth = 443
    inherited pnlNomeForm: TPanel
      Left = 272
      ExplicitLeft = 272
    end
    inherited pnlInfo: TPanel
      Width = 272
      ExplicitWidth = 272
    end
  end
  inherited pnlDados: TPanel
    Width = 443
    Height = 325
    ExplicitWidth = 443
    ExplicitHeight = 322
    object Label11: TLabel [0]
      Left = 8
      Top = 42
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
    object lblDesDtaIni: TLabel [1]
      Left = 73
      Top = 24
      Width = 119
      Height = 14
      Caption = '(DATA DA CAMPANHA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesDtaFin: TLabel [2]
      Left = 73
      Top = 62
      Width = 119
      Height = 14
      Caption = '(DATA DA CAMPANHA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel [3]
      Left = 8
      Top = 5
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
    object Label2: TLabel [4]
      Left = 8
      Top = 119
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label147: TLabel [5]
      Left = 8
      Top = 81
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rede de Lojas:'
    end
    object Label4: TLabel [6]
      Left = 8
      Top = 157
      Width = 51
      Height = 14
      Caption = 'Campanha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [7]
      Left = 346
      Top = 5
      Width = 72
      Height = 14
      Caption = 'Somente Class'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [8]
      Left = 8
      Top = 196
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
    inherited gpbDestino: TGroupBox
      Left = 180
      Top = 244
      Width = 160
      Height = 70
      TabOrder = 11
      ExplicitLeft = 180
      ExplicitTop = 244
      ExplicitWidth = 160
      ExplicitHeight = 70
      inherited ColorLabel1: TColorLabel
        Top = 32
        ExplicitTop = 32
      end
      inherited edtDestino: TEditFocus
        Top = 29
        ExplicitTop = 29
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 19
      Width = 60
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
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 56
      Width = 60
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
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 8
      Top = 133
      Width = 60
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 3
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
    object edtDesCli: TEditFocus
      Left = 69
      Top = 133
      Width = 270
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesRed: TEditFocus
      Left = 69
      Top = 95
      Width = 270
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodRed: TEditFocus
      Tag = 99
      Left = 8
      Top = 95
      Width = 60
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodRedExit
      OnKeyPress = edtCodRedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object rdgStatus: TRadioGroup
      Left = 10
      Top = 244
      Width = 160
      Height = 70
      Caption = 'Status'
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Abertas'
        'Terminadas'
        'Todas')
      ParentCtl3D = False
      TabOrder = 10
    end
    object edtCodCam: TEditFocus
      Tag = 99
      Left = 8
      Top = 171
      Width = 60
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
      MaxLength = 6
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodCamExit
      OnKeyPress = edtCodCamKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesCam: TEditFocus
      Left = 69
      Top = 171
      Width = 270
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object lstClaFis: TMemo
      Left = 343
      Top = 19
      Width = 90
      Height = 295
      TabStop = False
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 12
      WantReturns = False
      WordWrap = False
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 210
      Width = 60
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
      TabOrder = 5
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 69
      Top = 210
      Width = 270
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 64
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 352
    Top = 176
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
    Top = 120
  end
end
