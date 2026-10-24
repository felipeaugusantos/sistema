inherited frmDesagrupCtaPag: TfrmDesagrupCtaPag
  Left = 408
  Top = 261
  Width = 424
  Height = 160
  BorderIcons = [biSystemMenu]
  Caption = 'Desagrupamento de Contas a Pagar'
  Position = poMainFormCenter
  ExplicitWidth = 424
  ExplicitHeight = 160
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 90
    Width = 418
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = 16770261
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 90
    ExplicitWidth = 418
    inherited FlwBotoes: TFlowPanel
      Left = 0
      Top = 0
      Width = 418
      Height = 0
      Color = 16770261
      ParentBackground = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 418
      ExplicitHeight = 0
    end
    inherited btnSair: TBitBtnLocked
      Top = -47
      Enabled = False
      TabStop = False
      Visible = False
      ExplicitTop = -47
    end
  end
  inherited pnlStatus: TPanel
    Top = 115
    Width = 418
    TabOrder = 3
    ExplicitTop = 115
    ExplicitWidth = 418
    inherited pnlNomeForm: TPanel
      Left = 247
      ExplicitLeft = 247
    end
    inherited pnlInfo: TPanel
      Width = 247
      ExplicitWidth = 247
    end
  end
  inherited pgcDados: TPageControl
    Width = 418
    Height = 90
    ActivePage = nil
    TabOrder = 2
    TabStop = False
    ExplicitWidth = 418
    ExplicitHeight = 90
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 410
      ExplicitHeight = 58
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 418
    Height = 90
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 15
      Width = 87
      Height = 14
      Caption = 'Nro Agrupamento:'
    end
    object Label6: TLabel
      Left = 66
      Top = 63
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 52
      Top = 40
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object edtNumAgr: TEditFocus
      Tag = 99
      Left = 116
      Top = 11
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNumAgrExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 116
      Top = 59
      Width = 72
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 192
      Top = 59
      Width = 209
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 192
      Top = 35
      Width = 209
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 116
      Top = 35
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 1
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 90
    Width = 418
    Height = 25
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object btnConfirmaCtaPag: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 75
      Height = 23
      Align = alLeft
      Caption = '&Confirmar'
      TabOrder = 0
      OnClick = btnConfirmaCtaPagClick
    end
    object btnSairCtaPag: TBitBtnLocked
      Left = 342
      Top = 1
      Width = 75
      Height = 23
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairCtaPagClick
    end
  end
end
