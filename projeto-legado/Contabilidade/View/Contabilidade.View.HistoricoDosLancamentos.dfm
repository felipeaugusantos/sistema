inherited frmHistoricoDosLancamentos: TfrmHistoricoDosLancamentos
  Width = 584
  Height = 221
  Caption = 'Hist'#243'rico Dos Lan'#231'amentos Parte B'
  ExplicitWidth = 584
  ExplicitHeight = 221
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 148
    Width = 578
    ExplicitTop = 148
    ExplicitWidth = 578
    inherited FlwBotoes: TFlowPanel
      Width = 574
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 495
      ExplicitLeft = 495
    end
  end
  inherited pnlStatus: TPanel
    Top = 176
    Width = 578
    ExplicitTop = 176
    ExplicitWidth = 578
    inherited pnlNomeForm: TPanel
      Left = 231
      ExplicitLeft = 231
    end
    inherited pnlInfo: TPanel
      Width = 231
      ExplicitWidth = 231
    end
  end
  inherited pgcDados: TPageControl
    Width = 578
    Height = 148
    TabOrder = 3
    ExplicitWidth = 578
    ExplicitHeight = 148
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 570
      ExplicitHeight = 116
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 578
    Height = 148
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
      Left = 31
      Top = 18
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Conta:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 11
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'HIS_CODIGO'
      DataSource = dtsHisLan
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbmDescri: TDBMemoFocus
      Left = 65
      Top = 40
      Width = 500
      Height = 94
      DataField = 'HIS_DESCRI'
      DataSource = dtsHisLan
      ScrollBars = ssVertical
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 296
    Top = 0
  end
  object dtsHisLan: TDataSource
    Left = 328
  end
end
