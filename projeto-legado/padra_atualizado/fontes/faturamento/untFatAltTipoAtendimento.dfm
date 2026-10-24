inherited frmFatAltTipoAtendimento: TfrmFatAltTipoAtendimento
  Width = 460
  Height = 463
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o Tipo de Atendimento'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 460
  ExplicitHeight = 463
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 390
    Width = 454
    TabOrder = 2
    ExplicitTop = 390
    ExplicitWidth = 454
    inherited FlwBotoes: TFlowPanel
      Width = 450
      ExplicitTop = 2
      ExplicitWidth = 450
      ExplicitHeight = 24
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
      Left = 374
      Top = 2
      ExplicitLeft = 374
      ExplicitTop = 2
    end
  end
  object pnlBusca: TPanel [2]
    Left = 0
    Top = 0
    Width = 454
    Height = 87
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 4
      Top = 5
      Width = 439
      Height = 76
      Caption = 'Selecionar Documento'
      TabOrder = 0
      object Label5: TLabel
        Left = 6
        Top = 25
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
      end
      object Label4: TLabel
        Left = 150
        Top = 25
        Width = 41
        Height = 14
        Alignment = taRightJustify
        Caption = 'Esp'#233'cie:'
      end
      object Label3: TLabel
        Left = 18
        Top = 50
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object edtDocum: TEditFocus
        Tag = 99
        Left = 65
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
        Left = 191
        Top = 21
        Width = 28
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        MaxLength = 2
        ReadOnly = True
        TabOrder = 1
        Text = 'PD'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 65
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
        Left = 146
        Top = 46
        Width = 286
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
  object pnlDados: TPanel [3]
    Left = 0
    Top = 87
    Width = 454
    Height = 240
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 1
    object GroupBox2: TGroupBox
      Left = 5
      Top = 4
      Width = 438
      Height = 226
      Caption = 'Dados Documento'
      TabOrder = 0
      object Label1: TLabel
        Left = 6
        Top = 21
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Label2: TLabel
        Left = 6
        Top = 60
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dt.Emiss'#227'o:'
      end
      object Label6: TLabel
        Left = 97
        Top = 60
        Width = 104
        Height = 14
        Alignment = taRightJustify
        Caption = 'Condi'#231#227'o Pagamento:'
      end
      object lblCodVen: TLabel
        Left = 9
        Top = 100
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object lblCodRep: TLabel
        Left = 8
        Top = 140
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Representante:'
      end
      object Label7: TLabel
        Left = 7
        Top = 182
        Width = 85
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Documento:'
      end
      object Label8: TLabel
        Left = 99
        Top = 182
        Width = 112
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo Atendimento Atual:'
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 6
        Top = 35
        Width = 87
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 5
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesCli: TEditFocus
        Left = 97
        Top = 35
        Width = 334
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
        Left = 6
        Top = 74
        Width = 87
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
        Left = 97
        Top = 74
        Width = 334
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
        Left = 6
        Top = 114
        Width = 87
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
        Left = 97
        Top = 114
        Width = 334
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
        Left = 6
        Top = 154
        Width = 87
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
        Left = 97
        Top = 154
        Width = 334
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
      object edtValDoc: TEditFocus
        Tag = 99
        Left = 6
        Top = 197
        Width = 87
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesTpa: TEditFocus
        Tag = 99
        Left = 161
        Top = 197
        Width = 270
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
      object edtCodTpa: TEditFocus
        Tag = 99
        Left = 97
        Top = 197
        Width = 62
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 3
        TabOrder = 10
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
  object pnlVendedor: TPanel [4]
    Left = 0
    Top = 327
    Width = 454
    Height = 63
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object lblVen: TLabel
      Left = 12
      Top = 10
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Atendimento:'
    end
    object edtCodNew: TEditFocus
      Tag = 99
      Left = 11
      Top = 27
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodNewKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesNew: TEditFocus
      Left = 68
      Top = 27
      Width = 372
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
  end
  inherited pnlStatus: TPanel
    Top = 418
    Width = 454
    TabOrder = 4
    ExplicitTop = 418
    ExplicitWidth = 454
    inherited pnlNomeForm: TPanel
      Left = 283
      ExplicitLeft = 283
    end
    inherited pnlInfo: TPanel
      Width = 283
      ExplicitWidth = 283
    end
  end
end
