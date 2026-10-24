inherited frmFatDigDadosConcreto: TfrmFatDigDadosConcreto
  Left = 246
  Top = 222
  Width = 651
  Height = 470
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Informa'#231#245'es Fechamento'
  Position = poMainFormCenter
  ExplicitWidth = 651
  ExplicitHeight = 470
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 397
    Width = 645
    TabOrder = 5
    ExplicitTop = 353
    ExplicitWidth = 645
    DesignSize = (
      645
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 641
      ExplicitWidth = 641
    end
    inherited btnSair: TBitBtnLocked
      Left = 325
      ExplicitLeft = 325
    end
  end
  inherited pnlStatus: TPanel
    Top = 425
    Width = 645
    TabOrder = 6
    ExplicitTop = 381
    ExplicitWidth = 645
    inherited pnlNomeForm: TPanel
      Left = 457
      Width = 188
      ExplicitLeft = 457
      ExplicitWidth = 188
    end
    inherited pnlInfo: TPanel
      Width = 457
      ExplicitWidth = 457
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 4
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 397
    Width = 645
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 7
    ExplicitTop = 353
    object btnCancelaDados: TBitBtnLocked
      Left = 566
      Top = 3
      Width = 77
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
      TabOrder = 1
      OnClick = btnCancelaClick
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 10
      Top = 3
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
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 645
    Height = 201
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 154
      Top = 90
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lacre:'
    end
    object Label3: TLabel
      Left = 147
      Top = 20
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ve'#237'culo:'
    end
    object lblMotorista: TLabel
      Left = 138
      Top = 43
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motorista:'
    end
    object Label8: TLabel
      Left = 136
      Top = 67
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Betoneira:'
    end
    object Label140: TLabel
      Left = 128
      Top = 111
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abatimento:'
    end
    object Label155: TLabel
      Left = 139
      Top = 135
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo MPs:'
    end
    object Label156: TLabel
      Left = 160
      Top = 159
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Brita:'
    end
    object ColorLabel1: TColorLabel
      Left = 217
      Top = 181
      Width = 156
      Height = 14
      Caption = '(C)onvencional ou (B)ombeado?'
      CorDestaque = clRed
    end
    object Label30: TLabel
      Left = 436
      Top = 183
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'FCK Dias:'
    end
    object edtLacre_: TEditFocus
      Tag = 99
      Left = 188
      Top = 83
      Width = 362
      Height = 22
      Hint = 'Lacre'
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 15
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskPlaVei: TMaskEditFocus
      Tag = 99
      Left = 188
      Top = 12
      Width = 74
      Height = 23
      Hint = 'Placa'
      AutoSelect = False
      AutoSize = False
      CharCase = ecUpperCase
      EditMask = 'lll-9999;0; '
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
      TabOrder = 0
      Text = ''
      OnKeyPress = mskPlaVeiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesVei: TEditFocus
      Left = 264
      Top = 13
      Width = 286
      Height = 22
      Hint = 'Descri'#231#227'o do Ve'#237'culo'
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMot: TEditFocus
      Tag = 99
      Left = 188
      Top = 36
      Width = 74
      Height = 22
      Hint = 'C'#243'digo do Motorista'
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 5
      ReadOnly = True
      TabOrder = 2
      OnKeyPress = edtCodMotKeyPress
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomMot: TEditFocus
      Left = 264
      Top = 36
      Width = 286
      Height = 22
      Hint = 'Nome do motorista'
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBetone: TEditFocus
      Left = 188
      Top = 60
      Width = 362
      Height = 22
      Hint = 'Betoneira'
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAbatim: TEditFocus
      Tag = 99
      Left = 188
      Top = 106
      Width = 362
      Height = 22
      Hint = 'Abatimento'
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTipMps: TEditFocus
      Tag = 99
      Left = 188
      Top = 129
      Width = 362
      Height = 22
      Hint = 'Tipo Mps'
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBrita_: TEditFocus
      Tag = 99
      Left = 188
      Top = 152
      Width = 362
      Height = 22
      Hint = 'Brita'
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtConBom: TEditFocus
      Tag = 99
      Left = 188
      Top = 175
      Width = 26
      Height = 22
      Hint = '(C)onvencionado ou (B)ombeado'
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
    object edtFckDia: TEditFocus
      Tag = 99
      Left = 487
      Top = 175
      Width = 63
      Height = 22
      Hint = 'FCK Dias'
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  object pnlTipoDeBomba: TPanel [5]
    Left = 0
    Top = 201
    Width = 645
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    Visible = False
    object ColorLabel2: TColorLabel
      Left = 218
      Top = 6
      Width = 111
      Height = 14
      Caption = '(M)angote ou (L)an'#231'a?'
      CorDestaque = clRed
    end
    object Label2: TLabel
      Left = 112
      Top = 6
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de bomba:'
    end
    object edtTipoBomba: TEditFocus
      Tag = 99
      Left = 189
      Top = 2
      Width = 26
      Height = 22
      Hint = '(M)angote ou (L)an'#231'a?'
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlBombeamento: TPanel [6]
    Left = 0
    Top = 226
    Width = 645
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    Visible = False
    object lblTotalBombeamento: TLabel
      Left = 396
      Top = 2
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total'
    end
    object lblQtdBombeamento: TLabel
      Left = 188
      Top = 2
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade'
    end
    object lblPrecoBombeamento: TLabel
      Left = 292
      Top = 2
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o'
    end
    object lblBombeamentoConcreto: TLabel
      Left = 59
      Top = 19
      Width = 126
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bombeamento (Concreto):'
    end
    object edtTotBom: TEditFocus
      Tag = 99
      Left = 396
      Top = 16
      Width = 102
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 2
      OnExit = edtTotBomExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdBom: TEditFocus
      Tag = 99
      Left = 188
      Top = 16
      Width = 102
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      OnExit = edtQtdBomExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPrcBom: TEditFocus
      Tag = 99
      Left = 292
      Top = 16
      Width = 102
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      OnExit = edtPrcBomExit
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
  object pnlDadSer: TPanel [7]
    Left = 0
    Top = 264
    Width = 645
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    Visible = False
    object lbl1: TLabel
      Left = 122
      Top = 8
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Obra:'
    end
    object lbl2: TLabel
      Left = 127
      Top = 31
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo ART:'
    end
    object Label4: TLabel
      Left = 142
      Top = 54
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'CNO/CEI:'
    end
    object Label5: TLabel
      Left = 89
      Top = 77
      Width = 96
      Height = 14
      Alignment = taRightJustify
      Caption = 'Inscri'#231#227'o Imobili'#225'ria:'
    end
    object Label6: TLabel
      Left = 166
      Top = 100
      Width = 19
      Height = 14
      Alignment = taRightJustify
      Caption = 'CIB:'
    end
    object edtCodObr: TEditFocus
      Tag = 99
      Left = 188
      Top = 3
      Width = 210
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 0
      OnKeyPress = edtCodObrKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodART: TEditFocus
      Tag = 99
      Left = 188
      Top = 26
      Width = 210
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 1
      OnKeyPress = edtCodARTKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCno: TEditFocus
      Tag = 99
      Left = 188
      Top = 49
      Width = 210
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 2
      OnKeyPress = edtCodARTKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtInsImo: TEditFocus
      Tag = 99
      Left = 188
      Top = 72
      Width = 210
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 3
      OnKeyPress = edtCodARTKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCib: TEditFocus
      Tag = 99
      Left = 188
      Top = 95
      Width = 210
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 4
      OnKeyPress = edtCodARTKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
  end
end
