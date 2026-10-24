inherited frmConfirmaTipoProduto: TfrmConfirmaTipoProduto
  Width = 415
  Height = 189
  Caption = 'Tipo Produto SPED'
  ExplicitWidth = 415
  ExplicitHeight = 189
  PixelsPerInch = 96
  TextHeight = 14
  object Label146: TLabel [0]
    Left = 45
    Top = 33
    Width = 112
    Height = 14
    Alignment = taRightJustify
    Caption = 'Tipo de produto (SPED)'
  end
  inherited pnlBotoes: TPanel
    Top = 118
    Width = 409
    TabOrder = 1
    ExplicitTop = 118
    ExplicitWidth = 409
    inherited FlwBotoes: TFlowPanel
      Width = 328
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 330
      Top = 2
      Align = alRight
      ExplicitLeft = 326
    end
  end
  inherited pnlStatus: TPanel
    Top = 144
    Width = 409
    TabOrder = 2
    ExplicitTop = 144
    ExplicitWidth = 409
    inherited pnlNomeForm: TPanel
      Left = 238
      ExplicitLeft = 238
    end
    inherited pnlInfo: TPanel
      Width = 238
      ExplicitWidth = 238
    end
  end
  object cmbTipProd: TComboBoxFocus [4]
    Left = 45
    Top = 48
    Width = 320
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 368
    Top = 24
  end
end
