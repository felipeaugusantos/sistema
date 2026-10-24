inherited frmConsultaPedidos: TfrmConsultaPedidos
  Width = 1366
  Height = 780
  BorderStyle = bsSizeable
  Caption = 'Consulta de Pedidos'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1366
  ExplicitHeight = 780
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 677
    Width = 1350
    Height = 48
    ExplicitTop = 677
    ExplicitWidth = 1350
    ExplicitHeight = 48
    object Panel2: TPanel [0]
      Left = 2
      Top = 2
      Width = 1346
      Height = 21
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
    end
    inherited FlwBotoes: TFlowPanel
      Width = 1346
      Height = 44
      Align = alBottom
      ExplicitWidth = 1346
      ExplicitHeight = 44
      inherited btnConfirma: TBitBtnLocked
        TabOrder = 7
        TabStop = False
        Visible = False
      end
      object btnDadosEntrega: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 142
        Height = 22
        Caption = '[ F2 ] Endere'#231'o de Entrega'
        TabOrder = 0
        OnClick = btnDadosEntregaClick
      end
      object btnEnviaEmail: TBitBtnLocked
        Left = 217
        Top = 0
        Width = 142
        Height = 22
        Caption = '[ F9 ] Enviar E-mail'
        TabOrder = 1
        OnClick = btnEnviaEmailClick
      end
      object btnObsPed: TBitBtnLocked
        Left = 359
        Top = 0
        Width = 138
        Height = 22
        Caption = '[ F8 ] Obs. do Pedido'
        TabOrder = 2
        OnClick = btnObsPedClick
      end
      object btnRastrea: TBitBtnLocked
        Left = 497
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F4 ] Rastreamento'
        TabOrder = 3
        OnClick = btnRastreaClick
      end
      object btnLibNeg: TBitBtnLocked
        Left = 637
        Top = 0
        Width = 200
        Height = 22
        Caption = '[F5] Exibir motivo da libera'#231#227'o negada'
        TabOrder = 4
        OnClick = btnLibNegClick
      end
      object btnOcorrenciasDocumento: TBitBtnLocked
        Left = 837
        Top = 0
        Width = 190
        Height = 22
        Caption = '[F3] Ocorr'#234'ncias do Documento'
        TabOrder = 5
        OnClick = btnOcorrenciasDocumentoClick
      end
      object btnLegenda: TBitBtnLocked
        Left = 1027
        Top = 0
        Width = 119
        Height = 22
        Caption = '[ALT+F1] Legenda'
        TabOrder = 6
        OnClick = btnLegendaClick
      end
      object btnObsRomaneio: TBitBtnLocked
        Left = 1146
        Top = 0
        Width = 117
        Height = 22
        Caption = '[ F6 ] Obs. Romaneio'
        TabOrder = 8
        TabStop = False
        Visible = False
        OnClick = btnObsRomaneioClick
      end
      object btnAnexo: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 117
        Height = 22
        Caption = '[ F7 ] Anexo'
        TabOrder = 9
        TabStop = False
        OnClick = btnAnexoClick
      end
      object btnExportaCsv: TBitBtnLocked
        Left = 117
        Top = 22
        Width = 117
        Height = 22
        Caption = '[F11] Exportar CSV'
        TabOrder = 10
        TabStop = False
        OnClick = btnExportaCsvClick
      end
      object btnPODLalaMove: TBitBtnLocked
        Left = 234
        Top = 22
        Width = 168
        Height = 22
        Caption = 'Comprovante Entrega LalaMove'
        TabOrder = 11
        TabStop = False
        Visible = False
        OnClick = btnPODLalaMoveClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1274
      Top = 23
      Width = 74
      Align = alRight
      Caption = '&Sair'
      ExplicitLeft = 1274
      ExplicitTop = 23
      ExplicitWidth = 74
    end
  end
  inherited pnlStatus: TPanel
    Top = 725
    Width = 1350
    ExplicitTop = 725
    ExplicitWidth = 1350
    inherited pnlNomeForm: TPanel
      Left = 1179
      ExplicitLeft = 1179
    end
    inherited pnlInfo: TPanel
      Width = 1179
      ExplicitWidth = 1179
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 1350
    Height = 136
    Align = alTop
    Caption = ' '
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label1: TLabel
      Left = 828
      Top = 33
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 8
      Top = 110
      Width = 93
      Height = 14
      Caption = 'Emiss'#227'o do Pedido:'
    end
    object Label3: TLabel
      Left = 201
      Top = 110
      Width = 6
      Height = 14
      Caption = #224
    end
    object Label4: TLabel
      Left = 202
      Top = 7
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label5: TLabel
      Left = 200
      Top = 58
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
    end
    object Label6: TLabel
      Left = 51
      Top = 7
      Width = 50
      Height = 14
      Caption = 'N'#186' Pedido:'
    end
    object lblPedCom: TLabel
      Left = 506
      Top = 7
      Width = 70
      Height = 14
      Caption = 'Pedido Cliente:'
    end
    object lblDocFat: TLabel
      Left = 682
      Top = 7
      Width = 61
      Height = 14
      Caption = 'N'#186' Doc. Fat.:'
    end
    object lblEspFat: TLabel
      Left = 839
      Top = 7
      Width = 24
      Height = 14
      Caption = 'Esp.:'
    end
    object lblEmpFat: TLabel
      Left = 903
      Top = 7
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object lblEntRet: TLabel
      Left = 62
      Top = 58
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Destino:'
    end
    object lblDepVen: TLabel
      Left = 743
      Top = 59
      Width = 120
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento Vendedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblRedLoj: TLabel
      Left = 29
      Top = 33
      Width = 72
      Height = 14
      Caption = 'Rede de Lojas:'
    end
    object shaVen: TShape
      Left = 252
      Top = 56
      Width = 8
      Height = 20
    end
    object lblPedSite: TLabel
      Left = 672
      Top = 38
      Width = 71
      Height = 14
      Caption = 'N'#186' Pedido Site:'
    end
    object lblProduto: TLabel
      Left = 61
      Top = 83
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object lblPedidosFat: TLabel
      Left = 692
      Top = 83
      Width = 171
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o de faturamento do pedido:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 865
      Top = 30
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 11
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
      Left = 947
      Top = 30
      Width = 371
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 248
      Top = 4
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 291
      Top = 4
      Width = 214
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
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 261
      Top = 55
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 14
      OnExit = edtCodVenExit
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomVen: TEditFocus
      Left = 334
      Top = 55
      Width = 349
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
    object btnAdicionar: TBitBtnLocked
      Left = 308
      Top = 107
      Width = 85
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 24
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 396
      Top = 107
      Width = 85
      Height = 22
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 25
      OnClick = btnCancelaItemClick
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 106
      Top = 4
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtPedCom: TEditFocus
      Tag = 99
      Left = 576
      Top = 4
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 15
      TipoTexto = ttAlfanumerico
    end
    object edtCodRed: TEditFocus
      Tag = 99
      Left = 106
      Top = 30
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 8
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
    object edtNomRed: TEditFocus
      Left = 196
      Top = 30
      Width = 470
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
    object edtDocFat: TEditFocus
      Tag = 99
      Left = 746
      Top = 4
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtEspFat: TEditFocus
      Tag = 99
      Left = 865
      Top = 4
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 15
      TipoTexto = ttAlfanumerico
    end
    object edtEmpFat: TEditFocus
      Tag = 99
      Left = 949
      Top = 4
      Width = 52
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object cmbEntRet: TComboBox
      Tag = 99
      Left = 105
      Top = 55
      Width = 90
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 0
      ParentFont = False
      TabOrder = 13
      Text = 'TODOS'
      Items.Strings = (
        'TODOS'
        'ENTREGA'
        'RETIRA')
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 865
      Top = 55
      Width = 42
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
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDep: TEditFocus
      Left = 909
      Top = 55
      Width = 409
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
    object edtPedSite: TEditFocus
      Tag = 99
      Left = 746
      Top = 31
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object rdgRomaneio: TRadioGroup
      Left = 1131
      Top = 80
      Width = 187
      Height = 34
      Caption = 'Romaneio'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Sim'
        'N'#227'o')
      TabOrder = 21
    end
    object edtCodProduto: TEditFocus
      Tag = 99
      Left = 105
      Top = 80
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 18
      OnExit = edtCodProdutoExit
      OnKeyPress = edtCodProdutoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesProduto: TEditFocus
      Left = 196
      Top = 80
      Width = 487
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object cbbFaturado: TComboBox
      Left = 865
      Top = 80
      Width = 260
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 20
      Text = 'Todos os pedidos'
      Items.Strings = (
        'Todos os pedidos'
        'Pedidos n'#227'o faturados'
        'Pedidos faturados'
        'Pedidos baixados que n'#227'o ser'#227'o faturados')
    end
    object pnlEntregaFutura: TPanel
      Left = 1007
      Top = 4
      Width = 376
      Height = 26
      BevelOuter = bvNone
      TabOrder = 7
      object Label10: TLabel
        Left = 0
        Top = 3
        Width = 101
        Height = 14
        Caption = 'N'#186' Doc. Bx. Ent. Fut.:'
      end
      object Label11: TLabel
        Left = 212
        Top = 3
        Width = 24
        Height = 14
        Caption = 'Esp.:'
      end
      object Label12: TLabel
        Left = 276
        Top = 3
        Width = 45
        Height = 14
        Caption = 'Empresa:'
      end
      object edtDocBxEntFut: TEditFocus
        Tag = 99
        Left = 102
        Top = 0
        Width = 105
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttAlfanumerico
      end
      object edtEspBxEntFut: TEditFocus
        Tag = 99
        Left = 236
        Top = 0
        Width = 35
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 15
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 15
        TipoTexto = ttAlfanumerico
      end
      object edtEmpBxEntFut: TEditFocus
        Tag = 99
        Left = 321
        Top = 0
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 105
      Top = 106
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 22
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 213
      Top = 106
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 23
      Width = 90
    end
  end
  object prbProgresso: TProgressBar [3]
    Left = 0
    Top = 519
    Width = 1350
    Height = 15
    Align = alBottom
    Smooth = True
    TabOrder = 2
    Visible = False
  end
  object pnlOcorrencias: TPanel [4]
    Left = 0
    Top = 534
    Width = 1350
    Height = 143
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    Visible = False
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 1348
      Height = 17
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label15: TLabel
        Left = 1
        Top = 1
        Width = 1346
        Height = 14
        Hint = 'Inseridas na exclus'#227'o do documento em um romaneio anterior'
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Ocorr'#234'ncias'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        ExplicitLeft = 22
        ExplicitTop = 0
      end
    end
    object txtOcorrencias: TMemoFocus
      Left = 1
      Top = 18
      Width = 1348
      Height = 124
      Align = alClient
      Alignment = taCenter
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object pnlLegenda: TPanel [5]
    Left = 0
    Top = 136
    Width = 1350
    Height = 25
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    DesignSize = (
      1350
      25)
    object lblSemSal: TLabel
      Left = 8
      Top = 3
      Width = 92
      Height = 14
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Pedidos Baixados'
    end
    object shpSemSal: TShape
      Left = 96
      Top = 5
      Width = 12
      Height = 12
      Anchors = [akTop, akRight]
      Brush.Color = clGreen
    end
    object lblOcultaFiltro: TLabel
      Left = 124
      Top = 3
      Width = 77
      Height = 14
      Caption = 'Ocultar Filtros'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = lblOcultaFiltroClick
    end
  end
  object pnlPedidos: TPanel [6]
    Left = 0
    Top = 161
    Width = 1350
    Height = 358
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object cxgProdutos: TcxGrid
      Left = 1
      Top = 157
      Width = 1348
      Height = 200
      Align = alBottom
      TabOrder = 0
      object cxgProdutosDBTableView: TcxGridDBTableView
        OnKeyDown = cxgProdutosDBTableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgProdutosDBTableViewCustomDrawCell
        DataController.DataSource = dtsProdutos
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxgProdutosCODITE: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'CODITE'
        end
        object cxgProdutosREFERE: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
        end
        object cxgProdutosCODFAB: TcxGridDBColumn
          Caption = 'C'#243'd. F'#225'brica'
          DataBinding.FieldName = 'CODFAB'
        end
        object cxgProdutosCODBAR: TcxGridDBColumn
          Caption = 'C'#243'd. Barras'
          DataBinding.FieldName = 'CODBAR'
        end
        object cxgProdutosMARCA: TcxGridDBColumn
          Caption = 'Marca'
          DataBinding.FieldName = 'MARCA'
        end
        object cxgProdutosFDO_QTDITE: TcxGridDBColumn
          Caption = 'Qtd. Pedido'
          DataBinding.FieldName = 'FDO_QTDITE'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '#0.0000'
        end
        object cxgProdutosDESTINO: TcxGridDBColumn
          Caption = 'Destino'
          DataBinding.FieldName = 'DESTINO'
          Width = 60
        end
        object cxgProdutosFDO_DTENTR: TcxGridDBColumn
          Caption = 'Dt. Entrega'
          DataBinding.FieldName = 'FDO_DTENTR'
          Width = 78
        end
        object cxgProdutosSTATUSITEM: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'STATUSITEM'
          Width = 166
        end
        object cxgProdutosTRANSFERENCIA: TcxGridDBColumn
          Caption = 'Pd. Ag. Transfer'#234'ncia / Emp. Fat.'
          DataBinding.FieldName = 'TRANSFERENCIA'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 164
        end
        object cxgProdutosREQUISICAO: TcxGridDBColumn
          Caption = 'Requisi'#231#227'o'
          DataBinding.FieldName = 'REQUISICAO'
        end
        object cxgProdutosPEDIDODECOMPRAREQUISICAO: TcxGridDBColumn
          Caption = 'Pd. Compra Requisi'#231#227'o'
          DataBinding.FieldName = 'PEDIDO_DE_COMPRA_REQUISICAO'
          Width = 128
        end
        object cxgProdutosDATAENTREGAPEDIDO: TcxGridDBColumn
          Caption = 'Dt. Ent. Pd. Compra'
          DataBinding.FieldName = 'DATA_ENTREGA_PEDIDO'
          Width = 108
        end
        object cxgProdutosFATURA: TcxGridDBColumn
          Caption = 'Doc. Faturado'
          DataBinding.FieldName = 'FATURA'
          Width = 123
        end
        object cxgProdutosORI_QTDITE: TcxGridDBColumn
          Caption = 'Qtd. Faturado'
          DataBinding.FieldName = 'ORI_QTDITE'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '#0.0000'
          Width = 72
        end
        object cxgProdutosGER_NUMROM: TcxGridDBColumn
          Caption = 'Romaneio'
          DataBinding.FieldName = 'GER_NUMROM'
          Width = 53
        end
        object cxgProdutosGER_QTDROM: TcxGridDBColumn
          Caption = 'Qtd. Entregue'
          DataBinding.FieldName = 'GER_QTDROM'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '#0.0000'
          Width = 88
        end
        object cxgProdutosMOT_NOMOT: TcxGridDBColumn
          Caption = 'Motorista'
          DataBinding.FieldName = 'MOT_NOMMOT'
          Width = 62
        end
        object cxgProdutosGER_DTABAI: TcxGridDBColumn
          Caption = 'Bx. Romaneio - DT/HR - Recebedor'
          DataBinding.FieldName = 'GER_DTABAI'
          Width = 219
        end
        object cxgProdutosTRA_NOMTRA: TcxGridDBColumn
          Caption = 'Transportadora'
          DataBinding.FieldName = 'TRA_NOMTRA'
          Width = 81
        end
        object cxgProdutosGER_OBSBAI: TcxGridDBColumn
          Caption = 'Obs Bx Romaneio'
          DataBinding.FieldName = 'GER_OBSBAI'
          Width = 180
        end
        object cxgProdutosFDO_NUMCMP: TcxGridDBColumn
          Caption = 'Ped. Compra'
          DataBinding.FieldName = 'FDO_NUMCMP'
          Width = 99
        end
        object cxgProdutosNOTA_DE_ENTRADA: TcxGridDBColumn
          Caption = 'NF de Entrada'
          DataBinding.FieldName = 'NOTA_DE_ENTRADA'
          Width = 97
        end
        object cxgProdutosFDO_NITCMP: TcxGridDBColumn
          Caption = 'Item Ped. Compra'
          DataBinding.FieldName = 'FDO_NITCMP'
          Width = 112
        end
        object cxgProdutosFDO_NUMLOT: TcxGridDBColumn
          Caption = 'Lote Pedido'
          DataBinding.FieldName = 'FDO_NUMLOT'
        end
        object cxgProdutosNUMLOTFAT: TcxGridDBColumn
          Caption = 'Lote Doc. Fat.'
          DataBinding.FieldName = 'NUMLOTFAT'
          Width = 80
        end
      end
      object cxgProdutosLevel: TcxGridLevel
        GridView = cxgProdutosDBTableView
      end
    end
    object cxgConsulta: TcxGrid
      Left = 1
      Top = 1
      Width = 1348
      Height = 121
      Align = alClient
      TabOrder = 1
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgConsultaView: TcxGridDBBandedTableView
        OnKeyDown = cxgConsultaViewKeyDown
        OnKeyUp = cxgConsultaViewKeyUp
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = cxgConsultaViewCellClick
        OnCustomDrawCell = cxgConsultaViewCustomDrawCell
        DataController.DataSource = dtsConsul
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'PEDIDO'
            Styles.Content = cxsPedido
            Styles.Header = cxsTitulo1
            Width = 393
          end
          item
            Caption = 'DOC. FATURAMENTO'
            Styles.Content = cxsFatura
            Styles.Header = cxsTitulo2
            Width = 123
          end
          item
            Caption = 'DOC. CONFIRMA'#199#195'O'
            Styles.Content = cxsDocConf
            Styles.Header = cxsTitulo4
            Width = 163
          end
          item
            Caption = 'DOC. BAIXA ENT. FUT.'
            Styles.Content = cxsEntFut
            Styles.Header = cxsTitulo3
            Width = 103
          end
          item
            Caption = 'ROMANEIO'
            Styles.Content = cxsRomaneio
            Styles.Header = cxsTitulo5
          end
          item
            Caption = 'CONTROLE DE ENTREGADORES '
            Styles.Content = cxCtrEnt
            Styles.Header = cxsTitulo6
          end>
        object cxgConsultaNumPed: TcxGridDBBandedColumn
          Caption = 'PEDIDO'
          DataBinding.FieldName = 'NUMPED'
          BestFitMaxWidth = 77
          MinWidth = 115
          Options.Editing = False
          Options.CellMerging = True
          SortIndex = 2
          SortOrder = soAscending
          Width = 115
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgConsultaJafatu: TcxGridDBBandedColumn
          DataBinding.FieldName = 'JAFATU'
          Visible = False
          Options.Editing = False
          VisibleForCustomization = False
          Width = 20
          Position.BandIndex = 0
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object cxgConsultaDtaPed: TcxGridDBBandedColumn
          Caption = 'DT. EMISS'#195'O'
          DataBinding.FieldName = 'DTAENT'
          BestFitMaxWidth = 61
          MinWidth = 61
          Options.Editing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 61
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgConsultaHorPed: TcxGridDBBandedColumn
          Caption = 'HORA'
          DataBinding.FieldName = 'HORENT'
          Options.Editing = False
          SortIndex = 1
          SortOrder = soAscending
          Width = 20
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgConsultaCodEmp: TcxGridDBBandedColumn
          Caption = 'EMP.FAT.'
          DataBinding.FieldName = 'EMPEXP'
          Options.Editing = False
          Width = 20
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgConsultaCodVen: TcxGridDBBandedColumn
          Caption = 'VEN.'
          DataBinding.FieldName = 'CODVEN'
          BestFitMaxWidth = 24
          MinWidth = 24
          Options.Editing = False
          Width = 24
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgConsultaCodCli: TcxGridDBBandedColumn
          Caption = 'C'#211'D.CLIENTE'
          DataBinding.FieldName = 'CODCLI'
          Visible = False
          Options.Editing = False
          Width = 20
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgConsultaNomCli: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CLIENTE'
          Visible = False
          GroupIndex = 0
          Options.Editing = False
          Width = 23
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object cxgConsultaNomFan: TcxGridDBBandedColumn
          Caption = 'NOME FANTASIA'
          DataBinding.FieldName = 'NOMFAN'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object cxgConsultaSitped: TcxGridDBBandedColumn
          Caption = 'STATUS DEP. FINANCEIRO'
          DataBinding.FieldName = 'SITPED'
          Options.Editing = False
          VisibleForCustomization = False
          Width = 25
          Position.BandIndex = 0
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object cxgConsultaTipAte: TcxGridDBBandedColumn
          Caption = 'TIPO DE ATENDIMENTO'
          DataBinding.FieldName = 'TIPATE'
          Options.Editing = False
          VisibleForCustomization = False
          Width = 21
          Position.BandIndex = 0
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object cxgConsultaSepImp: TcxGridDBBandedColumn
          Caption = 'SEP. IMP. ?'
          DataBinding.FieldName = 'SEPIMP'
          Options.Editing = False
          VisibleForCustomization = False
          Width = 20
          Position.BandIndex = 0
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
        object cxgConsultaNumCmp: TcxGridDBBandedColumn
          Caption = 'PED. CLIENTE'
          DataBinding.FieldName = 'NUMCMP'
          Options.Editing = False
          Width = 23
          Position.BandIndex = 0
          Position.ColIndex = 12
          Position.RowIndex = 0
        end
        object cxgConsultaHorExp: TcxGridDBBandedColumn
          Caption = 'HR. EXP.'
          DataBinding.FieldName = 'HOREXP'
          Options.Editing = False
          Width = 20
          Position.BandIndex = 0
          Position.ColIndex = 16
          Position.RowIndex = 0
        end
        object cxgConsultaHorSep: TcxGridDBBandedColumn
          Caption = 'HR. SEP.'
          DataBinding.FieldName = 'HORSEP'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 26
          Position.RowIndex = 0
        end
        object cxgConsultaDtLibCom: TcxGridDBBandedColumn
          Caption = 'DT LIB.COM'
          DataBinding.FieldName = 'DTALIC'
          Position.BandIndex = 0
          Position.ColIndex = 14
          Position.RowIndex = 0
        end
        object cxgConsultaLibCom: TcxGridDBBandedColumn
          Caption = 'LIB. COM.'
          DataBinding.FieldName = 'FGO_LIBCOM'
          Options.Editing = False
          Width = 64
          Position.BandIndex = 0
          Position.ColIndex = 15
          Position.RowIndex = 0
        end
        object cxgConsultaDtLibFin: TcxGridDBBandedColumn
          Caption = 'DT LIB.FIN'
          DataBinding.FieldName = 'DTALIB'
          Position.BandIndex = 0
          Position.ColIndex = 17
          Position.RowIndex = 0
        end
        object cxgConsultaHorLib: TcxGridDBBandedColumn
          Caption = 'HR LIB.'
          DataBinding.FieldName = 'HORLIB'
          Position.BandIndex = 0
          Position.ColIndex = 18
          Position.RowIndex = 0
        end
        object cxgConsultaLibera: TcxGridDBBandedColumn
          Caption = 'LIB. FIN.'
          DataBinding.FieldName = 'FGO_LIBERA'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 19
          Position.RowIndex = 0
        end
        object cxgConsultaStatus: TcxGridDBBandedColumn
          DataBinding.FieldName = 'STATUS'
          Options.Editing = False
          Width = 64
          Position.BandIndex = 0
          Position.ColIndex = 20
          Position.RowIndex = 0
        end
        object cxgConsultaPedCom: TcxGridDBBandedColumn
          Caption = 'PEDIDO COMPRA'
          DataBinding.FieldName = 'PEDCOM'
          Options.Editing = False
          Width = 64
          Position.BandIndex = 0
          Position.ColIndex = 21
          Position.RowIndex = 0
        end
        object cxgConsultaDtEntr: TcxGridDBBandedColumn
          Caption = 'DT. ENTREGA'
          DataBinding.FieldName = 'DTENTR'
          BestFitMaxWidth = 61
          Options.Editing = False
          SortIndex = 9
          SortOrder = soAscending
          Width = 61
          Position.BandIndex = 0
          Position.ColIndex = 22
          Position.RowIndex = 0
        end
        object cxgConsultaEmpConf: TcxGridDBBandedColumn
          Caption = 'EMP.'
          DataBinding.FieldName = 'EMPCONF'
          Options.Editing = False
          Width = 20
          Position.BandIndex = 2
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgConsultaEspConf: TcxGridDBBandedColumn
          Caption = 'ESP.'
          DataBinding.FieldName = 'ESPCONF'
          Options.Editing = False
          Width = 20
          Position.BandIndex = 2
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgConsultaNumConf: TcxGridDBBandedColumn
          Caption = 'N'#218'MERO'
          DataBinding.FieldName = 'NUMCONF'
          BestFitMaxWidth = 77
          MinWidth = 77
          Options.Editing = False
          Width = 77
          Position.BandIndex = 2
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgConsultaEmiConf: TcxGridDBBandedColumn
          Caption = 'DT. EMISS'#195'O'
          DataBinding.FieldName = 'EMICONF'
          BestFitMaxWidth = 61
          MinWidth = 61
          Options.Editing = False
          Width = 61
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgConsultaEspOri: TcxGridDBBandedColumn
          Caption = 'ESP.'
          DataBinding.FieldName = 'ESPORI'
          Options.Editing = False
          SortIndex = 3
          SortOrder = soAscending
          Width = 20
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgConsultaDocOri: TcxGridDBBandedColumn
          Caption = 'N'#218'MERO'
          DataBinding.FieldName = 'NUMORI'
          BestFitMaxWidth = 77
          MinWidth = 77
          Options.Editing = False
          SortIndex = 4
          SortOrder = soAscending
          Width = 77
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgConsultaOriPed: TcxGridDBBandedColumn
          Caption = 'DOC. ORIGEM'
          DataBinding.FieldName = 'ORIPED'
          Visible = False
          GroupIndex = 1
          Options.Editing = False
          SortIndex = 10
          SortOrder = soAscending
          Width = 43
          Position.BandIndex = 0
          Position.ColIndex = 25
          Position.RowIndex = 0
        end
        object cxgConsultaEmpOri: TcxGridDBBandedColumn
          Caption = 'EMP.'
          DataBinding.FieldName = 'EMPORI'
          Options.Editing = False
          SortIndex = 5
          SortOrder = soAscending
          Width = 43
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgConsultaHorFat: TcxGridDBBandedColumn
          Caption = 'HORA'
          DataBinding.FieldName = 'HRAFAT'
          Options.Editing = False
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgConsultaEmiFat: TcxGridDBBandedColumn
          Caption = 'DT. EMISS'#195'O'
          DataBinding.FieldName = 'EMIFAT'
          BestFitMaxWidth = 61
          MinWidth = 61
          Options.Editing = False
          Width = 61
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgConsultaSituac: TcxGridDBBandedColumn
          Caption = 'LALAMOVE'
          DataBinding.FieldName = 'SITUAC'
          OnGetDisplayText = cxgConsultaSituacGetDisplayText
          Options.Editing = False
          Width = 88
          Position.BandIndex = 1
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgConsultaEspBai: TcxGridDBBandedColumn
          Caption = 'ESP.'
          DataBinding.FieldName = 'ESPBAI'
          Options.Editing = False
          SortIndex = 6
          SortOrder = soAscending
          Width = 20
          Position.BandIndex = 3
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgConsultaDocBai: TcxGridDBBandedColumn
          Caption = 'N'#218'MERO'
          DataBinding.FieldName = 'NUMBAI'
          BestFitMaxWidth = 77
          MinWidth = 77
          Options.Editing = False
          SortIndex = 7
          SortOrder = soAscending
          Width = 77
          Position.BandIndex = 3
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgConsultaEmpBai: TcxGridDBBandedColumn
          Caption = 'EMP.'
          DataBinding.FieldName = 'EMPBAI'
          Options.Editing = False
          SortIndex = 8
          SortOrder = soAscending
          Width = 56
          Position.BandIndex = 3
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgConsultaEmiBai: TcxGridDBBandedColumn
          Caption = 'DT. EMISS'#195'O'
          DataBinding.FieldName = 'EMIBAI'
          BestFitMaxWidth = 61
          MinWidth = 61
          Options.Editing = False
          Width = 61
          Position.BandIndex = 3
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgConsultaRom: TcxGridDBBandedColumn
          Caption = 'N'#218'MERO'
          DataBinding.FieldName = 'NUMROM'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgConsultaDtaRom: TcxGridDBBandedColumn
          Caption = 'DT. ROM.'
          DataBinding.FieldName = 'DTAROM'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgConsultaHorRom: TcxGridDBBandedColumn
          Caption = 'HR. ROM.'
          DataBinding.FieldName = 'HORROM'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgConsultaDtaIni: TcxGridDBBandedColumn
          Caption = 'DT. SA'#205'DA'
          DataBinding.FieldName = 'DTAINI'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgConsultaHorIni: TcxGridDBBandedColumn
          Caption = 'HR. SA'#205'DA'
          DataBinding.FieldName = 'HORINI'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgConsultaDtaChe: TcxGridDBBandedColumn
          Caption = 'DT. CHEGADA'
          DataBinding.FieldName = 'DTACHE'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgConsultaHorChe: TcxGridDBBandedColumn
          Caption = 'HR. CHEGADA'
          DataBinding.FieldName = 'HORCHE'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object cxgConsultaDtaRomBai: TcxGridDBBandedColumn
          Caption = 'DT. BAIXA'
          DataBinding.FieldName = 'DTAROB'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object cxgConsultaHorRomBai: TcxGridDBBandedColumn
          Caption = 'HR. BAIXA'
          DataBinding.FieldName = 'HORROB'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object cxgConsultaEspera: TcxGridDBBandedColumn
          Caption = 'EM ESPERA'
          DataBinding.FieldName = 'ESPERA'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object cxgConsultaDetRom: TcxGridDBBandedColumn
          Caption = 'DETALHES'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                610000001974455874536F6674776172650041646F626520496D616765526561
                647971C9653C0000000F744558745469746C6500436F6D626F426F783B9CE12C
                20000001AE49444154785E8592B16B15411087BFB9A8B5857F869641B1F18145
                B0B0086265501B15B4102D0282360A965150525888BE4A10C1422B11028F0822
                287616AF11BB70CA13412E77BB337A935DD67B0819B8BB99E2F7F1EDDC0A501E
                A07C772D054C80EAE178F36D2532320133FC65A43298360BCC575531BB77E1C8
                813D4085C8E8DCE9452C05E6EBE6D38FAC2C1F1C00EE3C98EC07AA1E201A1553
                E8D4D3884BA40663FAF53BB3EDC0DAFAC4A56F5F1FD17511401C1055518ABA15
                880F5D503E4F7FD0B6EAD02FDF7E65003D80DE20DB632448A910226D80E34B87
                1CDE45A50BC5404254D6C713DC2051CC7BC1309A36F0EAE5A77CA44497A1C1E5
                F3C732D52182873D73692EB76FA162EDD11B36B3418C8A9A317EF1014C002B20
                71934410EA7AC6EA9525425048007A00062BCB8B305862EE709B6C6580AA0370
                83E083F1E4F97BF74F955A1B2CB8AE7F72E3EA09622C06A231BAE6D95387131F
                862A652499A95A5962882EC6E367EF70D9FF0425296CD5336E5D3B49D46280AA
                7AE8E299A3203277934A15AAA1560C62D3FCDEB87BFFF5282FABDCC80C195E30
                C168DBED0D200850017B134CD8AD8A4600DA3F7B150F2026604F150000000049
                454E44AE426082}
              Kind = bkGlyph
            end>
          Properties.ViewStyle = vsButtonsOnly
          Properties.OnButtonClick = cxgConsultaDetRomPropertiesButtonClick
          Options.ShowEditButtons = isebAlways
          Width = 58
          Position.BandIndex = 4
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object cxgConsultaMtrRom: TcxGridDBBandedColumn
          Caption = 'MOTORISTA'
          DataBinding.FieldName = 'MTRROM'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
        object cxgConsultaTranspRom: TcxGridDBBandedColumn
          Caption = 'TRANSPORTADORA'
          DataBinding.FieldName = 'NOMTRA'
          Options.Editing = False
          Position.BandIndex = 4
          Position.ColIndex = 12
          Position.RowIndex = 0
        end
        object cxgConsultaPedBxNEtg: TcxGridDBBandedColumn
          Caption = 'PED.BX.N'#195'O.ENTREGUE'
          DataBinding.FieldName = 'PBNENT'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 23
          Position.RowIndex = 0
        end
        object cxgConsultaHistBai: TcxGridDBBandedColumn
          Caption = 'MOTIVO'
          DataBinding.FieldName = 'HISBAI'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 24
          Position.RowIndex = 0
        end
        object cxgConsultaHorLic: TcxGridDBBandedColumn
          Caption = 'HR. LIC.'
          DataBinding.FieldName = 'HORLIC'
          Position.BandIndex = 0
          Position.ColIndex = 13
          Position.RowIndex = 0
        end
        object cxgConsultaViewSaitaCtrlEnt: TcxGridDBBandedColumn
          Caption = 'SA'#205'DA'
          DataBinding.FieldName = 'DTASAI'
          Options.Editing = False
          Width = 80
          Position.BandIndex = 5
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgConsultaViewChegadaCtrlEnt: TcxGridDBBandedColumn
          Caption = 'CHEGADA'
          DataBinding.FieldName = 'DTACHG'
          Options.Editing = False
          Width = 87
          Position.BandIndex = 5
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgConsultaViewMotoristaCtrlEnt: TcxGridDBBandedColumn
          Caption = 'MOTORISTA'
          DataBinding.FieldName = 'MOTORA'
          Options.Editing = False
          Width = 130
          Position.BandIndex = 5
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgConsultaViewLAL_NOMMOT: TcxGridDBBandedColumn
          Caption = 'Nome do Motorista'
          DataBinding.FieldName = 'LAL_NOMMOT'
          Visible = False
          Options.ShowEditButtons = isebNever
          Position.BandIndex = 0
          Position.ColIndex = 27
          Position.RowIndex = 0
        end
        object cxgConsultaViewLAL_PLAVEI: TcxGridDBBandedColumn
          Caption = 'Placa do Ve'#237'culo'
          DataBinding.FieldName = 'LAL_PLAVEI'
          Visible = False
          Options.ShowEditButtons = isebNever
          Position.BandIndex = 0
          Position.ColIndex = 28
          Position.RowIndex = 0
        end
      end
      object cxgConsultaLevel1: TcxGridLevel
        GridView = cxgConsultaView
      end
    end
    object pnlRodape: TPanel
      Left = 1
      Top = 122
      Width = 1348
      Height = 35
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object Label7: TLabel
        Left = 7
        Top = 4
        Width = 130
        Height = 14
        Caption = 'Quantidade de Pedidos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 7
        Top = 19
        Width = 171
        Height = 14
        Caption = 'Quantidade de Itens no Pedido:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotPed: TLabel
        Left = 183
        Top = 2
        Width = 6
        Height = 14
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotItePed: TLabel
        Left = 183
        Top = 19
        Width = 33
        Height = 14
        Caption = '0,0000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 568
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 672
    Top = 120
  end
  object dtsConsul: TDataSource
    OnDataChange = dtsConsulDataChange
    Left = 744
    Top = 272
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 800
    Top = 128
    PixelsPerInch = 96
    object cxsTitulo1: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
    object cxsTitulo2: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
    object cxsFatura: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clBlue
    end
    object cxsTitulo3: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clPurple
    end
    object cxsTitulo4: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsEntFut: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clGreen
    end
    object cxsDocConf: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clRed
    end
    object cxsPedido: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object cxsPedidoBaixado: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clRed
    end
    object cxsTitulo5: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clMaroon
    end
    object cxsRomaneio: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clMaroon
    end
    object cxCtrEnt: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clPurple
    end
    object cxsTitulo6: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clPurple
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsItensPedido
    Left = 624
    Top = 408
  end
  object cdsItensPedido: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtpItensPedido'
    Left = 544
    Top = 385
  end
  object dtpItensPedido: TUniDataSetProvider
    Options = []
    Left = 456
    Top = 385
  end
  object cdsItensCache: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 393
    object cdsItensCacheAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsItensCacheSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 50
    end
  end
  object tmrProdutos: TTimer
    Enabled = False
    Interval = 600
    OnTimer = tmrProdutosTimer
    Left = 944
    Top = 128
  end
end
