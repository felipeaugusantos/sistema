inherited frmCadTiposIntegracaoWS: TfrmCadTiposIntegracaoWS
  Width = 528
  Height = 222
  Caption = 'Cadastro de Tipos de Integra'#231#227'o WebService'
  ExplicitWidth = 528
  ExplicitHeight = 222
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 149
    Width = 522
    ExplicitTop = 149
    ExplicitWidth = 522
    inherited FlwBotoes: TFlowPanel
      Width = 518
      ExplicitTop = 2
      ExplicitWidth = 518
    end
    inherited btnSair: TBitBtnLocked
      Left = 441
      ExplicitLeft = 441
    end
  end
  inherited pnlStatus: TPanel
    Top = 177
    Width = 522
    ExplicitTop = 177
    ExplicitWidth = 522
    inherited pnlNomeForm: TPanel
      Left = 175
      ExplicitLeft = 175
    end
    inherited pnlInfo: TPanel
      Width = 175
      ExplicitWidth = 175
    end
  end
  inherited pgcDados: TPageControl
    Width = 522
    Height = 149
    ExplicitWidth = 522
    ExplicitHeight = 149
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 514
      ExplicitHeight = 117
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 522
    Height = 149
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object lblDescricao: TLabel
      Left = 43
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblCodigo: TLabel
      Left = 59
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblSituacao: TLabel
      Left = 50
      Top = 63
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object ColorLabel1: TColorLabel
      Left = 135
      Top = 63
      Width = 75
      Height = 14
      Caption = '(A)tivo (I)nativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblCodigoOriginal: TLabel
      Left = 20
      Top = 86
      Width = 75
      Height = 14
      Caption = 'C'#243'digo Original:'
    end
    object lblSiglaNumPok: TLabel
      Left = 23
      Top = 110
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sigla NUMPOK:'
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 37
      Width = 400
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SIS_SISEXT'
      DataSource = dtsCadTip
      MaxLength = 255
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 14
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SIS_CODSIS'
      DataSource = dtsCadTip
      MaxLength = 20
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeStatus: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 60
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SIS_ATIVO_'
      DataSource = dtsCadTip
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 2
      OnEnter = dbeStatusEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodOri: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 83
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SIS_CODORI'
      DataSource = dtsCadTip
      MaxLength = 3
      TabOrder = 3
      OnKeyPress = dbeCodOriKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeSiglaNumPok: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 106
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SIS_SIGPED'
      DataSource = dtsCadTip
      MaxLength = 10
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object dtsCadTip: TDataSource
    Left = 376
    Top = 88
  end
end
