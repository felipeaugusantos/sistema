inherited frmDigMetMar: TfrmDigMetMar
  Left = 439
  Top = 278
  Width = 211
  Height = 173
  BorderIcons = [biSystemMenu]
  Caption = 'Meta/Margem'
  Position = poMainFormCenter
  ExplicitWidth = 211
  ExplicitHeight = 173
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 100
    Width = 205
    TabOrder = 1
    ExplicitTop = 100
    ExplicitWidth = 205
    DesignSize = (
      205
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 201
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 122
      ExplicitLeft = 122
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 3
      Top = 3
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
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 205
    Height = 100
    Align = alClient
    Color = 16770261
    TabOrder = 0
    ExplicitLeft = 74
    ExplicitTop = 22
    object lbl1: TLabel
      Left = 15
      Top = 13
      Width = 26
      Height = 14
      Caption = 'Meta:'
    end
    object lbl2: TLabel
      Left = 15
      Top = 41
      Width = 41
      Height = 14
      Caption = 'Margem:'
    end
    object edtTotMet: TEditFocus
      Tag = 99
      Left = 65
      Top = 10
      Width = 120
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtMarMes: TEditFocus
      Tag = 99
      Left = 65
      Top = 38
      Width = 64
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object pnlLitragem: TPanel
      Left = 1
      Top = 70
      Width = 203
      Height = 29
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitLeft = -13
      ExplicitTop = 51
      object Label1: TLabel
        Left = 11
        Top = 4
        Width = 44
        Height = 14
        Caption = 'Litragem:'
      end
      object edtTotLit: TEditFocus
        Tag = 99
        Left = 64
        Top = 0
        Width = 120
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 128
    Width = 205
    TabOrder = 2
    ExplicitTop = 128
    ExplicitWidth = 205
    inherited pnlNomeForm: TPanel
      Left = 34
      ExplicitLeft = 34
    end
    inherited pnlInfo: TPanel
      Width = 34
      ExplicitWidth = 34
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 48
  end
end
