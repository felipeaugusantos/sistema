inherited frmCadVerbasCliFor: TfrmCadVerbasCliFor
  Left = 404
  Top = 257
  Width = 552
  Height = 230
  Caption = 'Cadastro de Verbas'
  ExplicitWidth = 552
  ExplicitHeight = 230
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 163
    Width = 546
    Height = 22
    BevelInner = bvNone
    TabOrder = 1
    ExplicitTop = 163
    ExplicitWidth = 546
    ExplicitHeight = 22
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 544
      Height = 20
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 544
      ExplicitHeight = 20
      inherited btnIncluir: TBitBtnLocked
        Width = 77
        ExplicitWidth = 77
      end
      inherited btnGravar: TBitBtnLocked
        Left = 77
        Width = 76
        ExplicitLeft = 77
        ExplicitWidth = 76
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 153
        Width = 78
        ExplicitLeft = 153
        ExplicitWidth = 78
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 231
        Width = 78
        ExplicitLeft = 231
        ExplicitWidth = 78
      end
      inherited btnCancela: TBitBtnLocked
        Left = 309
        Width = 77
        ExplicitLeft = 309
        ExplicitWidth = 77
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 386
        Width = 78
        ExplicitLeft = 386
        ExplicitWidth = 78
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 465
      Top = 1
      Width = 70
      Height = 20
      ExplicitLeft = 465
      ExplicitTop = 1
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 546
    Height = 163
    TabOrder = 3
    Visible = False
    ExplicitWidth = 546
    ExplicitHeight = 163
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 538
      ExplicitHeight = 131
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 546
    Height = 163
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label2: TLabel
      Left = 188
      Top = 18
      Width = 76
      Height = 14
      Caption = 'Data de Lancto:'
    end
    object Label1: TLabel
      Left = 52
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lbl1: TLabel
      Left = 29
      Top = 40
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
    end
    object lbl2: TLabel
      Left = 53
      Top = 62
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lbl3: TLabel
      Left = 37
      Top = 84
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
    end
    object lbl4: TLabel
      Left = 11
      Top = 106
      Width = 75
      Height = 14
      Caption = 'Valor da Verba:'
    end
    object lbl5: TLabel
      Left = 160
      Top = 106
      Width = 63
      Height = 14
      Caption = 'Valor M'#237'nimo:'
    end
    object lbl6: TLabel
      Left = 54
      Top = 128
      Width = 34
      Height = 14
      Caption = 'Motivo:'
    end
    object dbeDtaLan: TDBEditFocus
      Tag = 99
      Left = 268
      Top = 11
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VBA_DTALAN'
      DataSource = dtsTabela
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 11
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VBA_CODVBA'
      DataSource = dtsTabela
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeCodFor: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 33
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VBA_CODFOR'
      DataSource = dtsTabela
      MaxLength = 8
      TabOrder = 2
      OnKeyPress = dbeCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCli: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 55
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VBA_CODCLI'
      DataSource = dtsTabela
      MaxLength = 8
      TabOrder = 4
      OnKeyPress = dbeCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeCodVen: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 77
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VBA_CODVEN'
      DataSource = dtsTabela
      MaxLength = 3
      TabOrder = 6
      OnKeyPress = dbeCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeValVba: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 99
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VBA_VALVBA'
      DataSource = dtsTabela
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValMin: TDBEditFocus
      Tag = 99
      Left = 228
      Top = 99
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VBA_VALMIN'
      DataSource = dtsTabela
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMot: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 121
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VBA_CODMOT'
      DataSource = dtsTabela
      MaxLength = 5
      TabOrder = 10
      OnKeyPress = dbeCodMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 153
      Top = 33
      Width = 380
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
    object edtNomCli: TEditFocus
      Left = 153
      Top = 55
      Width = 380
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 153
      Top = 77
      Width = 380
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMot: TEditFocus
      Left = 153
      Top = 121
      Width = 380
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
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
    Top = 185
    Width = 546
    TabOrder = 2
    ExplicitTop = 185
    ExplicitWidth = 546
    inherited pnlNomeForm: TPanel
      Left = 376
      Width = 170
      ExplicitLeft = 376
      ExplicitWidth = 170
    end
    inherited pnlInfo: TPanel
      Width = 376
      ExplicitWidth = 376
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 64
  end
  object dtsTabela: TDataSource
    Left = 432
    Top = 8
  end
end
