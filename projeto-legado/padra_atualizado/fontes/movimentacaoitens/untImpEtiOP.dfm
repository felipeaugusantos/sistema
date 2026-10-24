inherited frmImpEtiOP: TfrmImpEtiOP
  Width = 216
  Height = 160
  Caption = 'Etiquetas Ordem Produ'#231#227'o'
  ExplicitWidth = 216
  ExplicitHeight = 160
  PixelsPerInch = 96
  TextHeight = 14
  object Label3: TLabel [0]
    Left = 33
    Top = 22
    Width = 50
    Height = 14
    Alignment = taRightJustify
    Caption = 'N'#186' Ordem:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel [1]
    Left = 13
    Top = 47
    Width = 70
    Height = 14
    Alignment = taRightJustify
    Caption = 'Qtd. Etiquetas:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 87
    Width = 210
    TabOrder = 2
    ExplicitTop = 87
    ExplicitWidth = 210
    inherited btnSair: TBitBtnLocked
      Left = 127
      ExplicitLeft = 127
    end
  end
  inherited pnlStatus: TPanel
    Top = 115
    Width = 210
    TabOrder = 3
    ExplicitTop = 115
    ExplicitWidth = 210
    inherited pnlNomeForm: TPanel
      Left = 39
      ExplicitLeft = 39
    end
    inherited pnlInfo: TPanel
      Width = 39
      ExplicitWidth = 39
    end
  end
  object edtOrdPro: TEditFocus [5]
    Tag = 99
    Left = 84
    Top = 18
    Width = 115
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtOrdProKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 6
    TipoTexto = ttInteiro
  end
  object edtQtd: TEditFocus [6]
    Left = 84
    Top = 44
    Width = 45
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
  end
end
