inherited frmDigPortador: TfrmDigPortador
  Left = 266
  Top = 244
  Width = 406
  Height = 196
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 406
  ExplicitHeight = 196
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 151
    Width = 400
    ExplicitTop = 121
    ExplicitWidth = 400
    inherited FlwBotoes: TFlowPanel
      Width = 396
      ExplicitWidth = 396
    end
    inherited btnSair: TBitBtnLocked
      Left = 284
      ExplicitLeft = 284
    end
  end
  inherited pnlStatus: TPanel
    Top = 151
    Width = 400
    TabOrder = 3
    ExplicitTop = 121
    ExplicitWidth = 400
    inherited pnlNomeForm: TPanel
      Left = 251
      Width = 149
      ExplicitLeft = 251
      ExplicitWidth = 149
    end
    inherited pnlInfo: TPanel
      Width = 251
      ExplicitWidth = 251
    end
  end
  inherited pgcDados: TPageControl
    Width = 400
    Height = 151
    TabOrder = 1
    Visible = False
    ExplicitWidth = 400
    ExplicitHeight = 121
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 392
      ExplicitHeight = 89
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 400
    Height = 151
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 121
    object lblPor: TLabel
      Left = 35
      Top = 18
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lbl1: TLabel
      Left = 29
      Top = 43
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object edtPorBai: TEditFocus
      Tag = 99
      Left = 82
      Top = 14
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
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
    object edtCodPorBai: TEditFocus
      Left = 148
      Top = 14
      Width = 239
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 82
      Top = 39
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 13
      TabOrder = 2
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 13
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 148
      Top = 39
      Width = 239
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object pnlConfirma: TPanel
      Left = 2
      Top = 125
      Width = 396
      Height = 24
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clGray
      TabOrder = 6
      ExplicitTop = 95
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
        Left = 317
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
      end
    end
    object pnlHistorico: TPanel
      Left = 2
      Top = 93
      Width = 396
      Height = 32
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlHistorico'
      ShowCaption = False
      TabOrder = 5
      Visible = False
      ExplicitTop = 63
      object lblHist1: TLabel
        Left = 23
        Top = 5
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico 1:'
      end
      object edtHist01: TEditFocus
        Tag = 99
        Left = 80
        Top = 1
        Width = 305
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlCentroCusto: TPanel
      Left = 2
      Top = 62
      Width = 396
      Height = 31
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlHistorico'
      ShowCaption = False
      TabOrder = 4
      Visible = False
      ExplicitTop = 68
      inline fraCentroCusto: TfraCentroCustoEditFocus
        Left = 2
        Top = 3
        Width = 386
        Height = 26
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 3
        ExplicitWidth = 386
        ExplicitHeight = 26
        inherited lblEventos: TLabel
          Left = 3
          Width = 72
          Height = 14
          Caption = 'Centro Custos:'
          ExplicitLeft = 3
          ExplicitWidth = 72
          ExplicitHeight = 14
        end
        inherited edtCodEve: TEditFocus
          Left = 78
          Top = 1
          Width = 64
          Height = 23
          ExplicitLeft = 78
          ExplicitTop = 1
          ExplicitWidth = 64
          ExplicitHeight = 23
        end
        inherited edtDesEve: TEditFocus
          Left = 144
          Top = 1
          Width = 239
          Height = 23
          Enabled = True
          ExplicitLeft = 144
          ExplicitTop = 1
          ExplicitWidth = 239
          ExplicitHeight = 23
        end
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 65528
  end
end
