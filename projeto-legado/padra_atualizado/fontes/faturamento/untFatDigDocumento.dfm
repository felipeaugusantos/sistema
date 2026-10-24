inherited frmFatDigDocumento: TfrmFatDigDocumento
  Left = 321
  Top = 336
  Width = 323
  Height = 174
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 323
  ExplicitHeight = 174
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 101
    Width = 317
    TabOrder = 4
    ExplicitTop = 77
    ExplicitWidth = 317
    inherited FlwBotoes: TFlowPanel
      Width = 313
      ExplicitWidth = 313
    end
    inherited btnSair: TBitBtnLocked
      Left = 234
      ExplicitLeft = 234
    end
  end
  inherited pnlStatus: TPanel
    Top = 129
    Width = 317
    TabOrder = 3
    ExplicitTop = 105
    ExplicitWidth = 317
    inherited pnlNomeForm: TPanel
      Left = 160
      Width = 157
      ExplicitLeft = 160
      ExplicitWidth = 157
    end
    inherited pnlInfo: TPanel
      Width = 160
      ExplicitWidth = 160
    end
  end
  inherited pgcDados: TPageControl
    Width = 317
    Height = 101
    Visible = False
    ExplicitWidth = 317
    ExplicitHeight = 77
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 309
      ExplicitHeight = 45
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 317
    Height = 101
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    ExplicitHeight = 77
    object pnlDocumento: TPanel
      Left = 2
      Top = 52
      Width = 313
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitTop = 27
      object Label1: TLabel
        Left = 2
        Top = 5
        Width = 151
        Height = 14
        Caption = 'Nro de Documento para alterar:'
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 156
        Top = 1
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 0
        OnChange = edtNumDocChange
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
        Tag = 99
        Left = 243
        Top = 1
        Width = 30
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 1
        OnChange = edtEspDocChange
        OnKeyPress = edtNumDocKeyPress
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
        Left = 274
        Top = 1
        Width = 30
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
    end
    object pnlComanda: TPanel
      Left = 2
      Top = 27
      Width = 313
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 2
      object lblComanda: TLabel
        Left = 105
        Top = 4
        Width = 48
        Height = 14
        Caption = 'Comanda:'
      end
      object edtBarCom: TEditFocus
        Tag = 99
        Left = 156
        Top = 1
        Width = 148
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnKeyPress = edtBarComKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 13
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlHeranca: TPanel
      Left = 2
      Top = 77
      Width = 313
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      ExplicitTop = 52
      object chkHerOrc: TCheckBox
        Left = 2
        Top = 2
        Width = 213
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Utilizar Heran'#231'a de Or'#231'amento / Pedido?'
        Enabled = False
        TabOrder = 0
      end
    end
    object pnlRemessaDevolucao: TPanel
      Left = 2
      Top = 2
      Width = 313
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 10
      object Label2: TLabel
        Left = 36
        Top = 4
        Width = 117
        Height = 14
        Caption = 'Remessa de Devolu'#231#227'o:'
      end
      object edtRemessaDevolucao: TEditFocus
        Tag = 99
        Left = 156
        Top = 1
        Width = 148
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnExit = edtRemessaDevolucaoExit
        OnKeyPress = edtRemessaDevolucaoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
    end
  end
  object pnlConfirma: TPanel [4]
    Left = 0
    Top = 101
    Width = 317
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 77
    object FlwPnlConfirma: TFlowPanel
      Left = 2
      Top = 2
      Width = 235
      Height = 24
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnConfirmaDados: TBitBtnLocked
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
        OnClick = btnConfirmaDadosClick
      end
    end
    object btnCancelaDados: TBitBtnLocked
      AlignWithMargins = True
      Left = 237
      Top = 2
      Width = 77
      Height = 23
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 1
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 86
    Top = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 58
    Top = 4
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 4
    Top = 4
  end
end
