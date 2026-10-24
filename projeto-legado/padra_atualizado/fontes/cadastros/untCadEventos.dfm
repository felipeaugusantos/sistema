inherited frmCadEventos: TfrmCadEventos
  Left = 225
  Width = 633
  Height = 290
  Caption = 'Cadastro de Centro de Custos'
  ExplicitWidth = 633
  ExplicitHeight = 290
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 220
    Width = 627
    Height = 25
    ExplicitTop = 186
    ExplicitWidth = 527
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 551
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 451
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 74
        ExplicitLeft = 292
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 366
        Width = 73
        ExplicitLeft = 366
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 553
      Width = 72
      Height = 21
      Align = alRight
      ExplicitLeft = 453
      ExplicitWidth = 72
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 245
    Width = 627
    ExplicitTop = 211
    ExplicitWidth = 527
    inherited pnlNomeForm: TPanel
      Left = 447
      Width = 180
      ExplicitLeft = 347
      ExplicitWidth = 180
    end
    inherited pnlInfo: TPanel
      Width = 447
      ExplicitWidth = 347
    end
  end
  inherited pgcDados: TPageControl
    Width = 627
    Height = 220
    ExplicitWidth = 527
    ExplicitHeight = 186
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 519
      ExplicitHeight = 154
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 627
    Height = 220
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitWidth = 527
    ExplicitHeight = 186
    object Label2: TLabel
      Left = 41
      Top = 62
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 17
      Top = 15
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Resumido:'
    end
    object Label3: TLabel
      Left = 31
      Top = 85
      Width = 72
      Height = 14
      Caption = 'Conta Cont'#225'bil:'
    end
    object lblExiFat: TLabel
      Left = 327
      Top = 86
      Width = 108
      Height = 14
      Alignment = taRightJustify
      Caption = 'Exibir no faturamento?'
    end
    object cllExiFat: TColorLabel
      Left = 461
      Top = 86
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object lblCodCompleto: TLabel
      Left = 20
      Top = 38
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Completo:'
    end
    object lblDtaEve: TLabel
      Left = 76
      Top = 159
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data:'
    end
    object lblQtdPes: TLabel
      Left = 203
      Top = 159
      Width = 118
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade de Pessoas:'
    end
    object lblEndereco: TLabel
      Left = 4
      Top = 186
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Endere'#231'o do Evento:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 105
      Top = 10
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EVE_CODEVE'
      DataSource = dtsCadEve
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesEve: TDBEditFocus
      Tag = 99
      Left = 105
      Top = 58
      Width = 421
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EVE_DESEVE'
      DataSource = dtsCadEve
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeConCon: TDBEditFocus
      Tag = 99
      Left = 105
      Top = 82
      Width = 216
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EVE_CONCON'
      DataSource = dtsCadEve
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeExiFat: TDBEditFocus
      Tag = 99
      Left = 448
      Top = 83
      Width = 20
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EVE_EXIFAT'
      DataSource = dtsCadEve
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object rdgTipoEvento: TDBRadioGroup
      Left = 105
      Top = 105
      Width = 421
      Height = 45
      Caption = 'Tipo do Centro de Custos'
      Columns = 3
      DataField = 'EVE_TIPEVE'
      DataSource = dtsCadEve
      Items.Strings = (
        'Contas a Receber'
        'Contas a Pagar'
        #218'nico')
      TabOrder = 5
      Values.Strings = (
        'R'
        'P'
        'G')
    end
    object dbeCodigoCompleto: TDBEditFocus
      Tag = 99
      Left = 105
      Top = 34
      Width = 151
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EVE_CODCOM'
      DataSource = dtsCadEve
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDtaEve: TDBEditFocus
      Tag = 99
      Left = 105
      Top = 155
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EVE_DTAEVE'
      DataSource = dtsCadEve
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdPes: TDBEditFocus
      Tag = 99
      Left = 324
      Top = 155
      Width = 75
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EVE_QTDPES'
      DataSource = dtsCadEve
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEndEve: TDBEditFocus
      Tag = 99
      Left = 105
      Top = 183
      Width = 513
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EVE_ENDEVE'
      DataSource = dtsCadEve
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 344
    Top = 0
  end
  object dtsCadEve: TDataSource
    OnDataChange = dtsCadEveDataChange
    Left = 312
  end
end
