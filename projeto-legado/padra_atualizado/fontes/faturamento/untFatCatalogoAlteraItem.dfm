inherited frmFatCatalogoAlteraItem: TfrmFatCatalogoAlteraItem
  Left = 273
  Top = 403
  Width = 844
  Height = 677
  BorderIcons = [biSystemMenu]
  Caption = 'Cat'#225'logo de Itens - Altera'#231#227'o'
  Position = poScreenCenter
  ExplicitWidth = 844
  ExplicitHeight = 677
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 603
    Width = 838
    ExplicitTop = 603
    ExplicitWidth = 838
    inherited FlwBotoes: TFlowPanel
      Width = 834
      ExplicitWidth = 834
    end
  end
  inherited pnlStatus: TPanel
    Top = 632
    Width = 838
    ExplicitTop = 632
    ExplicitWidth = 838
    inherited pnlNomeForm: TPanel
      Left = 667
      ExplicitLeft = 667
    end
    inherited pnlInfo: TPanel
      Width = 667
      ExplicitWidth = 667
    end
  end
  inherited pgcDados: TPageControl
    Top = 225
    Width = 838
    Height = 378
    ExplicitTop = 225
    ExplicitWidth = 838
    ExplicitHeight = 378
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 830
      ExplicitHeight = 346
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 838
    Height = 225
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 38
      Top = 12
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd. F'#225'brica:'
    end
    object Label5: TLabel
      Left = 50
      Top = 35
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label4: TLabel
      Left = 43
      Top = 58
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 69
      Top = 81
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 35
      Top = 104
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Classif. de IPI:'
    end
    object lbl3: TLabel
      Left = 435
      Top = 104
      Width = 103
      Height = 14
      Alignment = taRightJustify
      Caption = 'Compra Centralizada:'
    end
    object lbl5: TColorLabel
      Left = 573
      Top = 104
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object lbl6: TLabel
      Left = 200
      Top = 104
      Width = 55
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'd.Barra:'
    end
    object lbl1: TLabel
      Left = 470
      Top = 58
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object lbl4: TLabel
      Left = 347
      Top = 81
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrev. Fiscal:'
    end
    object Label6: TLabel
      Left = 96
      Top = 127
      Width = 159
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'd.Barra da Embalagem:'
    end
    object Label28: TLabel
      Left = 431
      Top = 127
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label36: TLabel
      Left = 51
      Top = 151
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Aplica'#231#227'o:'
    end
    object edtCodFab: TEditFocus
      Tag = 99
      Left = 106
      Top = 8
      Width = 200
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 25
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 106
      Top = 31
      Width = 521
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = clWhite
      TabOrder = 1
      NormalColor = clWhite
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 106
      Top = 54
      Width = 58
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 165
      Top = 54
      Width = 300
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 106
      Top = 77
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 6
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 156
      Top = 77
      Width = 184
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtClaIpi: TEditFocus
      Tag = 99
      Left = 106
      Top = 100
      Width = 88
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttNumerico
      EditFormat = '####.##.##'
    end
    object edtCprCen: TEditFocus
      Tag = 99
      Left = 540
      Top = 100
      Width = 32
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtCodBar: TEditFocus
      Tag = 99
      Left = 258
      Top = 100
      Width = 168
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttNumerico
    end
    object edtCodUni: TEditFocus
      Tag = 99
      Left = 514
      Top = 54
      Width = 31
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 4
      OnKeyPress = edtCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object edtDesUni: TEditFocus
      Left = 546
      Top = 54
      Width = 81
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodAbf: TEditFocus
      Tag = 99
      Left = 415
      Top = 77
      Width = 50
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 8
      OnKeyPress = edtCodAbfKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesAbf: TEditFocus
      Left = 467
      Top = 77
      Width = 160
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBarEmb: TEditFocus
      Tag = 99
      Left = 258
      Top = 123
      Width = 168
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttNumerico
    end
    object edtRefere: TEditFocus
      Tag = 99
      Left = 491
      Top = 123
      Width = 136
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 16
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 16
      TipoTexto = ttAlfanumerico
      EditFormat = '####.##.##'
    end
    object mmoAplica: TMemoFocus
      Left = 108
      Top = 148
      Width = 352
      Height = 71
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object pnlPrecos: TPanel [4]
    Left = 0
    Top = 225
    Width = 838
    Height = 378
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label13: TLabel
      Left = 98
      Top = 12
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Compra:'
    end
    object Label14: TLabel
      Left = 90
      Top = 35
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto 01 (-):'
    end
    object Label20: TLabel
      Left = 87
      Top = 174
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'ICMS Entrada (-):'
    end
    object Label21: TLabel
      Left = 99
      Top = 220
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'IPI Entrada (+):'
    end
    object Label22: TLabel
      Left = 124
      Top = 244
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Frete (+):'
    end
    object Label24: TLabel
      Left = 79
      Top = 312
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sub. Tribut'#225'ria (+):'
    end
    object Label26: TLabel
      Left = 358
      Top = 131
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Custo:'
    end
    object lblTitMarBr1: TLabel
      Left = 555
      Top = 13
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem Bruta 01:'
    end
    object lblTitPreVe1: TLabel
      Left = 545
      Top = 35
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda 01:'
    end
    object lblTitMarBr2: TLabel
      Left = 556
      Top = 58
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem Bruta 02:'
      Visible = False
    end
    object lblMarBr2: TLabel
      Left = 734
      Top = 58
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
      Visible = False
    end
    object lblTitPreVe2: TLabel
      Left = 546
      Top = 81
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda 02:'
      Visible = False
    end
    object lblTitMarBr3: TLabel
      Left = 556
      Top = 104
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem Bruta 03:'
      Visible = False
    end
    object lblMarBr3: TLabel
      Left = 734
      Top = 104
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
      Visible = False
    end
    object lblTitPreVe3: TLabel
      Left = 546
      Top = 127
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda 03:'
      Visible = False
    end
    object lblTitMarBr4: TLabel
      Left = 555
      Top = 150
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem Bruta 04:'
      Visible = False
    end
    object lblMarBr4: TLabel
      Left = 734
      Top = 150
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
      Visible = False
    end
    object lblTitPreVe4: TLabel
      Left = 545
      Top = 173
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda 04:'
      Visible = False
    end
    object lblTitMarBr5: TLabel
      Left = 555
      Top = 196
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem Bruta 05:'
      Visible = False
    end
    object lblMarBr5: TLabel
      Left = 734
      Top = 196
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
      Visible = False
    end
    object lblTitPreVe5: TLabel
      Left = 545
      Top = 220
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda 05:'
      Visible = False
    end
    object lblTitMarBr6: TLabel
      Left = 555
      Top = 243
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem Bruta 06:'
      Visible = False
    end
    object lblMarBr6: TLabel
      Left = 734
      Top = 243
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
      Visible = False
    end
    object lblTitPreVe6: TLabel
      Left = 545
      Top = 266
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda 06:'
      Visible = False
    end
    object lblTitMarBr7: TLabel
      Left = 555
      Top = 288
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem Bruta 07:'
      Visible = False
    end
    object lblMarBr7: TLabel
      Left = 734
      Top = 290
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
      Visible = False
    end
    object lblTitPreVe7: TLabel
      Left = 545
      Top = 313
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda 07:'
      Visible = False
    end
    object Label33: TLabel
      Left = 242
      Top = 35
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label39: TLabel
      Left = 242
      Top = 174
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label40: TLabel
      Left = 519
      Top = 177
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label41: TLabel
      Left = 242
      Top = 220
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label43: TLabel
      Left = 242
      Top = 58
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lblMarBr1: TLabel
      Left = 734
      Top = 12
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lblDesMax: TLabel
      Left = 139
      Top = 58
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = '02 (-):'
    end
    object lblDesMaxPor: TLabel
      Left = 242
      Top = 289
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label2: TLabel
      Left = 408
      Top = 247
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso:'
    end
    object Label3: TLabel
      Left = 378
      Top = 293
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object Label75: TLabel
      Left = 351
      Top = 317
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comiss'#227'o Varejo:'
    end
    object Label77: TLabel
      Left = 519
      Top = 316
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label23: TLabel
      Left = 72
      Top = 289
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'Acr'#233'scimo Final (+):'
    end
    object Label42: TLabel
      Left = 242
      Top = 244
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lblPesLiq: TLabel
      Left = 371
      Top = 270
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso L'#237'quido:'
    end
    object Label7: TLabel
      Left = 361
      Top = 177
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'ICMS Saida (+):'
    end
    object Label8: TLabel
      Left = 243
      Top = 312
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label9: TLabel
      Left = 242
      Top = 81
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label11: TLabel
      Left = 139
      Top = 81
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = '03 (-):'
    end
    object Label12: TLabel
      Left = 242
      Top = 104
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label15: TLabel
      Left = 139
      Top = 104
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = '04 (-):'
    end
    object Label16: TLabel
      Left = 242
      Top = 127
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label17: TLabel
      Left = 139
      Top = 127
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = '05 (-):'
    end
    object Label18: TLabel
      Left = 242
      Top = 150
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label19: TLabel
      Left = 139
      Top = 150
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = '06 (-):'
    end
    object Label25: TLabel
      Left = 87
      Top = 197
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'Imp. Federais (-):'
    end
    object Label27: TLabel
      Left = 242
      Top = 197
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lblDesAdi: TLabel
      Left = 4
      Top = 333
      Width = 165
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. Adicionais (Boleto) (-):'
    end
    object Label29: TLabel
      Left = 243
      Top = 335
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lblValFre: TLabel
      Left = 96
      Top = 267
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Frete (+):'
    end
    object lblOutVal: TLabel
      Left = 342
      Top = 154
      Width = 93
      Height = 14
      Alignment = taRightJustify
      Caption = 'Outros Valores (+):'
    end
    object Label31: TLabel
      Left = 351
      Top = 200
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Imp. Federais (+):'
    end
    object Label32: TLabel
      Left = 519
      Top = 200
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object Label34: TLabel
      Left = 326
      Top = 223
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Des. Operacionais (+):'
    end
    object Label35: TLabel
      Left = 519
      Top = 223
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lblDolar1: TLabel
      Left = 734
      Top = 35
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'US$:'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblDolar2: TLabel
      Left = 734
      Top = 81
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'US$:'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblDolar3: TLabel
      Left = 734
      Top = 127
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'US$:'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblDolar4: TLabel
      Left = 734
      Top = 173
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'US$:'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblDolar5: TLabel
      Left = 734
      Top = 220
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'US$:'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblDolar7: TLabel
      Left = 734
      Top = 312
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'US$:'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblDolar6: TLabel
      Left = 734
      Top = 266
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'US$:'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object edtPreCom: TEditFocus
      Tag = 99
      Left = 171
      Top = 8
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesf01: TEditFocus
      Tag = 99
      Left = 171
      Top = 31
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtIcmEnt: TEditFocus
      Tag = 99
      Left = 171
      Top = 169
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtIpiEnt: TEditFocus
      Tag = 99
      Left = 171
      Top = 216
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtFreEnt: TEditFocus
      Tag = 99
      Left = 171
      Top = 239
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtSubsti: TEditFocus
      Tag = 99
      Left = 171
      Top = 308
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPreCus: TEditFocus
      Left = 437
      Top = 127
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Enabled = False
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtMarBr1: TEditFocus
      Tag = 99
      Left = 643
      Top = 8
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 25
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPreVe1: TEditFocus
      Tag = 99
      Left = 643
      Top = 31
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 26
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtMarBr2: TEditFocus
      Tag = 99
      Left = 643
      Top = 54
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 27
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPreVe2: TEditFocus
      Tag = 99
      Left = 643
      Top = 77
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 28
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtMarBr3: TEditFocus
      Tag = 99
      Left = 643
      Top = 100
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 29
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPreVe3: TEditFocus
      Tag = 99
      Left = 643
      Top = 123
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 30
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtMarBr4: TEditFocus
      Tag = 99
      Left = 643
      Top = 146
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 31
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPreVe4: TEditFocus
      Tag = 99
      Left = 643
      Top = 169
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 32
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtMarBr5: TEditFocus
      Tag = 99
      Left = 643
      Top = 192
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 33
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPreVe5: TEditFocus
      Tag = 99
      Left = 643
      Top = 215
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 34
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtMarBr6: TEditFocus
      Tag = 99
      Left = 643
      Top = 238
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 35
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPreVe6: TEditFocus
      Tag = 99
      Left = 643
      Top = 262
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 36
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtMarBr7: TEditFocus
      Tag = 99
      Left = 643
      Top = 285
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 37
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPreVe7: TEditFocus
      Tag = 99
      Left = 643
      Top = 308
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 38
      Visible = False
      OnExit = edtMarBr1Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesf02: TEditFocus
      Tag = 99
      Left = 171
      Top = 54
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPesIte: TEditFocus
      Tag = 99
      Left = 437
      Top = 243
      Width = 80
      Height = 22
      Alignment = taRightJustify
      TabOrder = 21
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtEmbala: TEditFocus
      Tag = 99
      Left = 437
      Top = 289
      Width = 80
      Height = 22
      Alignment = taRightJustify
      TabOrder = 23
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtComVar: TEditFocus
      Tag = 99
      Left = 437
      Top = 312
      Width = 80
      Height = 22
      Alignment = taRightJustify
      TabOrder = 24
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtAcrFin: TEditFocus
      Tag = 99
      Left = 171
      Top = 285
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPesLiq: TEditFocus
      Tag = 99
      Left = 437
      Top = 266
      Width = 80
      Height = 22
      Alignment = taRightJustify
      TabOrder = 22
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtIcmSai: TEditFocus
      Tag = 99
      Left = 437
      Top = 173
      Width = 80
      Height = 22
      Alignment = taRightJustify
      TabOrder = 18
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesf03: TEditFocus
      Tag = 99
      Left = 171
      Top = 77
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesf04: TEditFocus
      Tag = 99
      Left = 171
      Top = 100
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesf05: TEditFocus
      Tag = 99
      Left = 171
      Top = 123
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesf06: TEditFocus
      Tag = 99
      Left = 171
      Top = 146
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtSubFed: TEditFocus
      Tag = 99
      Left = 171
      Top = 192
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesAdb: TEditFocus
      Tag = 99
      Left = 171
      Top = 331
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtValFre: TEditFocus
      Tag = 99
      Left = 171
      Top = 262
      Width = 70
      Height = 22
      Alignment = taRightJustify
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtOutVal: TEditFocus
      Tag = 99
      Left = 437
      Top = 150
      Width = 80
      Height = 22
      Alignment = taRightJustify
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtImpfed: TEditFocus
      Tag = 99
      Left = 437
      Top = 197
      Width = 80
      Height = 22
      Alignment = taRightJustify
      TabOrder = 19
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesOpe: TEditFocus
      Tag = 99
      Left = 437
      Top = 220
      Width = 80
      Height = 22
      Alignment = taRightJustify
      TabOrder = 20
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object chkPreDol: TCheckBox
      Left = 244
      Top = 11
      Width = 86
      Height = 17
      Caption = 'Em d'#243'lar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 39
      OnClick = chkPreDolClick
    end
    object edtDolar1: TEditFocus
      Tag = 50
      Left = 759
      Top = 31
      Width = 65
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 40
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDolar2: TEditFocus
      Tag = 50
      Left = 759
      Top = 77
      Width = 65
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 41
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDolar3: TEditFocus
      Tag = 50
      Left = 759
      Top = 123
      Width = 65
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 42
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDolar4: TEditFocus
      Tag = 50
      Left = 759
      Top = 169
      Width = 65
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 43
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDolar5: TEditFocus
      Tag = 50
      Left = 759
      Top = 216
      Width = 65
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 44
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDolar7: TEditFocus
      Tag = 50
      Left = 759
      Top = 308
      Width = 65
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 45
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDolar6: TEditFocus
      Tag = 50
      Left = 759
      Top = 262
      Width = 65
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 46
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object pnlSuframa: TPanel
      Left = 312
      Top = 6
      Width = 221
      Height = 119
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 15
      object Label37: TLabel
        Left = 4
        Top = 52
        Width = 119
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto PIS/COFINS(-):'
      end
      object Label38: TLabel
        Left = 207
        Top = 52
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label44: TLabel
        Left = 207
        Top = 97
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label46: TLabel
        Left = 207
        Top = 6
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label47: TLabel
        Left = 207
        Top = 29
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label48: TLabel
        Left = 207
        Top = 74
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label50: TLabel
        Left = 85
        Top = 6
        Width = 38
        Height = 14
        Alignment = taRightJustify
        Caption = 'TCIF(+):'
      end
      object Label51: TLabel
        Left = 37
        Top = 97
        Width = 86
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fator Regional(+):'
      end
      object Label52: TLabel
        Left = 93
        Top = 29
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'TS(+):'
      end
      object Label53: TLabel
        Left = 35
        Top = 74
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto ICMS(-):'
      end
      object edtTCIFCu: TEditFocus
        Left = 125
        Top = 2
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtTSCust: TEditFocus
        Left = 125
        Top = 25
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDePiCo: TEditFocus
        Left = 125
        Top = 48
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDeICMS: TEditFocus
        Left = 125
        Top = 71
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtFatReg: TEditFocus
        Left = 125
        Top = 94
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
  end
  object pnlBotoesEnt: TPanel [5]
    Left = 0
    Top = 603
    Width = 838
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnCancelarEntrada: TBitBtnLocked
      Left = 713
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnCancelarEntradaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 576
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 544
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 368
    Top = 8
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 8
  end
end
