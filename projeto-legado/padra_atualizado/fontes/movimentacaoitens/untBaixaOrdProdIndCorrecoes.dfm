inherited frmBaixaOrdProdIndCorrecoes: TfrmBaixaOrdProdIndCorrecoes
  Width = 549
  Height = 425
  Caption = 'Corre'#231#227'o da Ordem de Produ'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 549
  ExplicitHeight = 425
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 16
    Top = 16
    Width = 70
    Height = 14
    Caption = 'Sequ'#234'ncia (IT)'
  end
  object Label2: TLabel [1]
    Left = 16
    Top = 58
    Width = 70
    Height = 14
    Caption = 'C'#243'digo do Item'
  end
  object Label3: TLabel [2]
    Left = 15
    Top = 102
    Width = 55
    Height = 14
    Caption = 'Quantidade'
  end
  object Label4: TLabel [3]
    Left = 16
    Top = 142
    Width = 66
    Height = 14
    Caption = 'Observa'#231#245'es'
  end
  object lblNumLot: TLabel [4]
    Left = 98
    Top = 102
    Width = 21
    Height = 14
    Alignment = taRightJustify
    Caption = 'Lote'
  end
  inherited pnlBotoes: TPanel
    Top = 352
    Width = 543
    TabOrder = 6
    ExplicitTop = 352
    ExplicitWidth = 543
    inherited FlwBotoes: TFlowPanel
      Width = 539
      TabOrder = 2
      ExplicitWidth = 539
    end
    inherited btnSair: TBitBtnLocked
      Left = 460
      ExplicitLeft = 460
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 75
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 380
    Width = 543
    TabOrder = 7
    ExplicitTop = 380
    ExplicitWidth = 543
    inherited pnlNomeForm: TPanel
      Left = 372
      ExplicitLeft = 372
    end
    inherited pnlInfo: TPanel
      Width = 372
      ExplicitWidth = 372
    end
  end
  object dbeSequen: TDBEditFocus [7]
    Tag = 99
    Left = 16
    Top = 32
    Width = 73
    Height = 22
    DataField = 'DMT_SEQUEN'
    DataSource = dtsItens
    MaxLength = 2
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCodIte: TDBEditFocus [8]
    Tag = 99
    Left = 16
    Top = 74
    Width = 73
    Height = 22
    DataField = 'DMT_ITESUB'
    DataSource = dtsItens
    MaxLength = 5
    TabOrder = 1
    OnKeyPress = dbeCodIteKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object dbeQtdIte: TDBEditFocus [9]
    Tag = 99
    Left = 16
    Top = 116
    Width = 73
    Height = 22
    DataField = 'DMT_QTDITE'
    DataSource = dtsItens
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeRefere: TDBEditFocus [10]
    Tag = 99
    Left = 90
    Top = 74
    Width = 439
    Height = 22
    TabStop = False
    Color = 16768952
    DataField = 'DMT_REFERE'
    DataSource = dtsItens
    ReadOnly = True
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeObserv: TDBMemoFocus [11]
    Tag = 99
    Left = 16
    Top = 158
    Width = 513
    Height = 177
    DataField = 'DMT_OBSERV'
    DataSource = dtsItens
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  object dbeNumLot: TDBEditFocus [12]
    Tag = 99
    Left = 95
    Top = 116
    Width = 119
    Height = 22
    CharCase = ecUpperCase
    DataField = 'DMT_NUMLOT'
    DataSource = dtsItens
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 30
    TabOrder = 4
    OnKeyPress = dbeNumLotKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 392
    Top = 8
  end
  object dtsItens: TDataSource
    Left = 464
    Top = 16
  end
end
