inherited frmEmailMarketingProspectos: TfrmEmailMarketingProspectos
  Width = 642
  Height = 296
  Caption = 'E-Mail Marketing - Prospectos'
  OnDestroy = FormDestroy
  ExplicitWidth = 642
  ExplicitHeight = 296
  PixelsPerInch = 96
  TextHeight = 14
  object lbl5: TLabel [0]
    Left = 8
    Top = 73
    Width = 56
    Height = 14
    Caption = 'Nome Inicial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lbl6: TLabel [1]
    Left = 321
    Top = 73
    Width = 52
    Height = 14
    Caption = 'Nome Final'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lbl7: TLabel [2]
    Left = 31
    Top = 96
    Width = 33
    Height = 14
    Caption = 'Cidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lbl9: TLabel [3]
    Left = 340
    Top = 96
    Width = 33
    Height = 14
    Caption = 'Estado'
  end
  object lbl1: TLabel [4]
    Left = 424
    Top = 95
    Width = 29
    Height = 14
    Caption = 'Bairro'
  end
  object lbl8: TLabel [5]
    Left = 16
    Top = 142
    Width = 47
    Height = 14
    Caption = 'Vendedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lbl13: TLabel [6]
    Left = 326
    Top = 142
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Atividade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lbl11: TLabel [7]
    Left = 14
    Top = 118
    Width = 50
    Height = 14
    Caption = 'End. Inicial'
  end
  object lbl12: TLabel [8]
    Left = 327
    Top = 118
    Width = 46
    Height = 14
    Caption = 'End. Final'
  end
  object shpCodVen: TShape [9]
    Left = 70
    Top = 138
    Width = 8
    Height = 21
  end
  inherited pnlBotoes: TPanel
    Top = 225
    Width = 636
    TabOrder = 17
    ExplicitTop = 225
    ExplicitWidth = 636
    inherited FlwBotoes: TFlowPanel
      Width = 632
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 553
      ExplicitLeft = 553
    end
  end
  inherited pnlStatus: TPanel
    Top = 251
    Width = 636
    TabOrder = 18
    ExplicitTop = 251
    ExplicitWidth = 636
    inherited pnlNomeForm: TPanel
      Left = 465
      ExplicitLeft = 465
    end
    inherited pnlInfo: TPanel
      Width = 465
      ExplicitWidth = 465
    end
  end
  object gpbData: TGroupBox [13]
    Left = 8
    Top = 4
    Width = 240
    Height = 60
    TabOrder = 0
    object lbl17: TLabel
      Left = 8
      Top = 16
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblTitData: TLabel
      Left = 154
      Top = 34
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl18: TLabel
      Left = 82
      Top = 16
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 82
      Top = 30
      Width = 69
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 30
      Width = 68
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  object rdgTipDta: TRadioGroup [14]
    Tag = 99
    Left = 254
    Top = 4
    Width = 124
    Height = 60
    Caption = 'Filtrar por data de:'
    ItemIndex = 0
    Items.Strings = (
      'Cadastro'
      'Nascimento')
    TabOrder = 1
  end
  object gpbAniv: TGroupBox [15]
    Left = 384
    Top = 4
    Width = 131
    Height = 60
    Caption = 'Anivers'#225'rio (dia/m'#234's)'
    TabOrder = 2
    object lbl15: TLabel
      Left = 13
      Top = 16
      Width = 29
      Height = 14
      Caption = 'Inicial:'
    end
    object lbl16: TLabel
      Left = 63
      Top = 16
      Width = 25
      Height = 14
      Caption = 'Final:'
    end
    object mskAniIni: TMaskEditFocus
      Tag = 99
      Left = 13
      Top = 30
      Width = 44
      Height = 22
      EditMask = '!99/99;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      Text = '  /  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskAniFin: TMaskEditFocus
      Tag = 99
      Left = 63
      Top = 30
      Width = 44
      Height = 22
      EditMask = '!99/99;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 1
      Text = '  /  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object edtNomeInicial: TEditFocus [16]
    Left = 70
    Top = 69
    Width = 242
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 3
    OnChange = edtNomeInicialChange
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtNomeFinal: TEditFocus [17]
    Left = 379
    Top = 69
    Width = 248
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
    ParentFont = False
    TabOrder = 4
    OnExit = edtNomeFinalExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodCid: TEditFocus [18]
    Tag = 99
    Left = 70
    Top = 92
    Width = 39
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    ParentFont = False
    TabOrder = 5
    OnExit = edtCodCidExit
    OnKeyPress = edtCodCidKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtEstado: TEditFocus [19]
    Left = 379
    Top = 92
    Width = 39
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 2
    ParentFont = False
    TabOrder = 7
    OnExit = edtEstadoExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfabetico
  end
  object edtDesCidade: TEditFocus [20]
    Left = 110
    Top = 92
    Width = 202
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
    TabOrder = 6
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtBairro: TEditFocus [21]
    Tag = 99
    Left = 459
    Top = 92
    Width = 168
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 30
    TabOrder = 8
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodVendedor: TEditFocus [22]
    Tag = 99
    Left = 79
    Top = 138
    Width = 30
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    ParentFont = False
    TabOrder = 11
    OnExit = edtCodVendedorExit
    OnKeyPress = edtCodVendedorKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtDesVendedor: TEditFocus [23]
    Left = 110
    Top = 138
    Width = 202
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
    TabOrder = 12
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodAti: TEditFocus [24]
    Tag = 99
    Left = 379
    Top = 138
    Width = 39
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    ParentFont = False
    TabOrder = 13
    OnExit = edtCodAtiExit
    OnKeyPress = edtCodAtiKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtAtividade: TEditFocus [25]
    Left = 417
    Top = 138
    Width = 209
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
    TabOrder = 14
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtEndIni: TEditFocus [26]
    Tag = 99
    Left = 70
    Top = 115
    Width = 242
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 9
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtEndFin: TEditFocus [27]
    Tag = 99
    Left = 379
    Top = 115
    Width = 248
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 10
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object rdgTipCli: TRadioGroup [28]
    Tag = 99
    Left = 8
    Top = 166
    Width = 185
    Height = 45
    Caption = 'Pessoa:'
    Columns = 3
    ItemIndex = 2
    Items.Strings = (
      'F'#237'sica'
      'Jur'#237'dica'
      'Todos')
    TabOrder = 15
  end
  object rdgStatus: TRadioGroup [29]
    Tag = 99
    Left = 204
    Top = 166
    Width = 185
    Height = 45
    Caption = 'Status:'
    Columns = 3
    ItemIndex = 2
    Items.Strings = (
      'Ativo'
      'Inativo'
      'Todos')
    TabOrder = 16
  end
end
