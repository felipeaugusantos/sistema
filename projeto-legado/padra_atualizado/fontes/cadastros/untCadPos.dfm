inherited frmCadPos: TfrmCadPos
  Left = 254
  Top = 376
  Width = 535
  Height = 205
  Caption = 'Cadastro de POS'
  ExplicitWidth = 535
  ExplicitHeight = 205
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 135
    Width = 529
    Height = 25
    TabOrder = 1
    ExplicitTop = 135
    ExplicitWidth = 529
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 465
      Height = 21
      ExplicitWidth = 465
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 75
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 150
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 225
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 300
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 375
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 467
      Width = 60
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 467
      ExplicitWidth = 60
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 160
    Width = 529
    TabOrder = 3
    ExplicitTop = 160
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 362
      Width = 167
      ExplicitLeft = 362
      ExplicitWidth = 167
    end
    inherited pnlInfo: TPanel
      Width = 362
      ExplicitWidth = 362
    end
  end
  inherited pgcDados: TPageControl
    Width = 529
    Height = 135
    Visible = False
    ExplicitWidth = 529
    ExplicitHeight = 135
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 521
      ExplicitHeight = 103
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 135
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 57
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 41
      Top = 35
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 63
      Top = 59
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Serial:'
    end
    object Label4: TLabel
      Left = 12
      Top = 83
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estabelecimento:'
    end
    object Label5: TLabel
      Left = 37
      Top = 107
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Adquirente:'
    end
    object dbeDesPos: TDBEditFocus
      Tag = 99
      Left = 95
      Top = 31
      Width = 403
      Height = 22
      CharCase = ecUpperCase
      DataField = 'POS_DESPOS'
      DataSource = dtsTabela
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
    object dbeCodPos: TDBEditFocus
      Tag = 99
      Left = 95
      Top = 8
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'POS_CODPOS'
      DataSource = dtsTabela
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
    object dbeSerPos: TDBEditFocus
      Tag = 99
      Left = 95
      Top = 55
      Width = 403
      Height = 22
      CharCase = ecUpperCase
      DataField = 'POS_SERPOS'
      DataSource = dtsTabela
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
      TipoTexto = ttAlfanumerico
    end
    object dbeEstabe: TDBEditFocus
      Tag = 99
      Left = 95
      Top = 79
      Width = 169
      Height = 22
      CharCase = ecUpperCase
      DataField = 'POS_ESTABE'
      DataSource = dtsTabela
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
      TipoTexto = ttNumerico
    end
    object dbeCodAdq: TDBEditFocus
      Tag = 99
      Left = 95
      Top = 103
      Width = 53
      Height = 22
      CharCase = ecUpperCase
      DataField = 'POS_CODADQ'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnKeyPress = dbeCodAdqKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtNomAdq: TEditFocus
      Tag = 99
      Left = 151
      Top = 103
      Width = 347
      Height = 22
      Alignment = taLeftJustify
      Color = 16770261
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
  end
  object dtsTabela: TDataSource
    Left = 352
  end
end
