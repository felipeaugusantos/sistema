inherited frmFatAltValorFreteSuges: TfrmFatAltValorFreteSuges
  Width = 516
  Height = 562
  Caption = 'Altera'#231#227'o do Valor do Frete Sugest'#227'o'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 516
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 489
    Width = 510
    Height = 29
    TabOrder = 3
    ExplicitTop = 469
    ExplicitWidth = 500
    ExplicitHeight = 29
    inherited FlwBotoes: TFlowPanel
      Width = 506
      Height = 25
      ExplicitTop = 2
      ExplicitWidth = 496
      ExplicitHeight = 25
      object btnConfirma: TBitBtnLocked
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
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 430
      ExplicitLeft = 420
    end
  end
  object pnlFrete: TPanel [2]
    Left = 0
    Top = 401
    Width = 510
    Height = 88
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 2
    ExplicitTop = 381
    ExplicitWidth = 500
    object lblVen: TLabel
      Left = 16
      Top = 14
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Transportadora:'
    end
    object Label17: TLabel
      Left = 8
      Top = 39
      Width = 141
      Height = 14
      Alignment = taRightJustify
      Caption = 'Novo "Valor Frete Sugest'#227'o":'
    end
    object Label20: TLabel
      Left = 49
      Top = 63
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Novo "N'#250'mero Lote":'
    end
    object edtNewTra: TEditFocus
      Left = 95
      Top = 11
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnExit = edtNewTraExit
      OnKeyPress = edtNewTraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNewDes: TEditFocus
      Left = 168
      Top = 11
      Width = 315
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNewFre: TEditFocus
      Left = 168
      Top = 36
      Width = 87
      Height = 22
      Alignment = taRightJustify
      MaxLength = 100
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 100
      TipoTexto = ttNumerico
    end
    object edtNewLot: TEditFocus
      Left = 168
      Top = 60
      Width = 100
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 30
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 94
    Width = 510
    Height = 307
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 1
    ExplicitTop = 87
    ExplicitWidth = 500
    ExplicitHeight = 294
    object GroupBox2: TGroupBox
      Left = 8
      Top = 6
      Width = 484
      Height = 285
      Caption = 'Dados Documento'
      TabOrder = 0
      object Label1: TLabel
        Left = 51
        Top = 27
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Label2: TLabel
        Left = 30
        Top = 52
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dt.Emiss'#227'o:'
      end
      object Label6: TLabel
        Left = 164
        Top = 52
        Width = 104
        Height = 14
        Alignment = taRightJustify
        Caption = 'Condi'#231#227'o Pagamento:'
      end
      object lblCodVen: TLabel
        Left = 36
        Top = 77
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object lblCodRep: TLabel
        Left = 12
        Top = 100
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Representante:'
      end
      object Bevel1: TBevel
        Left = 6
        Top = 175
        Width = 472
        Height = 2
      end
      object Label7: TLabel
        Left = 14
        Top = 211
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Base ICMS:'
      end
      object Label8: TLabel
        Left = 42
        Top = 235
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. ICMS:'
      end
      object Label9: TLabel
        Left = 6
        Top = 259
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Desp.Acess:'
      end
      object Label10: TLabel
        Left = 165
        Top = 211
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Base Sub.Trib:'
      end
      object Label11: TLabel
        Left = 193
        Top = 235
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Sub.Trib:'
      end
      object Label12: TLabel
        Left = 208
        Top = 259
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Frete:'
      end
      object Label13: TLabel
        Left = 336
        Top = 187
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Produtos:'
      end
      object Label14: TLabel
        Left = 341
        Top = 211
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Base IPI:'
      end
      object Label15: TLabel
        Left = 369
        Top = 235
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. IPI:'
      end
      object Label16: TLabel
        Left = 332
        Top = 259
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Total Nota:'
      end
      object Label18: TLabel
        Left = 8
        Top = 124
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Transportadora:'
      end
      object Label19: TLabel
        Left = 20
        Top = 148
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#250'mero Lote:'
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 87
        Top = 24
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesCli: TEditFocus
        Left = 160
        Top = 24
        Width = 315
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtDtaFat: TEditFocus
        Tag = 99
        Left = 87
        Top = 49
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 3
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtConPag: TEditFocus
        Tag = 99
        Left = 270
        Top = 49
        Width = 205
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 87
        Top = 74
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 3
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesVen: TEditFocus
        Tag = 99
        Left = 160
        Top = 74
        Width = 315
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 12
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodRep: TEditFocus
        Tag = 99
        Left = 87
        Top = 98
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 3
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesRep: TEditFocus
        Tag = 99
        Left = 160
        Top = 98
        Width = 315
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 12
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtBasIcm: TEditFocus
        Tag = 99
        Left = 87
        Top = 208
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtValIcm: TEditFocus
        Tag = 99
        Left = 87
        Top = 232
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesAce: TEditFocus
        Tag = 99
        Left = 87
        Top = 256
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtBasTri: TEditFocus
        Tag = 99
        Left = 256
        Top = 208
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtValTri: TEditFocus
        Tag = 99
        Left = 256
        Top = 232
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtValFre: TEditFocus
        Tag = 99
        Left = 256
        Top = 255
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtValPro: TEditFocus
        Tag = 99
        Left = 405
        Top = 184
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtBasIpi: TEditFocus
        Tag = 99
        Left = 405
        Top = 208
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtValIpi: TEditFocus
        Tag = 99
        Left = 405
        Top = 232
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 18
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtTotNf: TEditFocus
        Tag = 99
        Left = 405
        Top = 255
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 8
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtCodTra: TEditFocus
        Tag = 99
        Left = 87
        Top = 122
        Width = 70
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 3
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesTra: TEditFocus
        Tag = 99
        Left = 160
        Top = 122
        Width = 315
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 12
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTraLot: TEditFocus
        Tag = 99
        Left = 87
        Top = 146
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 3
        TabOrder = 20
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
    end
  end
  object pnlBusca: TPanel [4]
    Left = 0
    Top = 0
    Width = 510
    Height = 94
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 8
      Top = 5
      Width = 484
      Height = 76
      Caption = 'Selecionar Documento'
      TabOrder = 0
      object Label5: TLabel
        Left = 29
        Top = 25
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
      end
      object Label4: TLabel
        Left = 172
        Top = 25
        Width = 41
        Height = 14
        Alignment = taRightJustify
        Caption = 'Esp'#233'cie:'
      end
      object Label3: TLabel
        Left = 41
        Top = 50
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 87
        Top = 21
        Width = 80
        Height = 22
        Alignment = taLeftJustify
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
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 216
        Top = 21
        Width = 28
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 87
        Top = 46
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 2
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmp: TEditFocus
        Left = 169
        Top = 46
        Width = 306
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
  inherited pnlStatus: TPanel
    Top = 518
    Width = 510
    TabOrder = 4
    ExplicitTop = 498
    ExplicitWidth = 500
    inherited pnlNomeForm: TPanel
      Left = 339
      ExplicitLeft = 329
    end
    inherited pnlInfo: TPanel
      Width = 339
      ExplicitWidth = 329
    end
  end
end
