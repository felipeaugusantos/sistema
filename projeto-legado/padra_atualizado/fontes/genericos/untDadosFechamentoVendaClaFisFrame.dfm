object fraDadosFechamentoVendaClaFisFrame: TfraDadosFechamentoVendaClaFisFrame
  Left = 0
  Top = 0
  Width = 691
  Height = 24
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 691
    Height = 24
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 1020
    ExplicitHeight = 25
    object lblClaFis: TLabel
      Left = 40
      Top = 6
      Width = 62
      Height = 13
      Alignment = taRightJustify
      Caption = 'Class. Fiscal:'
    end
    object btnNotExp: TSpeedButton
      Left = 535
      Top = 2
      Width = 23
      Height = 22
      Hint = 'Informa'#231#245'es complementares da Nota de Exporta'#231#227'o'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        00669A00669A00669AB88989B88989B88989B88989B88989B88989B88989B889
        89B88989B88989FF00FFFF00FF00669A3CBEE336BAE130B6DFB88989FEFEFDFE
        FEFEFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDFEFEFDB88989FF00FFFF00FF00669A
        45C4E63FC0E438BCE2B88989FEFBF8B27E73B27E73B27E73B27E73B27E73B27E
        73FEFBF8B88989FF00FFFF00FF00669A4DC9E947C4E741C0E5B88989FEF8F3FF
        F4ECFEF6EEFEF8F1FFF9F4FEFBF6FEFCF9FEF8F3B88989FF00FFFF00FF00669A
        56CDED50C9EA4AC5E8B88989FEF6EDB27E73B27E73B27E73B27E73B27E73B27E
        73FEF6EDB88989FF00FFFF00FF00669A5ED2F058CFED52CBEBB88989FFF0E3FF
        F0E3FFF0E3FFF1E5FFF2E6FFF3E9FFF5EBFFF0E3B88989FF00FFFF00FF00669A
        66D7F360D4F15AD0EEB88989FFEDDDB27E73B27E73B27E73B27E73CDA99ECCAA
        9ED7C5BAB88989FF00FFFF00FF00669A6DDBF667D8F362D4F2B88989FFEBD8FF
        EAD7FFEBD8FFEBD8FFEBD8C4AAA7C5ABA8CDB5B0CD9999FF00FFFF00FF00669A
        74DFF86FDCF66ADAF4B88989FFE8D2FFE8D2FFE8D2FFE8D2FBE4CFC6ACA9FEFE
        FECD9999FF00FFFF00FFFF00FF00669A7AE3FA76E1F870DDF6B88989FFE6CFFF
        E6CFFFE6CFFFE6CFE9CFBFD2BAB4CD999900669AFF00FFFF00FFFF00FF00669A
        7FE6FC7BE4FA77E1F9B88989B88989B88989B88989B88989B88989CD999952CA
        EB00669AFF00FFFF00FFFF00FF00669A83E8FE80E6FC7DE5FC7DE5FC78E2FA72
        DFF86BDAF564D5F25DD0EF56CDED52CAEB00669AFF00FFFF00FFFF00FF00669A
        84E9FE84E9FE73737373737373737373737373737373737373737360D4F05ACF
        EE00669AFF00FFFF00FFFF00FF00669A84E9FE84E9FE737373CFC1BCCFC1BBCF
        C1BBCFC1BBCEBEB773737368D8F462D4F100669AFF00FFFF00FFFF00FFFF00FF
        00669A00669A737373E2D8D3FAF9F8F9F8F7F9F8F7D0C5BF73737300669A0066
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73737373737373
        7373737373737373FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
    end
    object edtClaFis: TEditFocus
      Tag = 99
      Left = 104
      Top = 2
      Width = 62
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 4
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtClaFi2: TEditFocus
      Tag = 99
      Left = 559
      Top = 2
      Width = 62
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 4
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtClaFi3: TEditFocus
      Tag = 99
      Left = 622
      Top = 2
      Width = 62
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 4
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object cmbNatOpe: TComboBoxFocus
      Tag = 99
      Left = 168
      Top = 2
      Width = 368
      Height = 21
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
end
