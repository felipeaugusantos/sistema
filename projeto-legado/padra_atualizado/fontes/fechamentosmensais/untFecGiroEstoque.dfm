inherited frmFecGiroEstoque: TfrmFecGiroEstoque
  Left = 364
  Top = 277
  Width = 387
  Height = 304
  Caption = 'Calculo de Giro de Estoque'
  Position = poScreenCenter
  ExplicitWidth = 387
  ExplicitHeight = 304
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 217
    Width = 381
    ExplicitTop = 214
    ExplicitWidth = 381
  end
  inherited pnlStatus: TPanel
    Top = 263
    Width = 381
    ExplicitTop = 260
    ExplicitWidth = 381
    inherited pnlNomeForm: TPanel
      Left = 197
      ExplicitLeft = 197
    end
    inherited pnlInfo: TPanel
      Width = 197
      ExplicitWidth = 197
    end
  end
  inherited pgcDados: TPageControl
    Width = 381
    Height = 217
    ExplicitWidth = 381
    ExplicitHeight = 214
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 373
      ExplicitHeight = 182
    end
  end
  inherited pnlBotoesConf: TPanel
    Top = 232
    Width = 381
    Height = 31
    ExplicitTop = 229
    ExplicitWidth = 381
    ExplicitHeight = 31
    inherited btnConfirma: TBitBtnLocked
      Left = 5
      Top = 4
      Width = 177
      ParentFont = False
      OnClick = btnConfirmaClick
      ExplicitLeft = 5
      ExplicitTop = 4
      ExplicitWidth = 177
    end
    inherited btnSairFechamento: TBitBtnLocked
      Left = 197
      Top = 4
      Width = 176
      ParentFont = False
      ExplicitLeft = 197
      ExplicitTop = 4
      ExplicitWidth = 176
    end
  end
  inherited pnlBarra: TPanel
    Top = 217
    Width = 381
    ExplicitTop = 214
    ExplicitWidth = 381
    inherited pgbProgresso: TProgressBar
      Width = 375
      ExplicitWidth = 375
    end
  end
  inherited pnlMeses: TPanel
    Width = 381
    Height = 217
    ExplicitWidth = 381
    ExplicitHeight = 214
    inherited Label1: TLabel
      Left = 20
      Top = 14
      ExplicitLeft = 20
      ExplicitTop = 14
    end
    inherited edtAno: TEditFocus
      Tag = 99
    end
    inherited gpbMeses: TGroupBox
      Top = 37
      ExplicitTop = 37
      inherited chkMes04: TCheckBox
        Top = 54
        ExplicitTop = 54
      end
      inherited chkMes05: TCheckBox
        Top = 54
        ExplicitTop = 54
      end
      inherited chkMes06: TCheckBox
        Top = 54
        ExplicitTop = 54
      end
      inherited chkMes07: TCheckBox
        Top = 90
        ExplicitTop = 90
      end
      inherited chkMes08: TCheckBox
        Top = 90
        ExplicitTop = 90
      end
      inherited chkMes09: TCheckBox
        Top = 90
        ExplicitTop = 90
      end
      inherited chkMes10: TCheckBox
        Top = 126
        ExplicitTop = 126
      end
      inherited chkMes11: TCheckBox
        Top = 126
        ExplicitTop = 126
      end
      inherited chkMes12: TCheckBox
        Top = 126
        ExplicitTop = 126
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 40
  end
  object tmrClose: TTimer
    Enabled = False
    OnTimer = tmrCloseTimer
    Left = 136
    Top = 16
  end
end
