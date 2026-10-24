inherited frmFatDigRomaneioLoteSeparacao: TfrmFatDigRomaneioLoteSeparacao
  Width = 323
  Height = 119
  Caption = 'Lote de Separa'#231#227'o de Romaneio'
  ExplicitWidth = 323
  ExplicitHeight = 119
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 41
    Top = 15
    Width = 54
    Height = 14
    Alignment = taRightJustify
    Caption = 'N'#186' do Lote:'
  end
  inherited pnlBotoes: TPanel
    Top = 48
    Width = 317
    ExplicitTop = 48
    ExplicitWidth = 317
    inherited FlwBotoes: TFlowPanel
      Width = 313
      ExplicitWidth = 313
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 234
      ExplicitLeft = 234
    end
  end
  inherited pnlStatus: TPanel
    Top = 74
    Width = 317
    ExplicitTop = 74
    ExplicitWidth = 317
    inherited pnlNomeForm: TPanel
      Left = 146
      ExplicitLeft = 146
    end
    inherited pnlInfo: TPanel
      Width = 146
      ExplicitWidth = 146
    end
  end
  object edtNumLot: TEditFocus [3]
    Tag = 99
    Left = 99
    Top = 11
    Width = 110
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 8
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttNumerico
  end
end
