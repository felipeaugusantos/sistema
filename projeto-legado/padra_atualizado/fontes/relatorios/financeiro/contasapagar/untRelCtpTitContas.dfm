inherited frmRelCtpTitContas: TfrmRelCtpTitContas
  Left = 326
  Top = 146
  Width = 570
  Height = 542
  Caption = 'Relat'#243'rio de Titulos por Plano de Contas'
  OnDestroy = FormDestroy
  ExplicitWidth = 570
  ExplicitHeight = 542
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 470
    Width = 564
    ExplicitTop = 470
    ExplicitWidth = 564
    inherited btnSair: TBitBtnLocked
      Left = 479
      ExplicitLeft = 479
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 81
      Width = 80
      ExplicitLeft = 81
      ExplicitWidth = 80
    end
  end
  inherited pnlDados: TPanel
    Width = 564
    Height = 470
    ExplicitWidth = 564
    ExplicitHeight = 470
    object Label27: TLabel [0]
      Left = 6
      Top = 260
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
    object Label28: TLabel [1]
      Left = 286
      Top = 260
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
    object lblEmpresa: TLabel [2]
      Left = 286
      Top = 298
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
    object Label1: TLabel [3]
      Left = 6
      Top = 298
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
      Left = 388
      Top = 194
      Width = 103
      Height = 14
      Caption = 'Final Plano de Contas'
      WordWrap = True
    end
    object Label12: TLabel [5]
      Left = 6
      Top = 333
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [6]
      Left = 6
      Top = 371
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
    object Label8: TLabel [7]
      Left = 454
      Top = 214
      Width = 84
      Height = 14
      Caption = '(3 '#250'ltimos d'#237'gitos)'
      WordWrap = True
    end
    object Label9: TLabel [8]
      Left = 388
      Top = 159
      Width = 62
      Height = 14
      Caption = 'Compet'#234'ncia'
      WordWrap = True
    end
    object lblPortador: TLabel [9]
      Left = 6
      Top = 408
      Width = 41
      Height = 14
      Caption = 'Portador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 352
      Top = 8
      Width = 205
      TabOrder = 2
      ExplicitLeft = 352
      ExplicitTop = 8
      ExplicitWidth = 205
      inherited ColorLabel1: TColorLabel
        Top = 19
        Width = 168
        Caption = '(V)'#237'deo (I)mpressora (E)xcel (C)sv'
        ExplicitTop = 19
        ExplicitWidth = 168
      end
    end
    object gpbContas: TGroupBox
      Left = 163
      Top = 8
      Width = 184
      Height = 45
      Caption = 'Contas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
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
    object gpbBoleto: TGroupBox
      Left = 6
      Top = 53
      Width = 153
      Height = 45
      Caption = 'Veio Boleto?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 19
        Width = 96
        Height = 14
        Caption = '(T)odos (S)im (N)'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object edtBoleto: TEditFocus
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
    object gpbRelatorio: TGroupBox
      Left = 6
      Top = 8
      Width = 153
      Height = 45
      Caption = 'Tipo de Relat'#243'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object ColorLabel5: TColorLabel
        Left = 28
        Top = 19
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtRelatorio: TEditFocus
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
        Text = 'A'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object mskContaIni: TMaskEditFocus
      Tag = 99
      Left = 6
      Top = 274
      Width = 62
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
      TabOrder = 14
      Text = ''
      OnExit = mskContaIniExit
      OnKeyPress = mskContaIniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskContaFin: TMaskEditFocus
      Tag = 99
      Left = 286
      Top = 274
      Width = 62
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
      TabOrder = 16
      Text = ''
      OnExit = mskContaFinExit
      OnKeyPress = mskContaFinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 286
      Top = 311
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 20
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
      Left = 70
      Top = 274
      Width = 195
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
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesContaFin: TEditFocus
      Left = 350
      Top = 274
      Width = 203
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
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 350
      Top = 311
      Width = 203
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
      TabOrder = 21
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEve: TEditFocus
      Left = 6
      Top = 311
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 18
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
      Left = 70
      Top = 311
      Width = 195
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbForHis: TGroupBox
      Left = 6
      Top = 112
      Width = 153
      Height = 45
      Caption = 'Op'#231#227'o de Hist'#243'rico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object ColorLabel6: TColorLabel
        Left = 28
        Top = 19
        Width = 117
        Height = 14
        Caption = '(F)ornecedor (H)ist'#243'rico'
        CorDestaque = clRed
      end
      object edtForHis: TEditFocus
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
        Text = 'F'
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
    object gpbOrdem: TGroupBox
      Left = 352
      Top = 53
      Width = 204
      Height = 104
      Caption = 'Ordem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      object ColorLabel7: TColorLabel
        Left = 27
        Top = 11
        Width = 150
        Height = 16
        AutoSize = False
        Caption = '(1) Plano de Contas - C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object ColorLabel8: TColorLabel
        Left = 27
        Top = 26
        Width = 156
        Height = 14
        AutoSize = False
        Caption = '(2) Plano de Contas - Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object ColorLabel9: TColorLabel
        Left = 27
        Top = 41
        Width = 120
        Height = 14
        AutoSize = False
        Caption = '(3) Contas de Resultado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object ColorLabel4: TColorLabel
        Left = 27
        Top = 56
        Width = 120
        Height = 14
        AutoSize = False
        Caption = '(4) Evento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object lblData: TColorLabel
        Left = 27
        Top = 71
        Width = 130
        Height = 14
        AutoSize = False
        Caption = '(5) Data de Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object ColorLabel10: TColorLabel
        Left = 27
        Top = 86
        Width = 130
        Height = 14
        AutoSize = False
        Caption = '(6) Fornecedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
        Tag = 99
        Left = 7
        Top = 40
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
        Text = '1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object GroupBox1: TGroupBox
      Left = 6
      Top = 159
      Width = 121
      Height = 100
      Caption = 'CADASTRO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object Label25: TLabel
        Left = 7
        Top = 16
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
      object Label26: TLabel
        Left = 7
        Top = 51
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
      object mskDtaIniC: TMaskEditFocus
        Tag = 99
        Left = 7
        Top = 30
        Width = 87
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
      object mskDtaFinC: TMaskEditFocus
        Tag = 99
        Left = 7
        Top = 65
        Width = 88
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
    end
    object GroupBox2: TGroupBox
      Left = 258
      Top = 159
      Width = 121
      Height = 100
      Caption = 'PAGAMENTO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      object Label2: TLabel
        Left = 7
        Top = 16
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
      object Label3: TLabel
        Left = 7
        Top = 51
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
      object mskDtaIniP: TMaskEditFocus
        Tag = 99
        Left = 7
        Top = 30
        Width = 87
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
      object mskDtaFinP: TMaskEditFocus
        Tag = 99
        Left = 7
        Top = 65
        Width = 88
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
    end
    object GroupBox3: TGroupBox
      Left = 132
      Top = 159
      Width = 121
      Height = 100
      Caption = 'VENCIMENTO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object Label4: TLabel
        Left = 7
        Top = 16
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
      object Label5: TLabel
        Left = 7
        Top = 51
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
      object mskDtaIniV: TMaskEditFocus
        Tag = 99
        Left = 7
        Top = 30
        Width = 87
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
      object mskDtaFinV: TMaskEditFocus
        Tag = 99
        Left = 7
        Top = 65
        Width = 88
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
    end
    object chkBaiCarCredito: TCheckBox
      Left = 388
      Top = 230
      Width = 145
      Height = 29
      Caption = 'Incluir Baixas de Cart'#227'o de Cr'#233'dito?'
      Checked = True
      State = cbChecked
      TabOrder = 13
      WordWrap = True
    end
    object edtFimCta: TEditFocus
      Left = 387
      Top = 207
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object gpbIncPrevis: TGroupBox
      Left = 163
      Top = 52
      Width = 184
      Height = 60
      Caption = 'Gerar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object lbl1: TColorLabel
        Left = 43
        Top = 9
        Width = 97
        Height = 14
        Caption = 'Apenas (P)revis'#245'es'
        CorDestaque = clRed
      end
      object lbl2: TColorLabel
        Left = 43
        Top = 25
        Width = 80
        Height = 14
        Caption = '(S)em Previs'#245'es'
        CorDestaque = clRed
      end
      object lbl3: TColorLabel
        Left = 43
        Top = 42
        Width = 38
        Height = 14
        Caption = '(T)odos'
        CorDestaque = clRed
      end
      object edtIncPrevis: TEditFocus
        Tag = 99
        Left = 7
        Top = 24
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'T'
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
    object edtCodFornecedor: TEditFocus
      Left = 6
      Top = 347
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 22
      OnExit = edtCodFornecedorExit
      OnKeyPress = edtCodFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 72
      Top = 347
      Width = 481
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
      TabOrder = 23
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkQuePagEve: TCheckBox
      Tag = 99
      Left = 6
      Top = 448
      Width = 155
      Height = 17
      Caption = 'Quebrar p'#225'gina por Evento'
      Enabled = False
      TabOrder = 28
    end
    object chkQuePagFor: TCheckBox
      Tag = 99
      Left = 378
      Top = 448
      Width = 174
      Height = 17
      Caption = 'Quebrar p'#225'gina por Fornecedor'
      Enabled = False
      TabOrder = 29
    end
    object gpbValorExibido: TGroupBox
      Left = 163
      Top = 112
      Width = 184
      Height = 45
      Caption = 'Valor a ser exibido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object ColorLabel11: TColorLabel
        Left = 31
        Top = 19
        Width = 132
        Height = 14
        Caption = '(1)Vlr. Liquido (2) Vlr. Bruto'
        CorDestaque = clRed
      end
      object edtValorExibido: TEditFocus
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
        Text = '1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttInteiro
      end
    end
    object edtCodPorBai: TEditFocus
      Tag = 99
      Left = 6
      Top = 385
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 24
      OnKeyPress = edtCodPorBaiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorBai: TEditFocus
      Left = 72
      Top = 385
      Width = 481
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
      TabOrder = 25
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskCompet: TMaskEditFocus
      Tag = 99
      Left = 387
      Top = 172
      Width = 62
      Height = 22
      EditMask = '99/9999;1;_'
      MaxLength = 7
      TabOrder = 11
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 6
      Top = 422
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 26
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
    object edtDesPortador: TEditFocus
      Left = 72
      Top = 422
      Width = 481
      Height = 22
      TabStop = False
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
      ReadOnly = True
      TabOrder = 27
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
    Top = 498
    Width = 564
    ExplicitTop = 498
    ExplicitWidth = 564
    inherited pnlNomeForm: TPanel
      Left = 393
      ExplicitLeft = 393
    end
    inherited pnlInfo: TPanel
      Width = 393
      ExplicitWidth = 393
      inherited shpMultSel: TShape
        Left = 374
        ExplicitLeft = 374
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 672
    Top = 240
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 680
    Top = 104
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 456
    Top = 304
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 672
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 832
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 800
    Top = 40
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 768
    Top = 40
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 736
    Top = 40
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 672
    Top = 40
  end
  inherited frxGen: TfrxUserDataSet
    Left = 704
    Top = 40
  end
  inherited frxDesigner: TfrxDesigner
    Left = 736
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 768
  end
  object svdExcel: TSaveDialog
    FileName = 'Rel Titulos por Conta'
    Filter = 'Arquivos Excel|*.xls'
    Left = 504
    Top = 264
  end
end
