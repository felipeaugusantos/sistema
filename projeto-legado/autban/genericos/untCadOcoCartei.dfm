inherited frmCadOcoCartei: TfrmCadOcoCartei
  Width = 563
  Height = 226
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 
    'Cadastro de Ocorr'#234'ncias para Lan'#231'amento de Tarifas Banc'#225'rias - A' +
    'uxiliares'
  Font.Quality = fqClearType
  Position = poMainFormCenter
  ExplicitWidth = 563
  ExplicitHeight = 226
  PixelsPerInch = 96
  TextHeight = 14
  object Label7: TLabel [0]
    Left = 43
    Top = 58
    Width = 46
    Height = 13
    Alignment = taRightJustify
    Caption = 'Portador:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    Transparent = True
  end
  object Label21: TLabel [1]
    Left = 30
    Top = 98
    Width = 59
    Height = 13
    Alignment = taRightJustify
    Caption = 'Fornecedor:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel [2]
    Left = 11
    Top = 38
    Width = 78
    Height = 13
    Alignment = taRightJustify
    Caption = 'Ocorr'#234'ncia/Mot:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    Transparent = True
  end
  object lblTipDes: TLabel [3]
    Left = 327
    Top = 119
    Width = 70
    Height = 13
    Caption = 'Tipo da Tarifa:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    Visible = False
  end
  object lblDescontada1: TLabel [4]
    Left = 349
    Top = 139
    Width = 199
    Height = 12
    Caption = 'Tipo utilizado apenas em ocorr'#234'ncias referentes'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    Visible = False
  end
  object lblDescontada2: TLabel [5]
    Left = 349
    Top = 152
    Width = 110
    Height = 12
    Caption = 'a Duplicatas Descontadas'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 184
    Width = 563
    Height = 26
    TabOrder = 13
    ExplicitTop = 184
    ExplicitWidth = 563
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 482
      Height = 22
      ExplicitWidth = 482
      ExplicitHeight = 22
      object btbConFir: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D36030000000000003600000028000000100000000C0000000100
          2000000000000003000000000000000000000000000000000000000000000000
          00000000000000000000000000000020004E004C00AE00000008000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000021004F007000E6008000FF004100B7000000070000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000092909550C7A0CE7008700FF008700FF008700FF004300B30000
          0005000000000000000000000000000000000000000000000000000000000000
          000009290956429B42EC48AC48FF2C9F2CFF0C910CFF048D04FF048D04FF0142
          01AE000000040000000000000000000000000000000000000000000000000A2A
          0A564C9E4CEC56B256FF54B154FF52B152FF50B050FF3CA63CFF249C24FF1494
          14FF094109A900000003000000000000000000000000000000000927095355A5
          55ED61B761FF60B760FF5EB65EFF408C40D8174D179153AB53F758B358FF53B1
          53FF46AB46FF285428AE000000020000000000000000000000000314032C4D95
          4DDB6BBC6BFF6ABB6AFF479047D902100225000000001441147E5DAD5DF761B7
          61FF60B660FF5EB65EFF335833AB000000010000000000000000000000000314
          032C529552DB519251D9021002250000000000000000000000001541157D65B2
          65F76BBC6BFF69BB69FF68BA68FF335433A60000000100000000000000000000
          00000314032C0210022500000000000000000000000000000000000000001641
          167D6CB66CF774C074FF73BF73FF71BE71FF365136A100000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00001743177D75BC75F77DC47DFF7CC37CFF7CBF7CFE1438146A000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000001843187D7FC07FF785C585FE2E652EA900010002000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000001941197B306530A60001000200000000}
        TabOrder = 0
        OnClick = btbConFirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 484
      Top = 2
      Align = alRight
      ExplicitLeft = 484
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 210
    Width = 563
    TabOrder = 15
    ExplicitTop = 210
    ExplicitWidth = 563
    inherited pnlNomeForm: TPanel
      Left = 392
      ExplicitLeft = 392
    end
    inherited pnlInfo: TPanel
      Width = 392
      ExplicitWidth = 392
    end
  end
  object edtDesPorTar: TEditFocus [8]
    Left = 153
    Top = 55
    Width = 395
    Height = 19
    TabStop = False
    Alignment = taLeftJustify
    AutoSize = False
    Color = 16768952
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtPorTar: TEditFocus [9]
    Tag = 99
    Left = 91
    Top = 55
    Width = 61
    Height = 19
    Alignment = taLeftJustify
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    MaxLength = 5
    ParentFont = False
    TabOrder = 3
    OnKeyPress = edtPorTarKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtDesForTar: TEditFocus [10]
    Left = 153
    Top = 95
    Width = 395
    Height = 19
    TabStop = False
    Alignment = taLeftJustify
    AutoSize = False
    Color = 16768952
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtForTar: TEditFocus [11]
    Tag = 99
    Left = 91
    Top = 95
    Width = 61
    Height = 19
    Alignment = taLeftJustify
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    MaxLength = 8
    ParentFont = False
    TabOrder = 6
    OnKeyPress = edtForTarKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttNumerico
  end
  object chkGerPag: TCheckBox [12]
    Left = 91
    Top = 130
    Width = 130
    Height = 17
    Caption = 'Gerar Contas a Pagar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    TabOrder = 9
  end
  object edtCodOco: TEditFocus [13]
    Tag = 99
    Left = 91
    Top = 35
    Width = 29
    Height = 19
    Alignment = taLeftJustify
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    MaxLength = 2
    ParentFont = False
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 2
    TipoTexto = ttNumerico
  end
  object edtDesOco: TEditFocus [14]
    Tag = 99
    Left = 153
    Top = 35
    Width = 395
    Height = 19
    Alignment = taLeftJustify
    AutoSize = False
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    MaxLength = 100
    ParentFont = False
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 100
    TipoTexto = ttAlfanumerico
  end
  object pnlTopo: TPanel [15]
    Left = 0
    Top = 0
    Width = 563
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = 
      'Cadastro de Ocorr'#234'ncias para Lan'#231'amento de Tarifas Banc'#225'rias - A' +
      'uxiliares'
    Color = clNavy
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Font.Quality = fqClearType
    ParentBackground = False
    ParentFont = False
    TabOrder = 14
  end
  object chkCusCar: TCheckBox [16]
    Left = 91
    Top = 114
    Width = 130
    Height = 17
    Caption = 'Custa de Cart'#243'rio'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    TabOrder = 8
  end
  object edtMotOco: TEditFocus [17]
    Tag = 99
    Left = 123
    Top = 35
    Width = 29
    Height = 19
    Alignment = taLeftJustify
    AutoSize = False
    CharCase = ecUpperCase
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    MaxLength = 2
    ParentFont = False
    TabOrder = 1
    Visible = False
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 2
    TipoTexto = ttAlfanumerico
  end
  object cmbTipDes: TComboBoxFocus [18]
    Tag = 99
    Left = 403
    Top = 116
    Width = 145
    Height = 21
    Style = csDropDownList
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    TabOrder = 12
    TextHint = 'Selecione o tipo'
    Visible = False
    OnChange = cmbTipDesChange
    Items.Strings = (
      'OUTRAS TARIFAS'
      'TARIFA IOF'
      'TARIFA BOLETO'
      'TARIFA DESCONTADA'
      'JUROS OPERA'#199#195'O'
      'EST. DESCONTADA')
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  object chkDiasCredito: TCheckBox [19]
    Left = 91
    Top = 147
    Width = 206
    Height = 17
    Caption = 'Utilizar dias para cr'#233'dito da carteira?'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    TabOrder = 10
  end
  inline fraPlanoDeContasOco: TfraPlanoDeContasMskEdit [20]
    Left = 6
    Top = 75
    Width = 549
    Height = 19
    TabOrder = 5
    ExplicitLeft = 6
    ExplicitTop = 75
    ExplicitWidth = 549
    ExplicitHeight = 19
    inherited lblPlaContas: TLabel
      Left = 8
      Top = 3
      Width = 75
      Height = 14
      Caption = 'Plano de Conta:'
      ExplicitLeft = 8
      ExplicitTop = 3
      ExplicitWidth = 75
      ExplicitHeight = 14
    end
    inherited edtDesCta: TEditFocus
      Left = 147
      Width = 395
      Height = 22
      ExplicitLeft = 147
      ExplicitWidth = 395
      ExplicitHeight = 22
    end
    inherited MskCodCta: TMaskEdit
      Width = 61
      Height = 22
      OnKeyPress = fraPlanoDeContasOcoMskCodCtaKeyPress
      ExplicitWidth = 61
      ExplicitHeight = 22
    end
  end
  object chkGerRec: TCheckBox [21]
    Left = 91
    Top = 164
    Width = 158
    Height = 17
    Caption = 'Gerar Contas a Receber'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    TabOrder = 11
  end
  inherited mnuAuxiliar: TPopupMenu [22]
    Left = 452
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents [23]
    Left = 484
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 420
    Top = 24
  end
end
