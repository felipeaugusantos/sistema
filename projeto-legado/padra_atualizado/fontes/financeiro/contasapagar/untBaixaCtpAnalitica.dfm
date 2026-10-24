inherited frmBaixaCtpAnalitica: TfrmBaixaCtpAnalitica
  Left = 301
  Top = 196
  Width = 392
  Height = 328
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 392
  ExplicitHeight = 328
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 259
    Width = 386
    ExplicitTop = 255
    ExplicitWidth = 386
    DesignSize = (
      386
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 382
      ExplicitTop = 2
      ExplicitWidth = 382
    end
    inherited btnSair: TBitBtnLocked
      Left = 278
      ExplicitLeft = 278
    end
  end
  inherited pgcDados: TPageControl
    Width = 386
    Height = 259
    TabOrder = 1
    Visible = False
    ExplicitWidth = 386
    ExplicitHeight = 255
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 378
      ExplicitHeight = 223
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 259
    Width = 386
    Height = 24
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 255
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 20
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
      ExplicitLeft = 4
      ExplicitTop = 3
      ExplicitHeight = 22
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 307
      Top = 2
      Width = 77
      Height = 20
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
      OnClick = btnCancelaDadosClick
      ExplicitLeft = 304
      ExplicitTop = 3
      ExplicitHeight = 22
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 386
    Height = 259
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 255
    object pnlCamBco: TPanel
      Left = 2
      Top = 95
      Width = 382
      Height = 160
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object lblCodBco: TLabel
        Left = 28
        Top = 4
        Width = 34
        Height = 14
        Caption = 'Banco:'
      end
      object lblNumAge: TLabel
        Left = 20
        Top = 27
        Width = 43
        Height = 14
        Caption = 'Ag'#234'ncia:'
      end
      object Label3: TLabel
        Left = 31
        Top = 50
        Width = 31
        Height = 14
        Caption = 'Conta:'
      end
      object lblNumChq: TLabel
        Left = 23
        Top = 73
        Width = 40
        Height = 14
        Caption = 'Cheque:'
      end
      object Label1: TLabel
        Left = 14
        Top = 119
        Width = 49
        Height = 14
        Caption = 'Bom para:'
      end
      object Label2: TLabel
        Left = 6
        Top = 143
        Width = 57
        Height = 14
        Caption = 'Favorecido:'
      end
      object Label6: TLabel
        Left = 20
        Top = 96
        Width = 43
        Height = 14
        Caption = 'Emiss'#227'o:'
      end
      object edtCodBco: TEditFocus
        Tag = 99
        Left = 67
        Top = 0
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
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
        Left = 148
        Top = 0
        Width = 223
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
      object edtNumAge: TEditFocus
        Tag = 99
        Left = 67
        Top = 23
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtConCor: TEditFocus
        Tag = 99
        Left = 67
        Top = 46
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 3
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
        Left = 67
        Top = 69
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskBomPara: TMaskEditFocus
        Tag = 99
        Left = 67
        Top = 115
        Width = 80
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 6
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtFavorecido: TEditFocus
        Left = 67
        Top = 139
        Width = 304
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaEmi: TMaskEditFocus
        Tag = 99
        Left = 67
        Top = 92
        Width = 80
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 5
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object pnlCamPor: TPanel
      Left = 2
      Top = 255
      Width = 382
      Height = 77
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 4
    end
    object pnlCamHis: TPanel
      Left = 2
      Top = 48
      Width = 382
      Height = 47
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object lblHist1: TLabel
        Left = 10
        Top = 5
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico 1:'
      end
      object lblHist2: TLabel
        Left = 10
        Top = 28
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico 2:'
      end
      object edtHist01: TEditFocus
        Left = 67
        Top = 1
        Width = 304
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 40
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 40
        TipoTexto = ttAlfanumerico
      end
      object edtHist02: TEditFocus
        Left = 67
        Top = 24
        Width = 304
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 40
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 40
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlCamPo1: TPanel
      Left = 2
      Top = 2
      Width = 382
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label5: TLabel
        Left = 19
        Top = 5
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object edtPorBai: TEditFocus
        Tag = 99
        Left = 67
        Top = 1
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        OnExit = edtEmiChequeExit
        OnKeyPress = edtPorBaiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesPor1: TEditFocus
        Left = 132
        Top = 1
        Width = 239
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
    end
    object Panel1: TPanel
      Left = 2
      Top = 25
      Width = 382
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label4: TLabel
        Left = 3
        Top = 5
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
      end
      object lblDtaBai: TLabel
        Left = 133
        Top = 5
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Baixa:'
        Visible = False
      end
      object lblEmiCheque: TLabel
        Left = 266
        Top = 5
        Width = 77
        Height = 14
        Caption = 'Emitir Cheque ? '
      end
      object edtDocBai: TEditFocus
        Left = 67
        Top = 1
        Width = 62
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaPag: TMaskEditFocus
        Tag = 99
        Left = 195
        Top = 1
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtEmiCheque: TEditFocus
        Tag = 99
        Left = 344
        Top = 1
        Width = 27
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 2
        OnExit = edtEmiChequeExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 283
    Width = 386
    TabOrder = 3
    ExplicitTop = 283
    ExplicitWidth = 386
    inherited pnlNomeForm: TPanel
      Left = 215
      ExplicitLeft = 215
    end
    inherited pnlInfo: TPanel
      Width = 215
      ExplicitWidth = 215
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 160
  end
end
