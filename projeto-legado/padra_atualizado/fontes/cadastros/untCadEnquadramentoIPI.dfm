inherited frmCadEnquadramentoIPI: TfrmCadEnquadramentoIPI
  Left = 292
  Top = 337
  Width = 533
  Height = 225
  Caption = 'C'#243'digos de Enquadramento de IPI'
  ExplicitWidth = 533
  ExplicitHeight = 225
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 155
    Width = 527
    Height = 25
    ExplicitTop = 155
    ExplicitWidth = 527
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 453
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 453
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 74
        ExplicitLeft = 292
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 366
        Width = 75
        Spacing = 2
        ExplicitLeft = 366
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 455
      Width = 70
      Height = 21
      Align = alRight
      ExplicitLeft = 455
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 180
    Width = 527
    ExplicitTop = 180
    ExplicitWidth = 527
    inherited pnlNomeForm: TPanel
      Left = 328
      Width = 199
      ExplicitLeft = 328
      ExplicitWidth = 199
    end
    inherited pnlInfo: TPanel
      Width = 328
      ExplicitWidth = 328
    end
  end
  inherited pgcDados: TPageControl
    Width = 527
    Height = 155
    ExplicitWidth = 527
    ExplicitHeight = 155
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 519
      ExplicitHeight = 123
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 527
    Height = 155
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 57
      Top = 14
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 41
      Top = 38
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label156: TLabel
      Left = 308
      Top = 14
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo CST:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 10
      Width = 72
      Height = 22
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBMemoFocus
      Tag = 99
      Left = 97
      Top = 34
      Width = 417
      Height = 111
      TabOrder = 2
      OnEnter = dbeDescriEnter
      OnKeyPress = dbeDescriKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object dbcGruCst: TDBComboBoxFocus
      Tag = 99
      Left = 369
      Top = 10
      Width = 145
      Height = 22
      Style = csDropDownList
      DataField = 'CLI_CATEGO'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Items.Strings = (
        'IMUNIDADE'
        'SUSPENS'#195'O'
        'ISEN'#199#195'O'
        'REDU'#199#195'O'
        'OUTROS')
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
  end
end
