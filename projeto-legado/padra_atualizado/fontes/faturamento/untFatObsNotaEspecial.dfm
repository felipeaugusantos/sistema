inherited frmFatObsNotaEspecial: TfrmFatObsNotaEspecial
  Left = 215
  Top = 228
  Width = 650
  Height = 385
  BorderIcons = [biSystemMenu]
  Caption = 'Observa'#231#245'es do Produto'
  Position = poScreenCenter
  ExplicitWidth = 650
  ExplicitHeight = 385
  PixelsPerInch = 96
  TextHeight = 14
  object lblCaracteresDisponiveis: TLabel [0]
    Left = 0
    Top = 239
    Width = 644
    Height = 14
    Align = alBottom
    Caption = 'Dispon'#237'veis 500 caracteres de 500'
    Visible = False
    ExplicitTop = 237
    ExplicitWidth = 168
  end
  inherited pnlBotoes: TPanel
    Top = 314
    Width = 644
    Height = 26
    TabOrder = 3
    ExplicitTop = 314
    ExplicitWidth = 644
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 486
      Height = 22
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 640
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 565
      Top = 2
      Align = alRight
      ExplicitLeft = 561
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 22
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
      ExplicitLeft = 3
      ExplicitTop = 3
    end
  end
  object memObserv: TMemoFocus [3]
    Left = 0
    Top = 0
    Width = 644
    Height = 239
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Lines.Strings = (
      'memObserv')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnKeyUp = memObservKeyUp
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
    Texto = 'memObserv'
    ExplicitHeight = 237
  end
  object pnlInfIcmsImo: TPanel [4]
    Left = 0
    Top = 253
    Width = 644
    Height = 26
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 251
    object chkInfIcmsImo: TCheckBox
      Left = 15
      Top = 6
      Width = 257
      Height = 17
      Caption = 'Digitar os valores do ICMS do Ativo/Imobilizado'
      TabOrder = 0
      OnClick = chkInfIcmsImoClick
    end
  end
  object pnlIcmsImobil: TPanel [5]
    Left = 0
    Top = 279
    Width = 644
    Height = 35
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label2: TLabel
      Left = 15
      Top = 13
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base ICMS:'
    end
    object Label3: TLabel
      Left = 310
      Top = 13
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor ICMS:'
    end
    object Label4: TLabel
      Left = 159
      Top = 13
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Aliquota ICMS:'
    end
    object edtBasIcms: TEditFocus
      Tag = 99
      Left = 72
      Top = 6
      Width = 80
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      Text = '0,00'
      OnChange = edtBasIcmsChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValIcms: TEditFocus
      Tag = 99
      Left = 367
      Top = 6
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
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
    object edtAlqIcms: TEditFocus
      Tag = 99
      Left = 230
      Top = 6
      Width = 70
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      Text = '0,00'
      OnChange = edtBasIcmsChange
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
  inherited pnlStatus: TPanel
    Top = 340
    Width = 644
    TabOrder = 4
    ExplicitTop = 340
    ExplicitWidth = 644
    inherited pnlNomeForm: TPanel
      Left = 473
      ExplicitLeft = 473
    end
    inherited pnlInfo: TPanel
      Width = 473
      ExplicitWidth = 473
    end
  end
end
