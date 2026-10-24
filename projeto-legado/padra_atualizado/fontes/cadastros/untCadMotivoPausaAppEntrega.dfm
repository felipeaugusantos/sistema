inherited frmCadMotivoPausaAppEntrega: TfrmCadMotivoPausaAppEntrega
  Width = 528
  Height = 143
  Caption = 'Motivos de Pausa do Motorista para APP Entrega'
  OnDestroy = FormDestroy
  ExplicitWidth = 528
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 38
    Top = 15
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 22
    Top = 39
    Width = 52
    Height = 14
    Alignment = taRightJustify
    Caption = 'Descri'#231#227'o:'
  end
  inherited pnlBotoes: TPanel
    Top = 70
    Width = 522
    ExplicitTop = 70
    ExplicitWidth = 522
    inherited FlwBotoes: TFlowPanel
      Width = 518
      ExplicitTop = 2
      ExplicitWidth = 518
      inherited btnPesquisa: TBitBtnLocked
        Width = 79
        ExplicitWidth = 79
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 441
      ExplicitLeft = 441
    end
  end
  inherited pnlStatus: TPanel
    Top = 98
    Width = 522
    ExplicitTop = 98
    ExplicitWidth = 522
    inherited pnlNomeForm: TPanel
      Left = 175
      ExplicitLeft = 175
    end
    inherited pnlInfo: TPanel
      Width = 175
      ExplicitWidth = 175
    end
  end
  inherited pgcDados: TPageControl
    Left = -650
    Align = alNone
    ExplicitLeft = -650
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object dbeCodigo: TDBEditFocus [5]
    Tag = 99
    Left = 76
    Top = 12
    Width = 65
    Height = 22
    CharCase = ecUpperCase
    DataField = 'OCR_CODIGO'
    DataSource = dtsTabela
    MaxLength = 5
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttAlfanumerico
  end
  object dbeDescri: TDBEditFocus [6]
    Tag = 99
    Left = 76
    Top = 36
    Width = 425
    Height = 22
    CharCase = ecUpperCase
    DataField = 'OCR_DESCRI'
    DataSource = dtsTabela
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 656
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 624
    Top = 16
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 536
    Top = 56
  end
  object dtsTabela: TDataSource
    Left = 744
    Top = 120
  end
end
