inherited frmPedePeriodoConEnt: TfrmPedePeriodoConEnt
  Width = 300
  Height = 150
  Caption = 'Gera'#231#227'o de per'#237'odo de entrega'
  ExplicitWidth = 300
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 14
  object lbl1: TLabel [0]
    Left = 6
    Top = 8
    Width = 51
    Height = 14
    Caption = 'Data Inicial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel [1]
    Left = 85
    Top = 8
    Width = 47
    Height = 14
    Caption = 'Data Final'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel [2]
    Left = 168
    Top = 9
    Width = 116
    Height = 14
    Caption = 'Quantidade de entregas'
  end
  inherited pnlBotoes: TPanel
    Top = 79
    Width = 294
    TabOrder = 3
    ExplicitTop = 79
    ExplicitWidth = 294
    inherited FlwBotoes: TFlowPanel
      Width = 213
      ExplicitWidth = 213
    end
    inherited btnSair: TBitBtnLocked
      Left = 215
      Top = 2
      Align = alRight
      ExplicitLeft = 215
      ExplicitTop = 2
    end
  end
  object mskDtaIni: TMaskEditFocus [5]
    Tag = 99
    Left = 6
    Top = 22
    Width = 77
    Height = 22
    EditMask = '99/99/9999;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    ParentFont = False
    TabOrder = 0
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object mskDtaFin: TMaskEditFocus [6]
    Tag = 99
    Left = 85
    Top = 22
    Width = 78
    Height = 22
    EditMask = '99/99/9999;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    ParentFont = False
    TabOrder = 1
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object edtQtdPe1: TEditFocus [7]
    Tag = 99
    Left = 168
    Top = 22
    Width = 115
    Height = 22
    Alignment = taRightJustify
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttInteiro
  end
  object prgProgesso: TProgressBar [8]
    Left = 0
    Top = 63
    Width = 294
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 5
  end
  inherited pnlStatus: TPanel
    Top = 105
    Width = 294
    TabOrder = 4
    ExplicitTop = 105
    ExplicitWidth = 294
    inherited pnlNomeForm: TPanel
      Left = 123
      ExplicitLeft = 123
    end
    inherited pnlInfo: TPanel
      Width = 123
      ExplicitWidth = 123
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 8
    Top = 48
  end
end
