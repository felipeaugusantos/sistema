inherited frmInsOpeGruOpe: TfrmInsOpeGruOpe
  Left = 217
  Top = 243
  Width = 524
  Height = 134
  HorzScrollBar.Range = 498
  VertScrollBar.Range = 99
  Caption = 'Insere Operador em um Grupo de Operador'
  ExplicitWidth = 524
  ExplicitHeight = 134
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 62
    Width = 518
    TabOrder = 2
    ExplicitTop = 62
    ExplicitWidth = 518
    inherited btnSair: TBitBtnLocked
      Left = 440
      ExplicitLeft = 440
    end
    inherited btnGravar: TBitBtnLocked
      Left = 75
      ExplicitLeft = 75
    end
    inherited btnCancela: TBitBtnLocked
      Left = 291
      ExplicitLeft = 291
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 219
      Visible = False
      ExplicitLeft = 219
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 363
      Visible = False
      ExplicitLeft = 363
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 147
      ExplicitLeft = 147
    end
  end
  inherited pnlStatus: TPanel
    Top = 90
    Width = 518
    TabOrder = 3
    ExplicitTop = 90
    ExplicitWidth = 518
    inherited pnlNomeForm: TPanel
      Left = 327
      Width = 191
      ExplicitLeft = 327
      ExplicitWidth = 191
    end
    inherited pnlInfo: TPanel
      Width = 327
      ExplicitWidth = 327
    end
  end
  inherited pgcDados: TPageControl
    Width = 518
    Height = 62
    TabOrder = 1
    Visible = False
    ExplicitWidth = 518
    ExplicitHeight = 62
    inherited tbsGeral: TTabSheet
      Caption = 'Geral'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 510
      ExplicitHeight = 30
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 518
    Height = 62
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 28
      Top = 15
      Width = 33
      Height = 14
      Caption = 'Grupo:'
    end
    object Label2: TLabel
      Left = 12
      Top = 37
      Width = 49
      Height = 14
      Caption = 'Operador:'
    end
    object dbeCodOpe: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 33
      Width = 50
      Height = 22
      AutoSize = False
      DataField = 'OPE_CODOPE'
      DataSource = frmModulo.dtsOpeGpo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = dbeCodOpeChange
      OnKeyPress = dbeCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object dbeGrupo: TDBEditFocus
      Left = 66
      Top = 11
      Width = 437
      Height = 21
      TabStop = False
      AutoSize = False
      CharCase = ecUpperCase
      DataField = 'GPO_DESCRI'
      DataSource = frmModulo.dtsCadGpo
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = 12040155
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesOperador: TEditFocus
      Left = 117
      Top = 33
      Width = 386
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 392
    Top = 8
  end
end
