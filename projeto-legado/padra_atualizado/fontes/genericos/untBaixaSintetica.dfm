inherited frmBaixaSintetica: TfrmBaixaSintetica
  Left = 245
  Top = 180
  Width = 508
  Height = 395
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Baixa Sint'#233'tica'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 508
  ExplicitHeight = 395
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 322
    Width = 502
    ExplicitTop = 322
    ExplicitWidth = 502
    DesignSize = (
      502
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 498
      ExplicitWidth = 498
    end
    inherited btnSair: TBitBtnLocked
      Left = 330
      ExplicitLeft = 330
    end
  end
  inherited pnlStatus: TPanel
    Top = 350
    Width = 502
    TabOrder = 3
    ExplicitTop = 350
    ExplicitWidth = 502
    inherited pnlNomeForm: TPanel
      Left = 332
      Width = 170
      ExplicitLeft = 332
      ExplicitWidth = 170
    end
    inherited pnlInfo: TPanel
      Width = 332
      ExplicitWidth = 332
    end
  end
  inherited pgcDados: TPageControl
    Width = 502
    Height = 322
    TabOrder = 1
    Visible = False
    ExplicitWidth = 502
    ExplicitHeight = 322
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 494
      ExplicitHeight = 290
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 322
    Width = 502
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 4
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
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
    object btnCancelaDados: TBitBtnLocked
      Left = 423
      Top = 2
      Width = 77
      Height = 24
      Align = alRight
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
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 502
    Height = 322
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object lblHistor: TLabel
      Left = 39
      Top = 145
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object lblDocBai: TLabel
      Left = 26
      Top = 122
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object lblData: TLabel
      Left = 59
      Top = 101
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data:'
    end
    object lblPorBai: TLabel
      Left = 40
      Top = 13
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblEmiCheque: TLabel
      Left = 7
      Top = 35
      Width = 77
      Height = 14
      Caption = 'Emitir Cheque ? '
    end
    object lblCodBco: TLabel
      Left = 48
      Top = 167
      Width = 34
      Height = 14
      Caption = 'Banco:'
    end
    object lblNumAge: TLabel
      Left = 40
      Top = 189
      Width = 43
      Height = 14
      Caption = 'Ag'#234'ncia:'
    end
    object lblNumChq: TLabel
      Left = 43
      Top = 233
      Width = 40
      Height = 14
      Caption = 'Cheque:'
    end
    object lblBomPara: TLabel
      Left = 35
      Top = 255
      Width = 49
      Height = 14
      Caption = 'Bom para:'
    end
    object lblFavorecido: TLabel
      Left = 27
      Top = 299
      Width = 57
      Height = 14
      Caption = 'Favorecido:'
    end
    object lblConCor: TLabel
      Left = 51
      Top = 211
      Width = 31
      Height = 14
      Caption = 'Conta:'
    end
    object lblCodFor: TLabel
      Left = 27
      Top = 57
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
    end
    object lblDtaEmi: TLabel
      Left = 39
      Top = 277
      Width = 43
      Height = 14
      Caption = 'Emiss'#227'o:'
    end
    object lblhist2: TLabel
      Left = 29
      Top = 147
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico 2:'
    end
    object edtDesPor1: TEditFocus
      Left = 154
      Top = 9
      Width = 336
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtDocBai: TEditFocus
      Left = 88
      Top = 119
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtHisBai: TEditFocus
      Tag = 99
      Left = 88
      Top = 140
      Width = 401
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = -1
      TipoTexto = ttAlfanumerico
    end
    object mskDtaLan: TMaskEditFocus
      Tag = 99
      Left = 88
      Top = 97
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtPorBai: TEditFocus
      Tag = 99
      Left = 88
      Top = 9
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtPorBaiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtEmiCheque: TEditFocus
      Tag = 99
      Left = 88
      Top = 31
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtCodBco: TEditFocus
      Tag = 99
      Left = 88
      Top = 163
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 8
      OnKeyPress = edtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomBco: TEditFocus
      Left = 170
      Top = 163
      Width = 319
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtNumAge: TEditFocus
      Tag = 99
      Left = 88
      Top = 185
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumChq: TEditFocus
      Tag = 99
      Left = 88
      Top = 229
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 10
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFavorecido: TEditFocus
      Left = 88
      Top = 295
      Width = 401
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskBomPara: TMaskEditFocus
      Left = 88
      Top = 251
      Width = 81
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 13
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtConCor: TEditFocus
      Tag = 99
      Left = 88
      Top = 207
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 11
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
      Left = 88
      Top = 53
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 2
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
      Left = 170
      Top = 53
      Width = 320
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object mskDtaEmi: TMaskEditFocus
      Left = 88
      Top = 273
      Width = 81
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 14
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtHist02: TEditFocus
      Tag = 99
      Left = 88
      Top = 141
      Width = 401
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = -1
      TipoTexto = ttAlfanumerico
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 1
      Top = 75
      Width = 491
      Height = 22
      TabOrder = 3
      ExplicitLeft = 1
      ExplicitTop = 75
      ExplicitWidth = 491
      inherited lblPlaContas: TLabel
        Left = 4
        Width = 81
        Height = 14
        ExplicitLeft = 4
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 153
        Width = 336
        Height = 22
        ExplicitLeft = 153
        ExplicitWidth = 336
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 87
        Width = 65
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 87
        ExplicitWidth = 65
        ExplicitHeight = 22
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 24
  end
  object cdsCadRec_VerificaData: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 320
    Top = 256
  end
end
