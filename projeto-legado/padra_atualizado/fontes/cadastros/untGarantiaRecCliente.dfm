inherited frmGarantiaRecCliente: TfrmGarantiaRecCliente
  Left = 236
  Top = 143
  Width = 942
  Height = 582
  BorderIcons = [biSystemMenu]
  Caption = 'Recebimento do Cliente'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 942
  ExplicitHeight = 582
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 509
    Width = 936
    TabOrder = 3
    ExplicitTop = 509
    ExplicitWidth = 936
    DesignSize = (
      936
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 932
      ExplicitWidth = 932
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F10 ] Confirmar'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnInformarLoteItem: TBitBtnLocked
        Left = 110
        Top = 0
        Width = 123
        Height = 22
        Caption = '[F3] Selecionar Lote'
        Enabled = False
        TabOrder = 1
        OnClick = btnInformarLoteItemClick
      end
      object btnAssistenciaTecnica: TBitBtnLocked
        Left = 233
        Top = 0
        Width = 136
        Height = 22
        Caption = '[F4] Assist'#234'ncia T'#233'cnica'
        Enabled = False
        TabOrder = 2
        Visible = False
        OnClick = btnAssistenciaTecnicaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 841
      Top = 2
      Width = 93
      ExplicitLeft = 841
      ExplicitTop = 2
      ExplicitWidth = 93
    end
  end
  inherited pnlStatus: TPanel
    Top = 537
    Width = 936
    TabOrder = 4
    ExplicitTop = 537
    ExplicitWidth = 936
    inherited pnlNomeForm: TPanel
      Left = 765
      ExplicitLeft = 765
    end
    inherited pnlInfo: TPanel
      Width = 765
      ExplicitWidth = 765
    end
  end
  object pnlGarantia: TPanel [2]
    Left = 0
    Top = 0
    Width = 936
    Height = 146
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label2: TLabel
      Left = 22
      Top = 75
      Width = 52
      Height = 14
      AutoSize = False
      Caption = 'Vendedor:'
    end
    object Label3: TLabel
      Left = 7
      Top = 12
      Width = 62
      Height = 14
      AutoSize = False
      Caption = 'Data Entrada:'
    end
    object Label4: TLabel
      Left = 36
      Top = 99
      Width = 38
      Height = 14
      AutoSize = False
      Caption = 'Cliente:'
    end
    object lblPlaVei: TLabel
      Left = 616
      Top = 99
      Width = 67
      Height = 14
      AutoSize = False
      Caption = 'Placa Ve'#237'culo:'
    end
    object lblIndGarantiaPropriaEmpresa: TLabel
      Left = 432
      Top = 11
      Width = 140
      Height = 14
      Caption = 'Garantia Pr'#243'pria Empresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object chkReposicao: TCheckBox
      Left = 73
      Top = 32
      Width = 619
      Height = 17
      Caption = 
        'Reposi'#231#227'o Imediata do Produto ao Cliente (Caso exista produtos c' +
        'om Reposi'#231#227'o e Sem Reposi'#231#227'o efetuar 2 Recebimentos)'
      TabOrder = 3
      OnClick = chkReposicaoClick
    end
    object chkCredito: TCheckBox
      Left = 73
      Top = 47
      Width = 162
      Height = 17
      Caption = 'Gerar Cr'#233'dito para o Cliente '
      TabOrder = 4
      OnClick = chkCreditoClick
    end
    object edtSenVen: TEditFocus
      Tag = 99
      Left = 73
      Top = 71
      Width = 108
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 183
      Top = 71
      Width = 573
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 73
      Top = 95
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 7
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
      Left = 147
      Top = 95
      Width = 463
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaEnt: TMaskEditFocus
      Tag = 99
      Left = 73
      Top = 8
      Width = 110
      Height = 22
      EditMask = '!99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object btnImportarXML: TBitBtnLocked
      Left = 184
      Top = 8
      Width = 112
      Height = 22
      Hint = 'Importar um novo XML para o Autcom'
      Caption = 'Importar XML'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000090000
        000E000000100000001000000010000000100000001000000011000000110000
        0011000000110000001100000011000000100000000B0000000377544AC1A474
        66FFA47465FFA47465FFA37364FFA37264FFA27263FFA27263FFA27162FFA271
        62FFA17062FFA17061FFA17061FFA17061FF735046C30000000AAC7E71FFF8F1
        EEFFF8F0EDFFF8F1ECFFF8F0ECFFF8F0ECFFF5EDE9FFF2EAE6FFF5EDE9FFF8EF
        EBFFF7EFEBFFF7EFEBFFF7EFEBFFF7F0EBFFA8796AFF0000000FAD8172FFF8F2
        EFFFF6EDE8FFF7EDE8FFF6ECE8FFF4EBE6FFE6DBD6FFA87A62FFE7DCD8FFF5EB
        E6FFF6EDE7FFF6ECE8FFF6ECE8FFF8F0ECFFA97B6BFF00000010AF8375FFF9F2
        EFFFF6ECE8FFF6EDE9FFF6ECE7FFEDE5E0FFAD836EFFC58A51FFB08975FFEDE4
        E0FFF6ECE7FFF6ECE8FFF6ECE8FFF8F1EDFFAA7C6DFF0000000FB18577FFF9F3
        F0FFF7EDE9FFF7EDE8FFF3EAE5FFCDB3A8FFAC6E41FFF7C67AFFA96B40FFCDB6
        ABFFF1E8E4FFF7EDE8FFF6EDE9FFF9F1EDFFAB7E6FFF0000000EB2887AFFF9F4
        F0FFF7EEE9FFF5EBE7FFE4D8D1FFA06544FFEFBE79FFF9CA82FFEDBB78FF9F63
        42FFE3D7D2FFF4EBE7FFF7EEE9FFF8F1EEFFAD8072FF0000000EB48A7CFFF9F4
        F1FFF7EEEAFFF4EBE7FFC69E83FFB47C54FFB47B53FFFACF88FFB37851FFB277
        4FFFC3987EFFF2E9E5FFF7EEE9FFF9F2EFFFAF8274FF0000000DB68D7FFFFAF4
        F2FFF7EEEAFFF6EDE9FFF2E9E5FFE9E1DDFFB77F57FFFDD48EFFB1744CFFE8DF
        DBFFF1E7E4FFF6EDE9FFF7EEEAFFF9F2EFFFB08476FF0000000CB88F82FFFAF5
        F2FFF7EEEAFFF7EEEBFFF7EEEAFFF0E7E5FFBA845CFFFEEAC1FFB2774FFFEFE7
        E3FFF7EEEAFFF7EFEAFFF7EEEAFFF9F3F0FFB28679FF0000000CB99184FFFAF5
        F3FFF8EFEBFFF7EFEAFFF7EFEBFFF2EAE6FFCB9E76FFCB9E76FFCB9E76FFF2E8
        E5FFF7EFEAFFF7EEEAFFF7EFEBFFFAF4F1FFB3897BFF0000000BBB9387FFFAF6
        F4FFF7EFEBFFF7EEEBFFF8EFEBFFF6EDEAFFF2EAE6FFF1E9E5FFF2EAE6FFF6ED
        EAFFF7EFEBFFF7EFEBFFF7EEEBFFFAF3F2FFB58B7DFF0000000AD4A477FFD8B1
        8BFFD2A373FFD1A372FFD1A272FFD1A170FFD0A070FFD09F6FFFCF9F6EFFCE9E
        6DFFCF9D6CFFCE9C6BFFCE9C6AFFD3A77CFFCE9764FF00000009D4A678FFEED7
        B6FFE2BB87FFE2BA86FFE2B985FFE2BA85FFE2BA85FFE1B984FFE1B984FFE1B8
        84FFE1B883FFE1B883FFE0B783FFEBD0AAFFCE9864FF00000009D4A679FFF1DC
        BCFFF0DCBCFFF0DBBCFFF0DBBCFFF0DCBBFFEFDABBFFEFDABBFFEFDABAFFEFDA
        B9FFEFD8B9FFEFD9B8FFEFD8B6FFEED5B1FFCE9865FF000000089E7B5AC0D4A6
        79FFD4A577FFD4A476FFD3A375FFD3A272FFD2A071FFD1A06FFFD09F6FFFD09D
        6DFFD09C6CFFD09B6AFFCF9B68FFCF9A67FF99714BC200000005}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnImportarXMLClick
    end
    object btnNotEle: TBitBtnLocked
      Left = 299
      Top = 8
      Width = 114
      Height = 22
      Hint = 'Carregar um XML j'#225' importado'
      Caption = 'Carregar XML'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnNotEleClick
    end
    object mskPlaVei: TMaskEditFocus
      Tag = 99
      Left = 685
      Top = 95
      Width = 71
      Height = 22
      Hint = 'Pressione INSERT para inserir um novo Ve'#237'culo'
      AutoSelect = False
      AutoSize = False
      CharCase = ecUpperCase
      EditMask = 'aaa-9a99;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object pnlFavorecidoCredito: TPanel
      Left = 1
      Top = 119
      Width = 934
      Height = 26
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlFavorecidoCredito'
      ShowCaption = False
      TabOrder = 10
      object lblNomeFavorecido: TLabel
        Left = 14
        Top = 3
        Width = 59
        Height = 14
        AutoSize = False
        Caption = 'Favorecido:'
      end
      object edtFavorecido: TEditFocus
        Tag = 99
        Left = 72
        Top = 0
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 0
        OnExit = edtFavorecidoExit
        OnKeyPress = edtFavorecidoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomeFavorecido: TEditFocus
        Left = 146
        Top = 0
        Width = 463
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = 16768952
        RequeridoColor = 16768952
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlProdutos: TPanel [3]
    Left = 0
    Top = 146
    Width = 936
    Height = 129
    Align = alTop
    Color = 16770261
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 1
    object pnlProdutoPrincipal: TPanel
      Left = 1
      Top = 1
      Width = 934
      Height = 127
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Label6: TLabel
        Left = 32
        Top = 6
        Width = 41
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Produto:'
      end
      object Label7: TLabel
        Left = 159
        Top = 30
        Width = 57
        Height = 14
        AutoSize = False
        Caption = 'Refer'#234'ncia:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 607
        Top = 30
        Width = 42
        Height = 14
        AutoSize = False
        Caption = 'Unidade:'
      end
      object Label9: TLabel
        Left = 32
        Top = 30
        Width = 41
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtde:'
      end
      object Label12: TLabel
        Left = 40
        Top = 54
        Width = 34
        Height = 14
        AutoSize = False
        Caption = 'Obs 1:'
      end
      object Label13: TLabel
        Left = 40
        Top = 78
        Width = 34
        Height = 14
        AutoSize = False
        Caption = 'Obs 2:'
      end
      object lblNumLot: TLabel
        Left = 528
        Top = 6
        Width = 90
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'd Armaz. Sa'#237'da:'
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 73
        Top = 1
        Width = 110
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        OnExit = edtCodIteExit
        OnKeyPress = edtCodIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtReferencia: TEditFocus
        Left = 216
        Top = 26
        Width = 385
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesUni: TEditFocus
        Left = 649
        Top = 26
        Width = 107
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesIte: TEditFocus
        Left = 184
        Top = 1
        Width = 338
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdIte: TEditFocus
        Tag = 99
        Left = 73
        Top = 26
        Width = 80
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtObsP_2: TEditFocus
        Tag = 99
        Left = 73
        Top = 74
        Width = 570
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 100
        ReadOnly = True
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtObsP_1: TEditFocus
        Left = 73
        Top = 50
        Width = 570
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 100
        ReadOnly = True
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object btnCancelar: TBitBtnLocked
        Left = 649
        Top = 74
        Width = 107
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
        TabOrder = 10
        OnClick = btnCancelarClick
      end
      object btnAdicionar: TBitBtnLocked
        Left = 649
        Top = 51
        Width = 107
        Height = 22
        Caption = 'Adicionar'
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
        TabOrder = 9
        OnClick = btnAdicionarClick
      end
      object edtNumLot: TEditFocus
        Tag = 99
        Left = 618
        Top = 1
        Width = 138
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        OnKeyPress = edtNumLotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object pnlVlrCredito: TPanel
        Left = 0
        Top = 99
        Width = 934
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlVlrCredito'
        ShowCaption = False
        TabOrder = 8
        object lblVlrCredito: TLabel
          Left = 1
          Top = 6
          Width = 72
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Unit. Cr'#233'dito:'
        end
        object edtUniCrd: TEditFocus
          Tag = 99
          Left = 73
          Top = 0
          Width = 80
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          Text = '0,00'
          OnExit = edtUniCrdExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
    end
  end
  object dbgItens: TDBGridCitel [4]
    Left = 0
    Top = 275
    Width = 936
    Height = 234
    Align = alClient
    DataSource = dtsItens
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnCellClick = dbgItensCellClick
    OnDblClick = dbgItensDblClick
    OnKeyDown = dbgItensKeyDown
    OnKeyPress = dbgItensKeyPress
    CorZebra = clMoneyGreen
    Zebra = True
    DestacarMouse = True
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        ReadOnly = True
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 190
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REFERE'
        ReadOnly = True
        Title.Caption = 'Refer'#234'ncia'
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESUNI'
        ReadOnly = True
        Title.Caption = 'Unidade'
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMDOC'
        ReadOnly = True
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPDOC'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Emp.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_UNITAR'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTITE'
        Title.Alignment = taRightJustify
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCONTOS'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTLIQ'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOTSAI'
        ReadOnly = True
        Width = 138
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODATC'
        Visible = False
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 586
    Top = 288
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 488
    Top = 56
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 646
    Top = 288
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'NUMENT'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'DTAENT'
        DataType = ftDateTime
      end
      item
        Name = 'CODVEN'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'CODCLI'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'CODFOR'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'CODITE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DESITE'
        DataType = ftString
        Size = 86
      end
      item
        Name = 'NUMDOC'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'EMPDOC'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'QTDITE'
        DataType = ftFloat
      end
      item
        Name = 'VALITE'
        DataType = ftFloat
      end
      item
        Name = 'REPOST'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'REFERE'
        DataType = ftString
        Size = 16
      end
      item
        Name = 'DESUNI'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'OBSP_1'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'OBSP_2'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'AUTINC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'QTDDEV'
        DataType = ftFloat
      end
      item
        Name = 'DTAENV'
        DataType = ftDateTime
      end
      item
        Name = 'JA_GRAVADO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CODFAB'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PRECUS'
        DataType = ftFloat
      end
      item
        Name = 'TABPRE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMLOT'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'GARFIL'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DESACE'
        DataType = ftFloat
      end
      item
        Name = 'LOTSAI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'DOCFAT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SEQDOC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'INCORI'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ITE_CODATC'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'UNICRD'
        DataType = ftFloat
      end
      item
        Name = 'UNICRDORI'
        DataType = ftFloat
      end
      item
        Name = 'DET_UNITAR'
        DataType = ftFloat
      end
      item
        Name = 'DET_DESESP'
        DataType = ftFloat
      end
      item
        Name = 'DET_DESCFF'
        DataType = ftFloat
      end
      item
        Name = 'TOTITE'
        DataType = ftFloat
      end
      item
        Name = 'DESCONTOS'
        DataType = ftFloat
      end
      item
        Name = 'TOTLIQ'
        DataType = ftFloat
      end
      item
        Name = 'BXSBIT'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'TABELA'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforeInsert = cdsItensBeforeInsert
    BeforePost = cdsItensBeforePost
    AfterPost = cdsItensAfterPost
    AfterCancel = cdsItensAfterCancel
    BeforeDelete = cdsItensBeforeDelete
    AfterDelete = cdsItensAfterDelete
    OnNewRecord = cdsItensNewRecord
    Left = 616
    Top = 288
    object cdsItensNUMENT: TStringField
      FieldName = 'NUMENT'
      Size = 12
    end
    object cdsItensDTAENT: TDateTimeField
      FieldName = 'DTAENT'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = 'dd/mm/yyyy'
    end
    object cdsItensCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
    object cdsItensCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsItensCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 8
    end
    object cdsItensCODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsItensDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o / Refer'#234'ncia'
      FieldName = 'DESITE'
      Size = 86
    end
    object cdsItensNUMDOC: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'NUMDOC'
      Size = 30
    end
    object cdsItensEMPDOC: TStringField
      DisplayLabel = 'Empresa Documento'
      FieldName = 'EMPDOC'
      Size = 3
    end
    object cdsItensQTDITE: TFloatField
      DisplayLabel = 'Qtd'
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensVALITE: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensREPOST: TStringField
      DisplayLabel = 'R'
      FieldName = 'REPOST'
      OnGetText = cdsItensREPOSTGetText
      Size = 1
    end
    object cdsItensREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsItensDESUNI: TStringField
      FieldName = 'DESUNI'
      Size = 15
    end
    object cdsItensOBSP_1: TStringField
      FieldName = 'OBSP_1'
      Size = 70
    end
    object cdsItensOBSP_2: TStringField
      FieldName = 'OBSP_2'
      Size = 70
    end
    object cdsItensAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsItensQTDDEV: TFloatField
      FieldName = 'QTDDEV'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensDTAENV: TDateTimeField
      FieldName = 'DTAENV'
    end
    object cdsItensJA_GRAVADO: TStringField
      FieldName = 'JA_GRAVADO'
      Size = 1
    end
    object cdsItensCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsItensPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsItensTABPRE: TStringField
      FieldName = 'TABPRE'
      Size = 1
    end
    object cdsItensNUMLOT: TStringField
      DisplayLabel = 'Lote'
      FieldName = 'NUMLOT'
      Size = 100
    end
    object cdsItensGARFIL: TStringField
      FieldName = 'GARFIL'
      Size = 1
    end
    object cdsItensDESACE: TFloatField
      DisplayLabel = 'Desp.Acess'#243'ria'
      FieldName = 'DESACE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensLOTSAI: TStringField
      DisplayLabel = 'Lote Sa'#237'da'
      FieldName = 'LOTSAI'
      OnValidate = ValidarLoteSaidaSelecionado
      Size = 100
    end
    object cdsItensDOCFAT: TStringField
      FieldName = 'DOCFAT'
    end
    object cdsItensSEQDOC: TStringField
      FieldName = 'SEQDOC'
    end
    object cdsItensINCORI: TStringField
      FieldName = 'INCORI'
    end
    object cdsItensITE_CODATC: TStringField
      DisplayLabel = 'Assist'#234'ncia'
      FieldName = 'ITE_CODATC'
      Size = 5
    end
    object cdsItensUNICRD: TFloatField
      FieldName = 'UNICRD'
    end
    object cdsItensUNICRDORI: TFloatField
      FieldName = 'UNICRDORI'
    end
    object cdsItensDET_UNITAR: TFloatField
      DisplayLabel = 'Vl. Unit'#225'rio'
      FieldName = 'DET_UNITAR'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensDET_DESESP: TFloatField
      FieldName = 'DET_DESESP'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensDET_DESCFF: TFloatField
      FieldName = 'DET_DESCFF'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensTOTITE: TFloatField
      DisplayLabel = 'Vl. Total'
      FieldName = 'TOTITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensDESCONTOS: TFloatField
      DisplayLabel = 'Descontos'
      FieldName = 'DESCONTOS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensTOTLIQ: TFloatField
      DisplayLabel = 'Vl. Total L'#237'q.'
      FieldName = 'TOTLIQ'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensBXSBIT: TStringField
      FieldName = 'BXSBIT'
      ProviderFlags = []
      Size = 1
    end
    object cdsItensTABELA: TStringField
      FieldName = 'TABELA'
    end
  end
  object frxReportEti: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39422.366011261600000000
    ReportOptions.LastChange = 42010.624441550900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 364
    Top = 336
    Datasets = <
      item
        DataSet = frxDadosEti
        DataSetName = 'frxDadosEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 104.000000000000000000
      PaperHeight = 122.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 12.000000000000000000
      BottomMargin = 12.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      Frame.LeftLine.Width = 2.000000000000000000
      Frame.TopLine.Width = 2.000000000000000000
      Frame.RightLine.Width = 2.000000000000000000
      Frame.BottomLine.Width = 2.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 461.102362200000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 347.716760000000000000
        Columns = 1
        ColumnWidth = 132.300000000000000000
        DataSet = frxDadosEti
        DataSetName = 'frxDadosEti'
        RowCount = 0
        object Memo5: TfrxMemoView
          Left = 10.204634090000000000
          Top = 44.236240000000000000
          Width = 162.519670390000000000
          Height = 20.787404020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Produto:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 181.314960630000000000
          Top = 105.826840000000000000
          Width = 155.716547640000000000
          Height = 20.787404020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            'Doc. de Venda')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 10.204634090000000000
          Top = 212.141930000000000000
          Width = 326.173228350000000000
          Height = 20.787404020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Motivo / Defeito:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 181.314960630000000000
          Top = 44.236240000000000000
          Width = 155.716547640000000000
          Height = 20.787404020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            'Data')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 10.204634090000000000
          Top = 137.312375000000000000
          Width = 162.519670390000000000
          Height = 20.787404020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Fornecedor:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 181.314960630000000000
          Top = 159.417440000000000000
          Width = 155.716547640000000000
          Height = 20.787404020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            'Doc. de Garantia')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 10.204634090000000000
          Top = 331.842519685039000000
          Width = 326.173228350000000000
          Height = 28.346456690000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Operador: [<frxDadosEti."NOMOPE">]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 10.204634090000000000
          Top = 9.322820000000000000
          Width = 327.685039370079000000
          Height = 26.078745040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM EM GARANTIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 181.314960630000000000
          Top = 65.314960630000000000
          Width = 155.716547640000000000
          Height = 32.125994020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            '[<frxDadosEti."DTAENT">]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 181.314960630000000000
          Top = 126.165430000000000000
          Width = 155.716547640000000000
          Height = 23.811023620000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[<frxDadosEti."NUMDOC">]-[<frxDadosEti."ESPDOC">]-[<frxDadosEti.' +
              '"CODEMP">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo7: TfrxMemoView
          Left = 181.314960630000000000
          Top = 179.643093430000000000
          Width = 155.716547640000000000
          Height = 23.811018740000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            '[<frxDadosEti."NUMGAR">]-GA-[<frxDadosEti."CODEMP">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 10.204634090000000000
          Top = 65.314960630000000000
          Width = 162.519670390000000000
          Height = 62.362234020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[<frxDadosEti."CODITE">] - [<frxDadosEti."DESITE">]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 10.204634090000000000
          Top = 157.769085000000000000
          Width = 162.519670390000000000
          Height = 45.354330710000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[<frxDadosEti."CODFOR">] - [<frxDadosEti."NOMFOR">]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 10.204634090000000000
          Top = 233.567100000000000000
          Width = 326.173228350000000000
          Height = 89.952755910000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[<frxDadosEti."OBSP_1">] [<frxDadosEti."OBSP_2">]')
          ParentFont = False
        end
      end
    end
  end
  object frxDadosEti: TfrxDBDataset
    UserName = 'frxDadosEti'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 396
    Top = 336
  end
end
