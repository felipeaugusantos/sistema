inherited frmCadAutorizadosWebService: TfrmCadAutorizadosWebService
  Width = 555
  Height = 352
  Caption = 'Cadastro de Autorizados WebService'
  ExplicitWidth = 555
  ExplicitHeight = 352
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 279
    Width = 549
    ExplicitTop = 279
    ExplicitWidth = 549
    inherited FlwBotoes: TFlowPanel
      Width = 545
      ExplicitTop = 2
      ExplicitWidth = 545
    end
    inherited btnSair: TBitBtnLocked
      Left = 464
      ExplicitLeft = 464
    end
  end
  inherited pnlStatus: TPanel
    Top = 307
    Width = 549
    ExplicitTop = 307
    ExplicitWidth = 549
    inherited pnlNomeForm: TPanel
      Left = 202
      ExplicitLeft = 202
    end
    inherited pnlInfo: TPanel
      Width = 202
      ExplicitWidth = 202
    end
  end
  inherited pgcDados: TPageControl
    Width = 549
    Height = 279
    ExplicitWidth = 549
    ExplicitHeight = 279
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 541
      ExplicitHeight = 247
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 549
    Height = 279
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object lblDescricao: TLabel
      Left = 121
      Top = 44
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblCodigo: TLabel
      Left = 137
      Top = 21
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblChave: TLabel
      Left = 102
      Top = 145
      Width = 71
      Height = 14
      Caption = 'Chave P'#250'blica:'
    end
    object lblSenha: TLabel
      Left = 139
      Top = 244
      Width = 34
      Height = 14
      Caption = 'Senha:'
    end
    object lblSiglaNumPok: TLabel
      Left = 101
      Top = 90
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sigla NUMPOK:'
    end
    object lblLogin: TLabel
      Left = 144
      Top = 221
      Width = 29
      Height = 14
      Caption = 'Login:'
    end
    object lblTipoAuth: TLabel
      Left = 84
      Top = 117
      Width = 89
      Height = 14
      Caption = 'Tipo Autentica'#231#227'o:'
    end
    object lblTipoIntegracaoWS: TLabel
      Left = 19
      Top = 68
      Width = 154
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Integra'#231#227'o WebService:'
    end
    object btnGerar: TSpeedButton
      Left = 456
      Top = 174
      Width = 70
      Height = 22
      Cursor = crHandPoint
      Hint = 'Gerar'
      Caption = 'Gerar'
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000000000000000000000000001F421C11FF30140DEC190A06B30304
        075F0000001B0000000500000000000000000000000000000000000000000000
        00000000000000000000000000000000001E663C2BE7B9C7D2FF7889A2FF2441
        82FF051033AF0000002100000005000000000000000000000000000000000000
        0002000000090000000E0000000F0000002041261BAE879AB2FFC8E3F5FF1F66
        B6FF2B6BA8FF051236AD0000001F000000040000000000000000000000000000
        00088C6657C0C38C7AFFC38C79FFCBA395FFA89894FF488BC3FFDEFEFDFF51B4
        E3FF1F68B7FF3173AEFF061538AA0000001C0000000400000000000000000000
        000CC5917EFFFDFBFAFFFCF8F6FFFAF7F5FFECEAE9FF7CA3BFFF479FD2FFDEFE
        FDFF59BFE9FF216BB9FF367BB3FF07173AA70000001A00000004000000000000
        000CC79481FFFEFBFAFFF9F0EAFFF8F0EAFFF7F0EBFFE8E4E1FF7EA4BFFF4BA5
        D5FFDEFEFDFF61CAEFFF246FBCFF3B83B9FF081A3DA300000018000000000000
        000BC99786FFFEFCFBFFF9F2EDFFF9F2EDFFF9F0EBFFF8F2EDFFEBE7E5FF82A7
        C2FF4EAAD7FFDEFEFDFF68D4F4FF2875BEFF3F8BBEFF091B3F9E000000000000
        000ACB9C8BFFFEFDFCFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF8F2EEFFEDE9
        E7FF85ABC7FF51AEDAFFDEFEFDFF6EDDF8FF2C7BC2FF18448BFF000000000000
        0009CFA08DFFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF8F4
        EFFFEFECE9FF89AECAFF54B1DCFFDEFEFDFF4FA6D4FF102C4E93000000000000
        0009D0A393FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
        EFFFFAF6F1FFF3EFEDFF83A0B8FF357FBCFF173A598F0000000C000000000000
        0008D3A897FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
        F1FFFBF5F0FFFAF6F3FFE2CCC4FF000000160000000600000001000000000000
        0007D3AB9AFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
        F3FFFCF6F2FFFBF6F1FFD1A494FF0000000C0000000000000000000000000000
        0006D8AE9DFFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7
        F5FFFBF7F4FFFCF7F3FFD3A897FF0000000B0000000000000000000000000000
        0006D8B0A0FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8
        F6FFFBF7F6FFFCF7F5FFD4AC9BFF0000000A0000000000000000000000000000
        0005D9B3A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFE
        FEFFFEFEFEFFFEFEFEFFD7AE9EFF000000090000000000000000000000000000
        0003A3867AC0DBB5A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3
        A2FFD9B2A2FFD8B2A2FFA08377C2000000060000000000000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnGerarClick
    end
    object btnCopiar: TSpeedButton
      Left = 456
      Top = 195
      Width = 70
      Height = 22
      Cursor = crHandPoint
      Hint = 'Copiar'
      Caption = 'Copiar'
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0002000000090000000E0000000F0000000F0000001000000010000000110000
        0011000000100000000B00000003000000000000000000000000000000000000
        00087C5345C0AD725EFFAC725DFFAC715DFFAC6F5BFFAB705CFFAB705CFFAB6E
        5CFFAB6E5AFF7A4E41C30000000B000000000000000000000000000000000000
        000BAF7462FFFDFBF9FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
        EEFFFAF2ECFFAC715DFF0000000F000000000000000000000000000000000000
        000BB17964FFFDFBFAFFF7EEE7FFF8EDE7FFF7EDE7FFF7EDE6FFF6ECE5FFF6EC
        E5FFFAF2EEFFAE7260FF01010120010101100101010B00000003000000000000
        000BB37C69FFFDFCFBFFF8EFE8FFF7EEE8FFF7EEE8FFF8EEE7FFF7EEE7FFF7EC
        E6FFFAF3EFFFB07863FFC19D92FFB57D6AFF815A4EC30101010B000000000000
        000AB57F6CFFFEFCFBFFF9F0EAFFF8F0EAFFF8EFE9FFF8EFE8FFF8EEE9FFF8EE
        E7FFFBF5F1FFB27A66FFEBE6E2FFFAF3EDFFB6806DFF0101010F000000000000
        0009B98270FFFEFDFCFFF9F2EDFFF9F2EDFFF9F0EBFFF9F0EAFFF8F0EAFFF8F0
        E9FFFBF6F3FFB37D6AFFE9E1DAFFFAF3EFFFB88170FF01010110000000000000
        0008BB8775FFFEFDFDFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF9F1EBFFF9F0
        EBFFFCF8F5FFB6806DFFEAE1DBFFFAF4F0FFB98673FF0101010F000000000000
        0007BF8B78FFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF9F3
        EDFFFCF9F7FFBA8471FFECE4DDFFFBF5F2FFBB8876FF0101010E000000000000
        0007C18E7EFFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
        EFFFFDFAF8FFBC8978FFEDE7E0FFFBF6F4FFBC8B7AFF0101010D000000000000
        0006C49382FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
        F1FFFDFBF9FFBF8C7CFFEFE8E3FFFCF8F5FFBF8E7CFF0101010D000000000000
        0005C49785FFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFDFDFFFEFD
        FDFFFEFDFCFFC2907FFFF0EBE6FFFCF9F7FFC29180FF0101010C000000000000
        0003967265C0C89988FFC99887FFC79887FFC59786FFC79785FFC79784FFC596
        84FFC59683FFCDA79AFFF4EFEAFFFDFAF8FFC49686FF0101010B000000000000
        000100000003000000040000000BD8BBB0FFF8F8F8FFF5F0EFFFF5F0EFFFF5EF
        EDFFF5EFEDFFF7F0EEFFFAF4F1FFFDFBF9FFC7998AFF0000000A000000000000
        0000000000000000000000000005CCA392FFFFFEFEFFFEFEFEFFFEFEFEFFFEFE
        FEFFFEFEFDFFFEFDFDFFFEFDFDFFFEFDFCFFCA9D8DFF00000009000000000000
        00000000000000000000000000039A7B6FC0CEA495FFCFA494FFCDA494FFCCA3
        93FFCDA392FFCDA391FFCCA291FFCCA290FF97776BC200000006}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnCopiarClick
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 177
      Top = 17
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'INT_CODAUT'
      DataSource = dtsCadAut
      MaxLength = 7
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 177
      Top = 40
      Width = 349
      Height = 22
      CharCase = ecUpperCase
      DataField = 'INT_DESCRI'
      DataSource = dtsCadAut
      MaxLength = 255
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipoIntegracaoWS: TDBEditFocus
      Tag = 99
      Left = 177
      Top = 63
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      DataField = 'INT_SISEXT'
      DataSource = dtsCadAut
      MaxLength = 20
      TabOrder = 2
      OnExit = dbeTipoIntegracaoWSExit
      OnKeyPress = dbeTipoIntegracaoWSKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeSiglaNumPok: TDBEditFocus
      Tag = 99
      Left = 177
      Top = 86
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      DataField = 'INT_SIGPED'
      DataSource = dtsCadAut
      MaxLength = 10
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object drbTipoAuth: TDBRadioGroup
      Left = 177
      Top = 110
      Width = 349
      Height = 31
      Columns = 2
      Ctl3D = True
      DataField = 'INT_TPAUTH'
      DataSource = dtsCadAut
      Items.Strings = (
        'BASIC'
        'JWT')
      ParentCtl3D = False
      TabOrder = 4
      Values.Strings = (
        'B'
        'T')
      OnChange = drbTipoAuthChange
    end
    object mmoChave: TDBMemoFocus
      Tag = 99
      Left = 177
      Top = 142
      Width = 279
      Height = 74
      DataField = 'INT_PUBKEY'
      DataSource = dtsCadAut
      MaxLength = 65000
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object dbeLogin: TDBEditFocus
      Tag = 99
      Left = 177
      Top = 217
      Width = 349
      Height = 22
      CharCase = ecUpperCase
      DataField = 'INT_LOGIN_'
      DataSource = dtsCadAut
      Enabled = False
      MaxLength = 100
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSenha: TDBEditFocus
      Tag = 99
      Left = 177
      Top = 240
      Width = 349
      Height = 22
      CharCase = ecUpperCase
      DataField = 'INT_PASSWD'
      DataSource = dtsCadAut
      Enabled = False
      MaxLength = 100
      PasswordChar = '*'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object dtsCadAut: TDataSource
    OnStateChange = dtsCadAutStateChange
    Left = 376
    Top = 88
  end
end
