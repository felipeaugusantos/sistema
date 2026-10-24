inherited frmCadBancos: TfrmCadBancos
  Left = 211
  Top = 240
  Width = 551
  Height = 222
  Caption = 'Cadastro de Bancos'
  ExplicitWidth = 551
  ExplicitHeight = 222
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 155
    Width = 545
    Height = 22
    BevelInner = bvNone
    TabOrder = 1
    ExplicitTop = 155
    ExplicitWidth = 545
    ExplicitHeight = 22
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 543
      Height = 20
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 543
      ExplicitHeight = 20
      inherited btnIncluir: TBitBtnLocked
        Width = 77
        ExplicitWidth = 77
      end
      inherited btnGravar: TBitBtnLocked
        Left = 77
        Width = 77
        ExplicitLeft = 77
        ExplicitWidth = 77
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 154
        Width = 77
        ExplicitLeft = 154
        ExplicitWidth = 77
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 231
        Width = 75
        ExplicitLeft = 231
        ExplicitWidth = 75
      end
      inherited btnCancela: TBitBtnLocked
        Left = 306
        Width = 74
        ExplicitLeft = 306
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 380
        Width = 79
        ExplicitLeft = 380
        ExplicitWidth = 79
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 460
      Top = 1
      Width = 76
      Height = 20
      ExplicitLeft = 460
      ExplicitTop = 1
      ExplicitWidth = 76
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 177
    Width = 545
    TabOrder = 3
    ExplicitTop = 177
    ExplicitWidth = 545
    inherited pnlNomeForm: TPanel
      Left = 382
      Width = 163
      ExplicitLeft = 382
      ExplicitWidth = 163
    end
    inherited pnlInfo: TPanel
      Width = 382
      ExplicitWidth = 382
    end
  end
  inherited pgcDados: TPageControl
    Width = 545
    Height = 155
    Visible = False
    ExplicitWidth = 545
    ExplicitHeight = 155
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 537
      ExplicitHeight = 123
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 545
    Height = 155
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label3: TLabel
      Left = 20
      Top = 99
      Width = 102
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr'#243'x. Nosso Numero:'
    end
    object Label2: TLabel
      Left = 92
      Top = 33
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object Label1: TLabel
      Left = 86
      Top = 11
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblProNu7: TLabel
      Left = 22
      Top = 121
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = '2'#186' Pr'#243'x. Nosso Num:'
    end
    object Label4: TLabel
      Left = 8
      Top = 77
      Width = 114
      Height = 14
      Alignment = taRightJustify
      Caption = 'Path extratos baixados:'
    end
    object LabelCgc1: TLabelCgc
      Left = 94
      Top = 55
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'CNPJ:'
      Pais = opcBrasil
    end
    object dbeProNum: TDBEditFocus
      Tag = 99
      Left = 126
      Top = 96
      Width = 155
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BCO_PRONUM'
      DataSource = dtsCadBco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnEnter = dbeProNumEnter
      OnExit = dbeProNumExit
      OnMouseEnter = dbeProNumEnter
      OnMouseLeave = dbeProNumExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeNomBco: TDBEditFocus
      Tag = 99
      Left = 126
      Top = 30
      Width = 384
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BCO_NOMBCO'
      DataSource = dtsCadBco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodBco: TDBEditFocus
      Tag = 99
      Left = 126
      Top = 8
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BCO_CODBCO'
      DataSource = dtsCadBco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeProNu7: TDBEditFocus
      Tag = 99
      Left = 126
      Top = 118
      Width = 155
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BCO_PRONU7'
      DataSource = dtsCadBco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnEnter = dbeProNu7Enter
      OnExit = dbeProNu7Exit
      OnMouseEnter = dbeProNu7Enter
      OnMouseLeave = dbeProNu7Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbePathExt: TDBEditFocus
      Tag = 99
      Left = 126
      Top = 74
      Width = 384
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BCO_PATEXT'
      DataSource = dtsCadBco
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
      TipoTexto = ttAlfanumerico
    end
    object btnLocal: TBitBtnLocked
      Left = 510
      Top = 74
      Width = 23
      Height = 22
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000457B98FF447A
        96FF447A96FF447A96FF447A96FF447A96FF447A96FF447A96FF447A96FF447A
        96FF447A96FF447A96FF447A96FF447A96FF447A96FF0306080D487F9CFF78BE
        E2FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CE
        F5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF4A839FFF0B141829487F9BFF70B3
        D6FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CE
        F5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF518BA9FF13212946457B98FF68A9
        CAFF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CE
        F5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF5A97B6FF1A2F3A62447A96FF609D
        BEFF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CE
        F5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF64A2C3FF233E4D81447A96FF5692
        B1FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CE
        F5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF6BADCFFF2E5265A5447A96FF4E88
        A6FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF85CE
        F5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF72B6DAFF39647BC7447A96FF447A
        96FF447A96FF447A96FF447A96FF447A96FF5187A3FF6BADCFFF84CDF3FF85CE
        F5FF85CEF5FF85CEF5FF85CEF5FF85CEF5FF7AC0E4FF40708BE2447A96FF65B0
        DBFF9C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFD3E0E6FF709AB1FF447A96FF447A
        96FF447A96FF447A96FF447A96FF447A96FF447A96FF427590F3447A96FF65B0
        DBFF9C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B78FF00000000447A96FF65B0
        DBFF9C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B78FF00000000447A96FF65B0
        DBFF9C8B78FF9C8B78FF9C8B78FF9C8B78FF9C8B78FF9C8B78FF9C8B78FF9C8B
        78FF9C8B78FF9C8B78FF9C8B78FF9C8B78FF9C8B78FF00000000447A96FF65B0
        DBFF65B0DBFF65B0DBFF63ACD5FF467C99F42645558E00000000000000000000
        0000000000000000000000000000000000000000000000000000447A96FF447A
        96FF447A96FF447A96FF447A96FF2645548D0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 6
      TabStop = False
      OnClick = btnLocalClick
    end
    object dbeNumCgc: TDBEditCgcCpf
      Tag = 99
      Left = 126
      Top = 52
      Width = 187
      Height = 22
      DataField = 'BCO_C_G_C_'
      DataSource = dtsCadBco
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
      Tipo = C_G_C_
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 736
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 704
    Top = 24
  end
  object dtsCadBco: TDataSource
    Left = 672
    Top = 24
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpLeftBottom
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 767
    Top = 24
  end
end
