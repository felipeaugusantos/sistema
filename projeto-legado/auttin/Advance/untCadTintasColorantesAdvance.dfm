inherited frmCadTintasColorantesAdvance: TfrmCadTintasColorantesAdvance
  Height = 189
  Caption = 'frmCadTintasColorantesAdvance'
  ExplicitHeight = 189
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 117
    ExplicitTop = 117
  end
  inherited pgcDados: TPageControl
    Height = 117
    ExplicitHeight = 117
    inherited tbsGeral: TTabSheet
      ExplicitHeight = 85
    end
  end
  inherited pnlCampos: TPanel
    Height = 117
    ExplicitHeight = 117
    object lblEmbalagem: TLabel [6]
      Left = 199
      Top = 89
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object dbeEmbalagem: TDBEditFocus
      Tag = 99
      Left = 260
      Top = 85
      Width = 70
      Height = 22
      DataField = 'COL_PESCOL'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      OnChange = dbeEmbalagemChange
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 145
    ExplicitTop = 145
  end
end
