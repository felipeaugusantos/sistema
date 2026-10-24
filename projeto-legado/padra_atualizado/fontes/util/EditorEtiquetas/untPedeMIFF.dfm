inherited frmPedeMIFF: TfrmPedeMIFF
  Width = 246
  Height = 147
  Caption = 'Dados do documento'
  ExplicitWidth = 246
  ExplicitHeight = 147
  PixelsPerInch = 96
  TextHeight = 14
  object lblNumDoc: TLabel [0]
    Left = 8
    Top = 18
    Width = 33
    Height = 14
    Caption = 'C'#243'digo'
  end
  object lblEspDoc: TLabel [1]
    Left = 172
    Top = 18
    Width = 21
    Height = 14
    Caption = 'Esp.'
  end
  object lblCodEmp: TLabel [2]
    Left = 204
    Top = 18
    Width = 26
    Height = 14
    Caption = 'Empr.'
  end
  object lblSerie: TLabel [3]
    Left = 142
    Top = 18
    Width = 25
    Height = 14
    Caption = 'S'#233'rie'
  end
  inherited pnlBotoes: TPanel
    Top = 74
    Width = 240
    TabOrder = 4
    ExplicitTop = 74
    ExplicitWidth = 240
    inherited FlwBotoes: TFlowPanel
      Left = 77
      Width = 84
      TabOrder = 2
      ExplicitLeft = 77
      ExplicitWidth = 84
    end
    inherited btnSair: TBitBtnLocked
      Left = 161
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 161
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 75
      Height = 24
      Align = alLeft
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
    Top = 102
    Width = 240
    TabOrder = 5
    ExplicitTop = 102
    ExplicitWidth = 240
    inherited pnlNomeForm: TPanel
      Left = 69
      ExplicitLeft = 69
    end
    inherited pnlInfo: TPanel
      Width = 69
      ExplicitWidth = 69
    end
  end
  object edtNumDoc: TEditFocus [6]
    Tag = 99
    Left = 8
    Top = 32
    Width = 133
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 12
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 12
    TipoTexto = ttNumerico
  end
  object edtEspDoc: TEditFocus [7]
    Tag = 99
    Left = 172
    Top = 32
    Width = 30
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ReadOnly = True
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodEmp: TEditFocus [8]
    Left = 203
    Top = 32
    Width = 30
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    ReadOnly = True
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtSerie: TEditFocus [9]
    Tag = 99
    Left = 142
    Top = 32
    Width = 30
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ReadOnly = True
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskDtaCad: TMaskEditFocus [10]
    Tag = 99
    Left = 8
    Top = 32
    Width = 72
    Height = 22
    EditMask = '99/99/9999;1;_'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    ParentFont = False
    TabOrder = 6
    Text = '  /  /    '
    Visible = False
    OnExit = mskDtaCadExit
    OnKeyDown = mskDtaCadKeyDown
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 80
    Top = 72
  end
end
