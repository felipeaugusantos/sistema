inherited frmHerancaFaturamento: TfrmHerancaFaturamento
  Width = 381
  Height = 142
  Caption = 'Heran'#231'a Faturamento'
  ExplicitWidth = 381
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 70
    Width = 375
    TabOrder = 1
    ExplicitTop = 70
    ExplicitWidth = 375
    inherited btnSair: TBitBtnLocked
      Left = 292
      ExplicitLeft = 292
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 375
    Height = 70
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 15
      Width = 57
      Height = 14
      Caption = 'Documento:'
    end
    object Label2: TLabel
      Left = 24
      Top = 39
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 72
      Top = 12
      Width = 81
      Height = 22
      Alignment = taRightJustify
      MaxLength = 12
      TabOrder = 0
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
      Left = 156
      Top = 12
      Width = 33
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 72
      Top = 36
      Width = 38
      Height = 22
      Alignment = taRightJustify
      MaxLength = 3
      TabOrder = 2
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 114
      Top = 36
      Width = 251
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
  end
  inherited pnlStatus: TPanel
    Top = 98
    Width = 375
    TabOrder = 2
    ExplicitTop = 98
    ExplicitWidth = 375
    inherited pnlNomeForm: TPanel
      Left = 204
      ExplicitLeft = 204
    end
    inherited pnlInfo: TPanel
      Width = 204
      ExplicitWidth = 204
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 232
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 72
  end
end
