inherited frmFatRomaneioBuscaChaveDeAcesso: TfrmFatRomaneioBuscaChaveDeAcesso
  Width = 385
  Height = 154
  BorderIcons = [biSystemMenu]
  Caption = 'Chave de Acesso NF-e - Inclus'#227'o Romaneio'
  Position = poScreenCenter
  ExplicitWidth = 385
  ExplicitHeight = 154
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl [0]
    Width = 379
    Height = 109
    Visible = False
    ExplicitWidth = 379
    ExplicitHeight = 109
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 371
      ExplicitHeight = 77
    end
  end
  inherited pnlStatus: TPanel
    Top = 109
    Width = 379
    ExplicitTop = 109
    ExplicitWidth = 379
    inherited pnlNomeForm: TPanel
      Left = 160
      Width = 219
      ExplicitLeft = 160
      ExplicitWidth = 219
    end
    inherited pnlInfo: TPanel
      Width = 160
      ExplicitWidth = 160
    end
  end
  inherited pnlBotoes: TPanel [2]
    Top = 109
    Width = 379
    ExplicitTop = 109
    ExplicitWidth = 379
    inherited FlwBotoes: TFlowPanel
      Width = 375
      ExplicitWidth = 375
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 379
    Height = 109
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object lblInfo: TLabel
      Left = 20
      Top = 8
      Width = 317
      Height = 28
      Caption = 
        'Informe o n'#250'mero da Chave de Acesso ou o C'#243'digo de Barras do Doc' +
        'umento (BARDOC) que deseja marcar no Romaneio'
      WordWrap = True
    end
    object edtCodReg: TEdit
      Left = 20
      Top = 40
      Width = 344
      Height = 22
      MaxLength = 44
      TabOrder = 0
      OnKeyDown = edtCodRegKeyDown
    end
    object btnFinalizar: TBitBtnLocked
      Left = 252
      Top = 68
      Width = 112
      Height = 22
      Caption = '[F10] Finalizar'
      TabOrder = 1
      OnClick = btnFinalizarClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 114
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 82
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 18
    Top = 64
  end
end
