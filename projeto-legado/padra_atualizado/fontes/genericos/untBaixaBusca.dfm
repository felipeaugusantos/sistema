inherited frmBaixaBusca: TfrmBaixaBusca
  Left = 233
  Top = 259
  Width = 354
  Height = 140
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 354
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 99
    Width = 348
    ExplicitTop = 99
    ExplicitWidth = 348
    inherited btnSair: TBitBtnLocked
      Left = 224
      ExplicitLeft = 224
    end
  end
  inherited pgcDados: TPageControl
    Width = 348
    Height = 99
    TabOrder = 1
    Visible = False
    ExplicitWidth = 348
    ExplicitHeight = 99
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 340
      ExplicitHeight = 67
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 348
    Height = 99
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object Label2: TLabel
      Left = 120
      Top = 8
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Nosso N'#250'mero'
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 65
      Height = 14
      AutoSize = False
      Caption = 'Duplicata'
    end
    object Label3: TLabel
      Left = 232
      Top = 8
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Documento Antigo'
    end
    object lblCliFor: TLabel
      Left = 8
      Top = 48
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Cliente/Fornecedor'
    end
    object lbl1: TLabel
      Left = 120
      Top = 48
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Valor'
    end
    object edtNosNum: TEditFocus
      Tag = 99
      Left = 120
      Top = 21
      Width = 105
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDup: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 105
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVel: TEditFocus
      Tag = 99
      Left = 232
      Top = 21
      Width = 105
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCliFor: TEditFocus
      Tag = 99
      Left = 8
      Top = 61
      Width = 105
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValDup: TEditFocus
      Tag = 99
      Left = 120
      Top = 61
      Width = 105
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 4
      OnExit = edtValDupExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited pnlStatus: TPanel
    Top = 99
    Width = 348
    TabOrder = 3
    ExplicitTop = 99
    ExplicitWidth = 348
    inherited pnlNomeForm: TPanel
      Left = 225
      Width = 123
      ExplicitLeft = 225
      ExplicitWidth = 123
    end
    inherited pnlInfo: TPanel
      Width = 225
      ExplicitWidth = 225
    end
  end
end
