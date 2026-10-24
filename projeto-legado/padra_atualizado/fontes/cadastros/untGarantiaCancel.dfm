inherited frmGarantiaCancel: TfrmGarantiaCancel
  Width = 503
  Height = 220
  BorderIcons = [biSystemMenu]
  Caption = 'Cancelamento de Garantia'
  Position = poMainFormCenter
  ExplicitWidth = 503
  ExplicitHeight = 220
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 148
    Width = 497
    TabOrder = 2
    ExplicitTop = 148
    ExplicitWidth = 497
    DesignSize = (
      497
      28)
    inherited btnSair: TBitBtnLocked
      Left = 414
      TabOrder = 1
      ExplicitLeft = 414
    end
    object btnConfirmar: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 110
      Height = 22
      Caption = '[ F10 ] Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 41
    Width = 497
    Height = 107
    Align = alClient
    Color = 16770261
    Enabled = False
    TabOrder = 1
    object Label2: TLabel
      Left = 17
      Top = 39
      Width = 52
      Height = 14
      AutoSize = False
      Caption = 'Vendedor:'
    end
    object Label3: TLabel
      Left = 12
      Top = 15
      Width = 56
      Height = 14
      AutoSize = False
      Caption = 'Dt. Entrada:'
    end
    object Label4: TLabel
      Left = 33
      Top = 63
      Width = 38
      Height = 14
      AutoSize = False
      Caption = 'Cliente:'
    end
    object Label5: TLabel
      Left = 9
      Top = 87
      Width = 58
      Height = 14
      AutoSize = False
      Caption = 'Fornecedor:'
    end
    object edtSenVen: TEditFocus
      Tag = 99
      Left = 69
      Top = 32
      Width = 84
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 156
      Top = 32
      Width = 333
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 69
      Top = 56
      Width = 84
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 156
      Top = 56
      Width = 333
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 69
      Top = 80
      Width = 84
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 156
      Top = 80
      Width = 333
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaEnt: TMaskEditFocus
      Tag = 99
      Left = 69
      Top = 8
      Width = 84
      Height = 22
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pnlTopo: TPanel [3]
    Left = 0
    Top = 0
    Width = 497
    Height = 41
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 16
      Width = 58
      Height = 14
      AutoSize = False
      Caption = 'Nr. Entrada:'
    end
    object edtNumEnt: TEditFocus
      Tag = 99
      Left = 69
      Top = 8
      Width = 84
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNumEntExit
      OnKeyPress = edtNumEntKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 176
    Width = 497
    TabOrder = 3
    ExplicitTop = 176
    ExplicitWidth = 497
    inherited pnlNomeForm: TPanel
      Left = 326
      ExplicitLeft = 326
    end
    inherited pnlInfo: TPanel
      Width = 326
      ExplicitWidth = 326
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 536
    Top = 352
  end
end
