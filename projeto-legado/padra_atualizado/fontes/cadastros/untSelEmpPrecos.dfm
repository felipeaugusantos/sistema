inherited frmSelEmpPrecos: TfrmSelEmpPrecos
  Width = 454
  Height = 457
  Caption = 'Selecionas as Empresas para replica'#231#227'o dos pre'#231'os'
  ExplicitWidth = 454
  ExplicitHeight = 457
  PixelsPerInch = 96
  TextHeight = 14
  object lbl1: TLabel [0]
    Left = 10
    Top = 21
    Width = 80
    Height = 14
    Caption = 'Empresa origem:'
  end
  object lbl2: TLabel [1]
    Left = 7
    Top = 44
    Width = 83
    Height = 14
    Caption = 'Empresa destino:'
  end
  object Label1: TLabel [2]
    Left = 111
    Top = 80
    Width = 203
    Height = 14
    Caption = 'Selecione os valores que ser'#227'o copiados:'
  end
  inherited pnlBotoes: TPanel
    Top = 384
    Width = 448
    TabOrder = 3
    ExplicitTop = 76
    ExplicitWidth = 448
    inherited FlwBotoes: TFlowPanel
      Width = 444
      TabOrder = 2
      ExplicitWidth = 444
    end
    inherited btnSair: TBitBtnLocked
      Left = 365
      ExplicitLeft = 365
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
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 412
    Width = 448
    TabOrder = 4
    ExplicitTop = 104
    ExplicitWidth = 448
    inherited pnlNomeForm: TPanel
      Left = 277
      ExplicitLeft = 277
    end
    inherited pnlInfo: TPanel
      Width = 277
      ExplicitWidth = 277
    end
  end
  object edtEmpOri: TEditFocus [5]
    Tag = 99
    Left = 92
    Top = 17
    Width = 45
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 0
    OnExit = edtEmpOriExit
    OnKeyPress = edtEmpOriKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomOri: TEditFocus [6]
    Left = 138
    Top = 17
    Width = 297
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 5
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtEmpDes: TEditFocus [7]
    Tag = 99
    Left = 92
    Top = 40
    Width = 45
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 1
    OnExit = edtEmpDesExit
    OnKeyPress = edtEmpDesKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomDes: TEditFocus [8]
    Left = 138
    Top = 40
    Width = 297
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  object cklCampos: TCheckListBox [9]
    Left = 111
    Top = 94
    Width = 203
    Height = 280
    ItemHeight = 14
    TabOrder = 2
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 336
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 352
    Top = 32
  end
end
