inherited frmCadTempAtendimentoCRM: TfrmCadTempAtendimentoCRM
  Left = 319
  Top = 465
  Width = 535
  Height = 163
  Caption = 'Temperatura do Atendimento'
  ExplicitWidth = 535
  ExplicitHeight = 163
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 93
    Width = 529
    Height = 25
    ExplicitTop = 93
    ExplicitWidth = 529
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 525
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 525
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      Width = 73
      Height = 20
      ExplicitLeft = 446
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 118
    Width = 529
    ExplicitTop = 118
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 322
      Width = 207
      ExplicitLeft = 322
      ExplicitWidth = 207
    end
    inherited pnlInfo: TPanel
      Width = 322
      ExplicitWidth = 322
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
    Width = 529
    Height = 93
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object lblCodigo: TLabel
      Left = 27
      Top = 15
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblDescricao: TLabel
      Left = 11
      Top = 38
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblSelCor: TLabel
      Left = 43
      Top = 62
      Width = 20
      Height = 14
      Cursor = crHandPoint
      Alignment = taRightJustify
      Caption = 'Cor:'
      FocusControl = dbeCorAdt
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lblSelCorClick
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 10
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TEA_CODIGO'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 34
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TEA_DESCRI'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCorAdt: TDBEditFocus
      Tag = 50
      Left = 69
      Top = 59
      Width = 31
      Height = 22
      DataField = 'TEA_CORTEA'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      OnChange = dbeCorAdtChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 68
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 440
    Top = 68
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 336
    Top = 72
  end
  object cldCores: TColorDialog
    Left = 490
    Top = 68
  end
end
