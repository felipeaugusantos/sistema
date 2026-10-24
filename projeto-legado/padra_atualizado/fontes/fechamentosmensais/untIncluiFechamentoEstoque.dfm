inherited frmIncluiFechamentoEstoque: TfrmIncluiFechamentoEstoque
  Width = 649
  Height = 171
  Caption = 'Incluir novo fechamento de estoque'
  ExplicitWidth = 649
  ExplicitHeight = 171
  PixelsPerInch = 96
  TextHeight = 14
  object Label62: TLabel [0]
    Left = 153
    Top = 22
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  object Label1: TLabel [1]
    Left = 52
    Top = 50
    Width = 148
    Height = 14
    Caption = #218'ltimo fechamento de estoque:'
  end
  object Label2: TLabel [2]
    Left = 16
    Top = 72
    Width = 184
    Height = 14
    Caption = 'Data do novo fechamento de estoque:'
  end
  inherited pnlBotoes: TPanel
    Top = 98
    Width = 643
    TabOrder = 4
    ExplicitTop = 98
    ExplicitWidth = 643
    inherited btnSair: TBitBtnLocked
      Left = 563
      ExplicitLeft = 563
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 126
    Width = 643
    TabOrder = 5
    ExplicitTop = 126
    ExplicitWidth = 643
    inherited pnlNomeForm: TPanel
      Left = 472
      ExplicitLeft = 472
    end
    inherited pnlInfo: TPanel
      Width = 472
      ExplicitWidth = 472
    end
  end
  object edtCodEmp: TEditFocus [6]
    Tag = 99
    Left = 202
    Top = 18
    Width = 53
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 0
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmp: TEditFocus [7]
    Left = 256
    Top = 18
    Width = 367
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskUltFec: TMaskEditFocus [8]
    Tag = 99
    Left = 202
    Top = 41
    Width = 53
    Height = 22
    TabStop = False
    Color = 16768952
    EditMask = '99/9999'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Text = '  /    '
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object mskNovFec: TMaskEditFocus [9]
    Tag = 99
    Left = 202
    Top = 64
    Width = 53
    Height = 22
    EditMask = '99/9999'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ParentFont = False
    TabOrder = 3
    Text = '  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 528
    Top = 160
  end
end
