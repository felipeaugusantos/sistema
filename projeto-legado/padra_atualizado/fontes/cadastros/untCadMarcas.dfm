inherited frmCadMarcas: TfrmCadMarcas
  Left = 254
  Top = 376
  Width = 535
  Height = 159
  Caption = 'Cadastro de Marcas'
  ExplicitWidth = 535
  ExplicitHeight = 159
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 89
    Width = 529
    Height = 25
    TabOrder = 1
    ExplicitTop = 89
    ExplicitWidth = 529
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 461
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 461
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
      Left = 463
      Width = 64
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 463
      ExplicitWidth = 64
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 114
    Width = 529
    TabOrder = 3
    ExplicitTop = 114
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
    Height = 89
    Visible = False
    ExplicitWidth = 529
    ExplicitHeight = 89
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 521
      ExplicitHeight = 57
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 89
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 58
      Top = 15
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 42
      Top = 38
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblFator: TLabel
      Left = 6
      Top = 63
      Width = 350
      Height = 14
      Alignment = taRightJustify
      Caption = 
        'Fator para eleva'#231#227'o do custo no relat'#243'rio de comiss'#227'o pelo fatur' +
        'amento:'
    end
    object Label37: TLabel
      Left = 365
      Top = 15
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativa:'
    end
    object ColorLabel1: TColorLabel
      Left = 424
      Top = 15
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object dbeDesMar: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 34
      Width = 403
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MAR_DESMAR'
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
    object dbeCodMar: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 11
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MAR_CODMAR'
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
    object dbeFatCus: TDBEditFocus
      Tag = 99
      Left = 369
      Top = 58
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'MAR_FATCUS'
      DataSource = dtsTabela
      MaxLength = 19
      ParentCtl3D = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeStatus: TDBEditFocus
      Tag = 99
      Left = 395
      Top = 10
      Width = 23
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MAR_ATIVA_'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      OnEnter = dbeStatusEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
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
