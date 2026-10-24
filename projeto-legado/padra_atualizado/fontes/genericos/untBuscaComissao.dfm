inherited frmBuscaComissao: TfrmBuscaComissao
  Left = 408
  Top = 377
  Width = 352
  Height = 101
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 352
  ExplicitHeight = 101
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 162
    Align = alNone
    ExplicitTop = 162
    end
  inherited pnlStatus: TPanel
    Top = 57
    Width = 346
    ExplicitTop = 57
    ExplicitWidth = 346
    inherited pnlNomeForm: TPanel
      Left = 175
      ExplicitLeft = 175
  end
    inherited pnlInfo: TPanel
      Width = 175
      ExplicitWidth = 175
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 346
    Height = 57
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label2: TLabel
      Left = 120
      Top = 8
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Dta. Cad.'
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 65
      Height = 14
      AutoSize = False
      Caption = 'C'#243'digo'
    end
    object Label3: TLabel
      Left = 231
      Top = 8
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Valor Venda'
    end
    object edtCodigo: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 105
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 7
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtValorVenda: TEditFocus
      Tag = 99
      Left = 231
      Top = 21
      Width = 105
      Height = 22
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
      EditFormat = '#,####0.00'
      Alignment = taLeftJustify
    end
    object edtDtaCad: TMaskEditFocus
      Left = 120
      Top = 21
      Width = 104
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 8
  end
end
