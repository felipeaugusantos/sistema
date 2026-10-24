inherited frmReformaTributariaCreditoDebito: TfrmReformaTributariaCreditoDebito
  Width = 765
  Height = 495
  BorderStyle = bsDialog
  Caption = 'Reforma Tribut'#225'ria - Cr'#233'dito/D'#233'bito'
  Position = poDesktopCenter
  ExplicitWidth = 765
  ExplicitHeight = 495
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 422
    Width = 759
    ExplicitTop = 422
    ExplicitWidth = 759
    inherited FlwBotoes: TFlowPanel
      Width = 755
      ExplicitWidth = 755
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnCancelar: TBitBtnLocked
        Left = 110
        Top = 0
        Width = 110
        Height = 22
        Caption = '[F3] Cancelar'
        TabOrder = 1
        OnClick = btnCancelarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 679
      ExplicitLeft = 679
    end
  end
  inherited pnlStatus: TPanel
    Top = 450
    Width = 759
    ExplicitTop = 450
    ExplicitWidth = 759
    inherited pnlNomeForm: TPanel
      Left = 588
      ExplicitLeft = 588
    end
    inherited pnlInfo: TPanel
      Width = 588
      ExplicitWidth = 588
    end
  end
  object pnlConsulta: TPanel [2]
    Left = 0
    Top = 0
    Width = 759
    Height = 42
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label4: TLabel
      Left = 68
      Top = 20
      Width = 38
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Cliente:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 109
      Top = 17
      Width = 83
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 195
      Top = 17
      Width = 550
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 42
    Width = 759
    Height = 380
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Label2: TLabel
      Left = 33
      Top = 5
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cr'#233'dito/D'#233'bito :'
    end
    object Label3: TLabel
      Left = 10
      Top = 31
      Width = 96
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Cr'#233'dito/D'#233'bito :'
    end
    object lblValor: TLabel
      Left = 22
      Top = 348
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Nota Fiscal:'
    end
    object lblMensagem: TLabel
      Left = 51
      Top = 87
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mensagem:'
    end
    object clbCreditoDebito: TColorLabel
      Left = 199
      Top = 5
      Width = 95
      Height = 14
      Caption = '(C)r'#233'dito  /  (D)'#233'bito'
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 201
      Top = 321
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor do CBS:'
    end
    object Label6: TLabel
      Left = 206
      Top = 294
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor do IBS:'
    end
    object Label7: TLabel
      Left = 54
      Top = 241
      Width = 51
      Height = 14
      Caption = 'M'#234's / Ano:'
    end
    object Label14: TLabel
      Left = 49
      Top = 57
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label15: TLabel
      Left = 281
      Top = 57
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Chave de Acesso:'
    end
    object Label1: TLabel
      Left = 197
      Top = 57
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object Label8: TLabel
      Left = 20
      Top = 268
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base do IBS/CBS:'
    end
    object Label9: TLabel
      Left = 25
      Top = 321
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'quota do CBS:'
    end
    object Label11: TLabel
      Left = 30
      Top = 294
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'quota do IBS:'
    end
    object Label10: TLabel
      Left = 42
      Top = 214
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Class. Fiscal:'
    end
    object edtCreDeb: TEditFocus
      Tag = 99
      Left = 109
      Top = 2
      Width = 83
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtTipFin: TEditFocus
      Tag = 99
      Left = 109
      Top = 28
      Width = 83
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 1
      OnKeyPress = edtTipFinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object edtValor: TEditFocus
      Tag = 99
      Left = 109
      Top = 344
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtMens01: TEditFocus
      Tag = 99
      Left = 109
      Top = 81
      Width = 636
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 200
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMens02: TEditFocus
      Tag = 99
      Left = 109
      Top = 106
      Width = 636
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 200
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMens03: TEditFocus
      Tag = 99
      Left = 109
      Top = 132
      Width = 636
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMens04: TEditFocus
      Tag = 99
      Left = 109
      Top = 158
      Width = 636
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMens05: TEditFocus
      Tag = 99
      Left = 109
      Top = 184
      Width = 636
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTipFinDescr: TEditFocus
      Left = 195
      Top = 28
      Width = 550
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
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
    object edtValCBS: TEditFocus
      Tag = 99
      Left = 271
      Top = 317
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValIBS: TEditFocus
      Tag = 99
      Left = 271
      Top = 290
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object mskMesAno: TMaskEditFocus
      Tag = 99
      Left = 109
      Top = 237
      Width = 83
      Height = 22
      EditMask = '99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 11
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 109
      Top = 54
      Width = 83
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      OnExit = edtNumDocExit
      OnKeyPress = edtNumDocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 229
      Top = 54
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 3
      OnExit = edtNumDocExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtChaveAcesso: TEditFocus
      Left = 373
      Top = 54
      Width = 372
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBasCal: TEditFocus
      Tag = 99
      Left = 109
      Top = 264
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtAlqCBS: TEditFocus
      Tag = 99
      Left = 109
      Top = 317
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 15
      OnExit = edtAlqCBSExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtAlqIBS: TEditFocus
      Tag = 99
      Left = 109
      Top = 290
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 13
      OnExit = edtAlqIBSExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtClaFis: TEditFocus
      Tag = 99
      Left = 109
      Top = 210
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 4
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtNatOpe: TEditFocus
      Tag = 99
      Left = 195
      Top = 210
      Width = 550
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 880
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 848
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 816
    Top = 8
  end
end
