inherited frmDesagrupDuplicatas: TfrmDesagrupDuplicatas
  Left = 263
  Top = 236
  Width = 420
  Height = 165
  BorderIcons = [biSystemMenu]
  Caption = 'Desagrupamento de Contas a Receber'
  Position = poMainFormCenter
  ExplicitWidth = 420
  ExplicitHeight = 165
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 96
    Width = 414
    Height = 24
    BevelInner = bvNone
    BevelOuter = bvRaised
    Color = 16770261
    Enabled = True
    Visible = True
    ExplicitTop = 96
    ExplicitWidth = 404
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Left = 77
      Top = 1
      Width = 261
      Height = 22
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      ExplicitLeft = 77
      ExplicitTop = 1
      ExplicitWidth = 251
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 210
      Top = -24
      Enabled = False
      TabOrder = 2
      TabStop = False
      Visible = False
      ExplicitLeft = 200
      ExplicitTop = -24
    end
    object btnSairDes: TBitBtnLocked
      Left = 338
      Top = 1
      Width = 75
      Height = 22
      Align = alRight
      Caption = '[ Esc ] Sair'
      DoubleBuffered = False
      TabOrder = 1
      OnClick = btnSairDesClick
      ExplicitLeft = 328
    end
    object btnConfirmaDes: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 76
      Height = 22
      Align = alLeft
      Caption = '&Confirmar'
      TabOrder = 0
      OnClick = btnConfirmaDesClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 414
    Height = 96
    TabOrder = 1
    Visible = False
    ExplicitWidth = 404
    ExplicitHeight = 96
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 396
      ExplicitHeight = 64
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 414
    Height = 96
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 404
    object Label1: TLabel
      Left = 6
      Top = 15
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nro. Agrupamento:'
    end
    object Label2: TLabel
      Left = 61
      Top = 39
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label6: TLabel
      Left = 51
      Top = 62
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
    object edtNumAgr: TEditFocus
      Tag = 99
      Left = 97
      Top = 11
      Width = 120
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNumAgrExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 173
      Top = 35
      Width = 223
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 97
      Top = 35
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 1
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 97
      Top = 59
      Width = 72
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
      Left = 173
      Top = 59
      Width = 223
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
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 120
    Width = 414
    TabOrder = 3
    ExplicitTop = 120
    ExplicitWidth = 404
    inherited pnlNomeForm: TPanel
      Left = 261
      Width = 153
      ExplicitLeft = 251
      ExplicitWidth = 153
    end
    inherited pnlInfo: TPanel
      Width = 261
      ExplicitWidth = 251
    end
  end
end
