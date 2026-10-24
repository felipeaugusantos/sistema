inherited frmRelFatComVendedor: TfrmRelFatComVendedor
  Left = 342
  Top = 213
  Width = 447
  Height = 393
  ActiveControl = mskDtaIni
  BorderIcons = [biSystemMenu]
  Caption = 'Comiss'#227'o por Vendedor - Faturamento'
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 14
    Top = 116
    Width = 48
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
  object Label3: TLabel [1]
    Left = 14
    Top = 118
    Width = 42
    Height = 14
    Caption = 'Digitador'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 315
    Width = 439
    TabOrder = 1
    inherited btnSair: TBitBtn
      Left = 358
    end
    inherited btnConfigurar: TBitBtn
      Width = 82
    end
  end
  inherited pnlStatus: TPanel
    Top = 343
    Width = 439
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 268
    end
    inherited pnlInfo: TPanel
      Width = 268
    end
  end
  inherited pnlDados: TPanel
    Width = 439
    Height = 315
    TabOrder = 0
    object Label5: TLabel [0]
      Left = 14
      Top = 7
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
    object Label7: TLabel [1]
      Left = 98
      Top = 28
      Width = 58
      Height = 14
      Caption = '(ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel [2]
      Left = 14
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
    object Label8: TLabel [3]
      Left = 98
      Top = 63
      Width = 58
      Height = 14
      Caption = '(ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVenDig: TLabel [4]
      Left = 14
      Top = 239
      Width = 48
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
    object lblEmpresa: TLabel [5]
      Left = 14
      Top = 277
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
    object Label2: TLabel [6]
      Left = 341
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
    inherited gpbDestino: TGroupBox
      Left = 168
      Top = 137
      Width = 170
      TabOrder = 4
      inherited ColorLabel1: TColorLabel
        Left = 26
      end
      inherited edtDestino: TEditFocus
        Left = 5
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 21
      Width = 77
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
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 56
      Width = 78
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
    object edtCodVendedor: TEditFocus
      Left = 14
      Top = 253
      Width = 57
      Height = 22
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
      TabOrder = 6
      OnExit = edtCodVendedorExit
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtDesVendedor: TEditFocus
      Left = 73
      Top = 253
      Width = 266
      Height = 22
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
      Alignment = taLeftJustify
    end
    object edtCodEmpresa: TEditFocus
      Left = 14
      Top = 291
      Width = 29
      Height = 22
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
      Alignment = taLeftJustify
    end
    object edtDesEmpresa: TEditFocus
      Left = 45
      Top = 291
      Width = 294
      Height = 22
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
      Alignment = taLeftJustify
    end
    object gpbOpcao: TGroupBox
      Left = 14
      Top = 86
      Width = 150
      Height = 150
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 24
        Width = 114
        Height = 14
        Caption = '(1) Calculado na Venda'
        CorDestaque = clRed
      end
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 42
        Width = 103
        Height = 14
        Caption = '(2) % Cad. Vendedor'
        CorDestaque = clRed
      end
      object ColorLabel4: TColorLabel
        Left = 28
        Top = 61
        Width = 98
        Height = 14
        Caption = '(3) % Cad. Produtos'
        CorDestaque = clRed
      end
      object ColorLabel5: TColorLabel
        Left = 28
        Top = 81
        Width = 111
        Height = 14
        Caption = '(4) % Cad. Fornecedor'
        CorDestaque = clRed
      end
      object ColorLabel7: TColorLabel
        Left = 28
        Top = 100
        Width = 68
        Height = 14
        Caption = '(5) % Margem'
        CorDestaque = clRed
      end
      object ColorLabel8: TColorLabel
        Left = 28
        Top = 119
        Width = 76
        Height = 14
        Caption = '(6) % Desconto'
        CorDestaque = clRed
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 7
        Top = 21
        Width = 18
        Height = 22
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = '1'
        OnExit = edtDestinoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        Alignment = taLeftJustify
      end
    end
    object gpbTipo: TGroupBox
      Left = 168
      Top = 86
      Width = 170
      Height = 50
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object ColorLabel6: TColorLabel
        Left = 26
        Top = 24
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipo: TEditFocus
        Tag = 99
        Left = 5
        Top = 21
        Width = 18
        Height = 22
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Alignment = taLeftJustify
      end
    end
    object lstClaFis: TMemo
      Left = 342
      Top = 20
      Width = 91
      Height = 293
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
      TabOrder = 10
      WantReturns = False
      WordWrap = False
    end
    object gpbVendedor: TGroupBox
      Left = 168
      Top = 188
      Width = 170
      Height = 48
      Caption = 'Op'#231#227'o de Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object lblVendedor: TColorLabel
        Left = 25
        Top = 18
        Width = 139
        Height = 14
        Caption = '(1)Vend. (2)Vend. 2  (3) Dig.'
        CorDestaque = clRed
      end
      object edtVendedor: TEditFocus
        Tag = 99
        Left = 5
        Top = 15
        Width = 18
        Height = 22
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = '1'
        OnChange = edtVendedorChange
        OnExit = edtDestinoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        Alignment = taLeftJustify
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 456
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 456
  end
end
