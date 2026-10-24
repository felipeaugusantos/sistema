inherited frmHistoricoPadrao: TfrmHistoricoPadrao
  Width = 529
  Height = 142
  Caption = 'Hist'#243'rico Padr'#227'o'
  ExplicitWidth = 529
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 72
    Width = 523
    Height = 25
    ExplicitTop = 72
    ExplicitWidth = 523
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 448
      Height = 21
      ExplicitWidth = 448
      ExplicitHeight = 21
      inherited btnPesquisa: TBitBtnLocked
        Width = 78
        ExplicitWidth = 78
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 450
      Width = 71
      Height = 21
      Align = alRight
      ExplicitLeft = 450
      ExplicitWidth = 71
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 97
    Width = 523
    ExplicitTop = 97
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 352
      Width = 171
      ExplicitLeft = 352
      ExplicitWidth = 171
    end
    inherited pnlInfo: TPanel
      Width = 352
      ExplicitWidth = 352
    end
  end
  inherited pgcDados: TPageControl
    Width = 523
    Height = 72
    TabOrder = 3
    ExplicitWidth = 523
    ExplicitHeight = 72
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 515
      ExplicitHeight = 40
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 523
    Height = 72
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label2: TLabel
      Left = 11
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 27
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 36
      Width = 424
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PAD_DESCRI'
      DataSource = dtsHisPad
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 12
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PAD_CODIGO'
      DataSource = dtsHisPad
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeTPLACO: TDBEditFocus
      Tag = 99
      Left = 132
      Top = 12
      Width = 64
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'PAD_TPLACO'
      DataSource = dtsHisPad
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 8
  end
  object dtsHisPad: TDataSource
    Left = 248
    Top = 65528
  end
end
