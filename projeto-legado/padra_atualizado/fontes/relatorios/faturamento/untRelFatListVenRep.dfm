inherited frmRelFatListVenRep: TfrmRelFatListVenRep
  Left = 310
  Top = 90
  Width = 505
  Height = 847
  Caption = 'Relat'#243'rio de Vendas para Reposi'#231#227'o'
  ExplicitWidth = 505
  ExplicitHeight = 847
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 776
    Width = 499
    ExplicitTop = 776
    ExplicitWidth = 499
    inherited FlwBotoes: TFlowPanel
      Width = 418
      ExplicitWidth = 418
      object btnAltOrc: TBitBtnLocked
        Left = 154
        Top = 0
        Width = 154
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Alterar Or'#231'amento/Pedido'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
          055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
          005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
          B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
          305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
          305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
          30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
          3055577777555557F7F555000555555999555577755555577755}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnAltOrcClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 420
      ExplicitLeft = 420
    end
  end
  inherited pnlStatus: TPanel
    Top = 802
    Width = 499
    ExplicitTop = 802
    ExplicitWidth = 499
    inherited pnlNomeForm: TPanel
      Left = 328
      TabOrder = 1
      ExplicitLeft = 328
    end
    inherited pnlInfo: TPanel
      Width = 328
      TabOrder = 0
      ExplicitWidth = 328
    end
  end
  inherited pnlDados: TPanel
    Width = 499
    Height = 776
    ExplicitWidth = 499
    ExplicitHeight = 776
    object Label5: TLabel [0]
      Left = 8
      Top = 4
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
      Left = 169
      Top = 38
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
      Left = 86
      Top = 4
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
    object Label9: TLabel [3]
      Left = 8
      Top = 78
      Width = 59
      Height = 14
      Caption = 'Linha/Grupo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [4]
      Left = 8
      Top = 113
      Width = 37
      Height = 14
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel [5]
      Left = 8
      Top = 323
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
    object Label12: TLabel [6]
      Left = 8
      Top = 358
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
    object Label11: TLabel [7]
      Left = 8
      Top = 218
      Width = 30
      Height = 14
      Caption = 'Marca'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [8]
      Left = 397
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
    object lblEmpresa: TLabel [9]
      Left = 8
      Top = 463
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
    object Label1: TLabel [10]
      Left = 8
      Top = 253
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
    object lblDescricao: TLabel [11]
      Left = 8
      Top = 393
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [12]
      Left = 8
      Top = 428
      Width = 53
      Height = 14
      Caption = 'Refer'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel [13]
      Left = 343
      Top = 428
      Width = 21
      Height = 14
      Caption = 'Unid'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel [14]
      Left = 8
      Top = 288
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
    object Label14: TLabel [15]
      Left = 199
      Top = 218
      Width = 91
      Height = 14
      Caption = 'Grupo de Compras'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel [16]
      Left = 8
      Top = 183
      Width = 94
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Produtos:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel [17]
      Left = 8
      Top = 41
      Width = 52
      Height = 14
      Caption = 'Hora Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel [18]
      Left = 86
      Top = 41
      Width = 48
      Height = 14
      Caption = 'Hora Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel [19]
      Left = 8
      Top = 148
      Width = 67
      Height = 14
      Caption = 'Departamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 393
      Top = 574
      Width = 96
      Height = 71
      TabOrder = 39
      ExplicitLeft = 393
      ExplicitTop = 574
      ExplicitWidth = 96
      ExplicitHeight = 71
      inherited ColorLabel1: TColorLabel
        Top = 18
        Width = 36
        Caption = '(V)'#237'deo'
        ExplicitTop = 18
        ExplicitWidth = 36
      end
      object ColorLabel4: TColorLabel [1]
        Left = 28
        Top = 32
        Width = 62
        Height = 14
        Caption = '(I)mpressora'
        CorDestaque = clRed
      end
      object ColorLabel5: TColorLabel [2]
        Left = 28
        Top = 47
        Width = 34
        Height = 14
        Caption = '(E)xcel'
        CorDestaque = clRed
      end
      inherited edtDestino: TEditFocus
        Left = 6
        Top = 28
        ExplicitLeft = 6
        ExplicitTop = 28
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 18
      Width = 76
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
      Left = 86
      Top = 18
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
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 92
      Width = 60
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 6
      Text = ''
      OnEnter = mskLinhaGrupoEnter
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtProdutos: TEditFocus
      Left = 8
      Top = 127
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 8
      OnExit = edtProdutosExit
      OnKeyPress = edtProdutosKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtFornecedor: TEditFocus
      Left = 8
      Top = 337
      Width = 60
      Height = 22
      Alignment = taLeftJustify
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
      OnExit = edtFornecedorExit
      OnKeyPress = edtFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtVendedor: TEditFocus
      Left = 8
      Top = 372
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
      TabOrder = 24
      OnExit = edtVendedorExit
      OnKeyPress = edtVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtMarca: TEditFocus
      Left = 8
      Top = 232
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 14
      OnExit = edtMarcaExit
      OnKeyPress = edtMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object lstClaFis: TMemo
      Left = 392
      Top = 20
      Width = 101
      Height = 479
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
      TabOrder = 5
      WantReturns = False
      WordWrap = False
    end
    object gpbTipo: TGroupBox
      Left = 67
      Top = 503
      Width = 174
      Height = 43
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 32
      object ColorLabel2: TColorLabel
        Left = 29
        Top = 17
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipo: TEditFocus
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
        Text = 'A'
        OnExit = edtTipoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 477
      Width = 32
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
      TabOrder = 29
      OnExit = edtEmpresaExit
      OnKeyPress = edtEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesGrupo: TEditFocus
      Left = 69
      Top = 92
      Width = 317
      Height = 22
      Alignment = taLeftJustify
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
    object edtDesProduto: TEditFocus
      Left = 69
      Top = 127
      Width = 317
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
    object edtDesFornecedor: TEditFocus
      Left = 69
      Top = 337
      Width = 317
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 23
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 69
      Top = 372
      Width = 317
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 25
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMarca: TEditFocus
      Left = 69
      Top = 232
      Width = 128
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 41
      Top = 477
      Width = 345
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 30
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCliente: TEditFocus
      Left = 8
      Top = 267
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 18
      OnExit = edtClienteExit
      OnKeyPress = edtClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 69
      Top = 267
      Width = 317
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescri: TEditFocus
      Left = 8
      Top = 407
      Width = 378
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
      ParentFont = False
      TabOrder = 26
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 8
      Top = 442
      Width = 332
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
      ParentFont = False
      TabOrder = 27
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Left = 343
      Top = 442
      Width = 43
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
      MaxLength = 2
      ParentFont = False
      TabOrder = 28
      OnExit = edtUnidadeExit
      OnKeyPress = edtUnidadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbOrdenar: TGroupBox
      Left = 8
      Top = 546
      Width = 138
      Height = 49
      Caption = 'Ordenar por...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 33
      object lblOrdena: TColorLabel
        Left = 29
        Top = 15
        Width = 106
        Height = 14
        AutoSize = False
        Caption = '(G)rupo + Alfab'#233'tico'
        CorDestaque = clRed
      end
      object ColorLabel3: TColorLabel
        Left = 29
        Top = 28
        Width = 106
        Height = 14
        AutoSize = False
        Caption = '(A)lfab'#233'tico'
        CorDestaque = clRed
      end
      object edtOrdena: TEditFocus
        Tag = 99
        Left = 7
        Top = 19
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'G'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gbpEspecie: TGroupBox
      Left = 8
      Top = 503
      Width = 57
      Height = 43
      Caption = 'Esp'#233'cie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 31
      object edtEspecie: TEditFocus
        Tag = 99
        Left = 14
        Top = 14
        Width = 25
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object chkSupEst: TCheckBox
      Left = 275
      Top = 651
      Width = 186
      Height = 17
      Caption = 'Somente Itens com Super Estoque'
      TabOrder = 46
    end
    object chkSalMat: TCheckBox
      Left = 275
      Top = 669
      Width = 190
      Height = 17
      Caption = 'Somente Itens com saldo na matriz'
      TabOrder = 47
    end
    object chkGerOrc: TCheckBox
      Left = 8
      Top = 651
      Width = 247
      Height = 17
      Caption = 'Gerar Or'#231'amentos/Pedidos p/ Transf. Estoque'
      Enabled = False
      TabOrder = 40
      OnClick = chkGerOrcClick
    end
    object chkIncBon: TCheckBox
      Left = 8
      Top = 669
      Width = 239
      Height = 17
      Caption = 'Incluir as Bonifica'#231#245'es'
      TabOrder = 41
    end
    object rdgEmpresa: TRadioGroup
      Left = 149
      Top = 546
      Width = 92
      Height = 49
      Caption = 'Empresa de...'
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Faturamento'
        'Origem')
      ParentCtl3D = False
      TabOrder = 34
    end
    object edtCodRede: TEditFocus
      Left = 8
      Top = 302
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 20
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
      Left = 69
      Top = 302
      Width = 317
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object prgProBar: TProgressBar
      Left = 1
      Top = 767
      Width = 497
      Height = 8
      Align = alBottom
      Smooth = True
      TabOrder = 51
      Visible = False
    end
    object chkAbaMul: TCheckBox
      Left = 8
      Top = 687
      Width = 263
      Height = 17
      Caption = 'Considerar abastecimento com m'#250'ltiplo de compra'
      TabOrder = 42
      OnEnter = chkAbaMulEnter
      OnExit = chkAbaMulExit
    end
    object rdgLocFis: TRadioGroup
      Left = 247
      Top = 574
      Width = 140
      Height = 71
      Caption = 'Imprimir itens:'
      ItemIndex = 2
      Items.Strings = (
        'Com localiza'#231#227'o f'#237'sica'
        'Sem localiza'#231#227'o f'#237'sica'
        'Todos')
      TabOrder = 38
    end
    object edtGruCmp: TEditFocus
      Left = 199
      Top = 232
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 16
      OnExit = edtGruCmpExit
      OnKeyPress = edtGruCmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesGruCmp: TEditFocus
      Left = 260
      Top = 232
      Width = 126
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkCodFab: TCheckBox
      Left = 275
      Top = 687
      Width = 186
      Height = 17
      Caption = 'Exibir c'#243'digo de f'#225'brica?'
      Enabled = False
      TabOrder = 48
      OnEnter = chkAbaMulEnter
      OnExit = chkAbaMulExit
    end
    object rdgSaldo: TRadioGroup
      Left = 233
      Top = 5
      Width = 152
      Height = 59
      Caption = 'Saldos'
      Columns = 2
      ItemIndex = 3
      Items.Strings = (
        'Positivo'
        'Negativo'
        'Zero'
        'Todos')
      TabOrder = 4
    end
    object chkIncluirFiliais: TCheckBox
      Left = 8
      Top = 705
      Width = 265
      Height = 17
      Caption = 'Incluir Filiais'
      TabOrder = 43
      OnEnter = chkAbaMulEnter
      OnExit = chkAbaMulExit
    end
    object chkEntFut: TCheckBox
      Left = 275
      Top = 703
      Width = 214
      Height = 21
      Caption = 'Incluir Mov. de Entrega Fut. CFOP x922'
      Checked = True
      State = cbChecked
      TabOrder = 49
      WordWrap = True
    end
    object edtCodGruPro: TEditFocus
      Tag = 99
      Left = 8
      Top = 197
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 12
      OnExit = edtCodGruProExit
      OnKeyPress = edtCodGruProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesGruPro: TEditFocus
      Left = 69
      Top = 197
      Width = 317
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object rdgGirEst: TRadioGroup
      Left = 247
      Top = 503
      Width = 242
      Height = 65
      Caption = 'Giro de Estoque - Venda'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'N'#227'o visualizar'
        'Visualizar 3 meses'
        'Visualizar 6 meses'
        'Visualizar 12 meses')
      TabOrder = 35
      OnClick = rdgGirEstClick
    end
    object chkMesAtu: TCheckBox
      Left = 116
      Top = 611
      Width = 125
      Height = 17
      Caption = 'Considerar m'#234's atual'
      Enabled = False
      TabOrder = 37
    end
    object rdgSaldoProduto: TRadioGroup
      Left = 8
      Top = 596
      Width = 91
      Height = 49
      Caption = 'Saldo produto'
      ItemIndex = 0
      Items.Strings = (
        'F'#237'sico'
        'Dispon'#237'vel')
      TabOrder = 36
    end
    object mskHorIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 55
      Width = 76
      Height = 22
      EditMask = '99:99:99;1;_'
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
      Text = '  :  :  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskHorFin: TMaskEditFocus
      Tag = 99
      Left = 86
      Top = 55
      Width = 77
      Height = 22
      Enabled = False
      EditMask = '99:99:99;1;_'
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
      Text = '  :  :  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object chkPedCompraAberto: TCheckBox
      Left = 8
      Top = 724
      Width = 265
      Height = 17
      Caption = 'Considerar pedido de compra em andamento'
      TabOrder = 44
    end
    object chkItensAbaixoMinimo: TCheckBox
      Left = 275
      Top = 724
      Width = 194
      Height = 17
      Caption = 'Somente itens abaixo do m'#237'nimo'
      TabOrder = 50
    end
    object edtDesDepartamento: TEditFocus
      Left = 69
      Top = 162
      Width = 317
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDepartamento: TEditFocus
      Left = 8
      Top = 162
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 10
      OnExit = edtDepartamentoExit
      OnKeyPress = edtDepartamentoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object chkExbDep: TCheckBox
      Left = 8
      Top = 744
      Width = 194
      Height = 17
      Caption = 'Exibir departamento?'
      Enabled = False
      TabOrder = 45
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 312
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 248
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 280
    Top = 248
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 280
    Top = 216
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 248
    Top = 216
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 216
    Top = 216
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 184
    Top = 216
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 152
    Top = 216
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 88
    Top = 216
  end
  inherited frxGen: TfrxUserDataSet
    Left = 120
    Top = 216
  end
  inherited frxDesigner: TfrxDesigner
    Left = 344
    Top = 216
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 376
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 248
  end
  object svdExcel: TSaveDialog
    Filter = 'Arquivos Excel|*.xls'
    Left = 248
    Top = 248
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 88
    Top = 256
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45579.414967777800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      '    qckSintetico.Visible := False;'
      '    qckAnalitico.Visible := False;'
      '    grpSFornecedor.Visible := False;'
      ''
      '    if <TIPO> = '#39'S'#39' then'
      '    begin'
      '        qckSintetico.Visible := True;'
      ''
      '        if <ORDENA> = '#39'F'#39' then'
      '           grpSFornecedor.Visible := True;'
      ''
      '        if <EXB_CODFAB> = '#39'N'#39' then'
      '        begin'
      '            mmoSHCodFabrica.Visible := False;'
      '            mmoSMCodFabrica.Visible := False;'
      ''
      
        '            mmoSHLocSup.Left := mmoSHLocSup.Left + mmoSHCodFabri' +
        'ca.Width;'
      
        '            mmoSMLocSup.Left := mmoSMLocSup.Left + mmoSMCodFabri' +
        'ca.Width;'
      ''
      
        '            mmoSHLocFis.Left := mmoSHLocFis.Left + mmoSHCodFabri' +
        'ca.Width;'
      
        '            mmoSMLocFis.Left := mmoSMLocFis.Left + mmoSMCodFabri' +
        'ca.Width;'
      ''
      
        '            mmoSMCodigo.Width := mmoSMCodigo.Width + mmoSHCodFab' +
        'rica.Width;'
      '        end;'
      ''
      '        if <EXB_SUPEST> = '#39'N'#39' then'
      '        begin'
      '            mmoSHLocSup.Visible := False;'
      '            mmoSMLocSup.Visible := False;'
      ''
      '            mmoSHLocFis.Visible := False;'
      '            mmoSMLocFis.Visible := False;'
      ''
      
        '            mmoSMCodigo.Width := mmoSMCodigo.Width + mmoSMLocSup' +
        '.Width;'
      
        '            mmoSMCodigo.Width := mmoSMCodigo.Width + mmoSMLocFis' +
        '.Width;'
      '        end;'
      ''
      '        if <EXB_CODDEP> = '#39'N'#39' then'
      '        begin'
      '            mmoSHDepartamento.Visible := False;'
      '            mmoSMDepartamento.Visible := False;'
      ''
      
        '            mmoSMMarca.Width := mmoSMMarca.Width + mmoSMDepartam' +
        'ento.Width;'
      '        end;'
      '    end;'
      ''
      '    if <TIPO> = '#39'A'#39' then'
      '       qckAnalitico.Visible := True;'
      ''
      'end.')
    Left = 89
    Top = 310
    Datasets = <
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
    object qckSintetico: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      ColumnWidth = 2.500000000000000000
      LargeDesignHeight = True
      object CabecalhoSintetico: TfrxPageHeader
        FillType = ftBrush
        Height = 205.090600000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        object mmoSCNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 128.428665000000000000
          Top = 5.779542200000000000
          Width = 491.489610000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object mmoSCNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 20.897650000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object mmoSCPagina: TfrxMemoView
          Left = 627.401320940000000000
          Top = 5.779530000000000000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
          ParentFont = False
        end
        object mmoSCEmitido: TfrxMemoView
          Left = 551.811380000000000000
          Top = 24.677180000000000000
          Width = 190.790600000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 3.779530000000000000
          Top = 47.244094488189000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INC_BONIFICACOES]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 359.055350000000000000
          Top = 47.244094488189000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHAGRUPO]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 3.779530000000000000
          Top = 62.252010000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 359.055350000000000000
          Top = 62.252010000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUPO_PRODUTOS]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 3.779530000000000000
          Top = 77.370130000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 359.055350000000000000
          Top = 77.370130000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DESCRICAO]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 3.779530000000000000
          Top = 92.488250000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 359.055350000000000000
          Top = 92.488250000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REFERENCIA]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 359.055350000000000000
          Top = 107.606370000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUPO_COMPRAS]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 3.779530000000000000
          Top = 122.724490000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[UNIDADE]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 359.055350000000000000
          Top = 122.724490000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 137.842610000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 359.055350000000000000
          Top = 137.842610000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 3.779530000000000000
          Top = 152.960730000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESPECIE]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 359.055350000000000000
          Top = 152.960730000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REDE_LOJAS]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 168.078850000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SALDO]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Top = 186.976500000000000000
          Width = 702.992355430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'REFERENTE AO PERIODO DE [DATA_INICIAL] A [DATA_FINAL]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 3.779530000000000000
          Top = 107.606370000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
        end
      end
      object HeaderSintetico: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 22.677165350000000000
        ParentFont = False
        Top = 328.819110000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object shpSH: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 22.677165350000000000
          Fill.BackColor = clScrollBar
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        end
        object mmoSHCodigo: TfrxMemoView
          Top = 3.779530000000000000
          Width = 49.133846060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHDescricao: TfrxMemoView
          Left = 49.133890000000000000
          Top = 3.779530000000000000
          Width = 70.677118980000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHCodFabrica: TfrxMemoView
          Left = 257.008040000000000000
          Top = 3.779530000000000000
          Width = 56.692906060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'D. F'#193'B.')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHLitKil: TfrxMemoView
          Left = 317.480520000000000000
          Top = 3.779530000000000000
          Width = 37.795256060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LTS/KGS')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHSalLojas: TfrxMemoView
          Left = 359.055350000000000000
          Top = 3.779530000000000000
          Width = 49.133846060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SAL. LOJAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHSalMat: TfrxMemoView
          Left = 411.968770000000000000
          Top = 3.779530000000000000
          Width = 41.574786060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SAL. MAT.')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHUnidade: TfrxMemoView
          Left = 529.134200000000000000
          Top = 3.779530000000000000
          Width = 15.118076060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHMarca: TfrxMemoView
          Left = 548.031850000000000000
          Top = 3.779530000000000000
          Width = 60.472426300000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHQtdTotVendida: TfrxMemoView
          Left = 684.094930000000000000
          Top = 3.779530000000000000
          Width = 60.472436060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.TOT.VEN.')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHLocFis: TfrxMemoView
          Left = 124.724490000000000000
          Top = 3.779530000000000000
          Width = 59.338528980000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOCALIZA'#199#195'O')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoSHLocSup: TfrxMemoView
          Left = 188.976500000000000000
          Top = 3.779530000000000000
          Width = 63.118058980000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SUPER ESTOQ.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 457.323130000000000000
          Top = 3.779530000000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PD.TRANSF.ABE')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHDepartamento: TfrxMemoView
          Left = 612.283860000000000000
          Top = 3.779530000000000000
          Width = 71.811016300000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DEPARTAMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 525.354670000000000000
        Width = 748.346940000000000000
        object mmoSFQtdRegs: TfrxMemoView
          Align = baRight
          Left = 495.118430000000000000
          Width = 253.228510000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterDataSintetico, 2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSFNomRel: TfrxMemoView
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'frmRelFatListVenRep')
          ParentFont = False
        end
        object mmoLinhaFinal: TfrxLineView
          Align = baWidth
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterDataSintetico: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 374.173470000000000000
        Width = 748.346940000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmoZebraSin: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 22.677180000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
          ParentFont = False
        end
        object mmoSMCodigo: TfrxMemoView
          Top = 3.779530000000000000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSMCodFabrica: TfrxMemoView
          Left = 257.008040000000000000
          Top = 3.779530000000000000
          Width = 56.692910940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSMLitKil: TfrxMemoView
          Left = 317.480520000000000000
          Top = 3.779530000000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LITROS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSMSalLojas: TfrxMemoView
          Left = 359.055350000000000000
          Top = 3.779530000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSMSalMat: TfrxMemoView
          Left = 411.968770000000000000
          Top = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALMAT"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSMUnidade: TfrxMemoView
          Left = 529.133858267717000000
          Top = 3.779530000000000000
          Width = 15.118100470000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSMMarca: TfrxMemoView
          Left = 548.031850000000000000
          Top = 3.779530000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSMQtdTotVendida: TfrxMemoView
          Left = 684.094930000000000000
          Top = 3.779530000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSMLocFis: TfrxMemoView
          Left = 124.724490000000000000
          Top = 3.779530000000000000
          Width = 60.472440940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSMLocSup: TfrxMemoView
          Left = 188.976500000000000000
          Top = 3.779530000000000000
          Width = 64.251968500000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCSUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 457.323130000000000000
          Top = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TEPEND"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSMDepartamento: TfrxMemoView
          Left = 612.283860000000000000
          Top = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODDEP"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object grpSFornecedor: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 283.464750000000000000
        Width = 748.346940000000000000
        Condition = 'frxRelatorio."NOMFOR"'
        object mmoQSFornecedor: TfrxMemoView
          Top = 3.779530000000000000
          Width = 585.827106060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNECEDOR: [frxRelatorio."NOMFOR"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummarySintetico: TfrxReportSummary
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 457.323130000000000000
        Width = 748.346940000000000000
        object Line1: TfrxLineView
          Align = baWidth
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object mmoSFQtdite: TfrxMemoView
          Left = 653.858690000000000000
          Top = 3.779530000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,MasterDataSintetico)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSFQtdTotVendida: TfrxMemoView
          Left = 472.441250000000000000
          Top = 3.779530000000000000
          Width = 177.637856300000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE VENDIDA GERAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSFTotLit: TfrxMemoView
          Left = 362.834880000000000000
          Top = 3.779530000000000000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,MasterDataSintetico)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSFTotalLitros: TfrxMemoView
          Left = 181.417440000000000000
          Top = 3.779530000000000000
          Width = 177.637856300000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSFTotKil: TfrxMemoView
          Left = 362.834880000000000000
          Top = 22.677180000000000000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,MasterDataSintetico)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSFTotalKilos: TfrxMemoView
          Left = 181.417440000000000000
          Top = 22.677180000000000000
          Width = 177.637856300000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 41.574830000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object qckAnalitico: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      object CabecalhoAnalitico: TfrxPageHeader
        FillType = ftBrush
        Height = 227.767780000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        object mmoSSNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 128.428665000000000000
          Top = 5.779542200000000000
          Width = 491.489610000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object mmoSSNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 20.897650000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object mmoSSPagina: TfrxMemoView
          Left = 627.401320940000000000
          Top = 5.779530000000000000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
          ParentFont = False
        end
        object mmoSSEmitido: TfrxMemoView
          Left = 551.811380000000000000
          Top = 24.677180000000000000
          Width = 190.790600000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
          ParentFont = False
        end
        object mmoSSIncBonificacoes: TfrxMemoView
          Left = 7.559060000000000000
          Top = 62.472480000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INC_BONIFICACOES]')
          ParentFont = False
        end
        object mmoSSLinhaGrupo: TfrxMemoView
          Left = 362.834880000000000000
          Top = 62.472480000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHAGRUPO]')
          ParentFont = False
        end
        object mmoSSVendedor: TfrxMemoView
          Left = 7.559060000000000000
          Top = 79.370130000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
        end
        object mmoSSGrupoProdutos: TfrxMemoView
          Left = 362.834880000000000000
          Top = 79.370130000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUPO_PRODUTOS]')
          ParentFont = False
        end
        object mmoSSProduto: TfrxMemoView
          Left = 7.559060000000000000
          Top = 94.488250000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
        end
        object mmoSSDescricao: TfrxMemoView
          Left = 362.834880000000000000
          Top = 94.488250000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DESCRICAO]')
          ParentFont = False
        end
        object mmoSSMarca: TfrxMemoView
          Left = 7.559060000000000000
          Top = 109.606370000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object mmoSSReferencia: TfrxMemoView
          Left = 362.834880000000000000
          Top = 109.606370000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REFERENCIA]')
          ParentFont = False
        end
        object mmoSSGrupoCompras: TfrxMemoView
          Left = 362.834880000000000000
          Top = 124.724490000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUPO_COMPRAS]')
          ParentFont = False
        end
        object mmoSSUnidade: TfrxMemoView
          Left = 7.559060000000000000
          Top = 139.842610000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[UNIDADE]')
          ParentFont = False
        end
        object mmoSSCliente: TfrxMemoView
          Left = 362.834880000000000000
          Top = 139.842610000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object mmoSSEmpresa: TfrxMemoView
          Left = 7.559060000000000000
          Top = 154.960730000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object mmoSSFornecedor: TfrxMemoView
          Left = 362.834880000000000000
          Top = 154.960730000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
        end
        object mmoSSEspecie: TfrxMemoView
          Left = 7.559060000000000000
          Top = 170.078850000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESPECIE]')
          ParentFont = False
        end
        object mmoSSRedeLojas: TfrxMemoView
          Left = 362.834880000000000000
          Top = 170.078850000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REDE_LOJAS]')
          ParentFont = False
        end
        object mmoSSSaldo: TfrxMemoView
          Left = 7.559060000000000000
          Top = 185.196970000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SALDO]')
          ParentFont = False
        end
        object mmoSSPeriodo: TfrxMemoView
          Left = 7.559060000000000000
          Top = 204.094620000000000000
          Width = 702.992355430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'REFERENTE AO PERIODO DE [DATA_INICIAL] A [DATA_FINAL]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 7.559060000000000000
          Top = 124.724490000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DEPARTAMENTO]')
          ParentFont = False
        end
      end
      object HeaderAnalitico: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 22.677165350000000000
        ParentFont = False
        Top = 306.141930000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 22.677165350000000000
          Fill.BackColor = clScrollBar
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        end
        object Memo4: TfrxMemoView
          Top = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA DOC')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 60.472480000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 143.622140000000000000
          Top = 3.779530000000000000
          Width = 332.598640000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO / NOME DO CLIENTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 480.000310000000000000
          Top = 3.779530000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMPRESA')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 544.252320000000000000
          Top = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 672.756340000000000000
          Top = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. VENDIDA')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 351.496290000000000000
        Width = 748.346940000000000000
        Condition = 'frxRelatorio."CODITE"'
        object Memo1: TfrxMemoView
          Top = 3.779530000000000000
          Width = 445.984496060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PRODUTO: [frxRelatorio."CODITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 612.283860000000000000
          Top = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'GIRO 12 MESES: [frxRelatorio."GIRITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 453.543600000000000000
          Top = 3.779530000000000000
          Width = 151.181200000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PD.TRANSF.ABERTO: [frxRelatorio."TEPEND"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 396.850650000000000000
        Width = 748.346940000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo3: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 22.677180000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Top = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTADOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 60.472480000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 143.622140000000000000
          Top = 3.779530000000000000
          Width = 332.598640000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 480.000310000000000000
          Top = 3.779530000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 544.252320000000000000
          Top = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 672.756340000000000000
          Top = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 442.205010000000000000
        Width = 748.346940000000000000
        object Memo16: TfrxMemoView
          Left = 672.756340000000000000
          Top = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,MasterData1)]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 18.897650000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo19: TfrxMemoView
          Left = 502.677490000000000000
          Top = 3.779530000000000000
          Width = 166.299320000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE VENDIDA:')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 355.275820000000000000
          Top = 3.000000000000000000
          Width = 71.811070000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 185.196970000000000000
          Top = 3.000000000000000000
          Width = 166.299320000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO ATUAL:')
          ParentFont = False
          WordWrap = False
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 525.354670000000000000
        Width = 748.346940000000000000
        object Memo17: TfrxMemoView
          Align = baRight
          Left = 495.118430000000000000
          Width = 253.228510000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterData1, 2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'frmRelFatListVenRep')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
