inherited frmDigBoleto: TfrmDigBoleto
  Left = 269
  Top = 218
  Width = 593
  Height = 330
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  ExplicitWidth = 593
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 258
    Width = 587
    TabOrder = 4
    ExplicitTop = 258
    ExplicitWidth = 587
    DesignSize = (
      587
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 583
      ExplicitWidth = 583
    end
    inherited btnSair: TBitBtnLocked
      Left = 328
      ExplicitLeft = 328
    end
  end
  inherited pnlStatus: TPanel
    Top = 285
    Width = 587
    TabOrder = 2
    ExplicitTop = 285
    ExplicitWidth = 587
    inherited pnlNomeForm: TPanel
      Left = 408
      Width = 179
      ExplicitLeft = 408
      ExplicitWidth = 179
    end
    inherited pnlInfo: TPanel
      Width = 408
      ExplicitWidth = 408
    end
  end
  inherited pgcDados: TPageControl
    Width = 587
    Height = 258
    TabOrder = 1
    Visible = False
    ExplicitWidth = 587
    ExplicitHeight = 258
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 579
      ExplicitHeight = 226
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 258
    Width = 587
    Height = 27
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 3
    object FlwpnlConfirma: TFlowPanel
      Left = 2
      Top = 2
      Width = 506
      Height = 23
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        506
        23)
      object btnConfirmaDados: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnConfirmaDadosClick
      end
      object btnAlterar: TBitBtnLocked
        Left = 77
        Top = 0
        Width = 77
        Height = 22
        Caption = '&Alterar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
          CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
          A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
          820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
          860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
          C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
          D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
          9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        TabStop = False
        OnClick = btnAlterarClick
      end
      object btnImprimirMercantil: TBitBtnLocked
        Left = 154
        Top = 0
        Width = 147
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Imprimir Dup. Mercantil'
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
        TabOrder = 2
        OnClick = btnImprimirMercantilClick
      end
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 508
      Top = 2
      Width = 77
      Height = 23
      Align = alRight
      Caption = 'Cancela&r'
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
      TabOrder = 1
      OnClick = btnCancelaClick
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 587
    Height = 258
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 27
      Top = 32
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mora Di'#225'ria:'
    end
    object Label2: TLabel
      Left = 151
      Top = 32
      Width = 20
      Height = 12
      AutoSize = False
      Caption = '%'
    end
    object Label5: TLabel
      Left = 40
      Top = 55
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label3: TLabel
      Left = 50
      Top = 78
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Banco:'
    end
    object lblNosNum: TLabel
      Left = 10
      Top = 101
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nosso N'#250'mero:'
    end
    object Label6: TLabel
      Left = 8
      Top = 9
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Impress'#227'o:'
    end
    object ColorLabel1: TColorLabel
      Left = 129
      Top = 9
      Width = 86
      Height = 14
      Caption = '(M)atricial (L)aser'
      CorDestaque = clRed
    end
    object lblPerMul: TLabel
      Left = 56
      Top = 189
      Width = 28
      Height = 22
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Multa:'
      Layout = tlCenter
    end
    object lblCartei: TLabel
      Left = 43
      Top = 166
      Width = 41
      Height = 22
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Carteira:'
      Layout = tlCenter
    end
    object lblPercen: TLabel
      Left = 147
      Top = 189
      Width = 20
      Height = 22
      AutoSize = False
      Caption = '%'
      Layout = tlCenter
    end
    object lblMsgPortadorAut: TLabel
      Left = 10
      Top = 233
      Width = 569
      Height = 22
      AutoSize = False
      Caption = 'MsgPortadorAutorizado'
      Font.Charset = ANSI_CHARSET
      Font.Color = 8421631
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object edtMorDia: TEditFocus
      Tag = 99
      Left = 88
      Top = 29
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 1
      OnExit = edtMorDiaExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 88
      Top = 52
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtCodBco: TEditFocus
      Tag = 99
      Left = 88
      Top = 75
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 3
      OnExit = edtCodBcoExit
      OnKeyPress = edtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNosNum: TEditFocus
      Tag = 99
      Left = 88
      Top = 98
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 11
      TabOrder = 4
      OnChange = edtNosNumChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 11
      TipoTexto = ttNumerico
    end
    object edtNomBan: TEditFocus
      Left = 145
      Top = 75
      Width = 240
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
    object edtDesPor: TEditFocus
      Left = 145
      Top = 52
      Width = 240
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
    object edtTipBol: TEditFocus
      Tag = 99
      Left = 88
      Top = 6
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'L'
      OnChange = edtTipBolChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtMens01: TEditFocus
      Left = 88
      Top = 121
      Width = 297
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 60
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMens02: TEditFocus
      Left = 88
      Top = 144
      Width = 297
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 60
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkEtiCob: TCheckBox
      Left = 88
      Top = 214
      Width = 185
      Height = 17
      Caption = 'Imprimir Etiquetas de Cobran'#231'a?'
      TabOrder = 9
    end
    object edtCartei: TEditFocus
      Left = 88
      Top = 167
      Width = 297
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      MaxLength = 60
      NumbersOnly = True
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPerMul: TEditFocus
      Left = 88
      Top = 190
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 60
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object rdgOpcoes: TRadioGroup
      Left = 390
      Top = 6
      Width = 185
      Height = 137
      Caption = 'Op'#231#245'es de impress'#227'o e gera'#231#227'o:'
      ItemIndex = 0
      Items.Strings = (
        'Imprimir'
        'Gerar PDF'
        'Imprimir e gerar PDF'
        'Enviar por email'
        'Enviar por email e imprimir')
      TabOrder = 12
      OnClick = rdgOpcoesClick
    end
    object chkEditaEmail: TCheckBox
      Left = 402
      Top = 147
      Width = 160
      Height = 17
      Caption = 'Editar e-mail antes do envio'
      Enabled = False
      TabOrder = 13
      WordWrap = True
    end
    object chkEnviarSMS: TCheckBox
      Left = 402
      Top = 164
      Width = 160
      Height = 17
      Caption = 'Enviar SMS'
      TabOrder = 14
      Visible = False
      WordWrap = True
    end
    object chkEnviarWpp: TCheckBox
      Left = 402
      Top = 182
      Width = 160
      Height = 17
      Caption = 'Enviar Whatsapp'
      TabOrder = 15
      Visible = False
      WordWrap = True
    end
    object chkBoletoOriginal: TCheckBox
      Left = 239
      Top = 6
      Width = 145
      Height = 17
      Caption = 'Reimprimir boleto original'
      TabOrder = 16
      WordWrap = True
      OnClick = chkBoletoOriginalClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 62
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 232
    Top = 96
  end
end
