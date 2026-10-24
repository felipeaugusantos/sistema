inherited frmCadDocas: TfrmCadDocas
  Width = 512
  Height = 171
  Caption = 'Cadastro de Docas'
  OnDestroy = FormDestroy
  ExplicitWidth = 512
  ExplicitHeight = 171
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 15
    Top = 10
    Width = 33
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel [1]
    Left = 15
    Top = 50
    Width = 49
    Height = 14
    Caption = 'Descri'#231#227'o'
  end
  inherited pnlBotoes: TPanel
    Top = 100
    Width = 506
    Height = 26
    TabOrder = 2
    ExplicitTop = 100
    ExplicitWidth = 506
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 435
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 425
      ExplicitHeight = 22
      inherited btnIncluir: TBitBtnLocked
        Width = 70
        Height = 22
        Align = alLeft
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 70
        Width = 70
        Height = 22
        Align = alLeft
        ExplicitLeft = 70
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 140
        Width = 70
        Height = 22
        Align = alLeft
        ExplicitLeft = 140
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 210
        Width = 70
        Height = 22
        Align = alLeft
        ExplicitLeft = 210
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 280
        Width = 70
        Height = 22
        Align = alLeft
        ExplicitLeft = 280
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 350
        Height = 22
        Align = alLeft
        ExplicitLeft = 350
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 437
      Width = 67
      Align = alRight
      ExplicitLeft = 436
      ExplicitWidth = 67
    end
  end
  inherited pgcDados: TPageControl
    Left = 1053
    Top = 36
    Width = 224
    Height = 133
    Align = alNone
    TabOrder = 4
    ExplicitLeft = 1053
    ExplicitTop = 36
    ExplicitWidth = 224
    ExplicitHeight = 133
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 216
      ExplicitHeight = 101
    end
  end
  inherited pnlStatus: TPanel
    Top = 126
    Width = 506
    TabOrder = 3
    ExplicitTop = 126
    ExplicitWidth = 506
    inherited pnlNomeForm: TPanel
      Left = 159
      ExplicitLeft = 159
    end
    inherited pnlInfo: TPanel
      Width = 159
      ExplicitWidth = 159
    end
  end
  object dbeCodigo: TDBEditFocus [6]
    Tag = 99
    Left = 15
    Top = 25
    Width = 57
    Height = 22
    CharCase = ecUpperCase
    DataField = 'DOC_IDDOCA'
    DataSource = dtsTabela
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object dbeDescri: TDBEditFocus [7]
    Tag = 99
    Left = 15
    Top = 65
    Width = 347
    Height = 22
    CharCase = ecUpperCase
    DataField = 'DOC_DESCRI'
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
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 100
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 576
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 572
    Top = 148
  end
  object dtsTabela: TDataSource
    Left = 456
    Top = 12
  end
end
