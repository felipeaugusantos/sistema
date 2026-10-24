inherited frmCadTabelaPrecosHeranca: TfrmCadTabelaPrecosHeranca
  Width = 473
  Height = 112
  ActiveControl = edtCodTab
  Caption = 'Heran'#231'a de Tabela de Pre'#231'os'
  ExplicitWidth = 473
  ExplicitHeight = 112
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 6
    Top = 13
    Width = 80
    Height = 14
    Alignment = taRightJustify
    Caption = 'Tabela de Pre'#231'o:'
  end
  inherited pnlBotoes: TPanel
    Top = 40
    Width = 467
    TabOrder = 1
    ExplicitTop = 40
    ExplicitWidth = 467
    inherited btnSair: TBitBtnLocked
      Left = 384
      ExplicitLeft = 384
    end
  end
  inherited pnlStatus: TPanel
    Top = 68
    Width = 467
    TabOrder = 2
    ExplicitTop = 68
    ExplicitWidth = 467
    inherited pnlNomeForm: TPanel
      Left = 296
      ExplicitLeft = 296
    end
    inherited pnlInfo: TPanel
      Width = 296
      ExplicitWidth = 296
    end
  end
  object edtCodTab: TEditFocus [3]
    Tag = 99
    Left = 91
    Top = 8
    Width = 52
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 6
    TabOrder = 0
    OnKeyPress = edtCodTabKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 6
    TipoTexto = ttNumerico
  end
  object edtNomTab: TEditFocus [4]
    Left = 144
    Top = 8
    Width = 313
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 3
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
end
