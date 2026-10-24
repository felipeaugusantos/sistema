inherited frmCadBairros: TfrmCadBairros
  Height = 152
  Caption = 'Cadastro de Bairros'
  OnDestroy = FormDestroy
  ExplicitHeight = 152
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 14
    Top = 20
    Width = 36
    Height = 14
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 135
    Top = 20
    Width = 27
    Height = 14
    Caption = 'Nome'
  end
  object Label3: TLabel [2]
    Left = 14
    Top = 43
    Width = 36
    Height = 14
    Caption = 'Cidade:'
  end
  object Label4: TLabel [3]
    Left = 387
    Top = 44
    Width = 16
    Height = 14
    Caption = 'UF:'
  end
  inherited pnlBotoes: TPanel
    Top = 82
    Height = 25
    ExplicitTop = 82
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 511
      Height = 21
      ExplicitTop = 2
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        Height = 21
        Spacing = 2
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        Height = 21
        Spacing = 2
        ExplicitLeft = 83
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        Height = 21
        Spacing = 2
        ExplicitLeft = 166
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        Height = 21
        Spacing = 2
        ExplicitLeft = 249
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 83
        Height = 21
        Spacing = 2
        ExplicitLeft = 332
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 415
        Width = 83
        Height = 21
        Spacing = 2
        ExplicitLeft = 415
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 513
      Width = 70
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 507
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Left = 1023
    Top = 8
    Width = 82
    Height = 57
    Align = alNone
    Visible = False
    ExplicitLeft = 1023
    ExplicitTop = 8
    ExplicitWidth = 82
    ExplicitHeight = 57
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 74
      ExplicitHeight = 25
    end
  end
  object dbeCodBai: TDBEditFocus [7]
    Tag = 99
    Left = 53
    Top = 16
    Width = 76
    Height = 22
    DataField = 'BAI_CODBAI'
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeDescri: TDBEditFocus [8]
    Tag = 99
    Left = 168
    Top = 16
    Width = 275
    Height = 22
    CharCase = ecUpperCase
    DataField = 'BAI_DESCRI'
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCodCid: TDBEditFocus [9]
    Tag = 99
    Left = 53
    Top = 40
    Width = 47
    Height = 22
    DataField = 'BAI_CODCID'
    MaxLength = 5
    TabOrder = 5
    OnKeyPress = dbeCodCidKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object edtNomCid: TEditFocus [10]
    Left = 104
    Top = 40
    Width = 277
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ReadOnly = True
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtEstado: TEditFocus [11]
    Left = 409
    Top = 40
    Width = 34
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ReadOnly = True
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited pnlStatus: TPanel
    Top = 107
    ExplicitTop = 107
    inherited pnlNomeForm: TPanel
      Left = 376
      Width = 209
      ExplicitLeft = 376
      ExplicitWidth = 209
    end
    inherited pnlInfo: TPanel
      Width = 376
      ExplicitWidth = 376
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 680
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 648
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 0
  end
end
