inherited frmCadGPC: TfrmCadGPC
  Left = 254
  Top = 376
  Width = 535
  Height = 138
  Caption = 'Cadastro de Classifica'#231#227'o Global do Produto - GPC'
  ExplicitWidth = 535
  ExplicitHeight = 138
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 65
    Width = 529
    TabOrder = 1
    ExplicitTop = 65
    ExplicitWidth = 529
    DesignSize = (
      529
      28)
    inherited btnSair: TBitBtnLocked
      Left = 445
      Width = 73
      Height = 20
      ExplicitLeft = 445
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 529
    Height = 65
    Visible = False
    ExplicitWidth = 529
    ExplicitHeight = 65
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 521
      ExplicitHeight = 33
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 65
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
    object dbeDesGpc: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 34
      Width = 403
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GPC_DESGPC'
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
    object dbeCodGpc: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 11
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GPC_CODGPC'
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
  end
  inherited pnlStatus: TPanel
    Top = 93
    Width = 529
    TabOrder = 3
    ExplicitTop = 93
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
