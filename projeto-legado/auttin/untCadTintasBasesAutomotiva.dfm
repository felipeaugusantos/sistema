inherited frmCadTintasBasesAutomotiva: TfrmCadTintasBasesAutomotiva
  Left = 273
  Top = 518
  Width = 532
  Height = 197
  Caption = 'frmCadTintasBasesAutomotiva'
  ExplicitWidth = 532
  ExplicitHeight = 197
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 125
    Width = 526
    TabOrder = 2
    ExplicitTop = 125
    ExplicitWidth = 526
    DesignSize = (
      526
      28)
    inherited btnSair: TBitBtnLocked
      Left = 449
      ExplicitLeft = 449
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 153
    Width = 526
    TabOrder = 3
    ExplicitTop = 153
    ExplicitWidth = 526
    inherited pnlNomeForm: TPanel
      Left = 179
      TabOrder = 1
      ExplicitLeft = 179
    end
    inherited pnlInfo: TPanel
      Width = 179
      TabOrder = 0
      ExplicitWidth = 179
    end
  end
  inherited pgcDados: TPageControl
    Width = 526
    Height = 125
    TabOrder = 0
    ExplicitWidth = 526
    ExplicitHeight = 125
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 518
      ExplicitHeight = 93
    end
  end
  inherited pnlCampos: TPanel
    Width = 526
    Height = 125
    TabOrder = 1
    ExplicitWidth = 526
    ExplicitHeight = 125
    object lblCodigo: TLabel
      Left = 40
      Top = 20
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblDescricao: TLabel
      Left = 160
      Top = 20
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblEmbalagem: TLabel
      Left = 19
      Top = 42
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object lblPesoEspecifico: TLabel
      Left = 356
      Top = 42
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso Espec'#237'fico:'
    end
    object lblCodigoItem: TLabel
      Left = 54
      Top = 64
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object lblPrecoCusto: TLabel
      Left = 45
      Top = 86
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Custo:'
    end
    object lblMargem: TLabel
      Left = 211
      Top = 86
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object lblPrecoVenda: TLabel
      Left = 394
      Top = 86
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Venda:'
    end
    object btnRestPreco: TSpeedButton
      Left = 489
      Top = 61
      Width = 23
      Height = 20
      Hint = 'Restaura dados do produto'
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
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btnRestPrecoClick
    end
    object edtDescricaoItem: TEdit
      Left = 120
      Top = 60
      Width = 369
      Height = 22
      TabStop = False
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
    end
    object dbeCodigo: TDBEditFocus
      Left = 80
      Top = 16
      Width = 73
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Left = 216
      Top = 16
      Width = 273
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEmbalagem: TDBEditFocus
      Left = 80
      Top = 38
      Width = 65
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePesoEspecifico: TDBEditFocus
      Left = 440
      Top = 38
      Width = 49
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigoItem: TDBEditFocus
      Left = 80
      Top = 60
      Width = 41
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      OnExit = dbeCodigoItemExit
      OnKeyPress = dbeCodigoItemKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePrecoCusto: TDBEditFocus
      Left = 80
      Top = 82
      Width = 57
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMargem: TDBEditFocus
      Left = 256
      Top = 82
      Width = 57
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePrecoVenda: TDBEditFocus
      Left = 432
      Top = 82
      Width = 57
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 153
    Width = 526
    TabOrder = 3
    ExplicitTop = 153
    ExplicitWidth = 526
    inherited pnlNomeForm: TPanel
      Left = 179
      TabOrder = 1
      ExplicitLeft = 179
    end
    inherited pnlInfo: TPanel
      Width = 179
      TabOrder = 0
      ExplicitWidth = 179
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 476
    Top = 122
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 443
    Top = 122
  end
end
