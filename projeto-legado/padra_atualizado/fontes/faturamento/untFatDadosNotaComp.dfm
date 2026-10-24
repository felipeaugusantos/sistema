inherited frmFatDadosNotaComp: TfrmFatDadosNotaComp
  Left = 275
  Top = 145
  Width = 650
  Height = 558
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Dados da Nota de Complemento / Cr'#233'dito'
  Position = poMainFormCenter
  ExplicitWidth = 650
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 489
    Width = 644
    ExplicitTop = 489
    ExplicitWidth = 644
    inherited FlwBotoes: TFlowPanel
      Width = 640
      ExplicitWidth = 640
    end
    inherited btnSair: TBitBtnLocked
      Left = 302
      ExplicitLeft = 302
    end
  end
  inherited pnlStatus: TPanel
    Top = 513
    Width = 644
    TabOrder = 3
    ExplicitTop = 513
    ExplicitWidth = 644
    inherited pnlNomeForm: TPanel
      Left = 466
      Width = 178
      ExplicitLeft = 466
      ExplicitWidth = 178
    end
    inherited pnlInfo: TPanel
      Width = 466
      ExplicitWidth = 466
    end
  end
  inherited pgcDados: TPageControl
    Width = 644
    Height = 489
    TabOrder = 1
    Visible = False
    ExplicitWidth = 644
    ExplicitHeight = 489
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 636
      ExplicitHeight = 457
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 489
    Width = 644
    Height = 24
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 4
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
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 565
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
      OnClick = btnCancelaClick
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 644
    Height = 489
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 14
      Top = 21
      Width = 87
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Observa'#231#245'es 01:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 18
      Top = 44
      Width = 83
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '02:'
    end
    object Label3: TLabel
      Left = 18
      Top = 67
      Width = 83
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '03:'
    end
    object Label4: TLabel
      Left = 18
      Top = 113
      Width = 83
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '05:'
    end
    object Label5: TLabel
      Left = 18
      Top = 90
      Width = 83
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '04:'
    end
    object Label6: TLabel
      Left = 18
      Top = 160
      Width = 83
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '07:'
    end
    object Label7: TLabel
      Left = 18
      Top = 137
      Width = 83
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '06:'
    end
    object Label8: TLabel
      Left = 18
      Top = 206
      Width = 83
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '09:'
    end
    object Label9: TLabel
      Left = 18
      Top = 183
      Width = 83
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '08:'
    end
    object Label10: TLabel
      Left = 18
      Top = 228
      Width = 83
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '10:'
    end
    object Label11: TLabel
      Left = 36
      Top = 255
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Entrada:'
    end
    object edtObse01: TEditFocus
      Tag = 99
      Left = 106
      Top = 14
      Width = 517
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse02: TEditFocus
      Tag = 99
      Left = 106
      Top = 37
      Width = 517
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse03: TEditFocus
      Tag = 99
      Left = 106
      Top = 60
      Width = 517
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse04: TEditFocus
      Tag = 99
      Left = 106
      Top = 83
      Width = 517
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse05: TEditFocus
      Tag = 99
      Left = 106
      Top = 106
      Width = 517
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse06: TEditFocus
      Tag = 99
      Left = 106
      Top = 129
      Width = 517
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse07: TEditFocus
      Tag = 99
      Left = 106
      Top = 153
      Width = 517
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse08: TEditFocus
      Tag = 99
      Left = 106
      Top = 176
      Width = 517
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse09: TEditFocus
      Tag = 99
      Left = 106
      Top = 199
      Width = 517
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse10: TEditFocus
      Tag = 99
      Left = 106
      Top = 222
      Width = 517
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaEnt: TMaskEditFocus
      Tag = 99
      Left = 106
      Top = 248
      Width = 70
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 10
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object pnlNfe: TPanel
      Left = 2
      Top = 276
      Width = 640
      Height = 211
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 11
      DesignSize = (
        640
        211)
      object Label14: TLabel
        Left = 42
        Top = 139
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
      end
      object Label15: TLabel
        Left = 10
        Top = 172
        Width = 89
        Height = 14
        Alignment = taRightJustify
        Caption = 'Chave de Acesso:'
      end
      object lbl1: TLabel
        Left = 288
        Top = 139
        Width = 32
        Height = 14
        Alignment = taRightJustify
        Caption = '(IF/NF)'
      end
      object lblIteCom: TLabel
        Left = 106
        Top = 187
        Width = 250
        Height = 13
        Cursor = crHandPoint
        Caption = 'Caso deseje complementar por produto, clique aqui.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lblIteComClick
      end
      object Shape1: TShape
        Left = 5
        Top = 2
        Width = 629
        Height = 100
        Anchors = [akLeft, akTop, akRight]
        Brush.Style = bsClear
      end
      object rdbComplemento: TRadioButton
        Left = 17
        Top = 12
        Width = 113
        Height = 17
        Caption = 'Complemento ICMS'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rdbComplementoClick
      end
      object rdbCredito: TRadioButton
        Left = 235
        Top = 12
        Width = 98
        Height = 17
        Caption = 'Cr'#233'dito ICMS'
        TabOrder = 1
        OnClick = rdbComplementoClick
      end
      object rdbComIpi: TRadioButton
        Left = 460
        Top = 12
        Width = 101
        Height = 17
        Caption = 'Complemento IPI'
        TabOrder = 2
        OnClick = rdbComplementoClick
      end
      object rdbTransfCredICMS: TRadioButton
        Tag = 99
        Left = 17
        Top = 34
        Width = 212
        Height = 17
        Caption = 'Transfer'#234'ncia de Saldo Credor de ICMS'
        TabOrder = 3
        OnClick = rdbComplementoClick
      end
      object rdbTransfDevICMS: TRadioButton
        Tag = 99
        Left = 235
        Top = 34
        Width = 221
        Height = 17
        Caption = 'Transfer'#234'ncia de Saldo Devedor de ICMS'
        TabOrder = 4
        OnClick = rdbComplementoClick
      end
      object edtChaveAcesso: TEditFocus
        Left = 104
        Top = 164
        Width = 368
        Height = 22
        Alignment = taLeftJustify
        Color = 15263976
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 15
        NormalColor = 15263976
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 241
        Top = 136
        Width = 26
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 14
        Text = 'NF'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 2
        TipoTexto = ttAlfabetico
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 104
        Top = 136
        Width = 83
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 12
        OnEnter = edtNumDocEnter
        OnExit = edtNumDocExit
        OnKeyPress = edtNumDocKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttAlfanumerico
      end
      object edtSerie: TEditFocus
        Tag = 99
        Left = 189
        Top = 136
        Width = 50
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkExibirDocOutros: TCheckBox
        Left = 104
        Top = 114
        Width = 277
        Height = 17
        Caption = 'Documento de outro Cliente / Fornecedor'
        Enabled = False
        TabOrder = 11
      end
      object rdbCompValor: TRadioButton
        Tag = 99
        Left = 17
        Top = 55
        Width = 212
        Height = 17
        Caption = 'Complemento de Valor'
        TabOrder = 6
        OnClick = rdbComplementoClick
      end
      object rdbRestIcmsStEstoque: TRadioButton
        Tag = 99
        Left = 235
        Top = 55
        Width = 177
        Height = 17
        Caption = 'Restitui'#231#227'o de ICMS ST/ Estoque'
        TabOrder = 7
        OnClick = rdbComplementoClick
      end
      object rdbEstornoDeCredito: TRadioButton
        Left = 460
        Top = 35
        Width = 117
        Height = 17
        Caption = 'Estorno de Cr'#233'dito'
        TabOrder = 5
        OnClick = rdbComplementoClick
      end
      object rdbComplementoDifalFcp: TRadioButton
        Left = 460
        Top = 55
        Width = 169
        Height = 17
        Caption = 'Complemento DIFAL/FCP DIFAL'
        TabOrder = 8
        WordWrap = True
        OnClick = rdbComplementoDifalFcpClick
      end
      object rdbComplementoStPerfilCnc: TRadioButton
        Tag = 99
        Left = 17
        Top = 76
        Width = 212
        Height = 17
        Caption = 'Complemento ST - Perfil CNC'
        TabOrder = 9
        OnClick = rdbComplementoClick
      end
      object rdbNFAjusteICMSaMaior: TRadioButton
        Tag = 99
        Left = 238
        Top = 76
        Width = 212
        Height = 17
        Caption = 'NF Ajuste ICMS a Maior'
        TabOrder = 16
        OnClick = rdbComplementoClick
      end
      object rdbComplementoFrete: TRadioButton
        Tag = 99
        Left = 235
        Top = 76
        Width = 136
        Height = 17
        Caption = 'Complemento Frete'
        TabOrder = 10
        OnClick = rdbComplementoClick
      end
    end
  end
end
