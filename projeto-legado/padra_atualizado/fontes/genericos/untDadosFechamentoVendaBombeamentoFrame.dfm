object fraDadosFechamentoVendaBombeamentoFrame: TfraDadosFechamentoVendaBombeamentoFrame
  Left = 0
  Top = 0
  Width = 693
  Height = 45
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 693
    Height = 45
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblTotalBombeamento: TLabel
      Left = 396
      Top = 6
      Width = 181
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor Total Bombeamento (Concreto):'
    end
    object lblQtdBombeamento: TLabel
      Left = 2
      Top = 6
      Width = 99
      Height = 13
      Alignment = taRightJustify
      Caption = 'Qtde Bombeamento:'
    end
    object lblPrecoBombeamento: TLabel
      Left = 193
      Top = 6
      Width = 102
      Height = 13
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Bombeamento:'
    end
    object lblRedISS: TLabel
      Left = 457
      Top = 27
      Width = 184
      Height = 13
      Alignment = taRightJustify
      Caption = 'Redu'#231#227'o de Base de C'#225'lculo de ISS%:'
    end
    object edtTotBom: TEditFocus
      Tag = 99
      Left = 582
      Top = 1
      Width = 102
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdBom: TEditFocus
      Tag = 99
      Left = 104
      Top = 1
      Width = 79
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPrcBom: TEditFocus
      Tag = 99
      Left = 296
      Top = 1
      Width = 92
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object chkTaxMin: TCheckBox
      Left = 104
      Top = 27
      Width = 132
      Height = 17
      Caption = 'Cobrar Taxa M'#237'nima'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object edtRedISS: TEditFocus
      Tag = 99
      Left = 643
      Top = 23
      Width = 41
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
end
