inherited frmFatVendasPigmentos: TfrmFatVendasPigmentos
  Width = 499
  Height = 180
  Caption = 'Calcular quantidade de pigmentos para venda'
  Position = poMainFormCenter
  ExplicitWidth = 499
  ExplicitHeight = 180
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 37
    Top = 16
    Width = 58
    Height = 14
    Caption = 'Quantidade:'
  end
  object Label2: TLabel [1]
    Left = 6
    Top = 63
    Width = 89
    Height = 14
    Caption = 'Fator Tintom'#233'trico:'
  end
  object Label3: TLabel [2]
    Left = 239
    Top = 63
    Width = 83
    Height = 14
    Caption = 'Quantidade Total:'
  end
  inherited pnlBotoes: TPanel
    Top = 107
    Width = 493
    TabOrder = 1
    ExplicitTop = 107
    ExplicitWidth = 493
    inherited FlwBotoes: TFlowPanel
      Width = 489
      ExplicitWidth = 489
      object btnCopiarParaVendas: TBitBtn
        Left = 0
        Top = 0
        Width = 169
        Height = 25
        Caption = 'Copiar para a tela de vendas'
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
        TabOrder = 0
        OnClick = btnCopiarParaVendasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 410
      ExplicitLeft = 410
    end
  end
  inherited pnlStatus: TPanel
    Top = 135
    Width = 493
    TabOrder = 2
    ExplicitTop = 135
    ExplicitWidth = 493
    inherited pnlNomeForm: TPanel
      Left = 322
      ExplicitLeft = 322
    end
    inherited pnlInfo: TPanel
      Width = 322
      ExplicitWidth = 322
    end
  end
  object edtQuantidade: TEdit [6]
    Left = 101
    Top = 16
    Width = 121
    Height = 22
    TabOrder = 0
    OnExit = edtQuantidadeExit
  end
  object edtFatorTintometrico: TEdit [7]
    Left = 101
    Top = 60
    Width = 121
    Height = 22
    TabStop = False
    Color = 16768952
    ReadOnly = True
    TabOrder = 4
  end
  object edtQuantidadeTotal: TEdit [8]
    Left = 328
    Top = 60
    Width = 88
    Height = 22
    TabStop = False
    Color = 16768952
    ReadOnly = True
    TabOrder = 5
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 312
    Top = 216
  end
end
