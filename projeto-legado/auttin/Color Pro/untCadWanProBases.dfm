inherited frmCadWanProBases: TfrmCadWanProBases
  Left = 224
  Width = 530
  Height = 178
  Caption = 'Cadastro de Bases - Color Pro'
  ExplicitWidth = 530
  ExplicitHeight = 178
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 106
    Width = 524
    ExplicitTop = 106
    ExplicitWidth = 524
    inherited btnSair: TBitBtnLocked
      Left = 447
      ExplicitLeft = 447
    end
  end
  inherited pgcDados: TPageControl
    Width = 524
    Height = 106
    ExplicitWidth = 524
    ExplicitHeight = 106
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 516
      ExplicitHeight = 74
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 524
    Height = 106
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 39
      Top = 16
      Width = 29
      Height = 14
      Caption = 'Linha:'
    end
    object Label2: TLabel
      Left = 368
      Top = 16
      Width = 28
      Height = 14
      Caption = 'Base:'
    end
    object Label3: TLabel
      Left = 16
      Top = 38
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label8: TLabel
      Left = 28
      Top = 82
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 17
      Top = 60
      Width = 51
      Height = 14
      Caption = 'Peso Esp.:'
    end
    object Label5: TLabel
      Left = 173
      Top = 60
      Width = 57
      Height = 14
      Caption = 'Embalagem:'
    end
    object Label6: TLabel
      Left = 349
      Top = 60
      Width = 80
      Height = 14
      Caption = 'Pre'#231'o de Venda:'
    end
    object dbeLinha: TDBEditFocus
      Tag = 99
      Left = 258
      Top = 8
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_LINHA_'
      DataSource = dtsWanProCadBas
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodBas: TDBEditFocus
      Tag = 99
      Left = 400
      Top = 8
      Width = 105
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_CODBAS'
      DataSource = dtsWanProCadBas
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 30
      Width = 433
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_DESBAS'
      DataSource = dtsWanProCadBas
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 144
      Top = 75
      Width = 361
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 75
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_CODITE'
      DataSource = dtsWanProCadBas
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePesEsp: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 52
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_PESESP'
      DataSource = dtsWanProCadBas
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEmbala: TDBEditFocus
      Tag = 99
      Left = 232
      Top = 52
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_EMBALA'
      DataSource = dtsWanProCadBas
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreVen: TDBEditFocus
      Tag = 99
      Left = 432
      Top = 52
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_PREVEN'
      DataSource = dtsWanProCadBas
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cbbLinha: TcxComboBox
      Left = 72
      Top = 8
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'AUTOBASE PLUS 100:50'
        'WANDABASE HS'
        'WANDALAC'
        'WANDA PU HS'
        'WANDACAR'
        'SINGLE STAGE CONVERTER'
        'AUTOCOAT BT100'
        'AUTOBASE PLUS 100:80'
        'AUTOCOAT BT120'
        'WANDA PU MS'
        'AUTOCOAT BT90'
        'AUTOCOAT BT110'
        'AUTOCOAT BT130 '
        'AUTOWAVE MM'
        'TECH FLEET PU'
        'TECH FLEET EPOXY'
        'TECH FLEET SINTETICO'
        'AUTOBASE PLUS BASELINE 100:50'
        'AUTOBASE PLUS BASELINE 100:80'
        'TECH FLEET LACA')
      Properties.OnChange = cbbLinhaPropertiesChange
      TabOrder = 0
      OnKeyDown = cbbLinhaKeyDown
      Width = 183
    end
  end
  inherited pnlStatus: TPanel
    Top = 134
    Width = 524
    ExplicitTop = 134
    ExplicitWidth = 524
    inherited pnlNomeForm: TPanel
      Left = 177
      ExplicitLeft = 177
    end
    inherited pnlInfo: TPanel
      Width = 177
      ExplicitWidth = 177
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 65520
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 65520
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 400
    Top = 65520
  end
  object dtsWanProCadBas: TDataSource
    Left = 384
    Top = 16
  end
end
