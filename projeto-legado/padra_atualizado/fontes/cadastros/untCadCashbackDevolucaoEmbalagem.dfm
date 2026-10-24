inherited frmCadCashbackDevolucaoEmbalagem: TfrmCadCashbackDevolucaoEmbalagem
  Width = 521
  Height = 221
  Caption = 'Cashback - Devolu'#231#227'o de Embalagem '
  ExplicitWidth = 521
  ExplicitHeight = 221
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 148
    Width = 515
    ExplicitTop = 148
    ExplicitWidth = 515
    inherited FlwBotoes: TFlowPanel
      Width = 511
      ExplicitTop = 2
      ExplicitWidth = 511
    end
    inherited btnSair: TBitBtnLocked
      Left = 434
      ExplicitLeft = 434
    end
  end
  inherited pnlStatus: TPanel
    Top = 176
    Width = 515
    TabOrder = 5
    ExplicitTop = 176
    ExplicitWidth = 515
    inherited pnlNomeForm: TPanel
      Left = 240
      Width = 275
      ExplicitLeft = 240
      ExplicitWidth = 275
    end
    inherited pnlInfo: TPanel
      Width = 240
      ExplicitWidth = 240
    end
  end
  inherited pgcDados: TPageControl
    Height = 0
    Align = alNone
    TabOrder = 6
    Visible = False
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object pnlCliente: TPanel [3]
    Left = 0
    Top = 0
    Width = 515
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblCliFor: TLabel
      Left = 37
      Top = 10
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 78
      Top = 7
      Width = 65
      Height = 22
      Hint = 'Pressione INSERT para inserir um novo cliente'
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentShowHint = False
      ShowHint = True
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
      Tag = 99
      Left = 145
      Top = 7
      Width = 361
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlTelefone: TPanel [4]
    Left = 0
    Top = 29
    Width = 515
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label16: TLabel
      Left = 28
      Top = 4
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Telefone:'
    end
    object edtTelefone: TMaskEditTelefone
      Tag = 99
      Left = 78
      Top = 0
      Width = 107
      Height = 22
      CharCase = ecUpperCase
      EditMask = '!\(99\)9999-9999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 13
      ParentFont = False
      TabOrder = 0
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
      Pais = opcBrasil
    end
  end
  object pnlCpfCnpj: TPanel [5]
    Left = 0
    Top = 53
    Width = 515
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Label12: TLabel
      Left = 2
      Top = 4
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = '1-CNPJ/2-CPF:'
    end
    object edtCgcCpf: TEditFocus
      Tag = 99
      Left = 78
      Top = 0
      Width = 21
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
      MaxLength = 1
      ParentFont = False
      TabOrder = 0
      OnChange = edtCgcCpfChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtCpfDev: TMaskEditC_G_C_
      Tag = 99
      Left = 100
      Top = 0
      Width = 168
      Height = 22
      CharCase = ecUpperCase
      EditMask = '999.999.999-99;0;'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      ParentFont = False
      TabOrder = 1
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pnlDadosDevolucaoEmbalagem: TPanel [6]
    Left = 0
    Top = 77
    Width = 515
    Height = 71
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object lblDigita: TLabel
      Left = 27
      Top = 4
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
    end
    object lblQuantidade: TLabel
      Left = 14
      Top = 28
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object lblVlrUnit: TLabel
      Left = 178
      Top = 28
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vlr. Unit'#225'rio:'
    end
    object Label15: TLabel
      Left = 343
      Top = 28
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total:'
    end
    object lblSaldoTotalCashback: TLabel
      Left = 356
      Top = 52
      Width = 150
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cashback - Saldo Total: 0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDadosCashback: TLabel
      Left = 7
      Top = 52
      Width = 91
      Height = 14
      Caption = 'Dados Cashback'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtNomDig: TEditFocus
      Left = 145
      Top = 0
      Width = 361
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdEmb: TEditFocus
      Tag = 99
      Left = 78
      Top = 24
      Width = 71
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtValorTotal: TEditFocus
      Tag = 99
      Left = 402
      Top = 24
      Width = 104
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtSenDig: TEditFocus
      Tag = 99
      Left = 78
      Top = 0
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnitar: TEditFocus
      Tag = 99
      Left = 240
      Top = 24
      Width = 81
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
end
