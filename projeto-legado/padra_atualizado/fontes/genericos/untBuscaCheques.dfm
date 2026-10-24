inherited FrmBuscaCheques: TFrmBuscaCheques
  Left = 425
  Top = 226
  Width = 352
  Height = 101
  Caption = ''
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 352
  ExplicitHeight = 101
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 175
    Align = alNone
    ExplicitTop = 175
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 346
    Height = 56
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object lblDtaFil: TLabel
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
      Caption = 'Nro. Cheque'
    end
    object Label3: TLabel
      Left = 231
      Top = 8
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Valor Cheque'
    end
    object edtNumCheque: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 105
      Height = 22
      Alignment = taLeftJustify
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
    end
    object edtValorCheque: TEditFocus
      Tag = 99
      Left = 231
      Top = 21
      Width = 105
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 2
      OnExit = edtValorChequeExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
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
end
