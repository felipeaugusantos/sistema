inherited frmCadPlanConCon: TfrmCadPlanConCon
  Width = 606
  Height = 204
  Caption = 'Cadastro - Plano de contas cont'#225'beis'
  OnDestroy = FormDestroy
  ExplicitWidth = 606
  ExplicitHeight = 204
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 190
    Top = 84
    Width = 97
    Height = 14
    Caption = 'C'#243'digo da natureza '
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 46
    Width = 33
    Height = 14
    Caption = 'C'#243'digo'
  end
  object Label4: TLabel [2]
    Left = 153
    Top = 46
    Width = 23
    Height = 14
    Caption = 'N'#237'vel'
  end
  object Label9: TLabel [3]
    Left = 6
    Top = 8
    Width = 27
    Height = 14
    Caption = 'Nome'
  end
  object Label3: TLabel [4]
    Left = 8
    Top = 84
    Width = 44
    Height = 14
    Caption = 'Indicador'
  end
  object Label5: TLabel [5]
    Left = 187
    Top = 8
    Width = 108
    Height = 14
    Caption = 'C'#243'digo correlacionado'
  end
  object Label6: TLabel [6]
    Left = 274
    Top = 46
    Width = 25
    Height = 14
    Caption = 'CNPJ'
  end
  object Label7: TLabel [7]
    Left = 343
    Top = 8
    Width = 22
    Height = 14
    Caption = 'NCM'
  end
  inherited pnlBotoes: TPanel
    Top = 134
    Width = 600
    Height = 25
    TabOrder = 1
    ExplicitTop = 134
    ExplicitWidth = 600
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 528
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 528
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 86
        Height = 21
        Spacing = 2
        ExplicitWidth = 86
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 86
        Width = 86
        Height = 21
        Spacing = 2
        ExplicitLeft = 86
        ExplicitWidth = 86
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 172
        Width = 86
        Height = 21
        Spacing = 2
        ExplicitLeft = 172
        ExplicitWidth = 86
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 258
        Width = 86
        Height = 21
        Spacing = 2
        ExplicitLeft = 258
        ExplicitWidth = 86
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 344
        Width = 86
        Height = 21
        Spacing = 2
        ExplicitLeft = 344
        ExplicitWidth = 86
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 430
        Width = 86
        Height = 21
        Spacing = 2
        ExplicitLeft = 430
        ExplicitWidth = 86
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 530
      Width = 68
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 530
      ExplicitWidth = 68
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 159
    Width = 600
    TabOrder = 0
    ExplicitTop = 159
    ExplicitWidth = 600
    inherited pnlNomeForm: TPanel
      Left = 424
      Width = 176
      TabOrder = 1
      ExplicitLeft = 424
      ExplicitWidth = 176
    end
    inherited pnlInfo: TPanel
      Width = 424
      TabOrder = 0
      ExplicitWidth = 424
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object edtCodPlan: TDBEditFocus [11]
    Tag = 99
    Left = 8
    Top = 61
    Width = 139
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CON_CODCTA'
    DataSource = dsPlaCon
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtNivel: TDBEditFocus [12]
    Tag = 99
    Left = 150
    Top = 61
    Width = 122
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CON_NIVEL_'
    DataSource = dsPlaCon
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtNome: TDBEditFocus [13]
    Tag = 99
    Left = 6
    Top = 22
    Width = 179
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CON_NOMCTA'
    DataSource = dsPlaCon
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtCodCorrelacionado: TDBEditFocus [14]
    Tag = 99
    Left = 187
    Top = 22
    Width = 153
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CON_CDCTAC'
    DataSource = dsPlaCon
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtCodNcm: TDBEditFocus [15]
    Tag = 99
    Left = 343
    Top = 22
    Width = 84
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CON_CODNCM'
    DataSource = dsPlaCon
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object lcbCodNat: TDBLookupComboBox [16]
    Left = 190
    Top = 98
    Width = 237
    Height = 22
    DataField = 'CON_CODNAT'
    DataSource = dsPlaCon
    KeyField = 'NAT_CODNAT'
    ListField = 'NAT_DESNAT'
    ListSource = dsCodigoNatureza
    TabOrder = 11
  end
  object lcbIndicador: TDBLookupComboBox [17]
    Left = 8
    Top = 99
    Width = 176
    Height = 22
    DataField = 'CON_CODIND'
    DataSource = dsPlaCon
    KeyField = 'IND_CODIND'
    ListField = 'IND_DESIND'
    ListSource = dsIndicador
    TabOrder = 9
  end
  object mskEdtCnpj: TMaskEditC_G_C_ [18]
    Left = 274
    Top = 61
    Width = 151
    Height = 22
    EditMask = '>aa\.aaa\.aaa/aaaa-99;0;'
    MaxLength = 18
    TabOrder = 8
    Text = ''
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
    strCgcCpf = '1'
  end
  object edtCodEmp: TDBEdit [19]
    Left = 794
    Top = 297
    Width = 121
    Height = 22
    DataField = 'CON_CODEMP'
    DataSource = dsPlaCon
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 10
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 747
    Top = 75
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 717
    Top = 75
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 687
    Top = 75
  end
  object dsPlaCon: TDataSource
    Left = 457
    Top = 10
  end
  object dsCodigoNatureza: TDataSource
    Left = 505
    Top = 9
  end
  object dsIndicador: TDataSource
    Left = 546
    Top = 9
  end
end
