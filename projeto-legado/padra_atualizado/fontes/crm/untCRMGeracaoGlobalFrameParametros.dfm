object fraCRMGeracaoGlobalFrameParametros: TfraCRMGeracaoGlobalFrameParametros
  Left = 0
  Top = 0
  Width = 790
  Height = 591
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pgcFiltros: TPageControl
    Left = 0
    Top = 0
    Width = 790
    Height = 591
    ActivePage = tbsClientesSemCompra
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    Style = tsFlatButtons
    TabOrder = 0
    OnChange = pgcFiltrosChange
    object tbsDadosCliente: TTabSheet
      Caption = '&1 - Dados do Cliente'
      object Label2: TLabel
        Left = 12
        Top = -3
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
      object Label4: TLabel
        Left = 396
        Top = -3
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Atividade'
      end
      object Label12: TLabel
        Left = 12
        Top = 35
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
      object Label1: TLabel
        Left = 396
        Top = 35
        Width = 71
        Height = 14
        Caption = 'Representante'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 12
        Top = 73
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Regi'#227'o'
      end
      object lbl4: TLabel
        Left = 396
        Top = 73
        Width = 56
        Height = 14
        Caption = 'Sub-Regi'#227'o'
      end
      object Label16: TLabel
        Left = 12
        Top = 111
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
      object Label3: TLabel
        Left = 396
        Top = 111
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = 'Canal de Acesso'
      end
      object Label5: TLabel
        Left = 396
        Top = 149
        Width = 36
        Height = 14
        Caption = 'Revista'
      end
      object Label6: TLabel
        Left = 460
        Top = 149
        Width = 80
        Height = 14
        Caption = 'Boleto por e-mail'
      end
      object Label8: TLabel
        Left = 546
        Top = 149
        Width = 67
        Height = 14
        Caption = 'Org'#227'o p'#250'blico'
      end
      object Label17: TLabel
        Left = 339
        Top = -3
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Estado'
      end
      object Label18: TLabel
        Left = 623
        Top = 149
        Width = 31
        Height = 14
        Caption = 'Status'
      end
      object Label25: TLabel
        Left = 13
        Top = 149
        Width = 92
        Height = 14
        Caption = 'Grupo de Atividade'
      end
      object Label209: TLabel
        Left = 12
        Top = 187
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Frequ'#234'ncia'
      end
      object Label248: TLabel
        Left = 396
        Top = 187
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Porte'
      end
      object Label249: TLabel
        Left = 12
        Top = 225
        Width = 108
        Height = 14
        Alignment = taRightJustify
        Caption = 'Faixa de Fat. Estimado'
      end
      object Label250: TLabel
        Left = 396
        Top = 225
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor Atual'
      end
      object shpLiberadoVendedor: TShape
        Left = 4
        Top = 49
        Width = 8
        Height = 22
      end
      object shpLiberadoRepresentante: TShape
        Left = 388
        Top = 49
        Width = 8
        Height = 22
      end
      object labelCadQua: TLabel
        Left = 12
        Top = 490
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qualifica'#231#227'o'
      end
      object lblCategoria: TLabel
        Left = 13
        Top = 263
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'Categoria'
      end
      object Label54: TLabel
        Left = 396
        Top = 264
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa'
      end
      object edtCodCid: TEditFocus
        Left = 12
        Top = 11
        Width = 70
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
        TabOrder = 0
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
      object edtNomCid: TEditFocus
        Left = 83
        Top = 11
        Width = 255
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
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
      object edtCodAti: TEditFocus
        Tag = 99
        Left = 396
        Top = 11
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 3
        OnExit = edtCodAtiExit
        OnKeyPress = edtCodAtiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomAti: TEditFocus
        Left = 467
        Top = 11
        Width = 307
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtVendedor: TEditFocus
        Tag = 99
        Left = 12
        Top = 49
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 5
        OnExit = edtVendedorExit
        OnKeyPress = edtVendedorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesVendedor: TEditFocus
        Left = 83
        Top = 49
        Width = 302
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtRepresentante: TEditFocus
        Tag = 99
        Left = 396
        Top = 49
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 7
        OnExit = edtRepresentanteExit
        OnKeyPress = edtRepresentanteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesRepresentante: TEditFocus
        Left = 467
        Top = 49
        Width = 307
        Height = 22
        Alignment = taLeftJustify
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
      object edtCodReg: TEditFocus
        Tag = 99
        Left = 12
        Top = 87
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 9
        OnExit = edtCodRegExit
        OnKeyPress = edtCodRegKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesReg: TEditFocus
        Left = 83
        Top = 87
        Width = 302
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodSub: TEditFocus
        Tag = 99
        Left = 396
        Top = 87
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 11
        OnExit = edtCodSubExit
        OnKeyPress = edtCodSubKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesSub: TEditFocus
        Left = 467
        Top = 87
        Width = 307
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
      object edtCodRede: TEditFocus
        Left = 12
        Top = 125
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 13
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
        Left = 83
        Top = 125
        Width = 302
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 14
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCac: TEditFocus
        Tag = 99
        Left = 396
        Top = 125
        Width = 70
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
        TabOrder = 15
        OnExit = edtCodCacExit
        OnKeyPress = edtCodCacKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesCac: TEditFocus
        Left = 467
        Top = 125
        Width = 307
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 16
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cmbRevista: TComboBoxFocus
        Left = 396
        Top = 163
        Width = 58
        Height = 22
        Style = csDropDownList
        ItemIndex = 2
        TabOrder = 19
        Text = 'Todos'
        Items.Strings = (
          'Sim'
          'N'#227'o'
          'Todos')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbBoleto: TComboBoxFocus
        Left = 460
        Top = 163
        Width = 80
        Height = 22
        Style = csDropDownList
        ItemIndex = 2
        TabOrder = 20
        Text = 'Todos'
        Items.Strings = (
          'Sim'
          'N'#227'o'
          'Todos')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbOrgPub: TComboBoxFocus
        Left = 546
        Top = 163
        Width = 71
        Height = 22
        Style = csDropDownList
        ItemIndex = 2
        TabOrder = 21
        Text = 'Todos'
        Items.Strings = (
          'Sim'
          'N'#227'o'
          'Todos')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtEstado: TEditFocus
        Left = 339
        Top = 11
        Width = 46
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
      object cmbStatus: TComboBoxFocus
        Left = 623
        Top = 163
        Width = 64
        Height = 22
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 22
        Text = 'Ativo'
        Items.Strings = (
          'Ativo'
          'Inativo'
          'Todos')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtCodGat: TEditFocus
        Tag = 99
        Left = 12
        Top = 163
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 17
        OnExit = edtCodGatExit
        OnKeyPress = edtCodGatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesGat: TEditFocus
        Left = 83
        Top = 163
        Width = 302
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 18
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCrmFre: TEditFocus
        Tag = 99
        Left = 12
        Top = 201
        Width = 70
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
        TabOrder = 23
        OnExit = edtCrmFreExit
        OnKeyPress = edtCrmFreKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtDesFre: TEditFocus
        Left = 83
        Top = 200
        Width = 302
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCrmPor: TEditFocus
        Tag = 99
        Left = 396
        Top = 200
        Width = 70
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
        TabOrder = 25
        OnExit = edtCrmPorExit
        OnKeyPress = edtCrmPorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtDesCrmPor: TEditFocus
        Left = 467
        Top = 200
        Width = 307
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtCrmFai: TEditFocus
        Tag = 99
        Left = 12
        Top = 239
        Width = 70
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
        OnExit = edtCrmFaiExit
        OnKeyPress = edtCrmFaiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtDesFai: TEditFocus
        Left = 83
        Top = 239
        Width = 302
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCrmFor: TEditFocus
        Tag = 99
        Left = 396
        Top = 239
        Width = 70
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
        TabOrder = 29
        OnExit = edtCrmForExit
        OnKeyPress = edtCrmForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtDesFor: TEditFocus
        Left = 467
        Top = 239
        Width = 307
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object rdgTipoPessoa: TRadioGroup
        Left = 396
        Top = 303
        Width = 378
        Height = 38
        Caption = 'Tipo de Cliente'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Todos'
          'Pessoa Jur'#237'dica'
          'Pessoa F'#237'sica')
        TabOrder = 36
      end
      object rdgClientesPor: TRadioGroup
        Left = 12
        Top = 301
        Width = 378
        Height = 38
        Caption = 'Filtrar por'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Per'#237'odo entre Datas'
          #218'ltimos Dias')
        TabOrder = 35
        OnClick = rdgClientesPorClick
      end
      object grbPeriodoCliente: TGroupBox
        Left = 12
        Top = 345
        Width = 378
        Height = 142
        Caption = 'Per'#237'odo entre Datas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 37
        object Label9: TLabel
          Left = 13
          Top = 17
          Width = 26
          Height = 14
          Caption = 'Inicial'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 92
          Top = 17
          Width = 22
          Height = 14
          Caption = 'Final'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 13
          Top = 59
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
        object Label21: TLabel
          Left = 92
          Top = 59
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
        object Label22: TLabel
          Left = 160
          Top = 75
          Width = 87
          Height = 14
          Caption = '('#218'ltima compra)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label39: TLabel
          Left = 160
          Top = 34
          Width = 72
          Height = 14
          Caption = '(Anivers'#225'rio)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label20: TLabel
          Left = 13
          Top = 100
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
        object Label23: TLabel
          Left = 92
          Top = 100
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
        object Label24: TLabel
          Left = 160
          Top = 116
          Width = 147
          Height = 14
          Caption = '('#218'ltimo pedido/or'#231'amento)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object mskDtaIniCli: TMaskEditFocus
          Tag = 99
          Left = 13
          Top = 31
          Width = 35
          Height = 22
          EditMask = '99/99'
          MaxLength = 5
          TabOrder = 0
          Text = '  /  '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtaFinCli: TMaskEditFocus
          Tag = 99
          Left = 92
          Top = 31
          Width = 37
          Height = 22
          Enabled = False
          EditMask = '99/99'
          MaxLength = 5
          TabOrder = 1
          Text = '  /  '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskIniCom: TMaskEditFocus
          Tag = 99
          Left = 13
          Top = 72
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
          TabOrder = 2
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskFinCom: TMaskEditFocus
          Tag = 99
          Left = 92
          Top = 72
          Width = 62
          Height = 22
          Enabled = False
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
          TabOrder = 3
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskIniOrc: TMaskEditFocus
          Tag = 99
          Left = 13
          Top = 113
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
          TabOrder = 4
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskFinOrc: TMaskEditFocus
          Tag = 99
          Left = 92
          Top = 113
          Width = 62
          Height = 22
          Enabled = False
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
          TabOrder = 5
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
      end
      object grbDiasCliente: TGroupBox
        Left = 396
        Top = 345
        Width = 378
        Height = 142
        Caption = #218'ltimos Dias'
        Enabled = False
        TabOrder = 38
        object Label40: TLabel
          Left = 87
          Top = 34
          Width = 190
          Height = 14
          Caption = 'Anivers'#225'rio nos '#250'ltimos                   dias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label41: TLabel
          Left = 76
          Top = 75
          Width = 201
          Height = 14
          Caption = #218'ltima compra nos '#250'ltimos                   dias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label42: TLabel
          Left = 24
          Top = 116
          Width = 253
          Height = 14
          Caption = #218'ltimo Pedido/Or'#231'amento nos '#250'ltimos                   dias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDiasAniversario: TEditFocus
          Tag = 99
          Left = 206
          Top = 31
          Width = 45
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDiasUltCom: TEditFocus
          Tag = 99
          Left = 206
          Top = 72
          Width = 45
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDiasUltOrc: TEditFocus
          Tag = 99
          Left = 206
          Top = 113
          Width = 45
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttNumerico
        end
      end
      object edtCodQua: TEditFocus
        Tag = 99
        Left = 12
        Top = 505
        Width = 70
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
        TabOrder = 39
        OnExit = edtCodQuaExit
        OnKeyPress = edtCodQuaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtDesQua: TEditFocus
        Left = 83
        Top = 505
        Width = 691
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 40
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCat: TEditFocus
        Tag = 99
        Left = 12
        Top = 277
        Width = 70
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
        TabOrder = 31
        OnExit = edtCodCatExit
        OnKeyPress = edtCodCatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesCat: TEditFocus
        Left = 83
        Top = 277
        Width = 302
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodEmpCli: TEditFocus
        Left = 395
        Top = 277
        Width = 70
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
        TabOrder = 33
        OnExit = edtCodEmpCliExit
        OnKeyPress = edtCodEmpCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomEmpCli: TEditFocus
        Left = 466
        Top = 277
        Width = 307
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 34
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkOcoAbe: TdxCheckGroupBox
        Tag = 99
        Left = 13
        Top = 533
        Caption = 'Filtrar Ocorr'#234'ncia em aberto'
        CheckBox.Checked = False
        TabOrder = 41
        OnClick = chkOcoAbeClick
        Height = 116
        Width = 378
        object lblTipo: TLabel
          Left = 16
          Top = 53
          Width = 23
          Height = 14
          Caption = 'Tipo:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblGrupo: TLabel
          Left = 10
          Top = 28
          Width = 33
          Height = 14
          Caption = 'Grupo:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblObsFiltroOcorrenciasAbertas: TLabel
          Left = 13
          Top = 77
          Width = 343
          Height = 14
          Caption = 
            '* O cliente que possuir a ocorr'#234'ncia filtrada em aberto n'#227'o ser'#225 +
            ' listado.'
        end
        object edtCodGoc: TEditFocus
          Tag = 99
          Left = 45
          Top = 25
          Width = 70
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
          TabOrder = 0
          OnExit = edtCodGocExit
          OnKeyPress = edtCodGocKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesGoc: TEditFocus
          Left = 117
          Top = 25
          Width = 253
          Height = 22
          TabStop = False
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
        object edtCodToc: TEditFocus
          Tag = 99
          Left = 45
          Top = 49
          Width = 70
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
          TabOrder = 2
          OnExit = edtCodTocExit
          OnKeyPress = edtCodTocKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesToc: TEditFocus
          Left = 117
          Top = 49
          Width = 253
          Height = 22
          TabStop = False
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
      end
    end
    object tbsDadosContatoCliente: TTabSheet
      Caption = '&2 - Dados de Contato do Cliente'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label184: TLabel
        Left = 12
        Top = 4
        Width = 29
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cargo'
      end
      object Label211: TLabel
        Left = 396
        Top = 4
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Departamento'
      end
      object Label213: TLabel
        Left = 12
        Top = 43
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Time Futebol'
      end
      object Label214: TLabel
        Left = 396
        Top = 43
        Width = 31
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hobby'
      end
      object Label215: TLabel
        Left = 12
        Top = 82
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Escolaridade'
      end
      object Label218: TLabel
        Left = 396
        Top = 82
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Gosto Musical'
      end
      object Label219: TLabel
        Left = 12
        Top = 121
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Estado Civil'
      end
      object Label14: TLabel
        Left = 396
        Top = 121
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Anivers'#225'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 448
        Top = 139
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = #224
      end
      object edtCgoCtt: TEditFocus
        Tag = 99
        Left = 12
        Top = 18
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        OnExit = edtCgoCttExit
        OnKeyPress = edtCgoCttKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesCgoCtt: TEditFocus
        Left = 83
        Top = 18
        Width = 305
        Height = 22
        TabStop = False
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
      object edtDptCtt: TEditFocus
        Tag = 99
        Left = 396
        Top = 18
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 2
        OnExit = edtDptCttExit
        OnKeyPress = edtDptCttKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesDptCtt: TEditFocus
        Left = 467
        Top = 18
        Width = 305
        Height = 22
        TabStop = False
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
      object edtTfuCtt: TEditFocus
        Tag = 99
        Left = 12
        Top = 57
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 4
        OnExit = edtTfuCttExit
        OnKeyPress = edtTfuCttKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesTfuCtt: TEditFocus
        Left = 83
        Top = 57
        Width = 305
        Height = 22
        TabStop = False
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
      object edtHobCtt: TEditFocus
        Tag = 99
        Left = 396
        Top = 57
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 6
        OnExit = edtHobCttExit
        OnKeyPress = edtHobCttKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesHobCtt: TEditFocus
        Left = 467
        Top = 57
        Width = 305
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
      object edtEscCtt: TEditFocus
        Tag = 99
        Left = 12
        Top = 97
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 8
        OnExit = edtEscCttExit
        OnKeyPress = edtEscCttKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesEscCtt: TEditFocus
        Left = 83
        Top = 97
        Width = 305
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtGmuCtt: TEditFocus
        Tag = 99
        Left = 396
        Top = 97
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 10
        OnExit = edtGmuCttExit
        OnKeyPress = edtGmuCttKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesGmuCtt: TEditFocus
        Left = 467
        Top = 97
        Width = 305
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtEciCtt: TEditFocus
        Tag = 99
        Left = 12
        Top = 136
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 12
        OnExit = edtEciCttExit
        OnKeyPress = edtEciCttKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesEciCtt: TEditFocus
        Left = 83
        Top = 136
        Width = 305
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
      object mskDtaIniCtt: TMaskEditFocus
        Tag = 99
        Left = 396
        Top = 136
        Width = 45
        Height = 22
        EditMask = '99/99'
        MaxLength = 5
        TabOrder = 14
        Text = '  /  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFinCtt: TMaskEditFocus
        Tag = 99
        Left = 463
        Top = 136
        Width = 47
        Height = 22
        Enabled = False
        EditMask = '99/99'
        MaxLength = 5
        TabOrder = 15
        Text = '  /  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object tbsClientesSemCompra: TTabSheet
      Caption = '&3 - Clientes que n'#227'o compraram no per'#237'odo'
      ImageIndex = 1
      object lblCodDep: TLabel
        Left = 12
        Top = 296
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Departamento'
      end
      object Label32: TLabel
        Left = 393
        Top = 296
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
      object Label33: TLabel
        Left = 12
        Top = 334
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
      object lbl1: TLabel
        Left = 393
        Top = 334
        Width = 37
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto'
      end
      object Label34: TLabel
        Left = 0
        Top = 539
        Width = 782
        Height = 20
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'Necess'#225'rio informar um per'#237'odo para habilitar o filtro por produ' +
          'to'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = -200
        ExplicitTop = 619
      end
      object Label49: TLabel
        Left = 12
        Top = 461
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa'
      end
      object lblFornecedor: TLabel
        Left = 12
        Top = 373
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor'
      end
      object lblUltVnd: TLabel
        Left = 11
        Top = 498
        Width = 131
        Height = 14
        Caption = 'Vendedor da '#250'ltima compra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblUltDig: TLabel
        Left = 393
        Top = 498
        Width = 126
        Height = 14
        Caption = 'Digitador da '#250'ltima compra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rdgFiltrarPor: TRadioGroup
        Left = 12
        Top = 20
        Width = 757
        Height = 53
        Caption = 'Filtrar por'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Per'#237'odo entre Datas'
          #218'ltimos Dias')
        TabOrder = 1
        OnClick = rdgFiltrarPorClick
      end
      object grbClientesQueCompraramNoPeriodo: TGroupBox
        Left = 12
        Top = 74
        Width = 757
        Height = 86
        Caption = 'Clientes que compraram alguma vez no(s)'
        Padding.Bottom = 5
        TabOrder = 2
        object grbPeriodoComComp: TGroupBox
          Left = 2
          Top = 16
          Width = 375
          Height = 63
          Align = alLeft
          Caption = 'Per'#237'odo entre Datas'
          TabOrder = 0
          object Label35: TLabel
            Left = 8
            Top = 17
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
          object Label36: TLabel
            Left = 85
            Top = 17
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
          object Label37: TLabel
            Left = 156
            Top = 34
            Width = 108
            Height = 14
            Caption = '(Per'#237'odo c/ compra)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object mskIniComComp: TMaskEditFocus
            Tag = 99
            Left = 8
            Top = 31
            Width = 63
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
          object mskFinComComp: TMaskEditFocus
            Tag = 99
            Left = 85
            Top = 31
            Width = 65
            Height = 22
            Enabled = False
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
        object grbDiasComComp: TGroupBox
          Left = 380
          Top = 16
          Width = 375
          Height = 63
          Align = alRight
          Caption = #218'ltimos Dias'
          TabOrder = 1
          object Label38: TLabel
            Left = 14
            Top = 32
            Width = 211
            Height = 14
            Caption = 'Que compraram nos '#250'ltimos                   dias'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtDiasComComp: TEditFocus
            Tag = 99
            Left = 154
            Top = 29
            Width = 45
            Height = 22
            Alignment = taLeftJustify
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 3
            TipoTexto = ttNumerico
          end
        end
      end
      object grbClientesSemCompraNoPeriodo: TGroupBox
        Left = 12
        Top = 164
        Width = 757
        Height = 126
        Caption = 'mas n'#227'o compraram no(s)'
        Padding.Bottom = 5
        TabOrder = 3
        object grbPeriodoEntreDatas: TGroupBox
          Left = 2
          Top = 16
          Width = 375
          Height = 103
          Align = alLeft
          Caption = 'Per'#237'odo entre Datas'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label26: TLabel
            Left = 8
            Top = 18
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
          object Label27: TLabel
            Left = 85
            Top = 18
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
          object Label28: TLabel
            Left = 156
            Top = 35
            Width = 109
            Height = 14
            Caption = '(Per'#237'odo s/ compra)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label11: TLabel
            Left = 8
            Top = 57
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
          object Label13: TLabel
            Left = 85
            Top = 57
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
          object Label29: TLabel
            Left = 156
            Top = 74
            Width = 127
            Height = 14
            Caption = '(Per'#237'odo s/ or'#231'amento)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object mskIniSem: TMaskEditFocus
            Tag = 99
            Left = 8
            Top = 32
            Width = 63
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
          object mskFinSem: TMaskEditFocus
            Tag = 99
            Left = 85
            Top = 32
            Width = 65
            Height = 22
            Enabled = False
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
          object mskIniSemO: TMaskEditFocus
            Tag = 99
            Left = 8
            Top = 71
            Width = 63
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
            TabOrder = 2
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
          object mskFinSemO: TMaskEditFocus
            Tag = 99
            Left = 85
            Top = 71
            Width = 65
            Height = 22
            Enabled = False
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
            TabOrder = 3
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
        end
        object grbUltimosDias: TGroupBox
          Left = 380
          Top = 16
          Width = 375
          Height = 103
          Align = alRight
          Caption = #218'ltimos Dias'
          Enabled = False
          TabOrder = 1
          object Label30: TLabel
            Left = 31
            Top = 35
            Width = 194
            Height = 14
            Caption = 'Sem compra nos '#250'ltimos                   dias'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label31: TLabel
            Left = 16
            Top = 74
            Width = 209
            Height = 14
            Caption = 'Sem or'#231'amento nos '#250'ltimos                   dias'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtDiasSem: TEditFocus
            Tag = 99
            Left = 154
            Top = 32
            Width = 45
            Height = 22
            Alignment = taLeftJustify
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDiasSemO: TEditFocus
            Tag = 99
            Left = 154
            Top = 71
            Width = 45
            Height = 22
            Alignment = taLeftJustify
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 3
            TipoTexto = ttNumerico
          end
        end
      end
      object edtDepVen: TEditFocus
        Tag = 99
        Left = 12
        Top = 311
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 4
        OnExit = edtDepVenExit
        OnKeyPress = edtDepVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesDep: TEditFocus
        Left = 82
        Top = 311
        Width = 307
        Height = 22
        TabStop = False
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
      object edtCodMar: TEditFocus
        Tag = 99
        Left = 393
        Top = 311
        Width = 68
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
        Left = 462
        Top = 311
        Width = 307
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
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 12
        Top = 348
        Width = 69
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
        TabOrder = 8
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
        Left = 82
        Top = 348
        Width = 307
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
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 393
        Top = 348
        Width = 68
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        ParentFont = False
        TabOrder = 10
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
        Left = 462
        Top = 348
        Width = 307
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object rdgClasOfertaCon: TRadioGroup
        Left = 12
        Top = 415
        Width = 377
        Height = 44
        Caption = 'Tipo de Produto'
        Columns = 4
        Items.Strings = (
          'Todos'
          'Principal'
          'Acess'#243'rio'
          'Consum'#237'vel')
        TabOrder = 14
      end
      object chkUtiCSC: TCheckBox
        Left = 12
        Top = 1
        Width = 167
        Height = 17
        Caption = 'Utilizar os filtros desta aba'
        TabOrder = 0
        OnClick = chkUtiCSCClick
      end
      object rdgFiltrarClientesNaoCompEmpresa: TRadioGroup
        Left = 395
        Top = 415
        Width = 375
        Height = 44
        Caption = 'Filtrar por Empresa'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Faturamento'
          'Origem')
        TabOrder = 15
        OnClick = rdgFiltrarClientesNaoCompEmpresaClick
      end
      object edtNomEmp: TEditFocus
        Left = 82
        Top = 477
        Width = 688
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 12
        Top = 477
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 16
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
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 12
        Top = 387
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 12
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
      object edtNomFor: TEditFocus
        Left = 82
        Top = 387
        Width = 307
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
      object edtUltVnd: TEditFocus
        Tag = 99
        Left = 12
        Top = 512
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 18
        OnExit = edtUltVndExit
        OnKeyPress = edtUltVndKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomUltVnd: TEditFocus
        Left = 82
        Top = 512
        Width = 307
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
      object edtUltDig: TEditFocus
        Tag = 99
        Left = 393
        Top = 512
        Width = 68
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 20
        OnExit = edtUltDigExit
        OnKeyPress = edtUltDigKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomUltDig: TEditFocus
        Left = 462
        Top = 512
        Width = 308
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object tbsFinanceiro: TTabSheet
      Caption = '&4 -Financeiro'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label43: TLabel
        Left = 12
        Top = 24
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Label44: TLabel
        Left = 396
        Top = 24
        Width = 100
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor do Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label45: TLabel
        Left = 12
        Top = 63
        Width = 112
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor da Duplicata:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label46: TLabel
        Left = 396
        Top = 63
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object Label48: TLabel
        Left = 396
        Top = 103
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 12
        Top = 38
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 8
        TabOrder = 1
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomCli: TEditFocus
        Left = 83
        Top = 38
        Width = 307
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCliVen: TEditFocus
        Tag = 99
        Left = 396
        Top = 35
        Width = 70
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
        TabOrder = 3
        OnExit = edtCliVenExit
        OnKeyPress = edtCliVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesCliVen: TEditFocus
        Left = 467
        Top = 38
        Width = 307
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtVenDup: TEditFocus
        Tag = 99
        Left = 12
        Top = 77
        Width = 70
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
        TabOrder = 5
        OnExit = edtVenDupExit
        OnKeyPress = edtVenDupKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesVenDup: TEditFocus
        Left = 83
        Top = 77
        Width = 307
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodPortador: TEditFocus
        Tag = 99
        Left = 396
        Top = 77
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 7
        OnExit = edtCodPortadorExit
        OnKeyPress = edtCodPortadorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesPortador: TEditFocus
        Left = 467
        Top = 77
        Width = 307
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtEmpDup: TEditFocus
        Tag = 99
        Left = 396
        Top = 118
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 10
        OnExit = edtEmpDupExit
        OnKeyPress = edtEmpDupKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomEmpDup: TEditFocus
        Left = 467
        Top = 118
        Width = 307
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object chkUtiFin: TCheckBox
        Left = 12
        Top = 1
        Width = 167
        Height = 17
        Caption = 'Utilizar os filtros desta aba'
        TabOrder = 0
        OnClick = chkUtiFinClick
      end
      object rdgFinanceiroPor: TRadioGroup
        Left = 17
        Top = 144
        Width = 762
        Height = 49
        Caption = 'Filtrar por'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Per'#237'odo entre Datas'
          #218'ltimos Dias')
        TabOrder = 12
        OnClick = rdgFinanceiroPorClick
      end
      object grbPeriodoVencimento: TGroupBox
        Left = 12
        Top = 199
        Width = 378
        Height = 63
        Caption = 'Per'#237'odo entre Datas'
        TabOrder = 13
        object Label50: TLabel
          Left = 8
          Top = 17
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
        object Label51: TLabel
          Left = 85
          Top = 17
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
        object Label52: TLabel
          Left = 156
          Top = 34
          Width = 136
          Height = 14
          Caption = '(Per'#237'odo de vencimento)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object mskIniVenc: TMaskEditFocus
          Tag = 99
          Left = 8
          Top = 31
          Width = 63
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
        object mskFinVenc: TMaskEditFocus
          Tag = 99
          Left = 85
          Top = 31
          Width = 65
          Height = 22
          Enabled = False
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
      object grbDiasVencimento: TGroupBox
        Left = 396
        Top = 199
        Width = 378
        Height = 63
        Caption = #218'ltimos Dias'
        TabOrder = 15
        object Label53: TLabel
          Left = 14
          Top = 34
          Width = 205
          Height = 14
          Caption = 'Que venceram nos '#250'ltimos                   dias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDiasVenc: TEditFocus
          Tag = 99
          Left = 148
          Top = 31
          Width = 45
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttNumerico
        end
      end
      object rdgFiltrarPorEmpresa: TRadioGroup
        Left = 12
        Top = 268
        Width = 378
        Height = 49
        Caption = 'Filtrar por Empresa'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Faturamento'
          'Pedido')
        TabOrder = 14
        OnClick = rdgFiltrarPorEmpresaClick
      end
      inline fraCentroCusto: TfraCentroCustoEditFocus
        Left = -4
        Top = 102
        Width = 394
        Height = 41
        TabOrder = 9
        ExplicitLeft = -4
        ExplicitTop = 102
        ExplicitWidth = 394
        ExplicitHeight = 41
        inherited lblEventos: TLabel
          Left = 16
          Top = 1
          Width = 87
          Height = 14
          ExplicitLeft = 16
          ExplicitTop = 1
          ExplicitWidth = 87
          ExplicitHeight = 14
        end
        inherited edtCodEve: TEditFocus
          Left = 16
          Top = 16
          Width = 70
          Height = 22
          OnExit = fraCentroCustoedtCodEveExit
          OnKeyPress = fraCentroCustoedtCodEveKeyPress
          ExplicitLeft = 16
          ExplicitTop = 16
          ExplicitWidth = 70
          ExplicitHeight = 22
        end
        inherited edtDesEve: TEditFocus
          Left = 87
          Top = 16
          Width = 307
          Height = 22
          ExplicitLeft = 87
          ExplicitTop = 16
          ExplicitWidth = 307
          ExplicitHeight = 22
        end
      end
      object grbDiasAVencer: TGroupBox
        Left = 396
        Top = 268
        Width = 378
        Height = 49
        Caption = #218'ltimos Dias'
        TabOrder = 16
        object Label47: TLabel
          Left = 14
          Top = 22
          Width = 205
          Height = 14
          Caption = 'Que ir'#227'o vencer em                              dias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDiasAVen: TEditFocus
          Tag = 99
          Left = 148
          Top = 24
          Width = 45
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttNumerico
        end
      end
      object grbDiasVencidosApos: TGroupBox
        Left = 396
        Top = 323
        Width = 378
        Height = 49
        Caption = #218'ltimos Dias'
        TabOrder = 17
        object Label55: TLabel
          Left = 14
          Top = 22
          Width = 203
          Height = 14
          Caption = 'Vencidos ap'#243's                                     dias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDiasVenA: TEditFocus
          Tag = 99
          Left = 148
          Top = 19
          Width = 45
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttNumerico
        end
      end
    end
    object tsPromocoes: TTabSheet
      AlignWithMargins = True
      Caption = '5 - Promo'#231#245'es / Venda Ativa'
      ImageIndex = 4
      object pnlCabecalhoPromocao: TPanel
        Left = 0
        Top = 0
        Width = 776
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object chkCatProm: TCheckBox
          Tag = 99
          Left = 3
          Top = 0
          Width = 337
          Height = 17
          Caption = 'Adicionar cat'#225'logo de promo'#231#245'es na gera'#231#227'o das ocorr'#234'ncias'
          TabOrder = 0
          OnClick = chkCatPromClick
        end
      end
      object pnlFiltrosPromocao_Local: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 25
        Width = 770
        Height = 525
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
      end
      inline frameFiltrosCatPromocao: TframeFiltrosCatPromocao
        Left = 0
        Top = 22
        Width = 776
        Height = 531
        Align = alClient
        TabOrder = 2
        ExplicitTop = 22
        ExplicitWidth = 776
        ExplicitHeight = 531
        inherited pnlFiltrosProdutos: TPanel
          Width = 776
          ExplicitWidth = 776
          inherited grpProdutos: TGroupBox
            Width = 776
            ExplicitWidth = 776
            inherited lblDepartamento: TLabel
              Left = 19
              Width = 70
              Height = 14
              ExplicitLeft = 19
              ExplicitWidth = 70
              ExplicitHeight = 14
            end
            inherited lblDesCon: TLabel
              Left = 595
              Width = 70
              Height = 14
              ExplicitLeft = 595
              ExplicitWidth = 70
              ExplicitHeight = 14
            end
            inherited lblTabPreco: TLabel
              Width = 54
              Height = 14
              ExplicitWidth = 54
              ExplicitHeight = 14
            end
            inherited Label59: TLabel
              Height = 14
              ExplicitHeight = 14
            end
            inherited edtDesDepPrm: TEditFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited edtCodMarPrm: TEditFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited edtDesMarPrm: TEditFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited edtDescri: TEditFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited edtCodItePrm: TEditFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited edtDesItePrm: TEditFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited cmbComSaldo: TComboBoxFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited cbTabPreco: TComboBoxFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited edtNomForPrm: TEditFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited chkPrecoImposto: TCheckBox
              Width = 170
              ExplicitWidth = 170
            end
            inherited edtCodEmpPrm: TEditFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited edtDesEmpPrm: TEditFocus
              Height = 22
              ExplicitHeight = 22
            end
          end
        end
        inherited pnlFiltrosPromocao: TPanel
          Width = 776
          ExplicitWidth = 776
          inherited grpPromocao: TGroupBox
            Width = 776
            ExplicitWidth = 776
            inherited lblTabPrecoPromocinal: TLabel
              Width = 112
              Height = 14
              ExplicitWidth = 112
              ExplicitHeight = 14
            end
            inherited edtDesPro: TEditFocus
              Height = 22
              ExplicitHeight = 22
            end
            inherited cbTabPrecoProm: TComboBoxFocus
              Height = 22
              ExplicitHeight = 22
            end
          end
        end
      end
    end
  end
end
