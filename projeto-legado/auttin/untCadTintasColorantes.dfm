inherited frmCadTintasColorantes: TfrmCadTintasColorantes
  Left = 231
  Top = 264
  Width = 541
  Height = 165
  Caption = 'frmCadTintasColorantes'
  ExplicitWidth = 541
  ExplicitHeight = 165
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 93
    Width = 535
    TabOrder = 2
    ExplicitTop = 93
    ExplicitWidth = 535
    DesignSize = (
      535
      28)
    inherited btnSair: TBitBtnLocked
      Left = 458
      ExplicitLeft = 458
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pgcDados: TPageControl
    Width = 535
    Height = 93
    TabOrder = 0
    ExplicitWidth = 535
    ExplicitHeight = 93
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 527
      ExplicitHeight = 61
    end
  end
  inherited pnlCampos: TPanel
    Width = 535
    Height = 93
    TabOrder = 1
    ExplicitWidth = 535
    ExplicitHeight = 93
    object lblCodigo: TLabel
      Left = 52
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblItem: TLabel
      Left = 66
      Top = 39
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnRestPreco: TSpeedButton
      Left = 498
      Top = 35
      Width = 23
      Height = 22
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
    object lblCusto: TLabel
      Left = 11
      Top = 61
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Custo:'
    end
    object lblMargem: TLabel
      Left = 215
      Top = 61
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object lblVenda: TLabel
      Left = 345
      Top = 61
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda:'
    end
    object lblDescricao: TLabel
      Left = 166
      Top = 17
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 13
      Width = 70
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COL_CODCOL'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeItem: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 35
      Width = 70
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COL_CODITE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      OnEnter = dbeEnterFocus
      OnExit = dbeItemExit
      OnKeyPress = dbeItemKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDescricaoItem: TEditFocus
      Left = 161
      Top = 35
      Width = 337
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCusto: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 57
      Width = 70
      Height = 22
      DataField = 'COL_PRECUS'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeMargem: TDBEditFocus
      Tag = 99
      Left = 260
      Top = 57
      Width = 70
      Height = 22
      DataField = 'COL_MARGEM'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeVenda: TDBEditFocus
      Tag = 99
      Left = 429
      Top = 57
      Width = 70
      Height = 22
      DataField = 'COL_PREVEN'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 221
      Top = 13
      Width = 277
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COL_CODCOL'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 121
    Width = 535
    TabOrder = 3
    ExplicitTop = 121
    ExplicitWidth = 535
    inherited pnlNomeForm: TPanel
      Left = 188
      TabOrder = 1
      ExplicitLeft = 188
    end
    inherited pnlInfo: TPanel
      Width = 188
      TabOrder = 0
      ExplicitWidth = 188
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 485
    Top = 100
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 452
    Top = 100
  end
end
