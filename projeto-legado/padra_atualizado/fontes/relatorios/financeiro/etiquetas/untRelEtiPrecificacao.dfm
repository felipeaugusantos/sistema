inherited frmRelEtiPrecificacao: TfrmRelEtiPrecificacao
  Left = 151
  Top = 92
  Width = 800
  Height = 717
  BorderStyle = bsSizeable
  Caption = 'Impress'#227'o de Etiquetas de Precifica'#231#227'o de Produtos'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 717
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 629
    Width = 784
    ExplicitTop = 629
    ExplicitWidth = 784
    DesignSize = (
      784
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 780
      ExplicitWidth = 780
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 662
    Width = 784
    ExplicitTop = 662
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
      object shpMultSel: TShape
        Left = 605
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited pgcDados: TPageControl
    Top = 347
    Width = 784
    Height = 282
    Visible = False
    ExplicitTop = 347
    ExplicitWidth = 784
    ExplicitHeight = 282
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 776
      ExplicitHeight = 250
    end
  end
  object pnlBotoesImp: TPanel [3]
    Left = 0
    Top = 629
    Width = 784
    Height = 33
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    DesignSize = (
      784
      33)
    object btnSairImp: TBitBtnLocked
      Left = 680
      Top = 6
      Width = 100
      Height = 24
      Anchors = [akTop, akRight]
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnSairImpClick
    end
    object btnConfigurar: TBitBtnLocked
      Left = 109
      Top = 6
      Width = 100
      Height = 24
      Anchors = [akLeft, akBottom]
      Caption = '[F6] Configurar'
      TabOrder = 1
      OnClick = btnConfigurarClick
    end
    object btnImprimir: TBitBtnLocked
      Left = 6
      Top = 6
      Width = 100
      Height = 24
      Caption = '&Imprimir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
        8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
        93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
        9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
        678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
        8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
        E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
        8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
        EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
        C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
        C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
        D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
        9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
        B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
        BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
        C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
        C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
        AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnImprimirClick
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 784
    Height = 347
    Align = alTop
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object lbl3: TLabel
      Left = 55
      Top = 75
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object lbl5: TLabel
      Left = 90
      Top = 146
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lbl6: TLabel
      Left = 67
      Top = 169
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object lbl2: TLabel
      Left = 64
      Top = 192
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lbl9: TLabel
      Left = 71
      Top = 216
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblLocFis: TLabel
      Left = 68
      Top = 239
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Loc. Fisica:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 21
      Top = 276
      Width = 102
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela Pre'#231'o a Vista:'
    end
    object lbl10: TLabel
      Left = 18
      Top = 299
      Width = 105
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela Pre'#231'o a Prazo:'
    end
    object lblDescon: TColorLabel
      Left = 338
      Top = 276
      Width = 151
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto Tabela Pre'#231'o a Vista:'
      CorDestaque = clRed
    end
    object lblSimDes: TColorLabel
      Left = 532
      Top = 274
      Width = 10
      Height = 14
      Caption = '%'
      CorDestaque = clRed
    end
    object lblAcresc: TColorLabel
      Left = 329
      Top = 299
      Width = 160
      Height = 14
      Alignment = taRightJustify
      Caption = 'Acr'#233'scimo Tabela Pre'#231'o a Prazo:'
      CorDestaque = clRed
    end
    object lblSimAcr: TColorLabel
      Left = 532
      Top = 299
      Width = 10
      Height = 14
      Caption = '%'
      CorDestaque = clRed
    end
    object lblQtdPar: TLabel
      Left = 5
      Top = 319
      Width = 118
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade de Parcelas:'
    end
    object lblQtdEtq: TLabel
      Left = 369
      Top = 320
      Width = 120
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade de Etiquetas:'
    end
    object lblTotEti: TLabel
      Left = 668
      Top = 238
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Etiquetas:'
    end
    object lbl7: TLabel
      Left = 61
      Top = 98
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cod. Barras:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 83
      Top = 122
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 124
      Top = 71
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 1
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 182
      Top = 71
      Width = 357
      Height = 22
      TabStop = False
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
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 124
      Top = 141
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 6
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
      Left = 182
      Top = 141
      Width = 357
      Height = 22
      TabStop = False
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
    object edtRefere: TEditFocus
      Tag = 99
      Left = 124
      Top = 165
      Width = 415
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 124
      Top = 189
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 9
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDescri: TEditFocus
      Tag = 99
      Left = 124
      Top = 212
      Width = 415
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocFis: TEditFocus
      Tag = 99
      Left = 124
      Top = 235
      Width = 415
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
      TabOrder = 12
      OnKeyPress = edtLocFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 182
      Top = 189
      Width = 357
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgStatus: TRadioGroup
      Left = 562
      Top = 71
      Width = 218
      Height = 37
      Caption = 'Status'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        '&Ativo'
        '&Inativo'
        '&Todos')
      TabOrder = 23
    end
    object pnl1: TPanel
      Left = 0
      Top = 263
      Width = 800
      Height = 3
      TabOrder = 21
    end
    object cmbPreVis: TComboBoxFocus
      Tag = 99
      Left = 124
      Top = 272
      Width = 137
      Height = 22
      Style = csOwnerDrawFixed
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbPrePra: TComboBoxFocus
      Tag = 99
      Left = 124
      Top = 295
      Width = 137
      Height = 22
      Style = csOwnerDrawFixed
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtQtdPar: TEditFocus
      Tag = 99
      Left = 124
      Top = 318
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '##0'
    end
    object edtQtdEtq: TEditFocus
      Tag = 99
      Left = 490
      Top = 318
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 18
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '##0'
    end
    object btnConfirma: TBitBtnLocked
      Left = 681
      Top = 289
      Width = 98
      Height = 24
      Caption = '[ F10 ] Confirma'
      TabOrder = 19
      OnClick = btnConfirmaClick
    end
    object btnLimFil: TBitBtnLocked
      Left = 681
      Top = 316
      Width = 98
      Height = 24
      Caption = '[ F4 ] Limpa Filtro'
      TabOrder = 20
      OnClick = btnLimFilClick
    end
    object edtTotEti: TEditFocus
      Left = 740
      Top = 233
      Width = 39
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16770261
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 22
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object edtPerAcr: TEditFocus
      Tag = 99
      Left = 490
      Top = 295
      Width = 39
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#0.00'
    end
    object edtPerDes: TEditFocus
      Tag = 99
      Left = 490
      Top = 272
      Width = 39
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#0.00'
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 2
      Width = 780
      Height = 63
      Align = alTop
      Caption = 'Nota Fiscal de Entrada'
      TabOrder = 0
      object Label4: TLabel
        Left = 62
        Top = 15
        Width = 57
        Height = 14
        Caption = 'Documento:'
      end
      object Label5: TLabel
        Left = 233
        Top = 15
        Width = 41
        Height = 14
        Caption = 'Esp'#233'cie:'
      end
      object Label6: TLabel
        Left = 409
        Top = 15
        Width = 28
        Height = 14
        Caption = 'S'#233'rie:'
      end
      object Label1: TLabel
        Left = 56
        Top = 39
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 122
        Top = 12
        Width = 81
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 12
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 276
        Top = 12
        Width = 35
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 2
        ReadOnly = True
        TabOrder = 1
        Text = 'NF'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtSerie: TEditFocus
        Tag = 99
        Left = 439
        Top = 12
        Width = 48
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodForDoc: TEditFocus
        Tag = 99
        Left = 122
        Top = 35
        Width = 81
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomForDoc: TEditFocus
        Left = 204
        Top = 35
        Width = 333
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
    end
    object edtCodBarra: TEditFocus
      Left = 124
      Top = 94
      Width = 415
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnKeyPress = edtCodBarraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object RadTipoAlteracao: TRadioGroup
      Left = 562
      Top = 114
      Width = 218
      Height = 37
      Caption = ' Tipo Altera'#231#227'o Valor '
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Percentual'
        'Valor')
      TabOrder = 24
      OnClick = RadTipoAlteracaoClick
    end
    object edtCodIte: TEditFocus
      Left = 124
      Top = 117
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 182
      Top = 117
      Width = 357
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgSaldo: TRadioGroup
      Left = 562
      Top = 157
      Width = 218
      Height = 37
      Caption = 'Saldo'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        '&Positivo'
        '&Negativo'
        '&Todos')
      TabOrder = 25
    end
    object cbxLocFisicaPrincipal: TCheckBox
      Left = 303
      Top = 238
      Width = 146
      Height = 17
      Caption = 'Loc. Fisica - Principal'
      Checked = True
      State = cbChecked
      TabOrder = 26
    end
    object cbxLocFisicaLote: TCheckBox
      Left = 430
      Top = 238
      Width = 107
      Height = 17
      Caption = 'Loc. Fisica - Lote'
      TabOrder = 27
    end
  end
  object dbgEtiquetas: TDBGridCitel [5]
    Left = 0
    Top = 347
    Width = 784
    Height = 282
    Align = alClient
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgEtiquetasDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 16
    Top = 400
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 504
  end
  object frxDBImpEti: TfrxDBDataset
    UserName = 'frxDBImpEti'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 56
    Top = 360
  end
  object frxPagina: TfrxReport
    Version = '5.6.11'
    DataSetName = 'frxEtiquetaItens'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'IMP_EDUARDO'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39377.549029351900000000
    ReportOptions.LastChange = 39826.491681307900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 472
    Top = 384
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 151.181102360000000000
        Top = 18.897650000000000000
        Width = 793.701299999999900000
        Columns = 3
        ColumnGap = 264.566929133858000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 18.897650000000000000
          Top = 18.897650000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Visible = False
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 18.897650000000000000
          Top = 41.574830000000000000
          Width = 230.551330000000000000
          Height = 41.574830000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."DESITE"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 18.897650000000000000
          Top = 86.929190000000010000
          Width = 230.551330000000000000
          Height = 60.472480000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -48
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBImpEti."VALITE"]')
          ParentFont = False
        end
      end
    end
  end
  object frxEtiqItensCodBarra: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39533.406450532400000000
    ReportOptions.LastChange = 40002.465640000000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllVal5xOnAfterData(Sender: TfrxComponent);'
      'begin'
      
        '  rllVal5x.Text := '#39'5 x R$ '#39' + FormatFloat('#39'#,##0.00'#39', <frxDBImp' +
        'Eti."VALITE"> / 5);'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 360
    Top = 416
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object CodBarraComPreco: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 3.000000000000000000
      RightMargin = 3.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 117.165354330000000000
        Top = 18.897650000000000000
        Width = 771.024120000000000000
        Columns = 3
        ColumnWidth = 249.448818897638000000
        ColumnGap = 7.559055118110240000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 4.774273330000000000
          Top = 12.435683340000000000
          Width = 236.551330000000000000
          Height = 34.771655980000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."CODITE"] - [frxDBImpEti."DESITE"]')
          ParentFont = False
        end
        object rllVal5x: TfrxMemoView
          Left = 4.774273330000000000
          Top = 45.989486670000010000
          Width = 236.551330000000000000
          Height = 23.118119990000000000
          OnAfterData = 'rllVal5xOnAfterData'
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'R$ #,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."VALITE"]')
          ParentFont = False
        end
        object rdbValorVista: TfrxMemoView
          Left = 68.811070000000000000
          Top = 75.590600000000000000
          Width = 172.299320000000000000
          Height = 15.559059990000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'R$ #,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."VALVIS"]')
          ParentFont = False
        end
        object rllEtiqueta: TfrxMemoView
          Left = 7.559060000000000000
          Top = 75.590600000000000000
          Width = 56.692950000000000000
          Height = 15.496062990000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'A VISTA')
          ParentFont = False
        end
      end
    end
  end
  object CodigoBarra: TfrxBarCodeObject
    Left = 504
    Top = 448
  end
  object frxEtiqItensZebra: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39533.411589062500000000
    ReportOptions.LastChange = 40451.551144016200000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 448
    Top = 432
  end
  object frxUserDataSet1: TfrxUserDataSet
    UserName = 'frxUserDataSet1'
    Left = 24
    Top = 360
  end
  object frxReport1: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39533.406450532400000000
    ReportOptions.LastChange = 40198.577235057870000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllVal5xOnAfterData(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 536
    Top = 408
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object ProdutoSemCodBarra: TfrxReportPage
      PaperWidth = 220.000000000000000000
      PaperHeight = 285.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 15.000000000000000000
      TopMargin = 12.000000000000000000
      BottomMargin = 11.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 49.133858267716530000
        Top = 18.897650000000000000
        Width = 752.126470000000000000
        Columns = 4
        ColumnWidth = 171.968503937008000000
        ColumnGap = 7.559055118110240000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 9.913385830000000000
          Top = 13.435683340000000000
          Width = 154.204736610000000000
          Height = 19.653535980000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."CODITE"] - [frxDBImpEti."DESITE"]')
          ParentFont = False
        end
        object rllEtiqueta: TfrxMemoView
          Left = 147.196970000000000000
          Top = 33.244094490000000000
          Width = 17.007864250000000000
          Height = 11.716532990000000000
          DataField = 'SIGUNI'
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBImpEti."SIGUNI"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 9.559060000000000000
          Top = 40.472480000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'R$ #,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBImpEti."VALITE"]')
          ParentFont = False
        end
      end
    end
  end
  object frxReport2: TfrxReport
    Version = '5.6.11'
    DataSetName = 'frxEtiquetaItens'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'IMP_EDUARDO'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39377.549029351900000000
    ReportOptions.LastChange = 39826.492693495400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 424
    Top = 384
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 151.181102360000000000
        Top = 18.897650000000000000
        Width = 793.701299999999900000
        Columns = 3
        ColumnGap = 264.566929133858000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 18.897650000000000000
          Top = 18.897650000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 18.897650000000000000
          Top = 56.692950000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."DESITE"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 18.897650000000000000
          Top = 86.929190000000010000
          Width = 230.551330000000000000
          Height = 60.472480000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -48
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBImpEti."VALITE"]')
          ParentFont = False
        end
      end
    end
  end
  object cdsImpEti: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 440
    object cdsImpEtiNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object cdsImpEtiENDERE: TStringField
      FieldName = 'ENDERE'
      Size = 60
    end
    object cdsImpEtiBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 30
    end
    object cdsImpEtiC_E_P_: TStringField
      FieldName = 'C_E_P_'
      Size = 9
    end
    object cdsImpEtiNOMCID: TStringField
      FieldName = 'NOMCID'
      Size = 40
    end
    object cdsImpEtiENDNUM: TStringField
      FieldName = 'ENDNUM'
      Size = 10
    end
    object cdsImpEtiENDCOM: TStringField
      FieldName = 'ENDCOM'
      Size = 50
    end
  end
  object cdsImpEtiIte: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspImpEti'
    Left = 192
    Top = 472
    object cdsImpEtiIteNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 40
    end
    object cdsImpEtiIteDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsImpEtiIteQTDETI: TIntegerField
      FieldName = 'QTDETI'
    end
    object cdsImpEtiIteVALITE: TFloatField
      FieldName = 'VALITE'
    end
    object cdsImpEtiIteCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 15
    end
    object cdsImpEtiIteREFERE: TStringField
      FieldName = 'REFERE'
      Size = 50
    end
    object cdsImpEtiIteSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsImpEtiIteCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsImpEtiIteCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsImpEtiIteLOCFIS: TStringField
      FieldName = 'LOCFIS'
      Size = 10
    end
    object cdsImpEtiIteCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsImpEtiIteVALVIS: TFloatField
      FieldName = 'VALVIS'
    end
    object cdsImpEtiIteCODIGO: TStringField
      FieldName = 'CODIGO'
    end
    object cdsImpEtiIteDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 40
    end
    object cdsImpEtiIteCODAMZ: TStringField
      FieldName = 'CODAMZ'
      Size = 3
    end
  end
  object cdsArmaze: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 224
    object cdsArmazeCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsArmazeCODAMZ: TStringField
      FieldName = 'CODAMZ'
      Size = 3
    end
  end
  object cdsCodBar: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 520
    Top = 40
    object cdsCodBarCODITE: TStringField
      FieldName = 'CODITE'
    end
    object cdsCodBarCODBAR: TStringField
      FieldName = 'CODBAR'
    end
  end
end
