inherited frmCRMGeracaoGlobalProspecto: TfrmCRMGeracaoGlobalProspecto
  Width = 800
  Height = 309
  Caption = 'CRM - Gera'#231#227'o global de ocorr'#234'ncias'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 309
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 236
    Width = 794
    TabOrder = 1
    ExplicitTop = 236
    ExplicitWidth = 794
    object lblInfEnter: TLabel [0]
      Left = 325
      Top = 8
      Width = 272
      Height = 14
      Caption = '[ENTER] - Para marcar/desmarcar o registro selecionado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    inherited FlwBotoes: TFlowPanel
      Left = 418
      Width = 374
      TabOrder = 5
      ExplicitLeft = 418
      ExplicitWidth = 374
    end
    inherited btnSair: TBitBtnLocked
      Left = 711
      TabOrder = 4
      ExplicitLeft = 711
    end
    object btnConfirma: TBitBtnLocked
      Left = 101
      Top = 2
      Width = 75
      Height = 24
      Align = alLeft
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 1
      Visible = False
      OnClick = btnConfirmaClick
    end
    object btnMarcarTodos: TBitBtnLocked
      Left = 176
      Top = 2
      Width = 121
      Height = 24
      Align = alLeft
      Caption = '[ F7 ] Marcar Todos'
      TabOrder = 2
      Visible = False
      OnClick = btnMarcarTodosClick
    end
    object btnDesmTodos: TBitBtnLocked
      Left = 297
      Top = 2
      Width = 121
      Height = 24
      Align = alLeft
      Caption = '[ F8 ] Desmarcar Todos'
      TabOrder = 3
      Visible = False
      OnClick = btnDesmTodosClick
    end
    object btnCarregarDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 99
      Height = 24
      Align = alLeft
      Caption = '&Carregar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0001000000050000000B0000000F0000000F0000000C00000005000000010000
        0000000000000000000000000000000000000000000000000000000000020000
        0009041A0E520C4826BE0F5D31EC0F5D31EC094222BE03140A540000000A0000
        0002000000000000000000000000000000000000000000000000000000080A34
        1D871C7A49FF25A773FF26B981FF24B880FF1EA36CFF116A3BFF052813890000
        000A000000010000000000000000000000000000000000000000061D104D2984
        56FC45CA9CFF33C792FF43CE9EFF68DDB9FF65DDB8FF3AC391FF157242FD0315
        0A4E000000040000000000000000000000000000000000000000155E36CA60C3
        9FFF41CF9FFF32B581FF21804EFF227E4EFF5AC39DFF6ADFBDFF28AB76FF0E4E
        2ACB000000160000000D0000000D0000000C0000000A000000071E7945F281E4
        C6FF4CD5A8FF1D7947FF061F115E1C7A46FF13592FFF3BAC7FFF40A279FF1C76
        46FE7B99BCFF0A448AFF083873DC07346DD4052B5AB8041F4089217E4BF18BE6
        CDFF65E0BBFF186C3DFF05190C561F804AFF58B08EFF27694BFF7AA6C2FF8EB9
        E0FF91C3EEFF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF1E6B40C773CE
        ADFF8EECD4FF48BD94FF1C7345FF23864FFF50DAAEFF41BE92FF237349FF7AAD
        BBFF9ACAF0FF67B1EEFF46A2ECFF56ADEDFF3B89CDFF0C447FDA0A2416453F9E
        6DFCBBF0E1FFC0F6EAFF9EF0DAFF84E9CEFF6BE3C0FF57DDB5FF4FD2A8FF2785
        57FF669F9CFF73B6E4FF58A6DFFF1A64A9FA0C3864A3020B1329000000021547
        2B7D3CA06AFF95D6BCFFBAEEDEFFCAF8EEFFC7F7EDFF81EBCEFF6CDEBBFF40A2
        73FF699F97FF5F84ABFF184F81DB02080E260000000500000002000000000000
        00020B261743206A42B4288754E52C965CFFCDF9F0FF95E0C7FF358F5FEC6B92
        98EEBBCFE3FF79A1CCFF1C4070DE000000190000000000000000000000000000
        00000000000100000002000000052F9A60FF8DD3B5FF277A4ECA09140F3A9DB3
        D0FCC5E4F6FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        0000000000000000000000000001319E63FF1C5D39980104020E576B8BD26486
        B4FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000000000000000000010000000100000006235291F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000}
      TabOrder = 0
      OnClick = btnCarregarDadosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 264
    Width = 794
    TabOrder = 2
    ExplicitTop = 264
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
      object Shape1: TShape
        Left = 601
        Top = 1
        Width = 16
        Height = 15
        Anchors = [akTop, akRight]
        Brush.Color = clBlue
      end
    end
  end
  object Notebook: TNotebook [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 236
    Align = alClient
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'Filtros'
      object pnlFiltros: TPanel
        Left = 0
        Top = 0
        Width = 794
        Height = 236
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Label2: TLabel
          Left = 12
          Top = 31
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
          Top = 31
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Atividade'
        end
        object Label12: TLabel
          Left = 12
          Top = 69
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
        object Label9: TLabel
          Left = 466
          Top = 147
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
        object Label10: TLabel
          Left = 506
          Top = 166
          Width = 6
          Height = 14
          Alignment = taRightJustify
          Caption = #224
        end
        object Label11: TLabel
          Left = 11
          Top = 4
          Width = 125
          Height = 16
          Caption = 'Dados do prospecto'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 16
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel1: TBevel
          Left = 1
          Top = 26
          Width = 787
          Height = 8
          Shape = bsTopLine
        end
        object Label17: TLabel
          Left = 347
          Top = 32
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado'
        end
        object Label18: TLabel
          Left = 396
          Top = 147
          Width = 31
          Height = 14
          Caption = 'Status'
        end
        object Label209: TLabel
          Left = 396
          Top = 69
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Frequ'#234'ncia'
        end
        object Label248: TLabel
          Left = 12
          Top = 108
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Porte'
        end
        object Label249: TLabel
          Left = 396
          Top = 108
          Width = 108
          Height = 14
          Alignment = taRightJustify
          Caption = 'Faixa de Fat. Estimado'
        end
        object Label250: TLabel
          Left = 12
          Top = 148
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor Atual'
        end
        object lblCategoria: TLabel
          Left = 13
          Top = 187
          Width = 46
          Height = 14
          Alignment = taRightJustify
          Caption = 'Categoria'
        end
        object lblRegiao: TLabel
          Left = 398
          Top = 187
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Regi'#227'o'
        end
        object edtCodCid: TEditFocus
          Left = 12
          Top = 45
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
          Top = 45
          Width = 260
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
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
        object edtCodAti: TEditFocus
          Tag = 99
          Left = 396
          Top = 45
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 1
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
          Top = 45
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
        object edtVendedor: TEditFocus
          Left = 12
          Top = 84
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
          MaxLength = 3
          ParentFont = False
          TabOrder = 2
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
        object edtDesVendedor: TEditFocus
          Left = 83
          Top = 84
          Width = 307
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mskDtaIniCli: TMaskEditFocus
          Tag = 99
          Left = 466
          Top = 163
          Width = 37
          Height = 22
          EditMask = '99/99'
          MaxLength = 5
          TabOrder = 8
          Text = '  /  '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtaFinCli: TMaskEditFocus
          Tag = 99
          Left = 515
          Top = 163
          Width = 37
          Height = 22
          EditMask = '99/99'
          MaxLength = 5
          TabOrder = 9
          Text = '  /  '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtEstado: TEditFocus
          Left = 344
          Top = 45
          Width = 46
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
        object cmbStatus: TComboBoxFocus
          Left = 396
          Top = 163
          Width = 64
          Height = 22
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 7
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
        object edtCrmFre: TEditFocus
          Tag = 99
          Left = 396
          Top = 84
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
          TabOrder = 3
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
          Left = 467
          Top = 84
          Width = 307
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
        object edtCrmPor: TEditFocus
          Tag = 99
          Left = 12
          Top = 123
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
          TabOrder = 4
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
          Left = 83
          Top = 123
          Width = 307
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtCrmFai: TEditFocus
          Tag = 99
          Left = 396
          Top = 123
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
          TabOrder = 5
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
          Left = 467
          Top = 123
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
        object edtCrmFor: TEditFocus
          Tag = 99
          Left = 12
          Top = 163
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
          TabOrder = 6
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
          Left = 83
          Top = 163
          Width = 307
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtDesCat: TEditFocus
          Left = 83
          Top = 202
          Width = 307
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtCodCat: TEditFocus
          Tag = 99
          Left = 12
          Top = 202
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
          TabOrder = 19
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
        object edtCodReg: TEditFocus
          Tag = 99
          Left = 396
          Top = 202
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
          TabOrder = 20
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
          Left = 467
          Top = 202
          Width = 307
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
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Dados'
      object pnlDados: TPanel
        Left = 0
        Top = 0
        Width = 794
        Height = 236
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object cxDados: TcxGridCitel
          Left = 0
          Top = 0
          Width = 794
          Height = 236
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxDadosTableView: TcxGridDBTableViewCitel
            OnKeyPress = cxDadosTableViewKeyPress
            Navigator.Buttons.CustomButtons = <>
            FilterBox.Position = fpTop
            OnCustomDrawCell = cxDadosTableViewCustomDrawCell
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = True
            Destaque = False
            CorZebra = clMoneyGreen
            object cxDadosTableViewColumnMARCA: TcxGridDBColumn
              Caption = 'X'
              DataBinding.FieldName = 'PRO_CODPRO'
              HeaderAlignmentHorz = taCenter
              Options.FilteringWithFindPanel = False
              Options.Focusing = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Options.ShowCaption = False
              Width = 24
            end
            object cxDadosTableViewColumn1: TcxGridDBColumn
              Caption = 'Prospecto'
              DataBinding.FieldName = 'PRO_NOMPRO'
            end
            object cxDadosTableViewColumn2: TcxGridDBColumn
              Caption = 'Cidade'
              DataBinding.FieldName = 'PRO_CIDADE'
            end
            object cxDadosTableViewColumn3: TcxGridDBColumn
              Caption = 'Status'
              DataBinding.FieldName = 'PRO_STATUS'
            end
            object cxDadosTableViewColumn4: TcxGridDBColumn
              Caption = 'Atividade'
              DataBinding.FieldName = 'ATI_DESATI'
            end
            object cxDadosTableViewColumn5: TcxGridDBColumn
              Caption = 'Vendedor'
              DataBinding.FieldName = 'NOMVEN'
            end
            object cxDadosTableViewColumn7: TcxGridDBColumn
              Caption = 'Regi'#227'o'
              DataBinding.FieldName = 'REG_DESREG'
            end
          end
          object cxDadosLevel1: TcxGridLevel
            GridView = cxDadosTableView
          end
        end
      end
    end
  end
  object imgLista: TImageList
    Left = 224
    Top = 280
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00D6D6D600D6D6D600D6D6D600DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      F700000000000000000000000000000000000000000000000000000000000000
      0000BDBDF7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BE7000000
      CE008484E7000000000000000000000000000000000000000000000000008484
      E7000000CE006B6BE70000000000000000000000000000000000C6E7C60008A5
      390010AD420008AD420063AD7300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDEF000000CE000000
      CE000000CE008484E700000000000000000000000000000000008484E7000000
      CE000000CE000000CE00BDBDEF0000000000000000000000000052B56B004AE7
      9C005AEFAD005AEFAD0021C66B0052A56B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484E7000000
      C6000000C6000000C6008484E70000000000000000008484E7000000C6000000
      C6000000C6008484E7000000000000000000000000000000000018B55A0063FF
      CE006BFFCE0052FFC6004AFFBD0018C66B0052A5630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      DE000000BD000000BD000000BD008484DE008484DE000000BD000000BD000000
      BD008484DE00000000000000000000000000000000009CCEA50010DE840029FF
      B50029FFAD0018FFAD0000FFA50010FF9C0008BD5A00429C5200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484DE000000B5000000B5000000B5000000B5000000B5000000B5008484
      DE00000000000000000000000000000000000000000042AD5A0000FF940000FF
      9C0008FFA50010FF9C0021FFA50031F7A50042EF9C0010B552004AA55A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484DE000000B5000000B5000000B5000000B5008484DE000000
      0000000000000000000000000000000000000000000000AD420000F7940029F7
      A5004AF7AD0063C68C005AE7A50073F7B5006BEFAD0063E79C0018AD4A00399C
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484D6000000AD000000AD000000AD000000AD008484D6000000
      00000000000000000000000000000000000094C6940010CE63004AEFA50063F7
      B50052CE7B0000000000ADD6B50052BD7B0084EFB50084E7AD0084D69C0029AD
      4A0039A54A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484D6000000A5000000A5000000A5000000A5000000A5000000A5008484
      D600000000000000000000000000000000007BC6840052DE940073E7AD006BEF
      AD0094CE9C000000000000000000D6E7D60063B5730094E7B50094DEAD009CDE
      AD0039AD52002994310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      D60000009C0000009C0000009C008484D6008484D6000000A5000000A5000000
      A5008484D600000000000000000000000000000000008CBD8C005AB573004AB5
      6B0000000000000000000000000000000000D6E7D6006BB57300ADE7BD00ADDE
      B500B5DEB50052AD630029943100D6EFD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484CE000000
      9C0000009C0000009C008484CE0000000000000000008484CE0000009C000000
      9C0000009C008484CE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000073B57B00C6E7
      C600BDDEBD00CEE7CE006BBD7B0073B573000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDDE00000094000000
      9400000094008484CE00000000000000000000000000000000008484CE000000
      94000000940000009400BDBDE700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BB5
      7B00DEEFDE00E7F7E700A5D6A500ADCEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BBD000000
      8C008484CE000000000000000000000000000000000000000000000000008484
      CE0000008C006B6BBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073A573008CBD8C00C6D6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      DE00000000000000000000000000000000000000000000000000000000000000
      0000BDBDDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FC1FFFFF00000000EFF7FFFF00000000
      C7E3C1FF0000000083C1C0FF00000000C183C07F00000000E007803F00000000
      F00F801F00000000F81F800F00000000F81F040700000000F00F060300000000
      E0078F0000000000C183FFC00000000083C1FFE000000000C7E3FFF100000000
      EFF7FFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
