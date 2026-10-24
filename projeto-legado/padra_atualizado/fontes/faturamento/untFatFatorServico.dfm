inherited frmFatFatorServico: TfrmFatFatorServico
  Width = 649
  Height = 290
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 649
  ExplicitHeight = 290
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 217
    Width = 643
    Height = 28
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 217
    ExplicitWidth = 643
    ExplicitHeight = 28
    inherited FlwBotoes: TFlowPanel
      Width = 639
      Visible = True
      ExplicitWidth = 639
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 22
        Caption = '[F10] Confirma'
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
        WordWrap = True
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 562
      Top = 2
      ExplicitLeft = 562
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 245
    Width = 643
    TabOrder = 3
    ExplicitTop = 245
    ExplicitWidth = 643
    inherited pnlNomeForm: TPanel
      Left = 472
      ExplicitLeft = 472
    end
    inherited pnlInfo: TPanel
      Width = 472
      ExplicitWidth = 472
    end
  end
  inherited pgcDados: TPageControl
    Width = 643
    Height = 217
    TabOrder = 2
    ExplicitWidth = 643
    ExplicitHeight = 217
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 635
      ExplicitHeight = 185
    end
  end
  object pnlPrincipal: TPanel [3]
    Left = 0
    Top = 0
    Width = 643
    Height = 217
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 641
      Height = 40
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblPedOrc: TLabel
        Left = 12
        Top = 14
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Or'#231'amento:'
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 74
        Top = 11
        Width = 89
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 12
        TabOrder = 0
        OnKeyPress = edtNumDocKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtEspDoc: TEditFocus
        Left = 165
        Top = 11
        Width = 26
        Height = 22
        TabStop = False
        Alignment = taCenter
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmp: TEditFocus
        Left = 193
        Top = 11
        Width = 28
        Height = 22
        TabStop = False
        Alignment = taCenter
        Color = 16768952
        Enabled = False
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomEmp: TEditFocus
        Left = 223
        Top = 11
        Width = 410
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
    object pnlInformacao: TPanel
      Left = 1
      Top = 41
      Width = 641
      Height = 146
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lblCliente: TLabel
        Left = 45
        Top = 10
        Width = 35
        Height = 14
        Caption = 'Cliente:'
      end
      object lblVendedor: TLabel
        Left = 30
        Top = 34
        Width = 50
        Height = 14
        Caption = 'Vendedor:'
      end
      object lblFpgPto: TLabel
        Left = 20
        Top = 82
        Width = 60
        Height = 14
        Caption = 'Form. Pagto:'
      end
      object lblCndPto: TLabel
        Left = 19
        Top = 58
        Width = 61
        Height = 14
        Caption = 'Cond. Pagto:'
      end
      object lblDtaEmi: TLabel
        Left = 12
        Top = 106
        Width = 68
        Height = 14
        Caption = 'Data Emiss'#227'o:'
      end
      object lblVlrTot: TLabel
        Left = 158
        Top = 106
        Width = 53
        Height = 14
        Caption = 'Valor Total:'
      end
      object edtCodCli: TEditFocus
        Left = 83
        Top = 7
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodVen: TEditFocus
        Left = 83
        Top = 31
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCnd: TEditFocus
        Left = 83
        Top = 55
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodFpg: TEditFocus
        Left = 83
        Top = 79
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDtaEmi: TEditFocus
        Left = 83
        Top = 103
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomCli: TEditFocus
        Left = 154
        Top = 7
        Width = 479
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomVen: TEditFocus
        Left = 154
        Top = 31
        Width = 479
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomCnd: TEditFocus
        Left = 154
        Top = 55
        Width = 479
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomFpg: TEditFocus
        Left = 154
        Top = 79
        Width = 479
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtVlrTot: TEditFocus
        Left = 214
        Top = 103
        Width = 147
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlFator: TPanel
      Left = 1
      Top = 187
      Width = 641
      Height = 29
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object lblFator: TLabel
        Left = 52
        Top = 6
        Width = 28
        Height = 14
        Caption = 'Fator:'
      end
      object edtFator: TEditFocus
        Tag = 99
        Left = 83
        Top = 3
        Width = 91
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 12
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 12
        TipoTexto = ttNumerico
        EditFormat = '0.00000000'
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 856
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 824
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 752
    Top = 120
  end
end
