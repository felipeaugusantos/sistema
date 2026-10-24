inherited frmCadTintasColorantesEmbalagem: TfrmCadTintasColorantesEmbalagem
  Height = 193
  Caption = 'frmCadTintasColorantesEmbalagem'
  ExplicitHeight = 193
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 121
    ExplicitTop = 121
  end
  inherited pgcDados: TPageControl
    Height = 121
    ExplicitHeight = 121
    inherited tbsGeral: TTabSheet
      ExplicitHeight = 89
    end
  end
  inherited pnlCampos: TPanel
    Height = 121
    ExplicitHeight = 121
    object lblEmbalagem: TLabel [6]
      Left = 344
      Top = 89
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda:'
    end
    object dbeEmbalagem: TDBEditFocus
      Tag = 99
      Left = 428
      Top = 85
      Width = 70
      Height = 22
      DataField = 'COL_PREVEN'
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
    Top = 149
    ExplicitTop = 149
  end
end
