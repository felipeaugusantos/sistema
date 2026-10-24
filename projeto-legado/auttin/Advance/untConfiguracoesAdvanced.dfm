inherited frmConfiguracoesAdvanced: TfrmConfiguracoesAdvanced
  Left = 323
  Top = 355
  Width = 507
  Height = 204
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es Advanced'
  Ctl3D = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 9
    Top = 52
    Width = 128
    Height = 14
    Alignment = taRightJustify
    Caption = 'Trava para valor de venda'
  end
  object Label20: TLabel [1]
    Left = 141
    Top = 52
    Width = 48
    Height = 14
    Caption = 'ADV_PRE'
  end
  object Label3: TLabel [2]
    Left = 264
    Top = 52
    Width = 25
    Height = 14
    Alignment = taRightJustify
    Caption = 'Fator'
  end
  object Label4: TLabel [3]
    Left = 46
    Top = 76
    Width = 142
    Height = 14
    Alignment = taRightJustify
    Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula'
  end
  object Label5: TLabel [4]
    Left = 11
    Top = 99
    Width = 145
    Height = 14
    Alignment = taRightJustify
    Caption = 'Path para arquivo de f'#243'rmulas'
  end
  inherited pnlBotoes: TPanel
    Top = 133
    Width = 499
    DesignSize = (
      499
      28)
    inherited btnSair: TBitBtn
      Left = 418
      TabOrder = 1
    end
    object btnGravarConf: TBitBtn
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = 'Gra&var'
      TabOrder = 0
      OnClick = btnGravarConfClick
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
    Top = 161
    Width = 499
    inherited pnlNomeForm: TPanel
      Left = 328
    end
    inherited pnlInfo: TPanel
      Width = 328
    end
  end
  object pnlCabecalho: TPanel [7]
    Left = 0
    Top = 0
    Width = 499
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Advanced'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object chkUsaAdv: TCheckBox [8]
    Tag = 99
    Left = 8
    Top = 30
    Width = 175
    Height = 18
    Caption = 'Utilizar essa tinta de m'#225'quina'
    TabOrder = 3
  end
  object edtTraAdv: TEditFocus [9]
    Tag = 99
    Left = 197
    Top = 48
    Width = 56
    Height = 20
    CharCase = ecUpperCase
    MaxLength = 3
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
    Alignment = taLeftJustify
  end
  object edtFatAdv: TEditFocus [10]
    Tag = 99
    Left = 297
    Top = 48
    Width = 57
    Height = 20
    CharCase = ecUpperCase
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
    Alignment = taLeftJustify
  end
  object edtNfmAdv: TEditFocus [11]
    Tag = 99
    Left = 197
    Top = 72
    Width = 56
    Height = 20
    CharCase = ecUpperCase
    MaxLength = 5
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
    Alignment = taLeftJustify
  end
  inline fraPatAdv: TfraDirectoryEditFocus [12]
    Tag = 99
    Left = 160
    Top = 96
    Width = 329
    Height = 21
    TabOrder = 7
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    inherited edtDirectory: TEditFocus
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
  end
end
