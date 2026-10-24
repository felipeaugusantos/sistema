inherited frmConsultaOcorrenciaCrmBusca: TfrmConsultaOcorrenciaCrmBusca
  Width = 307
  Height = 152
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 307
  ExplicitHeight = 152
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 108
    Width = 301
    ExplicitTop = 108
    ExplicitWidth = 301
    end
  inherited pnlStatus: TPanel
    Top = 108
    Width = 301
    ExplicitTop = 108
    ExplicitWidth = 301
    inherited pnlNomeForm: TPanel
      Left = 130
      ExplicitLeft = 130
    end
    inherited pnlInfo: TPanel
      Width = 130
      ExplicitWidth = 130
    end
  end
  inherited pgcDados: TPageControl
    Width = 301
    Height = 108
    ExplicitWidth = 301
    ExplicitHeight = 108
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 293
      ExplicitHeight = 76
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 301
    Height = 108
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 89
      Height = 14
      AutoSize = False
      Caption = 'Grupo Ocorr'#234'ncia'
    end
    object Label2: TLabel
      Left = 189
      Top = 8
      Width = 79
      Height = 14
      AutoSize = False
      Caption = 'Tipo Ocorr'#234'ncia'
    end
    object Label3: TLabel
      Left = 8
      Top = 52
      Width = 65
      Height = 14
      AutoSize = False
      Caption = 'Protocolo'
    end
    object Label4: TLabel
      Left = 189
      Top = 52
      Width = 65
      Height = 14
      AutoSize = False
      Caption = 'Data'
    end
    object edtCodGoc: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 105
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtCodToc: TEditFocus
      Tag = 99
      Left = 189
      Top = 21
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtProtoc: TEditFocus
      Tag = 99
      Left = 8
      Top = 65
      Width = 177
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 22
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtDtaOco: TMaskEditFocus
      Tag = 99
      Left = 189
      Top = 65
      Width = 92
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
    end
