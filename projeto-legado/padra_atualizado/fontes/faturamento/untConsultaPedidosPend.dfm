inherited frmConsultaPedidosPend: TfrmConsultaPedidosPend
  Width = 800
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Acompanhamento de Pedidos que Podem ser Faturados'
  Position = poDesigned
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 480
    Width = 784
    Height = 50
    TabOrder = 1
    ExplicitTop = 480
    ExplicitWidth = 784
    ExplicitHeight = 50
    object Label12: TLabel [0]
      Left = 8
      Top = 27
      Width = 161
      Height = 14
      Caption = 'Porcentagem do Pedido Atendido:'
    end
    inherited FlwBotoes: TFlowPanel
      Left = 406
      Top = 25
      Width = 83
      Height = 19
      Align = alNone
      TabOrder = 5
      ExplicitLeft = 406
      ExplicitTop = 25
      ExplicitWidth = 83
      ExplicitHeight = 19
      inherited btnConfirma: TBitBtnLocked
        Width = 81
        TabStop = False
        Visible = False
        ExplicitWidth = 81
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 704
      Top = 25
      Width = 78
      Height = 23
      Align = alRight
      Caption = '&Sair'
      TabOrder = 4
      TabStop = False
      ExplicitLeft = 704
      ExplicitTop = 25
      ExplicitWidth = 78
      ExplicitHeight = 23
    end
    object edtPorPedAte: TEditFocus
      Tag = 99
      Left = 171
      Top = 25
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnChange = edtPorPedAteChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnPedVen: TBitBtnLocked
      Left = 258
      Top = 26
      Width = 142
      Height = 22
      Caption = '[SPACE] - Pedido de Venda'
      TabOrder = 3
      TabStop = False
      OnClick = btnPedVenClick
    end
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 780
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 6
    end
    object ckbEstAtuDisp: TCheckBox
      Left = 110
      Top = 6
      Width = 146
      Height = 17
      Caption = 'Estoque Atual Dispon'#237'vel'
      TabOrder = 1
      OnClick = ckbEstAtuDispClick
    end
    object ckbSalDisp: TCheckBox
      Left = 5
      Top = 6
      Width = 102
      Height = 17
      Caption = 'Saldo Dispon'#237'vel'
      TabOrder = 0
      OnClick = ckbSalDispClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 784
    TabOrder = 2
    ExplicitTop = 545
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 241
    Align = alTop
    Caption = ' '
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 392
      Top = 42
      Width = 32
      Height = 14
      Caption = 'Cliente'
    end
    object Label2: TLabel
      Left = 392
      Top = 4
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
    end
    object Label3: TLabel
      Left = 463
      Top = 4
      Width = 47
      Height = 14
      Caption = 'Data Final'
    end
    object Label4: TLabel
      Left = 90
      Top = 5
      Width = 42
      Height = 14
      Caption = 'Empresa'
    end
    object Label5: TLabel
      Left = 392
      Top = 118
      Width = 47
      Height = 14
      Caption = 'Vendedor'
    end
    object Label6: TLabel
      Left = 8
      Top = 5
      Width = 47
      Height = 14
      Caption = 'N'#186' Pedido'
    end
    object Label7: TLabel
      Left = 8
      Top = 42
      Width = 65
      Height = 14
      Caption = 'Rede de lojas'
    end
    object Label8: TLabel
      Left = 8
      Top = 80
      Width = 33
      Height = 14
      Caption = 'Regi'#227'o'
    end
    object Label9: TLabel
      Left = 8
      Top = 118
      Width = 72
      Height = 14
      Caption = 'Dep. Vendedor'
    end
    object Label10: TLabel
      Left = 8
      Top = 156
      Width = 62
      Height = 14
      Caption = 'Dep. Produto'
    end
    object Label11: TLabel
      Left = 392
      Top = 156
      Width = 37
      Height = 14
      Caption = 'Produto'
    end
    object lblNumPedCli: TLabel
      Left = 392
      Top = 80
      Width = 68
      Height = 14
      Caption = 'N'#186' Ped Cliente'
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 392
      Top = 19
      Width = 70
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 464
      Top = 19
      Width = 70
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 392
      Top = 57
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
      Left = 474
      Top = 57
      Width = 300
      Height = 22
      TabStop = False
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 90
      Top = 19
      Width = 50
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
      Left = 140
      Top = 19
      Width = 250
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
      Left = 392
      Top = 133
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 14
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
      Left = 474
      Top = 133
      Width = 300
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
      Left = 8
      Top = 210
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
      TabOrder = 20
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 94
      Top = 210
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
      TabOrder = 21
      OnClick = btnCancelaItemClick
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 8
      Top = 19
      Width = 81
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
    object edtCodRede: TEditFocus
      Tag = 99
      Left = 8
      Top = 57
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 5
      OnKeyPress = edtCodRedeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomRede: TEditFocus
      Left = 90
      Top = 57
      Width = 300
      Height = 22
      TabStop = False
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
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 8
      Top = 95
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 9
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
      Left = 90
      Top = 95
      Width = 300
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
    object edtCodDepVen: TEditFocus
      Tag = 99
      Left = 8
      Top = 133
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 12
      OnKeyPress = edtCodDepVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDepVen: TEditFocus
      Left = 90
      Top = 133
      Width = 300
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
    object edtCodDepIte: TEditFocus
      Tag = 99
      Left = 8
      Top = 171
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 16
      OnKeyPress = edtCodDepIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDepIte: TEditFocus
      Left = 90
      Top = 171
      Width = 300
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
    object edtDesIte: TEditFocus
      Left = 474
      Top = 171
      Width = 300
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
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 392
      Top = 171
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 18
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtPedCli: TEditFocus
      Tag = 99
      Left = 392
      Top = 95
      Width = 118
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 15
      TipoTexto = ttAlfanumerico
    end
    object btnImprimir: TBitBtnLocked
      Left = 180
      Top = 210
      Width = 85
      Height = 22
      Caption = '&Imprimir'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        000000000000000000030000000C000000120000001400000014000000150000
        0015000000140000000D00000003000000000000000000000000000000000000
        00000000000000000009896256C2BD8A78FFBE8A78FFBD8A78FFBD8978FFBD89
        78FFBE8978FF876356C30000000B000000000000000000000000000000030000
        000E0000001500000021C08D7CFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
        E8FFF5ECE7FFBF8D7BFF00000026000000180000000F000000040000000C7B50
        42C5A76E5BFF9F6755FFC2917FFFF7F0ECFFE2B47DFFE2B37AFFE1B077FFE0AE
        72FFF6EEEAFFC2907FFF845545FF895847FF613E32C70000000E00000011BB7E
        6BFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFE0B1
        76FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67763FF0000001400000010BE85
        71FFF1E5DAFFECDBD0FF7A4835FF7A4835FF7A4835FF7A4835FF7A4835FF7A48
        35FF7A4835FF7A4835FFEBDBCFFFF1E2D8FFB97C69FF000000130000000EC28B
        78FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
        DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826EFF000000120000000CC793
        7FFFFAF4F1FFCDBEB8FF6F5448FF614337FF614035FF5F3F34FF5E3F33FF5D3D
        32FF5D3D34FF6A4C44FFCABCB6FFF9F5F1FFC18875FF000000100000000ACC99
        86FFFDFAFAFF7D6054FF745043FF744F43FF744E43FF734E43FF734E42FF724D
        42FF724C41FF724C40FF73584DFFFDFAFAFFC58F7CFF0000000E00000008CF9F
        8DFFFFFFFFFF7A5A4CFF8E695AFFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
        DEFFF6EFEBFF866253FF704F43FFFFFFFFFFCA9683FF0000000B00000005BE95
        84E9F5ECE8FF866656FF977262FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
        E1FFF8F2EEFF8E6A5BFF7A5B4CFFF5EAE6FFBA8E7DEA00000008000000023429
        2545A78375CC947262FFA07B6AFFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
        E3FFF9F5F3FF977263FF876658FFA68072CE3428234800000003000000000000
        0001000000030000000AC89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
        E7FFFBF7F6FFC59685FF00000011000000040000000200000000000000000000
        00000000000000000005CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
        EAFFFCFAF8FFC89A89FF00000009000000000000000000000000000000000000
        00000000000000000003CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
        FBFFFDFBFAFFCB9F8DFF00000007000000000000000000000000000000000000
        000000000000000000019A796DBFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
        91FFCDA391FF98786BC100000004000000000000000000000000}
      TabOrder = 22
      OnClick = btnImprimirClick
    end
  end
  object cxgConsulta: TcxGrid [3]
    Left = 0
    Top = 241
    Width = 784
    Height = 239
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgConsultaView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsul
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgConsultaViewNumDoc: TcxGridDBColumn
        Caption = 'PEDIDO'
        DataBinding.FieldName = 'NUMDOC'
        Options.Editing = False
      end
      object cxgConsultaViewCodCli: TcxGridDBColumn
        Caption = 'CLIENTE'
        DataBinding.FieldName = 'CODCLI'
        Options.Editing = False
      end
      object cxgConsultaViewCodVen: TcxGridDBColumn
        Caption = 'VEN.'
        DataBinding.FieldName = 'CODVEN'
        Options.Editing = False
      end
      object cxgConsultaViewDtaEnt: TcxGridDBColumn
        Caption = 'DT. EMISS'#195'O'
        DataBinding.FieldName = 'DTAENT'
        Options.Editing = False
      end
      object cxgConsultaViewCodIte: TcxGridDBColumn
        Caption = 'PRODUTO'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
      end
      object cxgConsultaViewEntRet: TcxGridDBColumn
        Caption = 'E/R'
        DataBinding.FieldName = 'ENTRET'
        Options.Editing = False
      end
      object cxgConsultaViewDtEntr: TcxGridDBColumn
        Caption = 'DT. ENTREGA'
        DataBinding.FieldName = 'DTENTR'
        Options.Editing = False
      end
      object cxgConsultaViewEstAtu: TcxGridDBColumn
        Caption = 'EST. ATUAL'
        DataBinding.FieldName = 'ESTATU'
        OnCustomDrawCell = cxgConsultaViewEstAtuCustomDrawCell
        Options.Editing = False
      end
      object cxgConsultaViewQtdIte: TcxGridDBColumn
        Caption = 'QTD. PEDIDO'
        DataBinding.FieldName = 'QTDITE'
        Options.Editing = False
      end
      object cxgConsultaViewSaldos: TcxGridDBColumn
        Caption = 'SALDO'
        DataBinding.FieldName = 'SALDOS'
        OnCustomDrawCell = cxgConsultaViewSaldosCustomDrawCell
        Options.Editing = False
      end
      object cxgConsultaViewPerTot: TcxGridDBColumn
        Caption = '% TOTAL'
        DataBinding.FieldName = 'PERTOT'
        Options.Editing = False
      end
      object cxgConsultaViewStatus: TcxGridDBColumn
        DataBinding.FieldName = 'STATUS'
        Options.Editing = False
      end
      object cxgConsultaViewPedCom: TcxGridDBColumn
        Caption = 'PED. COMPRA'
        DataBinding.FieldName = 'PEDCOM'
        Options.Editing = False
      end
      object cxgConsultaViewDtaCmp: TcxGridDBColumn
        Caption = 'DT. PED. COMPRA CLIENTE'
        DataBinding.FieldName = 'DTACMP'
        Options.Editing = False
        Width = 100
      end
      object cxgConsultaViewPedCli: TcxGridDBColumn
        Caption = 'N.PEDIDO CLIENTE'
        DataBinding.FieldName = 'PEDCLI'
        Options.Editing = False
      end
      object cxgConsultaViewPedSit: TcxGridDBColumn
        Caption = 'PEDIDO SIT/TAB/ECOMMERCE'
        DataBinding.FieldName = 'PEDSIT'
        Options.Editing = False
      end
      object cxgConsultaViewNitCmp: TcxGridDBColumn
        Caption = 'ITEM PED. CLIENTE'
        DataBinding.FieldName = 'NITCMP'
        Options.Editing = False
        Width = 100
      end
      object cxgConsultaViewVlrUni: TcxGridDBColumn
        Caption = 'VLR. UNIT.'
        DataBinding.FieldName = 'VLRUNI'
        Options.Editing = False
        Width = 80
      end
      object cxgConsultaViewDtPDCm: TcxGridDBColumn
        Caption = 'DT. PED. COMPRA'
        DataBinding.FieldName = 'DTPDCM'
        Options.Editing = False
        Width = 100
      end
      object cxgConsultaViewEnPDCm: TcxGridDBColumn
        Caption = 'ENT. PED. COMPRA'
        DataBinding.FieldName = 'ENPDCM'
        Options.Editing = False
        Width = 105
      end
      object cxgConsultaViewDiaEnt: TcxGridDBColumn
        Caption = 'DIAS PARA ENT.'
        DataBinding.FieldName = 'DIAENT'
        Options.Editing = False
        Width = 100
      end
      object cxgConsultaViewDiaEntNUMULTPDCMP: TcxGridDBColumn
        Caption = 'N.ULT.PED.COMPRA'
        DataBinding.FieldName = 'NUMULTPDCMP'
        Options.Editing = False
      end
      object cxgConsultaViewDiaEntFORULTPDCMP: TcxGridDBColumn
        Caption = 'FORN.ULT.PED.COMPRA'
        DataBinding.FieldName = 'FORULTPDCMP'
        Options.Editing = False
      end
    end
    object cxgConsultaLevel1: TcxGridLevel
      GridView = cxgConsultaView
    end
  end
  object prbProgresso: TProgressBar [4]
    Left = 0
    Top = 530
    Width = 784
    Height = 15
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 576
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 608
    Top = 0
  end
  object dtsConsul: TDataSource
    Left = 608
    Top = 32
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 576
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
      TextColor = clGreen
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
  end
end
