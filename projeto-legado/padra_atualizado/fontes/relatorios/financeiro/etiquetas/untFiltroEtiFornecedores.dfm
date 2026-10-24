inherited frmFiltroEtiFornecedores: TfrmFiltroEtiFornecedores
  Left = 264
  Top = 222
  Width = 361
  Height = 277
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 361
  ExplicitHeight = 277
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 233
    Width = 355
    ExplicitTop = 233
    ExplicitWidth = 355
    inherited btnSair: TBitBtnLocked
      Left = 284
      ExplicitLeft = 284
    end
  end
  inherited pgcDados: TPageControl
    Width = 355
    Height = 233
    TabOrder = 1
    Visible = False
    ExplicitWidth = 355
    ExplicitHeight = 233
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 347
      ExplicitHeight = 201
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 355
    Height = 233
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 22
      Top = 13
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Inicial:'
    end
    object Label2: TLabel
      Left = 25
      Top = 36
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Final:'
    end
    object Label4: TLabel
      Left = 32
      Top = 59
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade:'
    end
    object Label6: TLabel
      Left = 45
      Top = 82
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label8: TLabel
      Left = 49
      Top = 105
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object Label9: TLabel
      Left = 45
      Top = 128
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object Label10: TLabel
      Left = 11
      Top = 201
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Etiquetas:'
    end
    object lbl1: TLabel
      Left = 42
      Top = 154
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Revista:'
    end
    object ColorLabel1: TColorLabel
      Left = 123
      Top = 151
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object edtNomCid: TEditFocus
      Left = 131
      Top = 78
      Width = 209
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomIni: TEditFocus
      Tag = 99
      Left = 84
      Top = 9
      Width = 256
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFin: TEditFocus
      Tag = 99
      Left = 84
      Top = 32
      Width = 256
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 84
      Top = 55
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 3
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 84
      Top = 78
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 4
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtBairro: TEditFocus
      Tag = 99
      Left = 84
      Top = 101
      Width = 256
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Tag = 99
      Left = 84
      Top = 124
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdEti: TEditFocus
      Tag = 99
      Left = 84
      Top = 194
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomAti: TEditFocus
      Left = 131
      Top = 55
      Width = 209
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object chkMosFil: TCheckBox
      Left = 84
      Top = 173
      Width = 261
      Height = 17
      Caption = 'Mostrar apenas registros que satisfazem o filtro'
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object edtRevist: TEditFocus
      Tag = 99
      Left = 84
      Top = 147
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
  end
  inherited pnlStatus: TPanel
    Top = 233
    Width = 355
    TabOrder = 3
    ExplicitTop = 233
    ExplicitWidth = 355
    inherited pnlNomeForm: TPanel
      Left = 186
      Width = 169
      ExplicitLeft = 186
      ExplicitWidth = 169
    end
    inherited pnlInfo: TPanel
      Width = 186
      ExplicitWidth = 186
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 8
  end
end
