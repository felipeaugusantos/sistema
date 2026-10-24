inherited frmRelCtrReceber: TfrmRelCtrReceber
  Left = 234
  Top = 184
  Width = 691
  Height = 683
  Caption = 'Relat'#243'rio de Conta Corrente a Receber'
  OnDestroy = FormDestroy
  ExplicitWidth = 691
  ExplicitHeight = 683
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 611
    Width = 685
    ExplicitTop = 611
    ExplicitWidth = 685
    inherited btnSair: TBitBtnLocked
      Left = 599
      ExplicitLeft = 599
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 7
      ExplicitLeft = 7
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 85
      ExplicitLeft = 85
    end
  end
  inherited pnlDados: TPanel
    Width = 685
    Height = 611
    ExplicitLeft = 8
    ExplicitTop = -3
    ExplicitWidth = 685
    ExplicitHeight = 611
    object Label6: TLabel [0]
      Left = 7
      Top = 277
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
    object lblDtaIni: TLabel [1]
      Left = 79
      Top = 257
      Width = 78
      Height = 14
      Caption = '(VENCIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDtaFin: TLabel [2]
      Left = 79
      Top = 295
      Width = 78
      Height = 14
      Caption = '(VENCIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel [3]
      Left = 7
      Top = 362
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
    object lblPortador: TLabel [4]
      Left = 7
      Top = 398
      Width = 103
      Height = 14
      Caption = 'Portador da Duplicata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [5]
      Left = 343
      Top = 474
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
    object Label5: TLabel [6]
      Left = 7
      Top = 239
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
    object Label1: TLabel [7]
      Left = 7
      Top = 474
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
    object Label2: TLabel [8]
      Left = 7
      Top = 512
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
    object lblVenDig: TLabel [9]
      Left = 343
      Top = 512
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
    object lblEspDoc: TLabel [10]
      Left = 14
      Top = 84
      Width = 110
      Height = 14
      Caption = 'Esp'#233'cie do Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [11]
      Left = 234
      Top = 398
      Width = 91
      Height = 14
      Caption = 'Portador do Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [12]
      Left = 458
      Top = 398
      Width = 86
      Height = 14
      Caption = 'Portador da Baixa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [13]
      Left = 6
      Top = 548
      Width = 33
      Height = 14
      Caption = 'Regi'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel [14]
      Left = 458
      Top = 362
      Width = 69
      Height = 14
      Caption = 'Rede de Lojas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel [15]
      Left = 170
      Top = 239
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
    object Label9: TLabel [16]
      Left = 170
      Top = 277
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
    object Label10: TLabel [17]
      Left = 243
      Top = 295
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
    object LblCadIni: TLabel [18]
      Left = 243
      Top = 257
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
    object lblCndPag: TLabel [19]
      Left = 343
      Top = 548
      Width = 84
      Height = 14
      Caption = 'Cond. Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Top = 319
      Width = 192
      Height = 40
      TabOrder = 22
      ExplicitTop = 319
      ExplicitWidth = 192
      ExplicitHeight = 40
      inherited ColorLabel1: TColorLabel
        Left = 29
        Top = 17
        Width = 144
        Caption = '(V)'#237'deo  (I)mpressora  (E)xcel'
        ExplicitLeft = 29
        ExplicitTop = 17
        ExplicitWidth = 144
      end
      inherited edtDestino: TEditFocus
        Top = 14
        ExplicitTop = 14
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 253
      Width = 69
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 11
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 291
      Width = 69
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
      TabOrder = 12
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodCli: TEditFocus
      Left = 7
      Top = 376
      Width = 68
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
      TabOrder = 23
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
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 7
      Top = 412
      Width = 40
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 27
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 343
      Top = 487
      Width = 40
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
      TabOrder = 36
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
    object gpbTitulos: TGroupBox
      Left = 7
      Top = 2
      Width = 170
      Height = 42
      Caption = 'Titulos...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 19
        Width = 136
        Height = 14
        Caption = '(A)berto (Q)uitados (T)odos'
        CorDestaque = clRed
      end
      object edtTitulos: TEditFocus
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
        Text = 'T'
        OnExit = edtTitulosExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtDesCli: TEditFocus
      Left = 77
      Top = 376
      Width = 374
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtDesPor: TEditFocus
      Left = 49
      Top = 412
      Width = 178
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 28
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmp: TEditFocus
      Left = 385
      Top = 487
      Width = 291
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 37
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEve: TEditFocus
      Left = 7
      Top = 487
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 34
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
      Left = 49
      Top = 487
      Width = 287
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 35
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbTipoData: TGroupBox
      Left = 671
      Top = 227
      Width = 170
      Height = 40
      Caption = 'Tipo de Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 46
      Visible = False
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 19
        Width = 120
        Height = 14
        Caption = '(V)encimento (C)adastro'
        CorDestaque = clRed
      end
      object edtTipoDta: TEditFocus
        Tag = 99
        Left = 4
        Top = 15
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'V'
        OnExit = edtTipoDtaExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gbpDupDesc: TGroupBox
      Left = 182
      Top = 2
      Width = 170
      Height = 42
      Caption = 'Duplicata Descontada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object ColorLabel4: TColorLabel
        Left = 29
        Top = 19
        Width = 102
        Height = 14
        Caption = '(S)im  (N)'#227'o  (T)odas'
        CorDestaque = clRed
      end
      object edtDupDesc: TEditFocus
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
    object edtCodCid: TEditFocus
      Left = 7
      Top = 526
      Width = 40
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 38
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
    object edtDesCid: TEditFocus
      Left = 49
      Top = 526
      Width = 287
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 39
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbOrdem: TGroupBox
      Left = 7
      Top = 169
      Width = 345
      Height = 65
      Caption = 'Ordenar por...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      object ColorLabel5: TColorLabel
        Left = 27
        Top = 41
        Width = 216
        Height = 14
        Caption = 'Data do (D)ocumento / Data do (V)encimento'
        CorDestaque = clRed
      end
      object lblOrdCli: TColorLabel
        Left = 27
        Top = 17
        Width = 303
        Height = 14
        AutoSize = False
        Caption = 
          '(C)'#243'digo do Cliente / (N)ome do Cliente / Cond. de (P)agamento  ' +
          ' '
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
        Tag = 99
        Left = 7
        Top = 38
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 1
        Text = 'D'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtOrdemCli: TEditFocus
        Tag = 99
        Left = 7
        Top = 14
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'C'
        OnChange = edtOrdemCliChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtCodVen: TEditFocus
      Left = 343
      Top = 526
      Width = 40
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
      TabOrder = 40
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
      Left = 385
      Top = 526
      Width = 291
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 41
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkDiaCre: TCheckBox
      Left = 357
      Top = 191
      Width = 306
      Height = 17
      Caption = 'Considerar dias para cr'#233'dito do valor recebido'
      TabOrder = 15
    end
    object chkAjuDta: TCheckBox
      Left = 357
      Top = 211
      Width = 322
      Height = 17
      Caption = 'Ajustar venctos considerando S'#225'bados, Domingos e Feriados'
      TabOrder = 16
    end
    object gpbTipCliente: TGroupBox
      Left = 357
      Top = 2
      Width = 175
      Height = 42
      Caption = 'Tipo de Pessoa Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object ColorLabel7: TColorLabel
        Left = 29
        Top = 19
        Width = 125
        Height = 14
        Caption = '(F)'#237'sica (J)ur'#237'dica (T)odos'
        CorDestaque = clRed
      end
      object edtTipCliente: TEditFocus
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
    object edtPorCli: TEditFocus
      Tag = 99
      Left = 234
      Top = 412
      Width = 40
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 29
      OnExit = edtPorCliExit
      OnKeyPress = edtPorCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorCli: TEditFocus
      Left = 276
      Top = 412
      Width = 175
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 30
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgPortador: TRadioGroup
      Left = 9
      Top = 435
      Width = 667
      Height = 39
      Caption = 'Mostrar no relat'#243'rio'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Portador da Duplicata'
        'Portador do Cliente'
        'Portador da Baixa')
      TabOrder = 33
    end
    object chkImpRes: TCheckBox
      Left = 357
      Top = 232
      Width = 250
      Height = 17
      Caption = 'Imprimir resumo de valores no final do relat'#243'rio'
      TabOrder = 17
    end
    object rdgStatus: TRadioGroup
      Left = 536
      Top = 44
      Width = 140
      Height = 142
      Caption = 'Status do Documento'
      ItemIndex = 2
      Items.Strings = (
        'Enviados ao Banco'
        'N'#227'o enviados'
        'Todos')
      TabOrder = 7
    end
    object gpbImp: TGroupBox
      Left = 357
      Top = 83
      Width = 175
      Height = 103
      Caption = 'Imprimir...'
      TabOrder = 9
      object chkImpAdc: TCheckBox
        Left = 8
        Top = 13
        Width = 162
        Height = 17
        Caption = 'Dados/Obs do Cad. do Cliente'
        TabOrder = 0
      end
      object chkImpEnd: TCheckBox
        Left = 8
        Top = 30
        Width = 146
        Height = 17
        Caption = 'Endere'#231'o do Cliente'
        TabOrder = 1
      end
      object chkNossNum: TCheckBox
        Left = 8
        Top = 48
        Width = 146
        Height = 17
        Caption = 'Nosso N'#250'mero'
        TabOrder = 2
        OnClick = chkNossNumClick
      end
      object chkMeiaFolha: TCheckBox
        Left = 8
        Top = 65
        Width = 146
        Height = 17
        Caption = 'em Meia Folha (Matricial)'
        TabOrder = 3
        OnClick = chkMeiaFolhaClick
      end
      object chkHisCob: TCheckBox
        Left = 8
        Top = 84
        Width = 137
        Height = 16
        Caption = 'Hist'#243'rico de Cobran'#231'a'
        TabOrder = 4
      end
    end
    object rdgEmpresa: TRadioGroup
      Left = 536
      Top = 2
      Width = 140
      Height = 42
      Caption = 'Empresa de...'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Faturam.'
        'Origem')
      TabOrder = 3
    end
    object edtPorBai: TEditFocus
      Tag = 99
      Left = 458
      Top = 412
      Width = 40
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 31
      OnExit = edtPorBaiExit
      OnKeyPress = edtPorBaiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorBai: TEditFocus
      Left = 500
      Top = 412
      Width = 176
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 32
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbNome: TGroupBox
      Left = 7
      Top = 44
      Width = 195
      Height = 40
      Caption = 'Exibir...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object lblNome: TColorLabel
        Left = 29
        Top = 17
        Width = 159
        Height = 14
        Caption = '(R)az'#227'o Social   (N)ome Fantasia'
        CorDestaque = clRed
      end
      object edtNome: TEditFocus
        Tag = 99
        Left = 7
        Top = 14
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'R'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
    end
    object chkResumoSint: TCheckBox
      Left = 357
      Top = 293
      Width = 234
      Height = 17
      Caption = 'Emitir Resumo Sint'#233'tico no final do relat'#243'rio'
      TabOrder = 20
      Visible = False
    end
    object edtCodReg: TEditFocus
      Left = 7
      Top = 561
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 42
      OnExit = edtCodRegExit
      OnKeyPress = edtCodRegKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesReg: TEditFocus
      Left = 64
      Top = 561
      Width = 272
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 43
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRede: TEditFocus
      Tag = 99
      Left = 458
      Top = 376
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 25
      OnExit = edtCodRedeExit
      OnKeyPress = edtCodRedeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesRede: TEditFocus
      Left = 500
      Top = 376
      Width = 176
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
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskCadIni: TMaskEditFocus
      Tag = 99
      Left = 170
      Top = 253
      Width = 68
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 13
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskCadFin: TMaskEditFocus
      Tag = 99
      Left = 170
      Top = 291
      Width = 69
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
      TabOrder = 14
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object chkValCor: TCheckBox
      Left = 357
      Top = 253
      Width = 234
      Height = 17
      Caption = 'Imprimir valor corrigido'
      Checked = True
      State = cbChecked
      TabOrder = 18
    end
    object gpbValor: TGroupBox
      Left = 357
      Top = 44
      Width = 175
      Height = 40
      Caption = 'Valor das duplicatas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object lblValor: TColorLabel
        Left = 29
        Top = 17
        Width = 139
        Height = 14
        Caption = '(P)ositivo (N)egativo (T)odos'
        CorDestaque = clRed
      end
      object edtValor: TEditFocus
        Tag = 99
        Left = 7
        Top = 14
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
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
    object edtCodCnd: TEditFocus
      Tag = 99
      Left = 343
      Top = 561
      Width = 29
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
      TabOrder = 44
      OnExit = edtCodCndExit
      OnKeyPress = edtCodCndKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesCnd: TEditFocus
      Left = 374
      Top = 561
      Width = 302
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 45
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbHistorico: TGroupBox
      Left = 7
      Top = 130
      Width = 345
      Height = 40
      Caption = 'Exibir Hit'#243'rico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      object ColorLabel6: TColorLabel
        Left = 29
        Top = 17
        Width = 183
        Height = 14
        Caption = ' (T)odo Hist'#243'rico  Uma (L)inha apenas'
        CorDestaque = clRed
      end
      object edtHistorico: TEditFocus
        Tag = 99
        Left = 7
        Top = 14
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
    end
    object chkProfis: TCheckBox
      Left = 357
      Top = 275
      Width = 233
      Height = 14
      Caption = 'Exibir somente cr'#233'ditos para profissionais'
      TabOrder = 19
    end
    object mskEspecie: TMaskEditFocus
      Tag = 99
      Left = 10
      Top = 101
      Width = 165
      Height = 22
      CharCase = ecUpperCase
      EditMask = 'll-ll-ll-ll-ll-ll-ll-ll-ll-ll;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 29
      ParentShowHint = False
      ShowHint = False
      TabOrder = 5
      Text = '  -  -  -  -  -  -  -  -  -  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object chkNovaPaginaQuebra: TCheckBox
      Left = 357
      Top = 312
      Width = 284
      Height = 17
      Caption = 'Na quebra por cliente, avan'#231'ar para nova p'#225'gina'
      TabOrder = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 639
    Width = 685
    ExplicitTop = 639
    ExplicitWidth = 685
    inherited pnlNomeForm: TPanel
      Left = 442
      Width = 243
      ExplicitLeft = 442
      ExplicitWidth = 243
    end
    inherited pnlInfo: TPanel
      Width = 442
      ExplicitWidth = 442
      inherited shpMultSel: TShape
        Left = 424
        Top = 2
        Height = 12
        Align = alRight
        Visible = True
        ExplicitLeft = 422
        ExplicitTop = 2
        ExplicitHeight = 12
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 896
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 896
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 600
    Top = 88
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 864
    Top = 64
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 768
    Top = 96
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 736
    Top = 96
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 704
    Top = 96
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 800
    Top = 64
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 768
    Top = 64
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 704
    Top = 64
  end
  inherited frxGen: TfrxUserDataSet
    Left = 736
    Top = 64
  end
  inherited frxDesigner: TfrxDesigner
    Left = 800
    Top = 96
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 832
    Top = 96
  end
  object svdExcel: TSaveDialog
    Filter = 'Arquivos Excel|*.xls'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 864
    Top = 96
  end
  object frxRelatorioM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42094.448592881940000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltValP01: Double;'
      '  fltValP02: Double;'
      '  fltValP03: Double;      '
      '  fltValG01: Double;'
      '  fltValG02: Double;'
      '  fltValG03: Double;      '
      '  '
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
      '  '
      'procedure rllValP01OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP01.Text := FormatFloat('#39'#,##0.00'#39', fltValP01);'
      '  fltValG01      := fltValG01 + fltValP01;'
      
        '  fltValP01      := 0;                                          ' +
        '        '
      'end;'
      ''
      'procedure rllValP02OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP02.Text := FormatFloat('#39'#,##0.00'#39', fltValP02);'
      '  fltValG02      := fltValG02 + fltValP02;'
      '  fltValP02      := 0;  '
      'end;'
      ''
      'procedure rllValP03OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP03.Text := FormatFloat('#39'#,##0.00'#39', fltValP03);'
      '  fltValG03      := fltValG03 + fltValP03;'
      '  fltValP03      := 0;  '
      'end;'
      ''
      'procedure rllValG01OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG01.Text := FormatFloat('#39'#,##0.00'#39', fltValG01);'
      '  fltValG01      := 0;'
      'end;'
      ''
      'procedure rllValG02OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG02.Text := FormatFloat('#39'#,##0.00'#39', fltValG02);'
      '  fltValG02      := 0;  '
      'end;'
      ''
      'procedure rllValG03OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG03.Text := FormatFloat('#39'#,##0.00'#39', fltValG03);'
      '  fltValG03      := 0;  '
      'end;'
      ''
      'procedure rllVal001OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal001.Text := FormatFloat('#39'#,##0.00'#39', fGetVal001);'
      
        '  fltValP01      := fltValP01 + fGetVal001;                     ' +
        '                            '
      'end;'
      ''
      'procedure rllVal002OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal002.Text := FormatFloat('#39'#,##0.00'#39', fGetVal002);'
      '  fltValP02      := fltValP02 + fGetVal002;  '
      'end;'
      ''
      'procedure rllVal003OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal003.Text := FormatFloat('#39'#,##0.00'#39', fGetVal003);'
      '  fltValP03      := fltValP03 + fGetVal003;  '
      'end;'
      ''
      'procedure rdbDtaRecOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      
        '  if (TIPTIT <> '#39'A'#39') And (<frxRelatorio."CTR_DTAREC"> = '#39'0'#39') The' +
        'n'
      '    rdbDtaRec.Text := '#39#39';'
      ''
      'end;'
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ReportSummary1.Visible := Not blnMeiaFolha;'
      'end;'
      ''
      'procedure Memo154OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Memo154.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImpresso.Tex' +
        't;                                                              ' +
        '      '
      'end;'
      ''
      'procedure Memo109OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Memo109.Text := '#39'PAGINA: '#39' + Memo109.Text;                    ' +
        '                                            '
      'end;'
      ''
      'procedure rllPaginaCndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPaginaCnd.Text := '#39'PAGINA: '#39' + rllPaginaCnd.Text;  '
      'end; '
      ''
      'procedure rdbDtaRecCndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (TIPTIT <> '#39'A'#39') And (<frxRelatorio."CTR_DTAREC"> = '#39'0'#39') The' +
        'n'
      '    rdbDtaRecCnd.Text := '#39#39';  '
      'end;'
      ''
      'procedure rllVal001CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal001Cnd.Text := FormatFloat('#39'#,##0.00'#39', fGetVal001);'
      '  fltValP01         := fltValP01 + fGetVal001;  '
      'end;'
      ''
      'procedure rllVal002CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal002Cnd.Text := FormatFloat('#39'#,##0.00'#39', fGetVal002);'
      '  fltValP02         := fltValP02 + fGetVal002;  '
      'end;'
      ''
      'procedure rllVal003CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal003Cnd.Text := FormatFloat('#39'#,##0.00'#39', fGetVal003);'
      '  fltValP03         := fltValP03 + fGetVal003;  '
      'end;'
      ''
      'procedure rllValP01CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP01Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValP01);'
      '  fltValG01         := fltValG01 + fltValP01;'
      '  fltValP01         := 0;  '
      'end;'
      ''
      'procedure rllValP02CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP02Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValP02);'
      '  fltValG02         := fltValG02 + fltValP02;'
      '  fltValP02         := 0;  '
      'end;'
      ''
      'procedure rllValP03CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP03Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValP03);'
      '  fltValG03         := fltValG03 + fltValP03;'
      '  fltValP03         := 0;  '
      'end;'
      ''
      'procedure ReportSummary2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ReportSummary2.Visible := Not blnMeiaFolha  '
      'end;'
      ''
      'procedure rllValG01CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG01Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValG01);'
      '  fltValG01         := 0;  '
      'end;'
      ''
      'procedure rllValG02CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG02Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValG02);'
      '  fltValG02         := 0;  '
      'end;'
      ''
      'procedure rllValG03CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG03Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValG03);'
      '  fltValG03         := 0;  '
      'end;'
      ''
      
        'procedure rllTotalImpressoCndOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  rllTotalImpressoCnd.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotal' +
        'ImpressoCnd.Text;  '
      'end;'
      ''
      'procedure rgpTitGruOnBeforePrint(Sender: TfrxComponent);'
      'var'
      
        '  strObsCob: String;                                            ' +
        '                 '
      'begin'
      '  strObsCob := '#39#39';                                         '
      '  '
      
        '  If Not(<frxRelatorio."CLI_OBSERV"> = '#39' '#39') Then                ' +
        '                                         '
      '    strObsCob := <frxRelatorio."CLI_OBSERV">;'
      ''
      
        '  strObsCob := strObsCob + '#39' '#39' + fRetObsCobCliente(<frxRelatorio' +
        '."CTR_CODCLI">);                                                ' +
        '                                              '
      ''
      
        '  {*****************************************************}       ' +
        '                                                                ' +
        '                                                                ' +
        '                                                '
      '  {* NESSE CASO A PROPRIEDADE ALLOWEXPRESSIONS DO MEMO *}     '
      '  {* DEVE ESTAR COMO FALSE, POIS SE NA STRING CONTER   *}'
      '  {* [ ] VAI DAR ERRO DE EXPRESS'#195'O                     *}'
      '  {****************************************REQ 61012*AJ*}      '
      
        '  memoObs.Memo.Text := strObsCob; //fRetObsCobCliente(<frxRelato' +
        'rio."CTR_CODCLI">);     '
      ''
      '  If (Trim(memoObs.Memo.Text) = '#39#39') Then'
      '    chdObserv.Visible := False'
      '  else'
      '    chdObserv.Visible := True;  '
      'end;'
      ''
      'procedure DMPMemo6OnBeforePrint(Sender: TfrxComponent);'
      'begin              '
      '  If (<frxRelatorio."TAM_HIST"> = '#39'TRUE'#39') Then'
      '  Begin'
      '    rdbHistor.Visible := False;         '
      '    RdbHist02.Top := DMPMemo60.Height;          '
      '    RdbHist02.Text := rdbHistor.Text;'
      '    RdbHist02.Visible := True;'
      '  End'
      '  Else                    '
      '  Begin'
      '    rdbHistor.Visible := True;          '
      
        '    RdbHist02.Visible := False;                                 ' +
        '          '
      '    RdbHist02.Top := 0;             '
      '    RdbHist02.Text := '#39#39';       '
      '  End;                      '
      'end;'
      ''
      'procedure DMPMemo112OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."TAM_HIST"> = '#39'TRUE'#39') Then'
      '  Begin'
      '    rdbHistorCnd.Visible := False;'
      '    RdbHist02Cnd.Top := DMPMemo112.Height;'
      
        '    RdbHist02Cnd.Left:= DMPMemo112.Left;                        ' +
        '                                                                '
      '    RdbHist02Cnd.Text := rdbHistorCnd.Text;'
      '    RdbHist02Cnd.Visible := True;'
      '  End'
      '  Else                    '
      '  Begin'
      '    rdbHistorCnd.Visible := True;'
      '    RdbHist02Cnd.Visible := False;'
      '    RdbHist02Cnd.Top := 0;'
      '    RdbHist02Cnd.Text := '#39#39';       '
      '  End;  '
      'end;'
      ''
      'begin'
      '  fltValP01 := 0;'
      '  fltValP02 := 0;'
      '  fltValP03 := 0;      '
      '  fltValG01 := 0;'
      '  fltValG02 := 0;'
      '  fltValG03 := 0;'
      ''
      '  cmdMeiaFolha.Visible := blnMeiaFolha;'
      '  cmdMeiaFolhaCnd.Visible := blnMeiaFolha;      '
      '    '
      'end.')
    OnUserFunction = frxRelatorioMUserFunction
    Left = 616
    Top = 228
    Datasets = <
      item
        DataSet = frxDBResumo
        DataSetName = 'frxDBResumo'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 242.887343135257600000
      PaperSize = 256
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 731.000000000000000000
        Width = 1526.400000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbTitAbe: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 425.000000000000000000
        Width = 1526.400000000000000000
        ReprintOnNewPage = True
        object rllHistorA: TfrxDMPMemoView
          Left = 547.200000000000100000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CADASTRO')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 326.400000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'VEN')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'PORTADOR')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 960.000000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ATR')
          TruncOutboundText = False
        end
        object rllDtaVen: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENCTO.')
          TruncOutboundText = False
        end
        object rllCap001: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object rllCap002: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. JUROS')
          TruncOutboundText = False
        end
        object rllCap003: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. COR')
          TruncOutboundText = False
        end
        object rllDtaRec: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECEBIM.')
          TruncOutboundText = False
        end
        object rllCapBru: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL.BRUTO')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 255.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        Stretched = True
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 1056.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
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
          Left = 326.400000000000000000
          Top = 34.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1382.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 86.400000000000000000
          Top = 51.000000000000000000
          Width = 1353.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object cmdMeiaFolha: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object DMPMemo2: TfrxDMPMemoView
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCLI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCID]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILPOR]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILEMP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILEVE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILDUP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILORD]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILVEN]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILESP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILTIP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILSTA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PORCLI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PORBAI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPEMP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Top = 204.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REDLOJ]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 204.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILVLD]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Top = 221.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCND]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rgpTitGru: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1526.400000000000000000
        OnBeforePrint = 'rgpTitGruOnBeforePrint'
        Child = frxRelatorioM.chdEndere
        Condition = 'frxRelatorio."CTR_CODCLI"'
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE:')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 547.200000000000100000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODCLI"]-[frxRelatorio."CLI_NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TELEFONE:')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fFormataFonePaisInterna(<frxRelatorio."TELEFONE">)]')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CONTATO:')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CONTAT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CNPJ/CPF:')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CLI_CGCCPF"> = '#39'1'#39', FormatMaskText('#39'00.000.0' +
              '00/0000-00;0'#39',<frxRelatorio."CLI_C_G_C_">),FormatMaskText('#39'000.0' +
              '00.000-00;0'#39',<frxRelatorio."CLI_C_G_C_">))]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 527.000000000000000000
        Width = 1526.400000000000000000
        object DMPMemo44: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL PARCIAL DO CLIENTE:')
          TruncOutboundText = False
        end
        object rllValP01: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP01OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllValP02: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP02OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllValP03: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP03OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllLinha: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object rllValPBr: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VLRBRU">)]')
          TruncOutboundText = False
        end
        object rllLimite: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LIM.CREDITO:')
          TruncOutboundText = False
        end
        object rllMedAtr: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MEDIA ATRASO:')
          TruncOutboundText = False
        end
        object rllDtaCad: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DATA CADASTRO:')
          TruncOutboundText = False
        end
        object rdbLimite: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."LIMCRE">)]')
          TruncOutboundText = False
        end
        object rdbMedAtr: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[AVG(<frxRelatorio."CTR_DIAATR">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object rdbDtaCad: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."DTACAD">)]')
          TruncOutboundText = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 629.000000000000000000
        Width = 1526.400000000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        object DMPMemo47: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object rllValG01: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG01OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllValG02: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG02OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllValG03: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG03OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotVenc: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL VENCIDO:')
          TruncOutboundText = False
        end
        object rllTotAVenc: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 51.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL A RECEBER:')
          TruncOutboundText = False
        end
        object rllTotRecb: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 68.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL RECEBIDO:')
          TruncOutboundText = False
        end
        object rllTotVen: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTVEN]')
          TruncOutboundText = False
        end
        object rllTotAVen: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTAVE]')
          TruncOutboundText = False
        end
        object rllTotRec: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTREC]')
          TruncOutboundText = False
        end
        object rllValGBr: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VLRBRU">)]')
          TruncOutboundText = False
        end
        object rllAtrGeral: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'MEDIA ATRASO GERAL:')
          TruncOutboundText = False
        end
        object rdbAtrGeral: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[AVG(<frxRelatorio."CTR_DIAATR">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object chdObserv: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 374.000000000000000000
        Width = 1526.400000000000000000
        Child = frxRelatorioM.chdEspGru
        Stretched = True
        object rllObsCli: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OBS:')
          TruncOutboundText = False
        end
        object MemoObs: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 1392.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          AllowExpressions = False
          FontStyle = [fsx12cpi]
          HAlign = haBlock
          Memo.UTF8W = (
            '[frxRelatorio."OBSCOB"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object chdEndere: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 1526.400000000000000000
        Child = frxRelatorioM.chdObserv
        object DMPMemo38: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENDERECO:')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 1392.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ENDERE"]')
          TruncOutboundText = False
        end
      end
      object chdEspGru: TfrxChild
        FillType = ftBrush
        Top = 408.000000000000000000
        Width = 1526.400000000000000000
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 493.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo6OnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDUP'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 326.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbPortad: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[(Copy(<frxRelatorio."NOMPOR">,0,30))]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbHistor: TfrxDMPMemoView
          Left = 547.200000000000100000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object rdbDtaRec: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbDtaRecOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          HAlign = haCenter
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DIAATR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDtaVen: TfrxDMPMemoView
          Left = 768.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVal001: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllVal001OnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVal002: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllVal002OnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVal003: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllVal003OnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllValBru: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VLRBRU"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object RdbHist02: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          StretchMode = smActualHeight
          FontStyle = [fsx12cpi]
          HAlign = haBlock
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object DMPLine3: TfrxDMPLineView
        Align = baBottom
        Left = 4.800000000000000000
        Top = 926.500000000000000000
        Width = 1497.600000000000000000
        Color = clBlack
      end
    end
    object qckPagCnd: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 206.904033041145300000
      PaperSize = 256
      FontStyle = []
      object rlbCabecalhoCnd: TfrxPageHeader
        FillType = ftBrush
        Height = 255.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        Stretched = True
        object DMPMemo45: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 1056.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Align = baCenter
          Left = 326.400000000000000000
          Top = 34.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPaginaCnd: TfrxDMPMemoView
          Left = 1382.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaCndOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Align = baCenter
          Left = 86.400000000000000000
          Top = 51.000000000000000000
          Width = 1353.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand8: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object cmdMeiaFolhaCnd: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object DMPMemo58: TfrxDMPMemoView
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCLI]')
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCID]')
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILPOR]')
          TruncOutboundText = False
        end
        object DMPMemo62: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILEMP]')
          TruncOutboundText = False
        end
        object DMPMemo63: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILEVE]')
          TruncOutboundText = False
        end
        object DMPMemo64: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILDUP]')
          TruncOutboundText = False
        end
        object DMPMemo79: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILORD]')
          TruncOutboundText = False
        end
        object DMPMemo80: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILVEN]')
          TruncOutboundText = False
        end
        object DMPMemo81: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILESP]')
          TruncOutboundText = False
        end
        object DMPMemo82: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILTIP]')
          TruncOutboundText = False
        end
        object DMPMemo83: TfrxDMPMemoView
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILSTA]')
          TruncOutboundText = False
        end
        object DMPMemo84: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PORCLI]')
          TruncOutboundText = False
        end
        object DMPMemo85: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PORBAI]')
          TruncOutboundText = False
        end
        object DMPMemo86: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPEMP]')
          TruncOutboundText = False
        end
        object DMPMemo87: TfrxDMPMemoView
          Top = 204.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REDLOJ]')
          TruncOutboundText = False
        end
        object DMPMemo88: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 204.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILVLD]')
          TruncOutboundText = False
        end
        object DMPMemo89: TfrxDMPMemoView
          Top = 221.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCND]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 255.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          StretchMode = smActualHeight
          FontStyle = [fsx12cpi]
          HAlign = haBlock
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rgpTitGruCnd: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1526.400000000000000000
        Condition = 'frxRelatorio."CTR_CODCND"'
        object DMPMemo90: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COND. PAGTO.:')
          TruncOutboundText = False
        end
        object DMPMemo91: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODCND"]-[frxRelatorio."CND_DESCRI"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitAbeCnd: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 340.000000000000000000
        Width = 1526.400000000000000000
        ReprintOnNewPage = True
        object rllHistorACnd: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo101: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CADASTRO')
          TruncOutboundText = False
        end
        object DMPMemo102: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo103: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'LOJA')
          TruncOutboundText = False
        end
        object DMPMemo104: TfrxDMPMemoView
          Left = 326.400000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'VEN')
          TruncOutboundText = False
        end
        object DMPMemo105: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'PORTADOR')
          TruncOutboundText = False
        end
        object DMPMemo106: TfrxDMPMemoView
          Left = 960.000000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ATR')
          TruncOutboundText = False
        end
        object DMPMemo107: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENCTO.')
          TruncOutboundText = False
        end
        object rllCap001cnd: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object rllCap002cnd: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. JUROS')
          TruncOutboundText = False
        end
        object rllCap003cnd: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. COR')
          TruncOutboundText = False
        end
        object DMPMemo111: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECEBIM.')
          TruncOutboundText = False
        end
        object rllCapBruCnd: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL.BRUTO')
          TruncOutboundText = False
        end
      end
      object rlbDetalhesCnd: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 408.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo112: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo112OnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo113: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDUP'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo114: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo115: TfrxDMPMemoView
          Left = 326.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo116: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[(Copy(<frxRelatorio."NOMPOR">,0,30))]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbHistorCnd: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDtaRecCnd: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbDtaRecCndOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          HAlign = haCenter
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo119: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DIAATR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo120: TfrxDMPMemoView
          Left = 768.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVal001Cnd: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllVal001CndOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVal002Cnd: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllVal002CndOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVal003Cnd: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllVal003CndOnBeforePrint'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllValBruCnd: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VLRBRU"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbHist02Cnd: TfrxDMPMemoView
          Left = -9.600000000000000000
          Top = 17.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          StretchMode = smActualHeight
          FontStyle = [fsx12cpi]
          HAlign = haBlock
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1526.400000000000000000
        object DMPMemo124: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL PARCIAL DA CONDICAO:')
          TruncOutboundText = False
        end
        object rllValP01Cnd: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP01CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllValP02Cnd: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP02CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllValP03Cnd: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP03CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object rllValPBrCnd: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VLRBRU">)]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'MEDIA ATRASO PARCIAL:')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[AVG(<frxRelatorio."CTR_DIAATR">,rlbDetalhesCnd)]')
          TruncOutboundText = False
        end
      end
      object FORA_DE_USO_ChdObservCnd: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 493.000000000000000000
        Visible = False
        Width = 1526.400000000000000000
        Stretched = True
        object DMPMemo98: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OBS:')
          TruncOutboundText = False
        end
        object DMPMemo99: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 988.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."OBS001"]')
          TruncOutboundText = False
        end
        object DMPMemo128: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 988.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."OBS002"]')
          TruncOutboundText = False
        end
        object DMPMemo129: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 34.000000000000000000
          Width = 988.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."OBS003"]')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object DMPMemo130: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LIM.CREDITO:')
          TruncOutboundText = False
        end
        object DMPMemo131: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MEDIA ATRASO:')
          TruncOutboundText = False
        end
        object DMPMemo132: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DATA CADASTRO:')
          TruncOutboundText = False
        end
        object DMPMemo133: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."LIMCRE">)]')
          TruncOutboundText = False
        end
        object DMPMemo134: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[AVG(<frxRelatorio."CTR_DIAATR">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo135: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."DTACAD">)]')
          TruncOutboundText = False
        end
      end
      object ReportSummary2: TfrxReportSummary
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 595.000000000000000000
        Width = 1526.400000000000000000
        OnBeforePrint = 'ReportSummary2OnBeforePrint'
        object DMPMemo48: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1507.200000000000000000
          Color = clBlack
        end
        object rllValG01Cnd: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG01CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllValG02Cnd: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG02CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllValG03Cnd: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG03CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllTotVencCnd: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL VENCIDO:')
          TruncOutboundText = False
        end
        object rllTotAVencCnd: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 51.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL A VENCER:')
          TruncOutboundText = False
        end
        object rllTotRecebCnd: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 68.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL RECEBIDO:')
          TruncOutboundText = False
        end
        object rllTotVenCnd: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTVEN]')
          TruncOutboundText = False
        end
        object rllTotAVenCnd: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTAVE]')
          TruncOutboundText = False
        end
        object rllTotRecCnd: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTREC]')
          TruncOutboundText = False
        end
        object rllValGBrCnd: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VLRBRU">)]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'MEDIA ATRASO GERAL:')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[AVG(<frxRelatorio."CTR_DIAATR">,rlbDetalhesCnd)]')
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 697.000000000000000000
        Width = 1526.400000000000000000
        object DMPMemo123: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpressoCnd: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoCndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhesCnd)]')
          TruncOutboundText = False
        end
      end
    end
    object qckResumo: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frxDBResumo
        DataSetName = 'frxDBResumo'
        RowCount = 0
        object Memo127: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBResumo."CODCLI"] - [frxDBResumo."NOMCLI"]')
          TruncOutboundText = False
        end
        object Memo129: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FormatMaskText('#39'(00)0000-0000;0'#39',<frxDBResumo."FONE01">)]')
          TruncOutboundText = False
        end
        object Memo133: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBResumo."VALDUP"]')
          TruncOutboundText = False
        end
        object Memo135: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBResumo."VLRCOR"]')
          TruncOutboundText = False
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 442.000000000000000000
        Width = 1526.400000000000000000
        object Memo153: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 806.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object Memo154: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo154OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterData2)]')
          TruncOutboundText = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 255.000000000000000000
        Width = 1526.400000000000000000
        ReprintOnNewPage = True
        object Memo131: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo149: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 17.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'TELEFONE')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo150: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo152: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Top = 17.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. CORRIGIDO')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageHeader2: TfrxPageHeader
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        Stretched = True
        object Memo107: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 1056.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo108: TfrxDMPMemoView
          Align = baCenter
          Left = 326.400000000000000000
          Top = 34.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO SINTETICO - [NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo109: TfrxDMPMemoView
          Left = 1382.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo109OnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Memo110: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Memo111: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo78: TfrxDMPMemoView
          Align = baCenter
          Left = 86.400000000000000000
          Top = 51.000000000000000000
          Width = 1353.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCLI]')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCID]')
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILPOR]')
          TruncOutboundText = False
        end
        object DMPMemo68: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILEMP]')
          TruncOutboundText = False
        end
        object DMPMemo69: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILEVE]')
          TruncOutboundText = False
        end
        object DMPMemo70: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILDUP]')
          TruncOutboundText = False
        end
        object DMPMemo71: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILORD]')
          TruncOutboundText = False
        end
        object DMPMemo72: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILVEN]')
          TruncOutboundText = False
        end
        object DMPMemo73: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILESP]')
          TruncOutboundText = False
        end
        object DMPMemo74: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILTIP]')
          TruncOutboundText = False
        end
        object DMPMemo75: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILSTA]')
          TruncOutboundText = False
        end
        object DMPMemo76: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PORCLI]')
          TruncOutboundText = False
        end
        object DMPMemo77: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PORBAI]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 187.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILVLD]')
          TruncOutboundText = False
        end
      end
      object ReportSummary3: TfrxReportSummary
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 1526.400000000000000000
        OnBeforePrint = 'ReportSummary3OnBeforePrint'
        object Memo136: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object Line95: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object Memo137: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBResumo."VALDUP">,MasterData2)]')
          TruncOutboundText = False
        end
        object Memo139: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBResumo."VLRCOR">,MasterData2)]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
      end
    end
  end
  object cdsResumoSint: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 648
    Top = 136
    object cdsResumoSintCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsResumoSintNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object cdsResumoSintFONE01: TStringField
      FieldName = 'FONE01'
      Size = 15
    end
    object cdsResumoSintVALDUP: TFloatField
      FieldName = 'VALDUP'
      DisplayFormat = '#,##0.00'
    end
    object cdsResumoSintVLRCOR: TFloatField
      FieldName = 'VLRCOR'
      DisplayFormat = '#,##0.00'
    end
    object cdsResumoSintCODCND: TStringField
      FieldName = 'CODCND'
      Size = 3
    end
  end
  object frxDBResumo: TfrxDBDataset
    UserName = 'frxDBResumo'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsResumoSint
    BCDToCurrency = False
    Left = 576
    Top = 136
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42094.451097303200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltValP01: Double;'
      '  fltValP02: Double;'
      '  fltValP03: Double;      '
      '  fltValG01: Double;'
      '  fltValG02: Double;'
      '  fltValG03: Double;'
      '                                             '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rllValP01OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP01.Text := FormatFloat('#39'#,##0.00'#39', fltValP01);'
      '  fltValG01      := fltValG01 + fltValP01;'
      '  fltValP01      := 0;'
      'end;'
      ''
      'procedure rllValP02OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP02.Text := FormatFloat('#39'#,##0.00'#39', fltValP02);'
      '  fltValG02      := fltValG02 + fltValP02;'
      '  fltValP02      := 0;  '
      'end;'
      ''
      'procedure rllValP03OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP03.Text := FormatFloat('#39'#,##0.00'#39', fltValP03);'
      '  fltValG03      := fltValG03 + fltValP03;'
      '  fltValP03      := 0;  '
      'end;'
      ''
      'procedure rllValG01OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG01.Text := FormatFloat('#39'#,##0.00'#39', fltValG01);'
      '  fltValG01      := 0;'
      'end;'
      ''
      'procedure rllValG02OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG02.Text := FormatFloat('#39'#,##0.00'#39', fltValG02);'
      '  fltValG02      := 0;  '
      'end;'
      ''
      'procedure rllValG03OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG03.Text := FormatFloat('#39'#,##0.00'#39', fltValG03);'
      '  fltValG03      := 0;  '
      'end;'
      ''
      'procedure rllVal001OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal001.Text := FormatFloat('#39'#,##0.00'#39', fGetVal001);'
      '  fltValP01      := fltValP01 + fGetVal001;'
      'end;'
      ''
      'procedure rllVal002OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal002.Text := FormatFloat('#39'#,##0.00'#39', fGetVal002);'
      '  fltValP02      := fltValP02 + fGetVal002;'
      'end;'
      ''
      'procedure rllVal003OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal003.Text := FormatFloat('#39'#,##0.00'#39', fGetVal003);'
      '  fltValP03      := fltValP03 + fGetVal003;  '
      'end;'
      ''
      'procedure rdbDtaRecOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (TIPTIT <> '#39'A'#39') And (<frxRelatorio."CTR_DTAREC"> = '#39'0'#39') The' +
        'n'
      '    rdbDtaRec.Text := '#39#39';'
      ''
      'end;'
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ReportSummary1.Visible := Not blnMeiaFolha;  '
      'end;'
      ''
      'procedure rllTotRecOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotRec.Text := rllTotRec.Text + rllValG02.Text;          ' +
        '                                                       '
      'end;'
      ''
      'procedure ReportSummary3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ReportSummary3.Visible := Not blnMeiaFolha;  '
      'end;'
      ''
      'procedure rllPaginaCndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPaginaCnd.Text := '#39'P'#193'GINA: '#39' + rllPaginaCnd.Text;  '
      'end;'
      ''
      'procedure rdbDtaRecCndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '    if (TIPTIT <> '#39'A'#39') And (<frxRelatorio."CTR_DTAREC"> = '#39'0'#39') T' +
        'hen'
      '    rdbDtaRecCnd.Text := '#39#39';  '
      'end;'
      ''
      'procedure rllVal001CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal001Cnd.Text := FormatFloat('#39'#,##0.00'#39', fGetVal001);'
      '  fltValP01         := fltValP01 + fGetVal001;  '
      'end;'
      ''
      'procedure rllVal002CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal002Cnd.Text := FormatFloat('#39'#,##0.00'#39', fGetVal002);'
      '  fltValP02         := fltValP02 + fGetVal002;  '
      'end;'
      ''
      'procedure rllVal003CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllVal003Cnd.Text := FormatFloat('#39'#,##0.00'#39', fGetVal003);'
      '  fltValP03         := fltValP03 + fGetVal003;  '
      'end;'
      ''
      'procedure rllValP01CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP01Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValP01);'
      '  fltValG01         := fltValG01 + fltValP01;'
      '  fltValP01         := 0;  '
      'end;'
      ''
      'procedure rllValP02CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP02Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValP02);'
      '  fltValG02         := fltValG02 + fltValP02;'
      '  fltValP02         := 0;  '
      'end;'
      ''
      'procedure rllValP03CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValP03Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValP03);'
      '  fltValG03         := fltValG03 + fltValP03;'
      '  fltValP03         := 0;  '
      'end;'
      ''
      'procedure ReportSummary2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ReportSummary2.Visible := Not blnMeiaFolha;  '
      'end;'
      ''
      'procedure rllValG01CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG01Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValG01);'
      '  fltValG01         := 0;  '
      'end;'
      ''
      'procedure rllValG02CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG02Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValG02);'
      '  fltValG02         := 0;  '
      'end;'
      ''
      'procedure rllValG03CndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllValG03Cnd.Text := FormatFloat('#39'#,##0.00'#39', fltValG03);'
      '  fltValG03         := 0;  '
      'end;'
      ''
      'procedure rllTotRecCndOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '//  rllTotRec.Text := rllTotRec.Text + rllValG02.Text;  '
      'end;'
      ''
      
        'procedure rllTotalImpressoCndOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  rllTotalImpressoCnd.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotal' +
        'ImpressoCnd.Text;  '
      'end;'
      '  '
      'procedure rgpTitGruOnBeforePrint(Sender: TfrxComponent);'
      'var'
      
        '  strObsCob: String;                                            ' +
        '                 '
      'begin'
      
        '  strObsCob := '#39#39';                                              ' +
        '         '
      '  '
      '  If Not(<frxRelatorio."CLI_OBSERV"> = '#39' '#39') Then'
      '    strObsCob := <frxRelatorio."CLI_OBSERV">;'
      '       '
      
        '  strObsCob := strObsCob + '#39' '#39' + fRetObsCobCliente(<frxRelatorio' +
        '."CTR_CODCLI">);                                                ' +
        '                                              '
      ''
      
        '  {*****************************************************}       ' +
        '                                                                ' +
        '                                                                ' +
        '                                                '
      '  {* NESSE CASO A PROPRIEDADE ALLOWEXPRESSIONS DO MEMO *}     '
      '  {* DEVE ESTAR COMO FALSE, POIS SE NA STRING CONTER   *}'
      '  {* [ ] VAI DAR ERRO DE EXPRESS'#195'O                     *}'
      
        '  {****************************************REQ 61012*AJ*}       ' +
        '                                                                ' +
        '                                                                ' +
        '         '
      
        '  memoObs.Memo.Text := strObsCob; //fRetObsCobCliente(<frxRelato' +
        'rio."CTR_CODCLI">);     '
      ''
      '  If (Trim(memoObs.Memo.Text) = '#39#39') Then'
      '    chdObserv.Visible := False'
      '  Else'
      '    chdObserv.Visible := True;          '
      'end;'
      ''
      'procedure Memo20OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."TAM_HIST"> = '#39'TRUE'#39') Then'
      '  Begin'
      '    rdbHistor.Visible := False;                    '
      '    RdbHist02.Top := Memo20.Height + 0.1;'
      '    RdbHist02.Text := rdbHistor.Text;'
      '    RdbHist02.Visible := True;          '
      '  End'
      '  Else                    '
      '  Begin'
      '    rdbHistor.Visible := True;'
      '    RdbHist02.Visible := False;'
      '    RdbHist02.Top := 0;'
      '    RdbHist02.Text := '#39#39';       '
      '  End;'
      'end;'
      ''
      'procedure Memo98OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."TAM_HIST"> = '#39'TRUE'#39') Then'
      '  Begin'
      '    rdbHistorCnd.Visible := False;'
      '    RdbHist02Cnd.Top := Memo98.Height + 0.1;'
      
        '    RdbHist02Cnd.Left:= Memo98.Left;                            ' +
        '                                                            '
      '    RdbHist02Cnd.Text := rdbHistorCnd.Text;'
      '    RdbHist02Cnd.Visible := True;'
      '  End'
      '  Else                    '
      '  Begin'
      '    rdbHistorCnd.Visible := True;'
      '    RdbHist02Cnd.Visible := False;'
      '    RdbHist02Cnd.Top := 0;'
      '    RdbHist02Cnd.Text := '#39#39';       '
      '  End;  '
      'end;'
      ''
      'begin'
      '  fltValP01 := 0;'
      '  fltValP02 := 0;'
      '  fltValP03 := 0;      '
      '  fltValG01 := 0;'
      '  fltValG02 := 0;'
      '  fltValG03 := 0;'
      ''
      'end.')
    OnUserFunction = frxRelatorioMUserFunction
    Left = 616
    Top = 274
    Datasets = <
      item
        DataSet = frxDBResumo
        DataSetName = 'frxDBResumo'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 230.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 498.897960000000000000
        Width = 793.701300000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintChildIfInvisible = True
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Left = -1.000000000000000000
          Width = 789.921770000000000000
          Height = 17.007874020000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 4.600000000000000000
          Width = 56.692913390000000000
          Height = 17.007874020000000000
          OnBeforePrint = 'Memo20OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 61.963760000000000000
          Width = 111.496062990000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 174.256710000000000000
          Width = 28.800000000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 203.877180000000000000
          Width = 36.359060000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbPortad: TfrxMemoView
          Left = 241.497650000000000000
          Width = 82.166790000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMPOR"]')
          ParentFont = False
          WordWrap = False
        end
        object rllAtraso: TfrxMemoView
          Left = 541.458070000000000000
          Width = 23.281880000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DIAATR"]')
          ParentFont = False
          WordWrap = False
        end
        object rllVal001: TfrxMemoView
          Left = 616.818897640000000000
          Width = 58.960615280000000000
          Height = 17.007874020000000000
          OnBeforePrint = 'rllVal001OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999,99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllVal002: TfrxMemoView
          Left = 676.023622050000000000
          Width = 55.181085280000000000
          Height = 17.007874020000000000
          OnBeforePrint = 'rllVal002OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999,99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllVal003: TfrxMemoView
          Left = 731.850393700000000000
          Width = 56.692913390000000000
          Height = 17.007874020000000000
          OnBeforePrint = 'rllVal003OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999,99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbHistor: TfrxMemoView
          Left = 324.618800000000000000
          Width = 122.003030000000000000
          Height = 17.007874020000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordBreak = True
        end
        object rdbDtaRec: TfrxMemoView
          Left = 489.889610000000000000
          Width = 50.645649760000000000
          Height = 17.007874020000000000
          OnBeforePrint = 'rdbDtaRecOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object rdbDtaVen: TfrxMemoView
          Left = 447.369927400000000000
          Width = 41.574803150000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValBru: TfrxMemoView
          Left = 564.992125980000000000
          Width = 51.401555280000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VLRBRU"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object RdbHist02: TfrxMemoView
          Left = 8.692913390000000000
          Top = 17.385826769999990000
          Width = 781.606299210000000000
          Height = 17.007874020000000000
          Visible = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 37.779530000000000000
        Top = 755.906000000000000000
        Width = 793.701300000000000000
        object rllNomeForm: TfrxMemoView
          Top = 12.000000000000000000
          Width = 788.031496062992000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 196.029560000000000000
          Top = 12.000000000000000000
          Width = 591.798330000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbTitAbe: TfrxHeader
        FillType = ftBrush
        Height = 16.984230000000000000
        Top = 457.323130000000000000
        Width = 793.701300000000000000
        PrintChildIfInvisible = True
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 793.700787401575000000
          Height = 16.984230000000000000
          Fill.BackColor = clSilver
        end
        object rllHistorA: TfrxMemoView
          Left = 324.618800000000000000
          Top = 1.881880000000024000
          Width = 122.003030000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HIST'#211'RICO')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 4.600000000000000000
          Top = 1.881880000000024000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CADASTRO')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 61.963760000000000000
          Top = 1.881880000000024000
          Width = 111.496062992126000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 174.256710000000000000
          Top = 1.881880000000024000
          Width = 28.800000000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'LOJA')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 203.877180000000000000
          Top = 1.881880000000024000
          Width = 36.359060000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VEN')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 241.497650000000000000
          Top = 1.881880000000024000
          Width = 82.166790000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PORTADOR')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 541.458070000000000000
          Top = 1.881880000000024000
          Width = 23.281880000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ATR')
          ParentFont = False
        end
        object rllCap001: TfrxMemoView
          Left = 616.818897640000000000
          Top = 1.881880000000024000
          Width = 58.960615280000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object rllCap002: TfrxMemoView
          Left = 676.023622050000000000
          Top = 1.881880000000024000
          Width = 55.181085280000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. JUROS')
          ParentFont = False
        end
        object rllCap003: TfrxMemoView
          Left = 731.850393700000000000
          Top = 1.881880000000024000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. COR')
          ParentFont = False
        end
        object rllDtaRec: TfrxMemoView
          Left = 489.889610000000000000
          Top = 1.881880000000024000
          Width = 50.645649760000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECEBIM.')
          ParentFont = False
        end
        object rllDtaVen: TfrxMemoView
          Left = 447.369927400000000000
          Top = 1.881880000000024000
          Width = 41.574803150000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENCTO.')
          ParentFont = False
        end
        object rllCapBru: TfrxMemoView
          Left = 564.992125980000000000
          Top = 1.881880000000024000
          Width = 51.401555280000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL.BRUTO')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 241.811070000000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 123.968925000000000000
          Top = 9.440940000000001000
          Width = 545.763450000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 170.078996456693000000
          Top = 34.000000000000000000
          Width = 453.543307086614000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 692.352380000000000000
          Top = 11.425170000000000000
          Width = 96.302350000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 745.352380000000000000
          Top = 29.425170000000000000
          Width = 44.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 656.306740000000000000
          Top = 29.425170000000000000
          Width = 79.445640000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 22.677363070000000000
          Top = 51.000000000000000000
          Width = 748.346573860000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 9.448818900000000000
          Top = 85.039370080000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[FILCLI]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo3: TfrxMemoView
          Left = 413.102242600000000000
          Top = 102.047244090000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[FILCID]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo12: TfrxMemoView
          Left = 9.448818900000000000
          Top = 102.047244090000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[FILPOR]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo56: TfrxMemoView
          Left = 9.448818900000000000
          Top = 153.070866140000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[FILEMP]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo57: TfrxMemoView
          Left = 9.448818900000000000
          Top = 170.078740160000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[FILEVE]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo61: TfrxMemoView
          Left = 413.249600000000000000
          Top = 169.858292130000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[FILDUP]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo17: TfrxMemoView
          Left = 413.249600000000000000
          Top = 153.070866140000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[FILORD]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo19: TfrxMemoView
          Left = 413.249600000000000000
          Top = 119.055118110000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[FILVEN]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo15: TfrxMemoView
          Left = 9.448818900000000000
          Top = 187.086614170000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[FILESP]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo16: TfrxMemoView
          Left = 413.102242600000000000
          Top = 135.078740160000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[FILTIP]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo25: TfrxMemoView
          Left = 413.102242600000000000
          Top = 85.039370080000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[FILSTA]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo27: TfrxMemoView
          Left = 9.448818900000000000
          Top = 119.055118110000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[PORCLI]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo28: TfrxMemoView
          Left = 9.448818900000000000
          Top = 136.062992130000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[PORBAI]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo31: TfrxMemoView
          Left = 412.968770000000000000
          Top = 186.976500000000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPEMP]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo32: TfrxMemoView
          Left = 9.448818900000000000
          Top = 204.094620000000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[REDLOJ]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo33: TfrxMemoView
          Left = 413.102242600000000000
          Top = 204.094620000000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[FILVLD]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo35: TfrxMemoView
          Left = 8.559060000000000000
          Top = 221.992270000000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[FILCND]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
      end
      object rgpTitGru: TfrxGroupHeader
        FillType = ftBrush
        Height = 20.779530000000000000
        Top = 321.260050000000000000
        Width = 793.701300000000000000
        OnBeforePrint = 'rgpTitGruOnBeforePrint'
        Child = frxRelatorioJ.chdEndere
        Condition = 'frxRelatorio."CTR_CODCLI"'
        PrintChildIfInvisible = True
        object Memo36: TfrxMemoView
          Left = 11.338590000000000000
          Width = 44.825170000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE:')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 58.779530000000000000
          Width = 251.640630000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODCLI"] - [frxRelatorio."CLI_NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 512.603030000000000000
          Width = 25.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TEL:')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 542.335250000000000000
          Width = 87.911750000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFonePaisInterna(<frxRelatorio."TELEFONE">)]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 630.769820000000000000
          Width = 52.384230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTATO:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 315.912060000000000000
          Width = 52.384230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 373.675820000000000000
          Width = 133.266110000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CLI_CGCCPF"> = '#39'1'#39', FormatMaskText('#39'00.000.0' +
              '00/0000-00;0'#39',<frxRelatorio."CLI_C_G_C_">),FormatMaskText('#39'000.0' +
              '00.000-00;0'#39',<frxRelatorio."CLI_C_G_C_">))]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 683.567410000000000000
          Width = 98.418800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CONTAT"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 43.822820000000000000
        Top = 540.472790000000000000
        Width = 793.701300000000000000
        object Memo44: TfrxMemoView
          Left = 268.503937010000000000
          Top = 2.220469999999978000
          Width = 257.007874020000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL PARCIAL DO CLIENTE:')
          ParentFont = False
          WordWrap = False
        end
        object rllValP01: TfrxMemoView
          Left = 616.818897640000000000
          Top = 2.220469999999978000
          Width = 58.960615280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP01OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999,99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValP02: TfrxMemoView
          Left = 676.023622050000000000
          Top = 2.220469999999978000
          Width = 55.181085280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP02OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999,99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValP03: TfrxMemoView
          Left = 731.850393700000000000
          Top = 2.220469999999978000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP03OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999,99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLinha: TfrxLineView
          Top = 41.500000000000000000
          Width = 788.031496060000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllValPBr: TfrxMemoView
          Left = 564.992125980000000000
          Top = 2.220469999999978000
          Width = 51.401555280000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VLRBRU">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllLimite: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 11.338590000000000000
          Top = 20.354360000000040000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            'LIM.CR'#201'DITO:')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object rllMedAtr: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 275.874150000000000000
          Top = 20.464605990000000000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            'M'#201'DIA ATRASO:')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object rllDtaCad: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 530.598640000000000000
          Top = 20.913441970000010000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            'DATA CADASTRO:')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object rdbDtaCad: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 655.323130000000000000
          Top = 20.913419999999970000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DTACAD"]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object rdbLimite: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 136.063080000000000000
          Top = 20.354381969999960000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."LIMCRE"]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object rdbMedAtr: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 400.598640000000000000
          Top = 20.464605990000000000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            '[AVG(<frxRelatorio."CTR_DIAATR">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 86.311070000000000000
        Top = 646.299630000000000000
        Width = 793.701300000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        object Line2: TfrxLineView
          Top = 28.177180000000020000
          Width = 788.031496060000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTotVenc: TfrxMemoView
          Left = 394.102660000000000000
          Top = 33.354360000000040000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL VENCIDO:')
          ParentFont = False
        end
        object rllTotAVenc: TfrxMemoView
          Left = 386.102660000000000000
          Top = 51.031539999999950000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL A VENCER:')
          ParentFont = False
        end
        object rllTotRecb: TfrxMemoView
          Left = 386.102660000000000000
          Top = 68.708719999999970000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL RECEBIDO:')
          ParentFont = False
        end
        object rllTotRec: TfrxMemoView
          Left = 542.149970000000000000
          Top = 68.881889760000040000
          Width = 128.504020000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTotRecOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTREC]')
          ParentFont = False
        end
        object rllTotAVen: TfrxMemoView
          Left = 542.149970000000000000
          Top = 51.118112679999970000
          Width = 128.504020000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTAVE]')
          ParentFont = False
        end
        object rllTotVen: TfrxMemoView
          Left = 542.149970000000000000
          Top = 33.354360000000040000
          Width = 128.504020000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTVEN]')
          ParentFont = False
        end
        object rllValGBr: TfrxMemoView
          Left = 558.992125980000000000
          Top = 4.000000000000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VLRBRU">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 295.503937010000000000
          Top = 3.456710000000044000
          Width = 211.653514020000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
        end
        object rllValG01: TfrxMemoView
          Left = 616.818897640000000000
          Top = 3.677180000000021000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG01OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999,99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValG02: TfrxMemoView
          Left = 675.023622050000000000
          Top = 3.677180000000021000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG02OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999,99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValG03: TfrxMemoView
          Left = 732.850393700000000000
          Top = 3.677180000000021000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG03OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999,99')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllAtrGeral: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 7.559060000000000000
          Top = 4.559060000000045000
          Width = 136.063080000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            'M'#201'DIA ATRASO GERAL:')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object rdbAtrGeral: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 151.283550000000000000
          Top = 4.559060000000045000
          Width = 98.267780000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            '[AVG(<frxRelatorio."CTR_DIAATR">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
          VAlign = vaCenter
        end
      end
      object chdObserv: TfrxChild
        FillType = ftBrush
        Height = 22.645640000000000000
        Top = 411.968770000000000000
        Width = 793.701300000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object RllObs: TfrxMemoView
          Left = 7.600000000000000000
          Width = 29.707050000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBS:')
          ParentFont = False
        end
        object MemoObs: TfrxMemoView
          Left = 40.702350000000000000
          Width = 741.920840000000000000
          Height = 20.779530000000000000
          StretchMode = smMaxHeight
          AllowExpressions = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."OBSCOB"]')
          ParentFont = False
        end
      end
      object chdEndere: TfrxChild
        FillType = ftBrush
        Height = 20.779530000000000000
        Top = 366.614410000000000000
        Width = 793.701300000000000000
        Child = frxRelatorioJ.chdObserv
        PrintChildIfInvisible = True
        object Memo38: TfrxMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENDERECO:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 98.040940000000000000
          Width = 686.286580000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENDERE"]')
          ParentFont = False
        end
      end
    end
    object qckPagCnd: TfrxReportPage
      PaperWidth = 335.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalhoCnd: TfrxPageHeader
        FillType = ftBrush
        Height = 245.590600000000000000
        Top = 18.897650000000000000
        Width = 1190.551950000000000000
        object Memo45: TfrxMemoView
          Align = baCenter
          Left = 180.661875000000500000
          Top = 17.000000000000000000
          Width = 829.228199999999000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
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
        end
        object Memo46: TfrxMemoView
          Align = baCenter
          Left = 209.499630000000000000
          Top = 34.000000000000000000
          Width = 771.552690000000000000
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
        end
        object rllPaginaCnd: TfrxMemoView
          Left = 1072.069140000000000000
          Top = 15.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaCndOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo49: TfrxMemoView
          Left = 1120.069140000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo50: TfrxMemoView
          Left = 989.448670000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo51: TfrxMemoView
          Align = baCenter
          Left = 31.181355000000000000
          Top = 51.000000000000000000
          Width = 1128.189240000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Memo58: TfrxMemoView
          Left = 9.448818900000000000
          Top = 85.039370078740200000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCLI]')
        end
        object Memo59: TfrxMemoView
          Left = 598.299212600000000000
          Top = 102.047244094488000000
          Width = 588.094488190000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILCID]')
        end
        object Memo60: TfrxMemoView
          Left = 9.448818900000000000
          Top = 102.047244094488000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILPOR]')
        end
        object Memo62: TfrxMemoView
          Left = 9.448818900000000000
          Top = 153.070866141732000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILEMP]')
        end
        object Memo63: TfrxMemoView
          Left = 9.448818900000000000
          Top = 170.078740157480000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILEVE]')
        end
        object Memo64: TfrxMemoView
          Left = 598.446570000000000000
          Top = 136.062992125984000000
          Width = 588.018800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILDUP]')
        end
        object Memo65: TfrxMemoView
          Left = 598.446570000000000000
          Top = 153.070866141732000000
          Width = 588.018800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILORD]')
        end
        object Memo66: TfrxMemoView
          Left = 598.446570000000000000
          Top = 119.055118110236000000
          Width = 588.018800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILVEN]')
        end
        object Memo67: TfrxMemoView
          Left = 9.448818900000000000
          Top = 187.086614170000000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILESP]')
        end
        object Memo68: TfrxMemoView
          Left = 598.299212600000000000
          Top = 170.078740157480000000
          Width = 588.018800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILTIP]')
        end
        object Memo69: TfrxMemoView
          Left = 598.299212600000000000
          Top = 85.039370078740200000
          Width = 588.094488190000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILSTA]')
        end
        object Memo70: TfrxMemoView
          Left = 9.448818900000000000
          Top = 119.055118110236000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORCLI]')
        end
        object Memo71: TfrxMemoView
          Left = 9.448818900000000000
          Top = 136.062992125984000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORBAI]')
        end
        object Memo72: TfrxMemoView
          Left = 598.165740000000000000
          Top = 186.976500000000000000
          Width = 588.018800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPEMP]')
        end
        object Memo73: TfrxMemoView
          Left = 9.448818900000000000
          Top = 204.094620000000000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REDLOJ]')
        end
        object Memo74: TfrxMemoView
          Left = 598.299212600000000000
          Top = 204.094620000000000000
          Width = 588.018800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILVLD]')
        end
        object Memo75: TfrxMemoView
          Left = 8.559060000000000000
          Top = 221.992270000000000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCND]')
        end
      end
      object rgpTitGruCnd: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897576770000000000
        Top = 325.039580000000000000
        Width = 1190.551950000000000000
        Condition = 'frxRelatorio."CTR_CODCND"'
        object Memo76: TfrxMemoView
          Left = 9.600000000000000000
          Width = 97.738590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COND. PGTO.:')
        end
        object Memo77: TfrxMemoView
          Left = 109.040940000000000000
          Width = 391.483240000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODCND"] - [frxRelatorio."CND_DESCRI"]')
          WordWrap = False
        end
      end
      object rlbTitAbeCnd: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 366.614410000000000000
        Width = 1190.551950000000000000
        ReprintOnNewPage = True
        object Shape2: TfrxShapeView
          Width = 1188.661414880000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllHistorACnd: TfrxMemoView
          Left = 530.784230000000000000
          Width = 163.577860000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HIST'#211'RICO')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 5.600000000000000000
          Width = 80.881889760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CADASTRO')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 87.963760000000000000
          Width = 170.078740157480300000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 260.390600000000000000
          Width = 36.359060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'LOJA')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 299.231540000000000000
          Width = 32.579530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VEN')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 338.411070000000000000
          Width = 191.622017950000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PORTADOR')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Left = 827.481880000000000000
          Width = 30.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ATR')
          ParentFont = False
        end
        object rllCap001Cnd: TfrxMemoView
          Left = 942.236220470000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object rllCap002Cnd: TfrxMemoView
          Left = 1024.251968500000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. JUROS')
          ParentFont = False
        end
        object rllCap003Cnd: TfrxMemoView
          Left = 1106.645669290000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. COR')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Left = 757.984230000000000000
          Width = 69.543299760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECEBIM.')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 695.582667400000000000
          Width = 61.984247090000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENCTO.')
          ParentFont = False
        end
        object rllCapBruCnd: TfrxMemoView
          Left = 859.842519690000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL.BRUTO')
          ParentFont = False
        end
      end
      object rlbDetalhesCnd: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 411.968770000000000000
        Width = 1190.551950000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebraCnd: TfrxMemoView
          Width = 1186.772420000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 5.600000000000000000
          Width = 80.881889760000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo98OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo99: TfrxMemoView
          Left = 87.963760000000000000
          Width = 170.078740160000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo100: TfrxMemoView
          Left = 260.390600000000000000
          Width = 36.359060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo101: TfrxMemoView
          Left = 299.231540000000000000
          Width = 32.579530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo102: TfrxMemoView
          Left = 338.411070000000000000
          Width = 191.622017950000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMPOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo103: TfrxMemoView
          Left = 827.481880000000000000
          Width = 30.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DIAATR"]')
          ParentFont = False
          WordWrap = False
        end
        object rllVal001Cnd: TfrxMemoView
          Left = 942.236220470000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllVal001CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '99.999.999,99')
          ParentFont = False
          WordWrap = False
        end
        object rllVal002Cnd: TfrxMemoView
          Left = 1024.251968500000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllVal002CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rllVal003Cnd: TfrxMemoView
          Left = 1106.645669290000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllVal003CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rdbHistorCnd: TfrxMemoView
          Left = 530.784230000000000000
          Width = 163.577860000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rdbDtaRecCnd: TfrxMemoView
          Left = 757.984230000000000000
          Width = 69.543299760000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbDtaRecCndOnBeforePrint'
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Memo130: TfrxMemoView
          Left = 695.582667400000000000
          Width = 61.984247090000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValBruCnd: TfrxMemoView
          Left = 859.842519690000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VLRBRU"]')
          ParentFont = False
          WordWrap = False
        end
        object RdbHist02Cnd: TfrxMemoView
          Left = 5.779530000000000000
          Top = 10.559060000000000000
          Width = 1179.590551180000000000
          Height = 17.007874020000000000
          Visible = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          ParentFont = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 35.881880000000000000
        Top = 453.543600000000000000
        Width = 1190.551950000000000000
        object Memo132: TfrxMemoView
          Left = 598.677165350000000000
          Top = 6.047244089999990000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL PARCIAL DA CONDI'#199#195'O:')
          ParentFont = False
          WordWrap = False
        end
        object rllValP01Cnd: TfrxMemoView
          Left = 942.236220470000000000
          Top = 6.000000000000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP01CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllValP02Cnd: TfrxMemoView
          Left = 1024.251968500000000000
          Top = 6.000000000000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP02CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rllValP03Cnd: TfrxMemoView
          Left = 1106.645669290000000000
          Top = 6.000000000000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValP03CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Left = 4.800000000000000000
          Top = 30.500000000000300000
          Width = 1183.899010000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllValPBrCnd: TfrxMemoView
          Left = 859.842519690000000000
          Top = 6.000000000000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VLRBRU">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 3.000000000000000000
          Top = 6.047244090000000000
          Width = 158.740162360000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            'M'#201'DIA ATRASO PARCIAL:')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo18: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 162.519685039370000000
          Top = 6.047244089999990000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            '[AVG(<frxRelatorio."CTR_DIAATR">,rlbDetalhesCnd)]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
      end
      object FORA_DE_USO_chdObservCnd: TfrxChild
        FillType = ftBrush
        Height = 60.440940000000000000
        Top = 514.016080000000000000
        Visible = False
        Width = 1190.551950000000000000
        object Memo141: TfrxMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OBS:')
        end
        object Memo142: TfrxMemoView
          Left = 105.600000000000000000
          Width = 760.818490000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."OBS001"]')
          WordWrap = False
        end
        object Memo143: TfrxMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 760.818490000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."OBS002"]')
          WordWrap = False
        end
        object Memo144: TfrxMemoView
          Left = 105.600000000000000000
          Top = 34.000000000000000000
          Width = 760.818490000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."OBS003"]')
          WordWrap = False
        end
        object Line4: TfrxLineView
          Left = 4.800000000000000000
          Top = 57.500000000000000000
          Width = 1180.119480000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo145: TfrxMemoView
          Left = 876.850960000000000000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LIM.CREDITO:')
          ParentFont = False
        end
        object Memo146: TfrxMemoView
          Left = 876.850960000000000000
          Top = 17.007874020000000000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MEDIA ATRASO:')
          ParentFont = False
        end
        object Memo147: TfrxMemoView
          Left = 876.850960000000000000
          Top = 34.015770000000000000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA CADASTRO:')
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          Left = 1004.354980000000000000
          Top = 34.015748030000000000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DTACAD"]')
          ParentFont = False
        end
        object Memo151: TfrxMemoView
          Left = 1002.646260000000000000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LIMCRE"]')
          ParentFont = False
        end
        object Memo153: TfrxMemoView
          Left = 1002.708661420000000000
          Top = 17.007874020000000000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[AVG(<frxRelatorio."CTR_DIAATR">,rlbDetalhes)]')
          ParentFont = False
        end
      end
      object ReportSummary2: TfrxReportSummary
        FillType = ftBrush
        Height = 86.311070000000000000
        Top = 634.961040000000000000
        Width = 1190.551950000000000000
        OnBeforePrint = 'ReportSummary2OnBeforePrint'
        object Memo154: TfrxMemoView
          Left = 598.677165350000000000
          Top = 3.779527559055170000
          Width = 249.600000000000000000
          Height = 17.007874015748000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Left = 1.461410000000000000
          Top = 28.397650000000000000
          Width = 1179.968377010000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllValG01Cnd: TfrxMemoView
          Left = 942.236220470000000000
          Top = 3.677180000000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG01CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValG02Cnd: TfrxMemoView
          Left = 1024.251968500000000000
          Top = 3.677180000000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG02CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValG03Cnd: TfrxMemoView
          Left = 1106.645669290000000000
          Top = 3.677180000000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllValG03CndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotVencCnd: TfrxMemoView
          Left = 735.362710000000000000
          Top = 32.574830000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL VENCIDO:')
          ParentFont = False
        end
        object rllTotAVencCnd: TfrxMemoView
          Left = 727.362710000000000000
          Top = 50.252010000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL A VENCER:')
          ParentFont = False
        end
        object rllTotRecebCnd: TfrxMemoView
          Left = 727.362710000000000000
          Top = 67.929190000000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL RECEBIDO:')
          ParentFont = False
        end
        object rllTotRecCnd: TfrxMemoView
          Left = 860.410020000000000000
          Top = 68.102359760000000000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTotRecCndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTREC]')
          ParentFont = False
        end
        object rllTotAVenCnd: TfrxMemoView
          Left = 860.410020000000000000
          Top = 50.338582679999900000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTAVE]')
          ParentFont = False
        end
        object rllTotVenCnd: TfrxMemoView
          Left = 860.410020000000000000
          Top = 32.574830000000000000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTVEN]')
          ParentFont = False
        end
        object rllValGBrCnd: TfrxMemoView
          Left = 859.842519690000000000
          Top = 3.677180000000000000
          Width = 81.637795280000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VLRBRU">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Top = 3.779527560000020000
          Width = 151.181102360000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            'M'#201'DIA ATRASO GERAL:')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
        object Memo22: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 162.519685039370000000
          Top = 3.779527560000020000
          Width = 120.944960000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            '[AVG(<frxRelatorio."CTR_DIAATR">,rlbDetalhesCnd)]')
          ParentFont = False
          WordWrap = False
          Wysiwyg = False
        end
      end
      object rlbRodapeCnd: TfrxPageFooter
        FillType = ftBrush
        Height = 41.559060000000000000
        Top = 744.567410000000000000
        Width = 1190.551950000000000000
        object Memo164: TfrxMemoView
          Left = 9.600000000000000000
          Top = 12.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpressoCnd: TfrxMemoView
          Left = 444.699010000000000000
          Top = 12.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoCndOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhesCnd)]')
        end
      end
    end
    object qckResumo: TfrxReportPage
      PaperWidth = 335.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637795275600000
        Top = 336.378170000000000000
        Width = 1190.551950000000000000
        DataSet = frxDBResumo
        DataSetName = 'frxDBResumo'
        RowCount = 0
        object Memo967: TfrxMemoView
          Left = 1.000000000000000000
          Width = 1186.772420000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo127: TfrxMemoView
          Left = 11.111750000000000000
          Top = 1.000000000000000000
          Width = 625.814100000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBResumo."CODCLI"] - [frxDBResumo."NOMCLI"]')
        end
        object Memo129: TfrxMemoView
          Left = 647.612430000000000000
          Top = 1.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FormatMaskText('#39'(00)0000-0000;0'#39',<frxDBResumo."FONE01">)]')
        end
        object Memo133: TfrxMemoView
          Left = 868.535433070000000000
          Top = 1.000000000000000000
          Width = 119.433070870000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBResumo."VALDUP"]')
        end
        object Memo135: TfrxMemoView
          Left = 1057.133858270000000000
          Top = 1.000000000000000000
          Width = 123.212598430000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBResumo."VLRCOR"]')
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Height = 41.559060000000000000
        Top = 491.338900000000000000
        Width = 1190.551950000000000000
        object Memo90: TfrxMemoView
          Left = 9.600000000000000000
          Top = 12.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object Memo991: TfrxMemoView
          Left = 444.699010000000000000
          Top = 12.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterData2)]')
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 291.023810000000000000
        Width = 1190.551950000000000000
        ReprintOnNewPage = True
        object Shape4: TfrxShapeView
          Width = 1188.661414880000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo131: TfrxMemoView
          Left = 9.600000000000000000
          Width = 69.543299760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          Left = 650.623500000000000000
          Width = 148.006370000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TELEFONE')
          ParentFont = False
        end
        object Memo150: TfrxMemoView
          Left = 854.357390000000000000
          Width = 134.173250310000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo152: TfrxMemoView
          Left = 1059.207730000000000000
          Width = 122.834660310000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. CORRIGIDO')
          ParentFont = False
        end
      end
      object PageHeader2: TfrxPageHeader
        FillType = ftBrush
        Height = 211.574830000000000000
        Top = 18.897650000000000000
        Width = 1190.551950000000000000
        object Memo107: TfrxMemoView
          Align = baCenter
          Left = 180.661875000000500000
          Top = 17.000000000000000000
          Width = 829.228199999999000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
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
        end
        object Memo108: TfrxMemoView
          Align = baCenter
          Left = 209.499630000000000000
          Top = 34.000000000000000000
          Width = 771.552690000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO SINTETICO - [NOMREL]')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          Left = 1069.069140000000000000
          Top = 15.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo110: TfrxMemoView
          Left = 1117.069140000000000000
          Top = 32.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo111: TfrxMemoView
          Left = 986.448670000000000000
          Top = 32.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo112: TfrxMemoView
          Align = baCenter
          Left = 46.299475000000000000
          Top = 51.000000000000000000
          Width = 1097.953000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Memo113: TfrxMemoView
          Left = 9.448818900000000000
          Top = 85.039370078740200000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCLI]')
        end
        object Memo114: TfrxMemoView
          Left = 595.275590551181100000
          Top = 102.047244094488000000
          Width = 588.094488188976000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILCID]')
        end
        object Memo115: TfrxMemoView
          Left = 9.448818900000000000
          Top = 102.047244094488000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILPOR]')
        end
        object Memo116: TfrxMemoView
          Left = 9.448818900000000000
          Top = 153.070866141732000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILEMP]')
        end
        object Memo117: TfrxMemoView
          Left = 9.448818900000000000
          Top = 170.078740157480000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILEVE]')
        end
        object Memo118: TfrxMemoView
          Left = 595.275590551181100000
          Top = 136.062992125984000000
          Width = 588.094488188976000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILDUP]')
        end
        object Memo119: TfrxMemoView
          Left = 595.275590551181100000
          Top = 153.070866141732000000
          Width = 588.094488188976000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILORD]')
        end
        object Memo120: TfrxMemoView
          Left = 595.275590551181100000
          Top = 119.055118110236000000
          Width = 588.094488188976000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILVEN]')
        end
        object Memo121: TfrxMemoView
          Left = 9.448818900000000000
          Top = 187.086614173228000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILESP]')
        end
        object Memo122: TfrxMemoView
          Left = 595.275590551181100000
          Top = 170.078740160000000000
          Width = 588.094488190000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILTIP]')
        end
        object Memo123: TfrxMemoView
          Left = 595.275590550000000000
          Top = 85.039370080000000000
          Width = 588.094488190000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILSTA]')
        end
        object Memo124: TfrxMemoView
          Left = 9.448818900000000000
          Top = 119.055118110236000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORCLI]')
        end
        object Memo125: TfrxMemoView
          Left = 9.448818900000000000
          Top = 136.062992125984000000
          Width = 557.782560000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PORBAI]')
        end
        object Memo34: TfrxMemoView
          Left = 595.275590550000000000
          Top = 187.086614170000000000
          Width = 588.018800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILVLD]')
        end
      end
      object ReportSummary3: TfrxReportSummary
        FillType = ftBrush
        Height = 52.295300000000000000
        Top = 415.748300000000000000
        Width = 1190.551950000000000000
        OnBeforePrint = 'ReportSummary3OnBeforePrint'
        object Memo136: TfrxMemoView
          Left = 592.362090000000000000
          Top = 3.118119999999980000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
        end
        object Line95: TfrxLineView
          Left = 4.800000000000000000
          Top = 26.177180000000100000
          Width = 1179.968377010000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo137: TfrxMemoView
          Left = 868.535433070000000000
          Top = 3.118119999999980000
          Width = 119.433070870000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBResumo."VALDUP">,MasterData2)]')
        end
        object Memo139: TfrxMemoView
          Left = 1057.133858270000000000
          Top = 3.118119999999980000
          Width = 123.212598430000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBResumo."VLRCOR">,MasterData2)]')
        end
      end
    end
  end
end
