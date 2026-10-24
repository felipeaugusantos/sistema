inherited frmCadGrupoAtributo: TfrmCadGrupoAtributo
  Width = 533
  Height = 135
  Caption = 'Cadastro de Grupo de Atributos'
  ExplicitWidth = 533
  ExplicitHeight = 135
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 61
    Width = 527
    Height = 29
    TabOrder = 1
    ExplicitTop = 61
    ExplicitWidth = 527
    ExplicitHeight = 29
    inherited FlwBotoes: TFlowPanel
      Width = 440
      Height = 25
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        Height = 22
        Align = alLeft
        ExplicitWidth = 73
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        Height = 22
        Align = alLeft
        ExplicitLeft = 73
        ExplicitWidth = 73
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        Height = 22
        Align = alLeft
        ExplicitLeft = 146
        ExplicitWidth = 73
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        Height = 22
        Align = alLeft
        ExplicitLeft = 219
        ExplicitWidth = 73
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        Height = 22
        Align = alLeft
        ExplicitLeft = 292
        ExplicitWidth = 73
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        Height = 22
        Align = alLeft
        ExplicitLeft = 365
        ExplicitWidth = 73
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 445
      Margins.Top = 0
      Align = alRight
      ExplicitLeft = 445
    end
  end
  inherited pgcDados: TPageControl
    Width = 527
    Height = 61
    TabOrder = 3
    ExplicitWidth = 527
    ExplicitHeight = 62
  end
  inherited pnlStatus: TPanel
    Top = 90
    Width = 527
    TabOrder = 2
    ExplicitTop = 90
    ExplicitWidth = 527
    inherited pnlNomeForm: TPanel
      Left = 180
      ExplicitLeft = 180
    end
    inherited pnlInfo: TPanel
      Width = 180
      ExplicitWidth = 180
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 0
    Width = 527
    Height = 61
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 62
    object Label1: TLabel
      Left = 28
      Top = 10
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 12
      Top = 34
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 6
      Width = 47
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_CODIGO'
      DataSource = dtsGruAtr
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
      Left = 66
      Top = 30
      Width = 450
      Height = 22
      DataField = 'GRU_DESCRI'
      DataSource = dtsGruAtr
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object chkExiCon: TDBCheckBox [5]
    Left = 347
    Top = 8
    Width = 169
    Height = 17
    Caption = 'Exibir na Consulta de Produtos'
    DataField = 'GRU_EXICON'
    DataSource = dtsGruAtr
    TabOrder = 5
    ValueChecked = 'S'
    ValueUnchecked = 'N'
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 392
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 296
    Top = 16
  end
  object dtsGruAtr: TDataSource
    Left = 192
    Top = 8
  end
end
