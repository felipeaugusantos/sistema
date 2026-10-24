inherited frmRelFatMetasVendedorCTR: TfrmRelFatMetasVendedorCTR
  Left = 458
  Top = 244
  Width = 441
  Height = 296
  Caption = 'Relat'#243'rio de Metas por Vendedor - Contas a Receber'
  ExplicitWidth = 441
  ExplicitHeight = 296
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 223
    Width = 435
    ExplicitTop = 223
    ExplicitWidth = 435
    inherited btnSair: TBitBtnLocked
      Left = 352
      ExplicitLeft = 352
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 7
      ExplicitLeft = 7
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 84
      ExplicitLeft = 84
    end
  end
  inherited pnlDados: TPanel
    Width = 435
    Height = 217
    ExplicitWidth = 435
    ExplicitHeight = 217
    object Label7: TLabel [0]
      Left = 65
      Top = 28
      Width = 57
      Height = 14
      Caption = '(M'#202'S/ANO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel [1]
      Left = 65
      Top = 63
      Width = 57
      Height = 14
      Caption = '(M'#202'S/ANO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel [2]
      Left = 5
      Top = 42
      Width = 61
      Height = 14
      Caption = 'Per'#237'odo Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel [3]
      Left = 5
      Top = 7
      Width = 65
      Height = 14
      Caption = 'Per'#237'odo Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [4]
      Left = 5
      Top = 119
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
    object Label12: TLabel [5]
      Left = 5
      Top = 81
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
    object Label1: TLabel [6]
      Left = 352
      Top = 7
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
    object shaVen: TShape [7]
      Left = 5
      Top = 95
      Width = 8
      Height = 22
    end
    inherited gpbDestino: TGroupBox
      Left = 146
      Top = 164
      Width = 181
      TabOrder = 7
      ExplicitLeft = 146
      ExplicitTop = 164
      ExplicitWidth = 181
      inherited ColorLabel1: TColorLabel
        Top = 19
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitTop = 19
        ExplicitWidth = 138
      end
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 13
      Top = 95
      Width = 31
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
      TabOrder = 2
      OnExit = edtCodVenExit
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVen: TEditFocus
      Left = 45
      Top = 95
      Width = 282
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
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
      Left = 5
      Top = 133
      Width = 38
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
      TabOrder = 4
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
      Left = 45
      Top = 133
      Width = 282
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbQuebra: TGroupBox
      Left = 5
      Top = 164
      Width = 138
      Height = 45
      Caption = 'Quebra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object ColorLabel6: TColorLabel
        Left = 28
        Top = 20
        Width = 87
        Height = 14
        Caption = '(M)'#234's (V)endedor'
        CorDestaque = clRed
      end
      object edtQuebra: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'V'
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
    object lstClaFis: TMemo
      Left = 332
      Top = 21
      Width = 93
      Height = 188
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
      TabOrder = 8
      WantReturns = False
      WordWrap = False
    end
    object mskMesAnoIni: TMaskEditFocus
      Tag = 99
      Left = 5
      Top = 21
      Width = 52
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
    object mskMesAnoFin: TMaskEditFocus
      Tag = 99
      Left = 5
      Top = 56
      Width = 52
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 1
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pgbProgresso: TProgressBar [3]
    Left = 0
    Top = 217
    Width = 435
    Height = 6
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 251
    Width = 435
    ExplicitTop = 251
    ExplicitWidth = 435
    inherited pnlNomeForm: TPanel
      Left = 264
      ExplicitLeft = 264
    end
    inherited pnlInfo: TPanel
      Width = 264
      ExplicitWidth = 264
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 184
    Top = 64
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 184
    Top = 16
  end
end
