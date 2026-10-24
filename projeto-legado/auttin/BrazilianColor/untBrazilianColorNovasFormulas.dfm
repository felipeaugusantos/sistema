inherited frmBrazilianColorNovasFormulas: TfrmBrazilianColorNovasFormulas
  Height = 536
  Caption = 'frmBrazilianColorNovasFormulas'
  ExplicitHeight = 536
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 464
    TabOrder = 2
    ExplicitTop = 464
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 492
    TabOrder = 3
    ExplicitTop = 492
    inherited pnlNomeForm: TPanel
      TabOrder = 1
    end
    inherited pnlInfo: TPanel
      TabOrder = 0
    end
  end
  inherited pgcDados: TPageControl
    Height = 464
    TabOrder = 0
    ExplicitHeight = 464
    inherited tbsGeral: TTabSheet
      ExplicitHeight = 432
    end
  end
  inherited pnlCentral: TPanel
    Height = 464
    TabOrder = 1
    ExplicitHeight = 464
    inherited lblCodigo: TLabel
      Left = 22
      ExplicitLeft = 22
    end
    object lblDescricao: TLabel [1]
      Left = 6
      Top = 61
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblAno: TLabel [2]
      Left = 35
      Top = 89
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ano:'
    end
    object lblMontadora: TLabel [3]
      Left = 4
      Top = 117
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Montadora:'
    end
    object lblTipo: TLabel [4]
      Left = 284
      Top = 33
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object Label1: TLabel [5]
      Left = 127
      Top = 89
      Width = 118
      Height = 14
      Alignment = taRightJustify
      Caption = 'Acr'#233'scimo m'#227'o de obra:'
    end
    object Label55: TLabel [6]
      Left = 350
      Top = 89
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object Label2: TLabel [7]
      Left = 29
      Top = 149
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha:'
    end
    inherited pnlCabecalho: TPanel
      ParentBackground = False
      TabOrder = 0
    end
    inherited dbeCodigo: TDBEditFocus
      Left = 64
      TabOrder = 1
      ExplicitLeft = 64
    end
    inherited dbgComponentes: TcxGrid
      Top = 189
      Height = 271
      TabOrder = 9
      ExplicitTop = 189
      ExplicitHeight = 271
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 58
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAno: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 86
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_A_N_O_'
      Enabled = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMontadora: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 114
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODMON'
      Enabled = False
      TabOrder = 6
      OnKeyPress = dbeMontadoraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipo: TDBEditFocus
      Tag = 99
      Left = 313
      Top = 30
      Width = 201
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_TIPO__'
      Enabled = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesMon: TEditFocus
      Left = 127
      Top = 114
      Width = 387
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object dbeAcrMob: TDBEditFocus
      Tag = 99
      Left = 251
      Top = 86
      Width = 94
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_ACRMOB'
      Enabled = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 429
      Top = 86
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object Cmblinha: TComboBox
      Left = 64
      Top = 146
      Width = 181
      Height = 22
      Style = csOwnerDrawFixed
      Enabled = False
      TabOrder = 7
      OnChange = CmblinhaChange
      Items.Strings = (
        'BASE POLIESTER'
        'EPOXY'
        'LACA NITRO'
        'POLIURETANO'
        'PU CLASSICO'
        'SINTETICO')
    end
    object _dbeLinha: TDBEditFocus
      Tag = 99
      Left = 328
      Top = 146
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_LINHA_'
      Enabled = False
      TabOrder = 11
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 248
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 288
    Top = 248
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 616
    Top = 200
  end
  inherited dtsComponentes: TDataSource
    Left = 448
    Top = 264
  end
  inherited cdsCompoentes: TUniClientDataSet
    Left = 416
    Top = 264
  end
end
