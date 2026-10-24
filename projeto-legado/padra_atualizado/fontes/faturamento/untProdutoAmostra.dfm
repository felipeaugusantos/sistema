inherited frmProdutoAmostra: TfrmProdutoAmostra
  Height = 285
  Caption = 'Recebimento de amostra'
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 214
    TabOrder = 1
    ExplicitTop = 214
    inherited FlwBotoes: TFlowPanel
      ExplicitTop = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Align = alRight
    end
  end
  inherited pnlStatus: TPanel
    Top = 240
    TabOrder = 2
    ExplicitTop = 240
  end
  object pnlTexto: TPanel [3]
    Left = 0
    Top = 0
    Width = 483
    Height = 214
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentColor = True
    TabOrder = 0
    object lblDescricao: TLabel
      Left = 16
      Top = 7
      Width = 109
      Height = 14
      Caption = 'Descri'#231#227'o da amostra:'
    end
    object lblNome: TLabel
      Left = 16
      Top = 135
      Width = 58
      Height = 14
      Caption = 'Trazido por:'
    end
    object memDescricao: TMemoFocus
      Left = 16
      Top = 24
      Width = 449
      Height = 89
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 255
      ScrollBars = ssVertical
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object edtNome: TEditFocus
      Tag = 99
      Left = 16
      Top = 152
      Width = 449
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
end
