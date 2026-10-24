inherited frmFatAltEmbarcacoes: TfrmFatAltEmbarcacoes
  Width = 750
  Height = 340
  BorderStyle = bsDialog
  Caption = 'Altera'#231#227'o de Embarca'#231#227'o no documento de venda'
  Position = poMainFormCenter
  ExplicitWidth = 750
  ExplicitHeight = 340
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 267
    Width = 744
    ExplicitTop = 267
    ExplicitWidth = 744
    inherited FlwBotoes: TFlowPanel
      Width = 740
      ExplicitWidth = 740
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
      Left = 662
      Top = 2
      ExplicitLeft = 662
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 295
    Width = 744
    ExplicitTop = 295
    ExplicitWidth = 744
    inherited pnlNomeForm: TPanel
      Left = 573
      ExplicitLeft = 573
    end
    inherited pnlInfo: TPanel
      Width = 573
      ExplicitWidth = 573
    end
  end
  object pnlBusca: TPanel [3]
    Left = 0
    Top = 0
    Width = 744
    Height = 62
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label5: TLabel
      Left = 9
      Top = 13
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label3: TLabel
      Left = 21
      Top = 36
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label4: TLabel
      Left = 161
      Top = 13
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object edtDocum: TEditFocus
      Tag = 99
      Left = 68
      Top = 9
      Width = 89
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 68
      Top = 32
      Width = 57
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
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 204
      Top = 9
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
    object edtDesEmp: TEditFocus
      Left = 125
      Top = 32
      Width = 604
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
  object pnlDados: TPanel [4]
    Left = 0
    Top = 62
    Width = 744
    Height = 161
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 4
    object Label1: TLabel
      Left = 12
      Top = 7
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 645
      Top = 7
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dt.Emiss'#227'o:'
    end
    object Label6: TLabel
      Left = 12
      Top = 44
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'Condi'#231#227'o Pagamento:'
    end
    object lblVenAtu: TLabel
      Left = 12
      Top = 81
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object Label7: TLabel
      Left = 645
      Top = 44
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Documento:'
    end
    object lblRepAtu: TLabel
      Left = 380
      Top = 81
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Representante:'
    end
    object Label9: TLabel
      Left = 12
      Top = 118
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embarca'#231#227'o Atual:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 12
      Top = 21
      Width = 70
      Height = 22
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
    object edtDtaFat: TEditFocus
      Tag = 99
      Left = 642
      Top = 21
      Width = 87
      Height = 22
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
      Left = 12
      Top = 58
      Width = 627
      Height = 22
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
    object edtDesCli: TEditFocus
      Left = 83
      Top = 21
      Width = 555
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
    object edtDesVen: TEditFocus
      Tag = 99
      Left = 83
      Top = 95
      Width = 295
      Height = 22
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
    object edtValDoc: TEditFocus
      Tag = 99
      Left = 642
      Top = 58
      Width = 87
      Height = 22
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
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 12
      Top = 95
      Width = 70
      Height = 22
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
    object edtCodRep: TEditFocus
      Tag = 99
      Left = 380
      Top = 95
      Width = 70
      Height = 22
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
      Left = 452
      Top = 95
      Width = 277
      Height = 22
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
    object edtCodEmbAtual: TEditFocus
      Tag = 99
      Left = 12
      Top = 133
      Width = 70
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 6
      ReadOnly = True
      TabOrder = 9
      OnKeyPress = edtCodEmbKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtNomEmbAtual: TEditFocus
      Left = 83
      Top = 133
      Width = 646
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlFundo: TPanel [5]
    Left = 0
    Top = 223
    Width = 744
    Height = 44
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    object lblNomEmb: TLabel
      Left = 13
      Top = 15
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embarca'#231#227'o:'
    end
    object edtCodEmb: TEditFocus
      Tag = 99
      Left = 79
      Top = 11
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 6
      ReadOnly = True
      TabOrder = 0
      OnKeyPress = edtCodEmbKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtNomEmb: TEditFocus
      Left = 150
      Top = 11
      Width = 580
      Height = 22
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 398
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 512
    Top = 8
  end
end
