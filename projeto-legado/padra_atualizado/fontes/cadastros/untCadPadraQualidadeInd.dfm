inherited frmCadPadraQualidade: TfrmCadPadraQualidade
  Width = 568
  Height = 405
  Hint = 'frmCadAnalise'
  Caption = 'Cadastro de especifica'#231#245'es para qualidade'
  OnDestroy = FormDestroy
  ExplicitWidth = 568
  ExplicitHeight = 405
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 9
    Top = 9
    Width = 84
    Height = 14
    Caption = 'Produto Estrutura'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 69
    Width = 68
    Height = 14
    Caption = 'Especifica'#231#227'o'
  end
  object Label3: TLabel [2]
    Left = 336
    Top = 69
    Width = 49
    Height = 14
    Caption = 'Par'#226'metro'
  end
  object Bevel1: TBevel [3]
    Left = 0
    Top = 56
    Width = 562
    Height = 8
    Shape = bsTopLine
  end
  inherited pnlBotoes: TPanel
    Top = 335
    Width = 562
    Height = 25
    TabOrder = 3
    ExplicitTop = 335
    ExplicitWidth = 562
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 558
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 558
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 79
        ExplicitWidth = 79
      end
      inherited btnGravar: TBitBtnLocked
        Left = 79
        Width = 79
        ExplicitLeft = 79
        ExplicitWidth = 79
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 158
        Width = 79
        ExplicitLeft = 158
        ExplicitWidth = 79
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 237
        Width = 79
        ExplicitLeft = 237
        ExplicitWidth = 79
      end
      inherited btnCancela: TBitBtnLocked
        Left = 316
        Width = 79
        ExplicitLeft = 316
        ExplicitWidth = 79
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 395
        Width = 79
        ExplicitLeft = 395
        ExplicitWidth = 79
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 476
      Width = 76
      Height = 20
      ExplicitLeft = 476
      ExplicitWidth = 76
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 9999
    Top = 88
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 6
    ExplicitLeft = 9999
    ExplicitTop = 88
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  inherited pnlStatus: TPanel
    Top = 360
    Width = 562
    TabOrder = 4
    ExplicitTop = 360
    ExplicitWidth = 562
    inherited pnlNomeForm: TPanel
      Left = 368
      Width = 194
      ExplicitLeft = 368
      ExplicitWidth = 194
    end
    inherited pnlInfo: TPanel
      Width = 368
      ExplicitWidth = 368
    end
  end
  object edtProdutos: TEditFocus [8]
    Tag = 99
    Left = 9
    Top = 25
    Width = 51
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 5
    TabOrder = 0
    OnKeyPress = edtProdutosKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtDesProduto: TEditFocus [9]
    Left = 61
    Top = 25
    Width = 488
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
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
  object dbgDados: TDBGridCitel [10]
    Left = 8
    Top = 116
    Width = 540
    Height = 211
    TabStop = False
    BorderStyle = bsNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 8
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDblClick = dbgDadosDblClick
    OnKeyDown = dbgDadosKeyDown
    CorZebra = clMoneyGreen
    Zebra = True
    DestacarMouse = True
    Columns = <
      item
        Expanded = False
        FieldName = 'GMT_ESPECI'
        Title.Caption = 'Especifica'#231#227'o'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GMT_PARAME'
        Title.Caption = 'Par'#226'metro'
        Width = 200
        Visible = True
      end>
  end
  object edtEspeci: TEditFocus [11]
    Tag = 99
    Left = 8
    Top = 88
    Width = 313
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtParame: TEditFocus [12]
    Tag = 99
    Left = 336
    Top = 88
    Width = 212
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object dbeAutoincrem: TDBEditFocus [13]
    Left = 800
    Top = 57
    Width = 121
    Height = 22
    DataField = 'AUTOINCREM'
    TabOrder = 9
    Visible = False
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 56
  end
end
