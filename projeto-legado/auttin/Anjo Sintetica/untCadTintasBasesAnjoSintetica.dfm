inherited frmCadTintasBasesAnjoSintetica: TfrmCadTintasBasesAnjoSintetica
  Caption = 'frmCadTintasBasesAnjoSintetica'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
    end
  end
  inherited pnlCampos: TPanel
    inherited lblBase: TLabel
      Left = 144
      ExplicitLeft = 144
    end
    object lblProdKey: TLabel [9]
      Left = 253
      Top = 20
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Prod. Key:'
    end
    object lblSubKey: TLabel [10]
      Left = 370
      Top = 20
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Prod. Key:'
    end
    inherited dbeBase: TDBEditFocus
      Left = 176
      Width = 65
      ExplicitLeft = 176
      ExplicitWidth = 65
    end
    inherited dbeCodigo: TDBEditFocus
      Width = 65
      ExplicitWidth = 65
    end
    object dbeProdKey: TDBEditFocus
      Tag = 99
      Left = 307
      Top = 16
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeSubKey: TDBEditFocus
      Tag = 99
      Left = 424
      Top = 16
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 455
    Top = 36
  end
end
