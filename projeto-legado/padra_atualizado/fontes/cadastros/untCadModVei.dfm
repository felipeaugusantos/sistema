inherited frmCadModVei: TfrmCadModVei
  Left = 319
  Top = 465
  Width = 532
  Height = 172
  Caption = 'Cadastro de Modelos de Ve'#237'culos'
  ExplicitWidth = 532
  ExplicitHeight = 172
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 102
    Width = 526
    Height = 25
    ExplicitTop = 102
    ExplicitWidth = 526
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 454
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 522
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Width = 73
        Height = 21
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 145
        Width = 73
        Height = 21
        ExplicitLeft = 145
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 218
        Width = 73
        Height = 21
        ExplicitLeft = 218
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 291
        Width = 75
        Height = 21
        ExplicitLeft = 291
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 366
        Width = 75
        Height = 21
        ExplicitLeft = 366
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 456
      Width = 68
      Height = 21
      Align = alRight
      ExplicitLeft = 453
      ExplicitWidth = 68
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Left = 536
    Top = 18
    Width = 73
    Height = 33
    Align = alNone
    Visible = False
    ExplicitLeft = 536
    ExplicitTop = 18
    ExplicitWidth = 73
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 1
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 526
    Height = 102
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 11
      Top = 41
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lbl5: TLabel
      Left = 30
      Top = 64
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object dbeDesMod: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 37
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MOD_DESMOD'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMod: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MOD_CODMOD'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeCodMar: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 60
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MOD_CODMAR'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnKeyPress = dbeCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodMarChamaCadastro
    end
    object edtDesMar: TEditFocus
      Left = 106
      Top = 60
      Width = 409
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
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
  end
  inherited pnlStatus: TPanel
    Top = 127
    Width = 526
    ExplicitTop = 127
    ExplicitWidth = 526
    inherited pnlNomeForm: TPanel
      Left = 319
      Width = 207
      ExplicitLeft = 319
      ExplicitWidth = 207
    end
    inherited pnlInfo: TPanel
      Width = 319
      ExplicitWidth = 319
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 4
  end
end
