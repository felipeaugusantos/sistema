inherited frmCadAeroportos: TfrmCadAeroportos
  Width = 535
  Height = 218
  Caption = 'Cadastro de Aeroportos'
  ExplicitWidth = 535
  ExplicitHeight = 218
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 12
    Top = 23
    Width = 36
    Height = 14
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 18
    Top = 51
    Width = 30
    Height = 14
    Caption = 'Nome:'
  end
  object Label3: TLabel [2]
    Left = 12
    Top = 79
    Width = 36
    Height = 14
    Caption = 'Cidade:'
  end
  object Label4: TLabel [3]
    Left = 461
    Top = 79
    Width = 16
    Height = 14
    Caption = 'UF:'
  end
  object Label5: TLabel [4]
    Left = 25
    Top = 107
    Width = 23
    Height = 14
    Caption = 'Pa'#237's:'
  end
  inherited pnlBotoes: TPanel
    Top = 145
    Width = 529
    ExplicitTop = 145
    ExplicitWidth = 529
    inherited FlwBotoes: TFlowPanel
      Width = 525
      ExplicitTop = 2
      ExplicitWidth = 525
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
      Left = 446
      ExplicitLeft = 446
    end
  end
  inherited pnlStatus: TPanel
    Top = 173
    Width = 529
    ExplicitTop = 173
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 364
      Width = 165
      ExplicitLeft = 364
      ExplicitWidth = 165
    end
    inherited pnlInfo: TPanel
      Width = 364
      ExplicitWidth = 364
    end
  end
  inherited pgcDados: TPageControl
    Left = 504
    Top = 218
    Width = 105
    Height = 34
    Align = alNone
    ExplicitLeft = 504
    ExplicitTop = 218
    ExplicitWidth = 105
    ExplicitHeight = 34
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 97
      ExplicitHeight = 2
    end
  end
  object dbeCodAeroporto: TDBEditFocus [8]
    Tag = 99
    Left = 53
    Top = 20
    Width = 76
    Height = 22
    DataField = 'AER_CODAER'
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeDescri: TDBEditFocus [9]
    Tag = 99
    Left = 53
    Top = 48
    Width = 402
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AER_DESCRI'
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCodCid: TDBEditFocus [10]
    Tag = 99
    Left = 53
    Top = 76
    Width = 76
    Height = 22
    DataField = 'AER_CODCID'
    MaxLength = 5
    TabOrder = 5
    OnKeyPress = dbeCodCidKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object edtNomCid: TEditFocus [11]
    Left = 130
    Top = 76
    Width = 325
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ReadOnly = True
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtEstado: TEditFocus [12]
    Left = 481
    Top = 76
    Width = 34
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ReadOnly = True
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtNomPais: TEditFocus [13]
    Left = 130
    Top = 104
    Width = 325
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ReadOnly = True
    TabOrder = 9
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object dbeCodPais: TDBEditFocus [14]
    Tag = 99
    Left = 53
    Top = 104
    Width = 76
    Height = 22
    DataField = 'AER_CODPAI'
    MaxLength = 12
    TabOrder = 8
    OnKeyPress = dbeCodPaisKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 352
    Top = 0
  end
  object dtsTabela: TDataSource
    Left = 248
  end
end
