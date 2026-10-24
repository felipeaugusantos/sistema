inherited frmRcxConfCupomBusca: TfrmRcxConfCupomBusca
  Left = 370
  Top = 340
  Width = 377
  Height = 136
  BorderIcons = [biSystemMenu]
  Caption = 'Busca'
  Position = poMainFormCenter
  ExplicitWidth = 377
  ExplicitHeight = 136
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 95
    Width = 371
    ExplicitTop = 95
    ExplicitWidth = 371
  end
  inherited pgcDados: TPageControl
    Width = 371
    Height = 95
    ExplicitWidth = 371
    ExplicitHeight = 95
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 363
      ExplicitHeight = 63
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 371
    Height = 95
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 65
      Height = 14
      AutoSize = False
      Caption = 'Documento'
    end
    object Label2: TLabel
      Left = 169
      Top = 8
      Width = 65
      Height = 14
      AutoSize = False
      Caption = 'Data'
    end
    object Label3: TLabel
      Left = 8
      Top = 48
      Width = 97
      Height = 14
      AutoSize = False
      Caption = 'Nome do Cliente'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 154
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    object mskDtaEnt: TMaskEditFocus
      Tag = 99
      Left = 168
      Top = 21
      Width = 72
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNomCli: TEditFocus
      Tag = 99
      Left = 8
      Top = 61
      Width = 353
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 40
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 40
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 371
    ExplicitTop = 95
    ExplicitWidth = 371
    inherited pnlNomeForm: TPanel
      Left = 200
      ExplicitLeft = 200
    end
    inherited pnlInfo: TPanel
      Width = 200
      ExplicitWidth = 200
    end
  end
end
