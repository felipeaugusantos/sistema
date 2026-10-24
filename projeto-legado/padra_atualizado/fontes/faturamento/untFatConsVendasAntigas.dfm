inherited frmFatConsVendasAntigas: TfrmFatConsVendasAntigas
  Width = 937
  Height = 600
  Caption = 'Vendas do Sistema Anterior'
  Position = poMainFormCenter
  ExplicitWidth = 937
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 921
    Height = 26
    TabOrder = 1
    ExplicitTop = 519
    ExplicitWidth = 921
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 799
      Height = 22
      ExplicitWidth = 799
      ExplicitHeight = 22
      inherited btnPesquisar: TBitBtnLocked
        Width = 118
        ExplicitWidth = 118
      end
      object btnDadosComp: TBitBtnLocked
        Left = 236
        Top = 0
        Width = 175
        Height = 22
        Caption = '[ F6 ] &Dados Complementares'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000333333FF333333FF0000
          0000000000000000000000000000000000000000000000000000000000003333
          33FF333333FF333333FF333333FF333333FF333333FF0F0F0F4D0F0F0F4D3333
          33FF333333FF333333FF333333FF333333FF333333FF00000000000000003333
          33FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000333333FF00000000000000003333
          33FF00000000242424B3242424B3242424B3242424B300000000000000002424
          24B3242424B3242424B3242424B300000000333333FF00000000000000003333
          33FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000333333FF00000000000000003333
          33FF00000000242424B3242424B3242424B3242424B300000000000000002424
          24B3242424B3242424B3242424B300000000333333FF00000000000000003333
          33FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000333333FF00000000000000003333
          33FF00000000242424B3242424B3242424B3242424B300000000000000002424
          24B3242424B3242424B3242424B300000000333333FF00000000000000003333
          33FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000333333FF00000000000000003333
          33FF00000000242424B3242424B3242424B3242424B300000000000000002424
          24B3242424B3242424B3242424B300000000333333FF00000000000000003333
          33FF0000000000000000000000000000000000000000333333FF333333FF0000
          000000000000000000000000000000000000333333FF00000000000000003333
          33FF333333FF333333FF333333FF333333FF333333FF0F0F0F4D0F0F0F4D3333
          33FF333333FF333333FF333333FF333333FF333333FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 2
        Visible = False
        OnClick = btnDadosCompClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 801
      Top = 2
      Width = 118
      Align = alRight
      ExplicitLeft = 801
      ExplicitTop = 2
      ExplicitWidth = 118
    end
  end
  inherited pnlHeader: TPanel
    Width = 921
    Height = 191
    TabOrder = 0
    ExplicitWidth = 921
    ExplicitHeight = 191
    object lbl1: TLabel
      Left = 280
      Top = 1
      Width = 35
      Height = 14
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 14
      Top = 76
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
    object lbl11: TLabel
      Left = 328
      Top = 76
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
    object lbl12: TLabel
      Left = 14
      Top = 114
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object lbl13: TLabel
      Left = 329
      Top = 114
      Width = 53
      Height = 14
      Caption = 'Refer'#234'ncia'
    end
    object lbl14: TLabel
      Left = 476
      Top = 115
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
    object lbl15: TLabel
      Left = 14
      Top = 1
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
    object lbl16: TLabel
      Left = 83
      Top = 19
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
    object lbl17: TLabel
      Left = 147
      Top = 1
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
    object lbl18: TLabel
      Left = 216
      Top = 19
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
    object lbl2: TLabel
      Left = 299
      Top = 152
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
    object lblNumDoc: TLabel
      Left = 684
      Top = 152
      Width = 54
      Height = 14
      Caption = 'Documento'
    end
    object lblEspDoc: TLabel
      Left = 765
      Top = 153
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
    end
    object Label13: TLabel
      Left = 14
      Top = 37
      Width = 118
      Height = 14
      Caption = 'Consumidor (CGC / CPF)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 328
      Top = 37
      Width = 95
      Height = 14
      Caption = 'Consumidor (Nome)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 14
      Top = 153
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
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 280
      Top = 15
      Width = 67
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
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 347
      Top = 15
      Width = 554
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 90
      Width = 63
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
      TabOrder = 5
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
      Tag = 99
      Left = 328
      Top = 90
      Width = 67
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
      TabOrder = 6
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
    object edtDesGrupo: TEditFocus
      Left = 80
      Top = 90
      Width = 242
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
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
      Left = 395
      Top = 90
      Width = 506
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescri: TEditFocus
      Left = 14
      Top = 128
      Width = 308
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 328
      Top = 128
      Width = 147
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 476
      Top = 128
      Width = 51
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
      TabOrder = 11
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMar: TEditFocus
      Left = 528
      Top = 128
      Width = 373
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 15
      Width = 64
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
      Left = 147
      Top = 15
      Width = 65
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
    object btnFiltrar: TBitBtnLocked
      Left = 816
      Top = 166
      Width = 85
      Height = 22
      Caption = '&Consultar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
        1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
        7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
        E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
        EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
        8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 18
      OnClick = btnFiltrarClick
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 299
      Top = 166
      Width = 65
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
      TabOrder = 14
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtNomEmp: TEditFocus
      Left = 365
      Top = 166
      Width = 313
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    object edtNumDoc: TEditFocus
      Left = 683
      Top = 166
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Left = 764
      Top = 166
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object edtCodCliCon: TEditFocus
      Tag = 99
      Left = 14
      Top = 52
      Width = 118
      Height = 22
      Hint = 
        'Campo "Cliente" deve estar preenchido com o c'#243'digo do "Cliente C' +
        'onsumidor"'
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 18
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnKeyPress = edtCodCliConKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 18
      TipoTexto = ttNumerico
    end
    object edtConNom: TEditFocus
      Left = 328
      Top = 52
      Width = 573
      Height = 22
      Hint = 
        'Campo "Cliente" deve estar preenchido com o c'#243'digo do "Cliente C' +
        'onsumidor"'
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomCliCon: TEditFocus
      Tag = 99
      Left = 135
      Top = 52
      Width = 187
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodRede: TEditFocus
      Tag = 99
      Left = 14
      Top = 166
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 13
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
      Left = 80
      Top = 166
      Width = 213
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
  end
  inherited pnlTail: TPanel
    Top = 349
    Width = 921
    Height = 170
    Visible = True
    ExplicitTop = 349
    ExplicitWidth = 921
    ExplicitHeight = 170
    object lbl4: TLabel
      Left = 47
      Top = 8
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 68
      Top = 31
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 479
      Top = 31
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 39
      Top = 78
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mensagem:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 13
      Top = 124
      Width = 91
      Height = 14
      Alignment = taRightJustify
      Caption = 'Condi'#231#227'o Pagto.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl10: TLabel
      Left = 437
      Top = 124
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = 'Formas de Pagto.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCodCli: TLabel
      Left = 62
      Top = 147
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblFornecedor: TLabel
      Left = 37
      Top = 55
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtDesItem: TEditFocus
      Left = 106
      Top = 4
      Width = 795
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMarca: TEditFocus
      Left = 106
      Top = 27
      Width = 367
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtVendedor: TEditFocus
      Left = 538
      Top = 27
      Width = 363
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMens001: TEditFocus
      Left = 106
      Top = 74
      Width = 795
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMens002: TEditFocus
      Left = 106
      Top = 97
      Width = 795
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCndPgto: TEditFocus
      Left = 106
      Top = 120
      Width = 325
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFormas: TEditFocus
      Left = 538
      Top = 120
      Width = 363
      Height = 22
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
    object edtCliente: TEditFocus
      Left = 106
      Top = 143
      Width = 795
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFornecedor: TEditFocus
      Left = 106
      Top = 51
      Width = 795
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 231
    Width = 929
    Height = 58
    Align = alNone
    DataSource = nil
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OnEnter = dbgConsultaEnter
  end
  inherited pnlPesquisa: TPanel
    Top = 191
    Width = 921
    ExplicitTop = 191
    ExplicitWidth = 921
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      Width = 489
      ExplicitTop = 9
      ExplicitWidth = 489
    end
    inherited edtValor: TEditFocus
      Left = 792
      Top = 9
      ExplicitLeft = 792
      ExplicitTop = 9
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 921
    TabOrder = 2
    ExplicitTop = 545
    ExplicitWidth = 921
    inherited pnlNomeForm: TPanel
      Left = 750
      ExplicitLeft = 750
    end
    inherited pnlInfo: TPanel
      Width = 750
      ExplicitWidth = 750
    end
  end
  object dbgItens: TcxGrid [7]
    Left = 0
    Top = 231
    Width = 921
    Height = 118
    Align = alClient
    TabOrder = 7
    TabStop = False
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgItensDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsulta
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object GER_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'GER_CODEMP'
      end
      object GER_DTAENT: TcxGridDBColumn
        Caption = 'Data Ent.'
        DataBinding.FieldName = 'GER_DTAENT'
      end
      object GER_NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'GER_NUMDOC'
      end
      object GER_ESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'GER_ESPDOC'
      end
      object GER_NOMCLI: TcxGridDBColumn
        Caption = 'Nome Cliente'
        DataBinding.FieldName = 'GER_NOMCLI'
        Width = 166
      end
      object DET_CODITE: TcxGridDBColumn
        Caption = 'C'#243'd.Item'
        DataBinding.FieldName = 'DET_CODITE'
      end
      object DET_DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DET_DESCRI'
        Width = 135
      end
      object DET_QTDITE: TcxGridDBColumn
        Caption = 'Quant.'
        DataBinding.FieldName = 'DET_QTDITE'
        HeaderAlignmentHorz = taRightJustify
      end
      object DET_UNITAR: TcxGridDBColumn
        Caption = 'Vr. Unit.'
        DataBinding.FieldName = 'DET_UNITAR'
        HeaderAlignmentHorz = taRightJustify
      end
      object DET_TOTITE: TcxGridDBColumn
        Caption = 'Vr. Total'
        DataBinding.FieldName = 'DET_TOTITE'
        HeaderAlignmentHorz = taRightJustify
      end
      object DET_TOTCUS: TcxGridDBColumn
        Caption = 'Vr. Custo'
        DataBinding.FieldName = 'DET_TOTCUS'
        HeaderAlignmentHorz = taRightJustify
      end
    end
    object dbgItensLevel1: TcxGridLevel
      GridView = dbgItensDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 681
    Top = 490
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 553
    Top = 490
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 144
  end
  inherited qryConsulta: TUniQuery
    Left = 553
    Top = 522
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 617
    Top = 490
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 585
    Top = 490
  end
  inherited dtsConsulta: TDataSource
    Left = 649
    Top = 490
  end
end
