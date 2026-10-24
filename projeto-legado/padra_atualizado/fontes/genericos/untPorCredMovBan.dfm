inherited frmPorCredMovBan: TfrmPorCredMovBan
  Left = 574
  Top = 285
  Width = 415
  Height = 242
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Dados para Cr'#233'dito no Movimento Banc'#225'rio'
  Position = poMainFormCenter
  ExplicitWidth = 415
  ExplicitHeight = 242
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 57
    Width = 409
    ExplicitTop = 57
    ExplicitWidth = 409
    DesignSize = (
      409
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 405
      ExplicitWidth = 405
    end
    inherited btnSair: TBitBtnLocked
      Left = 305
      ExplicitLeft = 305
    end
  end
  inherited pgcDados: TPageControl
    Top = 136
    Width = 381
    Height = 72
    Align = alNone
    Visible = False
    ExplicitTop = 136
    ExplicitWidth = 381
    ExplicitHeight = 72
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 373
      ExplicitHeight = 40
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 169
    Width = 409
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    Color = clGray
    TabOrder = 3
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
      Left = 330
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
  inherited pnlStatus: TPanel
    Top = 197
    Width = 409
    ExplicitTop = 197
    ExplicitWidth = 409
    inherited pnlNomeForm: TPanel
      Left = 279
      Width = 130
      ExplicitLeft = 279
      ExplicitWidth = 130
    end
    inherited pnlInfo: TPanel
      Width = 279
      ExplicitWidth = 279
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 0
    Width = 409
    Height = 60
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object rdgTipocheque: TRadioGroup
      Left = 4
      Top = 5
      Width = 396
      Height = 46
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Tipo de Cheque'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Cheque '#224' Vista'
        'Cheque '#224' Prazo')
      TabOrder = 0
      OnClick = rdgTipoChequeClick
    end
  end
  object Panel2: TPanel [6]
    Left = 0
    Top = 57
    Width = 409
    Height = 112
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object pnlFundo: TPanel
      Left = 5
      Top = 2
      Width = 396
      Height = 104
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object lblPorBa1: TLabel
        Left = 42
        Top = 30
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object Label5: TLabel
        Left = 5
        Top = 5
        Width = 375
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'CR'#201'DITO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCodPorBai: TEditFocus
        Left = 153
        Top = 23
        Width = 223
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
      object edtPorBai: TEditFocus
        Tag = 99
        Left = 89
        Top = 23
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnChange = edtPorBaiChange
        OnKeyPress = edtPorBaiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
        Left = 2
        Top = 62
        Width = 377
        Height = 22
        TabOrder = 2
        ExplicitLeft = 2
        ExplicitTop = 62
        ExplicitWidth = 377
        inherited lblPlaContas: TLabel
          Left = 0
          Width = 84
          Height = 14
          ExplicitLeft = 0
          ExplicitWidth = 84
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 151
          Width = 223
          Height = 22
          ExplicitLeft = 151
          ExplicitWidth = 223
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 87
          Width = 64
          Height = 22
          OnExit = fraPlanoDeContasMskCodCtaExit
          OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
          ExplicitLeft = 87
          ExplicitWidth = 64
          ExplicitHeight = 22
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 176
    Top = 88
  end
end
