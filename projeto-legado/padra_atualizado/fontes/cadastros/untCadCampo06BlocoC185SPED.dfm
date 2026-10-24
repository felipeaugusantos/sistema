inherited frmCadCampo06BlocoC185SPED: TfrmCadCampo06BlocoC185SPED
  Width = 541
  Height = 275
  Caption = 'Cadastro do Campo 06 do Bloco C185 do SPED'
  ExplicitWidth = 541
  ExplicitHeight = 275
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 17
    Top = 23
    Width = 36
    Height = 14
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 23
    Top = 51
    Width = 30
    Height = 14
    Caption = 'Nome:'
  end
  object Label10: TLabel [2]
    Left = 31
    Top = 137
    Width = 22
    Height = 14
    Caption = 'CST:'
  end
  object Label3: TLabel [3]
    Left = 23
    Top = 163
    Width = 30
    Height = 14
    Caption = 'CFOP:'
  end
  object Label4: TLabel [4]
    Left = 10
    Top = 79
    Width = 43
    Height = 14
    Caption = 'Dt. In'#237'cio:'
  end
  object Label5: TLabel [5]
    Left = 18
    Top = 107
    Width = 35
    Height = 14
    Caption = 'Dt. Fim:'
  end
  inherited pnlBotoes: TPanel
    Top = 202
    Width = 535
    ExplicitTop = 202
    ExplicitWidth = 535
    inherited FlwBotoes: TFlowPanel
      Width = 531
      ExplicitTop = 2
      ExplicitWidth = 531
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 80
        Height = 22
        ExplicitWidth = 80
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 452
      ExplicitLeft = 452
    end
  end
  inherited pnlStatus: TPanel
    Top = 230
    Width = 535
    ExplicitTop = 230
    ExplicitWidth = 535
    inherited pnlNomeForm: TPanel
      Left = 370
      Width = 165
      ExplicitLeft = 370
      ExplicitWidth = 165
    end
    inherited pnlInfo: TPanel
      Width = 370
      ExplicitWidth = 370
    end
  end
  inherited pgcDados: TPageControl
    Left = 352
    Top = 346
    Width = 105
    Height = 34
    Align = alNone
    ExplicitLeft = 352
    ExplicitTop = 346
    ExplicitWidth = 105
    ExplicitHeight = 34
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 97
      ExplicitHeight = 2
    end
  end
  object dbeCodigo: TDBEditFocus [9]
    Tag = 99
    Left = 59
    Top = 20
    Width = 76
    Height = 22
    DataField = 'B06_CODIGO'
    DataSource = dtsTabela
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeDescri: TDBEditFocus [10]
    Tag = 99
    Left = 58
    Top = 48
    Width = 364
    Height = 22
    CharCase = ecUpperCase
    DataField = 'B06_DESCRI'
    DataSource = dtsTabela
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCodCST: TDBEditFocus [11]
    Tag = 99
    Left = 183
    Top = 132
    Width = 343
    Height = 22
    CharCase = ecUpperCase
    DataField = 'B06_CODCST'
    DataSource = dtsTabela
    ReadOnly = True
    TabOrder = 10
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCODCFO: TDBEditFocus [12]
    Tag = 99
    Left = 183
    Top = 160
    Width = 343
    Height = 22
    CharCase = ecUpperCase
    DataField = 'B06_CODCFO'
    DataSource = dtsTabela
    ReadOnly = True
    TabOrder = 14
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtCST: TEditFocus [13]
    Tag = 99
    Left = 58
    Top = 132
    Width = 52
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 2
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 2
    TipoTexto = ttInteiro
  end
  object btnIncluiCST: TBitBtnLocked [14]
    Left = 116
    Top = 132
    Width = 29
    Height = 22
    Caption = '+'
    TabOrder = 8
    OnClick = btnIncluiCSTClick
  end
  object btnRemoveCST: TBitBtnLocked [15]
    Left = 148
    Top = 132
    Width = 29
    Height = 22
    Caption = '-'
    TabOrder = 9
    OnClick = btnRemoveCSTClick
  end
  object edtCFOP: TEditFocus [16]
    Tag = 99
    Left = 58
    Top = 160
    Width = 52
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 4
    TabOrder = 11
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 4
    TipoTexto = ttInteiro
  end
  object btnIncluiCFOP: TBitBtnLocked [17]
    Left = 116
    Top = 160
    Width = 29
    Height = 22
    Caption = '+'
    TabOrder = 12
    OnClick = btnIncluiCFOPClick
  end
  object btnRemoveCFOP: TBitBtnLocked [18]
    Left = 148
    Top = 160
    Width = 29
    Height = 22
    Caption = '-'
    TabOrder = 13
    OnClick = btnRemoveCFOPClick
  end
  object edtDtaIni: TMaskEditFocus [19]
    Tag = 99
    Left = 58
    Top = 76
    Width = 65
    Height = 22
    CharCase = ecUpperCase
    Enabled = False
    EditMask = '99/99/9999;1;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 5
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object edtDtaFin: TMaskEditFocus [20]
    Tag = 99
    Left = 58
    Top = 104
    Width = 65
    Height = 22
    CharCase = ecUpperCase
    Enabled = False
    EditMask = '99/99/9999;1;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 6
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 352
    Top = 0
  end
  object dtsTabela: TDataSource
    Left = 240
  end
end
