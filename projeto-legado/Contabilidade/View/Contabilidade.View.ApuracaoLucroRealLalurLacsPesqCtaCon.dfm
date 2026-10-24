inherited frmApuracaoLucroRealLalurLacsPesqCtaCon: TfrmApuracaoLucroRealLalurLacsPesqCtaCon
  Width = 695
  Height = 112
  Caption = 'Informe uma conta controlada'
  ExplicitWidth = 695
  ExplicitHeight = 112
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 4
    Top = 13
    Width = 86
    Height = 14
    Alignment = taRightJustify
    Caption = 'Conta Controlada:'
  end
  inherited pnlBotoes: TPanel
    Top = 41
    Width = 689
    TabOrder = 1
    ExplicitTop = 41
    ExplicitWidth = 689
    inherited FlwBotoes: TFlowPanel
      Width = 685
      ExplicitWidth = 685
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 609
      ExplicitLeft = 609
    end
  end
  inherited pnlStatus: TPanel
    Top = 67
    Width = 689
    TabOrder = 2
    ExplicitTop = 67
    ExplicitWidth = 689
    inherited pnlNomeForm: TPanel
      Left = 518
      ExplicitLeft = 518
    end
    inherited pnlInfo: TPanel
      Width = 518
      ExplicitWidth = 518
    end
  end
  object edtCtaCon: TEditFocus [3]
    Tag = 99
    Left = 98
    Top = 10
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    TabOrder = 0
    OnKeyPress = edtCtaConKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clWindow
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
  end
  object edtNomCon: TEditFocus [4]
    Left = 157
    Top = 10
    Width = 522
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 3
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
end
