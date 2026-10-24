inherited frmFatTintasMaquina: TfrmFatTintasMaquina
  Left = 205
  Top = 182
  Width = 588
  Height = 416
  ActiveControl = trvTintas
  BorderIcons = [biSystemMenu]
  Caption = 'Tintas de m'#225'quina'
  Position = poScreenCenter
  ExplicitWidth = 588
  ExplicitHeight = 416
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 349
    Width = 582
    Height = 26
    ExplicitTop = 340
    ExplicitWidth = 580
    ExplicitHeight = 26
    inherited btnSair: TBitBtnLocked
      Left = 499
      Top = 1
      ExplicitLeft = 499
      ExplicitTop = 1
    end
    object btnConfirma: TBitBtn
      Left = 3
      Top = 1
      Width = 77
      Height = 22
      Caption = '&Confirma'
      TabOrder = 1
      OnClick = btnConfirmaClick
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 375
    Width = 582
    ExplicitTop = 366
    ExplicitWidth = 580
    inherited pnlNomeForm: TPanel
      Left = 409
      ExplicitLeft = 409
    end
    inherited pnlInfo: TPanel
      Width = 409
      ExplicitWidth = 409
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 582
    Height = 349
    Align = alClient
    Color = 16770261
    TabOrder = 2
    ExplicitWidth = 580
    ExplicitHeight = 340
    object pnlLista: TPanel
      Left = 1
      Top = 1
      Width = 321
      Height = 347
      Align = alLeft
      BorderWidth = 5
      Color = 16770261
      TabOrder = 0
      ExplicitHeight = 338
      object trvTintas: TTreeView
        Left = 6
        Top = 6
        Width = 309
        Height = 335
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Indent = 24
        ParentFont = False
        SortType = stData
        TabOrder = 0
        OnChange = trvTintasChange
        OnDblClick = trvTintasDblClick
        OnKeyDown = trvTintasKeyDown
        ExplicitHeight = 326
      end
    end
    object pnlImagem: TPanel
      Left = 322
      Top = 1
      Width = 259
      Height = 347
      Align = alClient
      BorderWidth = 5
      Color = 16770261
      TabOrder = 1
      ExplicitWidth = 257
      ExplicitHeight = 338
      object imgTinta: TImage
        Left = 6
        Top = 69
        Width = 242
        Height = 144
        Center = True
        Stretch = True
      end
    end
  end
end
