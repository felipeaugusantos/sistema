inherited frmIncluiPedidoRotasRegiao: TfrmIncluiPedidoRotasRegiao
  Width = 636
  Height = 210
  Caption = 'Incluir Pedido '#224' Rota de Entrega'
  ExplicitWidth = 636
  ExplicitHeight = 210
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 139
    Width = 630
    ExplicitTop = 139
    ExplicitWidth = 630
    inherited FlwBotoes: TFlowPanel
      Width = 626
      ExplicitWidth = 626
    end
    inherited btnSair: TBitBtnLocked
      Left = 547
      ExplicitLeft = 547
    end
  end
  inherited pnlStatus: TPanel
    Top = 165
    Width = 630
    ExplicitTop = 165
    ExplicitWidth = 630
    inherited pnlNomeForm: TPanel
      Left = 459
      ExplicitLeft = 459
    end
    inherited pnlInfo: TPanel
      Width = 459
      ExplicitWidth = 459
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 630
    Height = 139
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      630
      139)
    object lblPedido: TLabel
      Left = 46
      Top = 16
      Width = 35
      Height = 14
      Caption = 'Pedido:'
    end
    object lblCliente: TLabel
      Left = 46
      Top = 40
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblDtEmissao: TLabel
      Left = 13
      Top = 64
      Width = 68
      Height = 14
      Caption = 'Data Emiss'#227'o:'
    end
    object lblCondPagto: TLabel
      Left = 20
      Top = 88
      Width = 61
      Height = 14
      Caption = 'Cond. Pagto:'
    end
    object lblVendedor: TLabel
      Left = 31
      Top = 113
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
    end
    object lblEmpresa: TLabel
      Left = 230
      Top = 16
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lblDtPrevisao: TLabel
      Left = 342
      Top = 64
      Width = 70
      Height = 14
      Caption = 'Data Previs'#227'o:'
    end
    object lblValor: TLabel
      Left = 190
      Top = 64
      Width = 28
      Height = 14
      Caption = 'Valor:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 87
      Top = 13
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNumDocExit
      OnKeyPress = edtNumDocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 174
      Top = 13
      Width = 30
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      ReadOnly = True
      TabOrder = 1
      Text = 'PD'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 87
      Top = 37
      Width = 70
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 160
      Top = 37
      Width = 452
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object mskDtaEmi: TMaskEditFocus
      Tag = 99
      Left = 87
      Top = 61
      Width = 70
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 6
      Text = '  /  /    '
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 87
      Top = 85
      Width = 525
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      ReadOnly = True
      TabOrder = 9
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 86
      Top = 109
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      PasswordChar = '*'
      ReadOnly = True
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 133
      Top = 109
      Width = 479
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 278
      Top = 13
      Width = 31
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtDesEmp: TEditFocus
      Left = 311
      Top = 13
      Width = 301
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object mskPrevis: TMaskEditFocus
      Tag = 99
      Left = 418
      Top = 61
      Width = 82
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtVlrCon: TEditFocus
      Tag = 99
      Left = 224
      Top = 61
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      ReadOnly = True
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 336
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 264
    Top = 88
  end
end
