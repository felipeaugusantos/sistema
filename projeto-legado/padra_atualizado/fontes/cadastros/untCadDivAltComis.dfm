inherited frmCadDivAltComis: TfrmCadDivAltComis
  Left = 331
  Top = 370
  Width = 355
  Height = 178
  Caption = 'Altera'#231#227'o da Comiss'#227'o por Atividade'
  OnClose = FormClose
  ExplicitWidth = 355
  ExplicitHeight = 178
  PixelsPerInch = 96
  TextHeight = 14
  object Label4: TLabel [0]
    Left = 33
    Top = 21
    Width = 48
    Height = 14
    Alignment = taRightJustify
    Caption = 'Atividade:'
  end
  object Label18: TLabel [1]
    Left = 10
    Top = 47
    Width = 71
    Height = 14
    Alignment = taRightJustify
    Caption = 'Comiss'#227'o (%):'
  end
  object lblPerComPro: TLabel [2]
    Left = 130
    Top = 47
    Width = 98
    Height = 14
    Alignment = taRightJustify
    Caption = 'Itens SEM promo'#231#227'o'
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label1: TLabel [3]
    Left = 10
    Top = 73
    Width = 71
    Height = 14
    Alignment = taRightJustify
    Caption = 'Comiss'#227'o (%):'
  end
  object Label2: TLabel [4]
    Left = 130
    Top = 73
    Width = 100
    Height = 14
    Alignment = taRightJustify
    Caption = 'Itens COM promo'#231#227'o'
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 106
    Width = 349
    TabOrder = 5
    ExplicitTop = 106
    ExplicitWidth = 349
    DesignSize = (
      349
      28)
    inherited btnSair: TBitBtnLocked
      Left = 266
      TabOrder = 1
      ExplicitLeft = 266
    end
    object btnGravar: TBitBtnLocked
      Left = 3
      Top = 4
      Width = 72
      Height = 20
      Caption = '&Gravar'
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
      ModalResult = 1
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 134
    Width = 349
    TabOrder = 4
    ExplicitTop = 134
    ExplicitWidth = 349
    inherited pnlNomeForm: TPanel
      Left = 178
      ExplicitLeft = 178
    end
    inherited pnlInfo: TPanel
      Width = 178
      ExplicitWidth = 178
    end
  end
  object edtCodAti: TEditFocus [7]
    Tag = 99
    Left = 83
    Top = 17
    Width = 44
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 3
    TabOrder = 0
    OnExit = edtCodAtiExit
    OnKeyPress = edtCodAtiKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomAti: TEditFocus [8]
    Left = 128
    Top = 17
    Width = 212
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
  object edtPerCom: TEditFocus [9]
    Tag = 99
    Left = 83
    Top = 43
    Width = 44
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtPerCop: TEditFocus [10]
    Tag = 99
    Left = 83
    Top = 69
    Width = 44
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 48
  end
end
