inherited frmCadReiCores: TfrmCadReiCores
  Left = 215
  Top = 204
  VertScrollBar.Range = 0
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Cores - Renner Imobili'#225'ria'
  ClientHeight = 122
  ClientWidth = 514
  ExplicitWidth = 520
  ExplicitHeight = 146
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 78
    Width = 514
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 78
    ExplicitWidth = 514
    inherited btnSair: TBitBtnLocked
      Left = 439
      ExplicitLeft = 439
    end
    inherited btnGravar: TBitBtnLocked
      Left = 75
      ExplicitLeft = 75
    end
    inherited btnCancela: TBitBtnLocked
      Left = 290
      ExplicitLeft = 290
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 218
      ExplicitLeft = 218
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 362
      Width = 77
      ExplicitLeft = 362
      ExplicitWidth = 77
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 147
      ExplicitLeft = 147
    end
  end
  inherited pnlStatus: TPanel
    Top = 106
    Width = 514
    TabOrder = 3
    ExplicitTop = 106
    ExplicitWidth = 514
    inherited pnlNomeForm: TPanel
      Left = 339
      Width = 175
      ExplicitLeft = 339
      ExplicitWidth = 175
    end
    inherited pnlInfo: TPanel
      Width = 339
      ExplicitWidth = 339
    end
  end
  inherited pgcDados: TPageControl
    Width = 514
    Height = 78
    Visible = False
    ExplicitWidth = 514
    ExplicitHeight = 78
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 506
      ExplicitHeight = 46
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 514
    Height = 78
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 26
      Top = 36
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 10
      Top = 59
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object dbeCodPro: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 29
      Width = 81
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COR_CODPRO'
      DataSource = dtsCadReiCores
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 52
      Width = 409
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COR_DESCRI'
      DataSource = dtsCadReiCores
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
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 512
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Cores - Renner imobili'#225'ria'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      ExplicitWidth = 692
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 440
    Top = 24
  end
  object dtsCadReiCores: TDataSource
    Left = 152
    Top = 24
  end
end
