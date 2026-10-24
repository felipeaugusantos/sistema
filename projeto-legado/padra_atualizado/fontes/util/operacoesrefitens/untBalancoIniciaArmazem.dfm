inherited frmBalancoIniciaArmazem: TfrmBalancoIniciaArmazem
  Width = 515
  Height = 121
  Caption = 'Inicializa'#231#227'o de Balan'#231'o por armaz'#233'm'
  OnClose = FormClose
  ExplicitWidth = 515
  ExplicitHeight = 121
  PixelsPerInch = 96
  TextHeight = 14
  object Label8: TLabel [0]
    Left = 14
    Top = 16
    Width = 49
    Height = 14
    Alignment = taRightJustify
    Caption = 'Armaz'#233'm:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 48
    Width = 509
    TabOrder = 1
    ExplicitTop = 49
    ExplicitWidth = 509
    inherited FlwBotoes: TFlowPanel
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 426
      ExplicitLeft = 426
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
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
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 76
    Width = 509
    TabOrder = 2
    ExplicitTop = 77
    ExplicitWidth = 509
    inherited pnlNomeForm: TPanel
      Left = 338
      ExplicitLeft = 338
    end
    inherited pnlInfo: TPanel
      Width = 338
      ExplicitWidth = 338
    end
  end
  object edtCodAmz: TEditFocus [4]
    Tag = 99
    Left = 67
    Top = 13
    Width = 52
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    ParentFont = False
    TabOrder = 0
    OnExit = edtCodAmzExit
    OnKeyPress = edtCodAmzKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtDesAmz: TEditFocus [5]
    Left = 120
    Top = 13
    Width = 373
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  inherited mnuAuxiliar: TPopupMenu
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 488
    Top = 72
  end
end
