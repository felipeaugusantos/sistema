inherited frmCadMovFlex: TfrmCadMovFlex
  Left = 377
  Top = 241
  Width = 533
  Height = 439
  Caption = 'Movimenta'#231#227'o Flex'
  ExplicitWidth = 533
  ExplicitHeight = 439
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 369
    Width = 527
    Height = 25
    ExplicitTop = 345
    ExplicitWidth = 527
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 450
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 450
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 74
        ExplicitLeft = 146
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 220
        Width = 73
        ExplicitLeft = 220
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 293
        Width = 73
        ExplicitLeft = 293
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 366
        Width = 74
        ExplicitLeft = 366
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 452
      Width = 73
      Height = 21
      Align = alRight
      ExplicitLeft = 452
      ExplicitWidth = 73
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 394
    Width = 527
    ExplicitTop = 370
    ExplicitWidth = 527
    inherited pnlNomeForm: TPanel
      Left = 320
      Width = 207
      ExplicitLeft = 320
      ExplicitWidth = 207
    end
    inherited pnlInfo: TPanel
      Width = 320
      ExplicitWidth = 320
    end
  end
  inherited pgcDados: TPageControl
    Width = 527
    Height = 369
    TabOrder = 3
    ExplicitWidth = 527
    ExplicitHeight = 345
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 519
      ExplicitHeight = 313
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 527
    Height = 369
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = -4
    ExplicitHeight = 360
    object Label6: TLabel
      Left = 7
      Top = 138
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Documento:'
    end
    object Label4: TLabel
      Left = 30
      Top = 87
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lan'#231'amento:'
    end
    object Label3: TLabel
      Left = 20
      Top = 63
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Documento:'
    end
    object Label2: TLabel
      Left = 67
      Top = 39
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data:'
    end
    object Label1: TLabel
      Left = 11
      Top = 13
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd. Sequencial:'
    end
    object Label9: TLabel
      Left = 42
      Top = 162
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object Label10: TLabel
      Left = 57
      Top = 211
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label12: TLabel
      Left = 52
      Top = 259
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label13: TLabel
      Left = 47
      Top = 306
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object ColorLabel2: TColorLabel
      Left = 123
      Top = 85
      Width = 83
      Height = 14
      Caption = '(C)r'#233'dito (D)'#233'bito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label15: TLabel
      Left = 180
      Top = 63
      Width = 4
      Height = 14
      Alignment = taRightJustify
      Caption = '-'
    end
    object Label5: TLabel
      Left = 55
      Top = 112
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Origem:'
    end
    object ColorLabel1: TColorLabel
      Left = 123
      Top = 110
      Width = 69
      Height = 14
      Caption = '(F)lex (V)erba'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label7: TLabel
      Left = 33
      Top = 235
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label8: TLabel
      Left = 36
      Top = 186
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Supervisor:'
    end
    object Label11: TLabel
      Left = 47
      Top = 283
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object dbeCreDeb: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 80
      Width = 25
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_CREDEB'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNumDoc: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 56
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_NUMDOC'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaLan: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 32
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_DTALAN'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodSeq: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 8
      Width = 121
      Height = 22
      TabStop = False
      DataField = 'FLE_CODSEQ'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValLan: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 131
      Width = 82
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_VALLAN'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodVen: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 155
      Width = 33
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_CODVEN'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      OnKeyPress = dbeCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 130
      Top = 155
      Width = 383
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCli: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 204
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_CODCLI'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      OnKeyPress = dbeCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtNomCli: TEditFocus
      Left = 160
      Top = 204
      Width = 353
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodPro: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 252
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_CODITE'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 15
      OnKeyPress = dbeCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtNomPro: TEditFocus
      Left = 160
      Top = 252
      Width = 353
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeEspDoc: TDBEditFocus
      Tag = 99
      Left = 187
      Top = 56
      Width = 26
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_ESPDOC'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeHistor: TDBMemoFocus
      Tag = 99
      Left = 96
      Top = 300
      Width = 418
      Height = 56
      DataField = 'FLE_HISTOR'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ScrollBars = ssVertical
      TabOrder = 19
      OnKeyPress = dbeHistorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object dbeOrigem: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 105
      Width = 25
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_ORIGEM'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodFor: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 228
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_CODFOR'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 13
      OnKeyPress = dbeCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 160
      Top = 228
      Width = 353
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodSup: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 179
      Width = 33
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_CODSUP'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      OnKeyPress = dbeCodSupKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtNomSup: TEditFocus
      Left = 130
      Top = 179
      Width = 383
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 276
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FLE_CODEMP'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 17
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 160
      Top = 276
      Width = 353
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 432
  end
end
