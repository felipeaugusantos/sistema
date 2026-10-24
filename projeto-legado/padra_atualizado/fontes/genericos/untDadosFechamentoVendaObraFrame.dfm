object fraDadosFechamentoVendaObraFrame: TfraDadosFechamentoVendaObraFrame
  Left = 0
  Top = 0
  Width = 621
  Height = 23
  TabOrder = 0
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 621
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblCodigoObra: TLabel
      Left = 13
      Top = 6
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = 'C'#243'd. Obra:'
    end
    object lblCodigoART: TLabel
      Left = 144
      Top = 6
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'C'#243'd. ART:'
    end
    object Label1: TLabel
      Left = 270
      Top = 4
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'CNO/CEI:'
    end
    object Label2: TLabel
      Left = 394
      Top = 4
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = 'Insr.Imob.:'
    end
    object Label3: TLabel
      Left = 529
      Top = 4
      Width = 21
      Height = 13
      Alignment = taRightJustify
      Caption = 'CIB:'
    end
    object edtCodObr: TEditFocus
      Tag = 99
      Left = 70
      Top = 1
      Width = 70
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodART: TEditFocus
      Tag = 99
      Left = 197
      Top = 1
      Width = 70
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCno: TEditFocus
      Tag = 99
      Left = 320
      Top = 1
      Width = 70
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtInsImo: TEditFocus
      Tag = 99
      Left = 452
      Top = 0
      Width = 70
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCib: TEditFocus
      Tag = 99
      Left = 553
      Top = 0
      Width = 60
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 4
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
