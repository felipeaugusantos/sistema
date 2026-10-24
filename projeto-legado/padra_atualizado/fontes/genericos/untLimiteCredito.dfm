inherited frmLimiteCredito: TfrmLimiteCredito
  Width = 450
  Height = 277
  Caption = 'Altera'#231#227'o de Limite de Cr'#233'dito do Cliente'
  OnDestroy = FormDestroy
  ExplicitWidth = 450
  ExplicitHeight = 277
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 206
    Width = 444
    ExplicitTop = 206
    ExplicitWidth = 444
    inherited FlwBotoes: TFlowPanel
      Width = 440
      ExplicitTop = 2
      ExplicitWidth = 440
    end
    inherited btnSair: TBitBtnLocked
      Left = 364
      ExplicitLeft = 364
    end
  end
  inherited pnlStatus: TPanel
    Top = 232
    Width = 444
    ExplicitTop = 232
    ExplicitWidth = 444
    inherited pnlNomeForm: TPanel
      Left = 273
      ExplicitLeft = 273
    end
    inherited pnlInfo: TPanel
      Width = 273
      ExplicitWidth = 273
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 444
    Height = 59
    Align = alTop
    TabOrder = 3
    object Label1: TLabel
      Left = 25
      Top = 9
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblCpfCnpjCliente: TLabel
      Left = 32
      Top = 33
      Width = 28
      Height = 14
      Caption = 'CNPJ:'
    end
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 70
      Top = 6
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 136
      Top = 6
      Width = 281
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCpfCnpjCliente: TEditFocus
      Left = 70
      Top = 30
      Width = 106
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 59
    Width = 444
    Height = 147
    Align = alClient
    TabOrder = 4
    object Label42: TLabel
      Left = 43
      Top = 80
      Width = 110
      Height = 14
      Alignment = taRightJustify
      Caption = 'Novo Limite de Cr'#233'dito:'
    end
    object Label2: TLabel
      Left = 44
      Top = 52
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Limite de Cr'#233'dito Atual:'
    end
    object edtNovoLimCre: TEditFocus
      Tag = 99
      Left = 159
      Top = 76
      Width = 243
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
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtLimCreAtual: TEditFocus
      Tag = 99
      Left = 159
      Top = 48
      Width = 243
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
