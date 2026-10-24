inherited frmCadEmpresasTintometricos: TfrmCadEmpresasTintometricos
  Left = 252
  Top = 182
  Width = 531
  Height = 499
  Caption = 'Sistemas tintom'#233'tricos a utilizar'
  Position = poScreenCenter
  ExplicitWidth = 531
  ExplicitHeight = 499
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 239
    Top = 0
    Height = 428
  end
  object Splitter2: TSplitter [1]
    Left = 272
    Top = 0
    Height = 428
  end
  inherited pnlBotoes: TPanel
    Top = 428
    Width = 525
    Height = 26
    ExplicitTop = 428
    ExplicitWidth = 525
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 74
      Width = 372
      Height = 22
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 521
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      Top = 2
      Align = alRight
      ExplicitLeft = 442
    end
    object btnConfirmar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 72
      Height = 22
      Align = alLeft
      Caption = '&Confirmar'
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
      OnClick = btnConfirmarClick
      ExplicitLeft = 3
      ExplicitTop = 4
    end
  end
  object pnlDisponiveis: TPanel [4]
    Left = 0
    Top = 0
    Width = 239
    Height = 428
    Align = alLeft
    BevelOuter = bvNone
    BorderWidth = 5
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitHeight = 426
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 229
      Height = 17
      Align = alTop
      Caption = 'Dispon'#237'veis'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 75
    end
    object lsbDisponiveis: TListBox
      Left = 5
      Top = 22
      Width = 229
      Height = 401
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 17
      ParentFont = False
      Sorted = True
      TabOrder = 0
      OnDblClick = lsbDisponiveisDblClick
      ExplicitHeight = 399
    end
  end
  object Panel2: TPanel [5]
    Left = 242
    Top = 0
    Width = 30
    Height = 428
    Align = alLeft
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 426
    object btnAddUm: TSpeedButton
      Left = 3
      Top = 146
      Width = 25
      Height = 25
      Caption = '>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      OnClick = btnAddUmClick
    end
    object btnAddTodos: TSpeedButton
      Left = 3
      Top = 170
      Width = 25
      Height = 25
      Caption = '>>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      OnClick = btnAddTodosClick
    end
    object btnDelUma: TSpeedButton
      Left = 3
      Top = 219
      Width = 25
      Height = 25
      Caption = '<'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      OnClick = btnDelUmaClick
    end
    object btnDelTodos: TSpeedButton
      Left = 3
      Top = 194
      Width = 25
      Height = 25
      Caption = '<<'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      OnClick = btnDelTodosClick
    end
  end
  object pnlUtilizadas: TPanel [6]
    Left = 275
    Top = 0
    Width = 250
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitHeight = 426
    object Label2: TLabel
      Left = 5
      Top = 5
      Width = 240
      Height = 17
      Align = alTop
      Caption = 'Utilizadas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 63
    end
    object lsbUtilizadas: TListBox
      Left = 5
      Top = 22
      Width = 240
      Height = 401
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 17
      ParentFont = False
      Sorted = True
      TabOrder = 0
      OnDblClick = lsbUtilizadasDblClick
      ExplicitHeight = 399
    end
  end
  inherited pnlStatus: TPanel
    Top = 454
    Width = 525
    ExplicitTop = 454
    ExplicitWidth = 525
    inherited pnlNomeForm: TPanel
      Left = 354
      ExplicitLeft = 354
    end
    inherited pnlInfo: TPanel
      Width = 354
      ExplicitWidth = 354
    end
  end
end
