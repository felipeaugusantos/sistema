inherited frmCadWanBases: TfrmCadWanBases
  Left = 224
  Top = 174
  Width = 538
  Height = 173
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Bases - Wanda'
  ExplicitWidth = 538
  ExplicitHeight = 173
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 105
    Width = 532
    ExplicitTop = 105
    ExplicitWidth = 532
    inherited btnSair: TBitBtnLocked
      Left = 455
      ExplicitLeft = 455
    end
  end
  inherited pgcDados: TPageControl
    Width = 532
    Height = 105
    ExplicitWidth = 532
    ExplicitHeight = 105
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 524
      ExplicitHeight = 73
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 532
    Height = 105
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 40
      Top = 16
      Width = 29
      Height = 14
      Caption = 'Linha:'
    end
    object Label2: TLabel
      Left = 152
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
    object Label4: TLabel
      Left = 40
      Top = 60
      Width = 27
      Height = 14
      Caption = 'Peso:'
    end
    object Label5: TLabel
      Left = 152
      Top = 60
      Width = 69
      Height = 14
      Caption = 'Peso Unidade:'
    end
    object Label6: TLabel
      Left = 320
      Top = 60
      Width = 28
      Height = 14
      Caption = 'Valor:'
    end
    object Label8: TLabel
      Left = 30
      Top = 81
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
    object dbeLinha: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 8
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_LINHA_'
      DataSource = dtsWanCadBas
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodBas: TDBEditFocus
      Tag = 99
      Left = 184
      Top = 8
      Width = 153
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_CODBAS'
      DataSource = dtsWanCadBas
      TabOrder = 1
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
      DataSource = dtsWanCadBas
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePesBas: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 52
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_PESBAS'
      DataSource = dtsWanCadBas
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePesUni: TDBEditFocus
      Tag = 99
      Left = 224
      Top = 52
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_PESUNI'
      DataSource = dtsWanCadBas
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValBas: TDBEditFocus
      Tag = 99
      Left = 352
      Top = 52
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_VALBAS'
      DataSource = dtsWanCadBas
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 144
      Top = 74
      Width = 361
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 74
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_CODITE'
      DataSource = dtsWanCadBas
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
  end
  inherited pnlStatus: TPanel
    Top = 133
    Width = 532
    ExplicitTop = 133
    ExplicitWidth = 532
    inherited pnlNomeForm: TPanel
      Left = 185
      ExplicitLeft = 185
    end
    inherited pnlInfo: TPanel
      Width = 185
      ExplicitWidth = 185
    end
  end
  object dtsWanCadBas: TDataSource
    Left = 296
    Top = 16
  end
end
