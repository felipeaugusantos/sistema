inherited frmHerancaCadEqu: TfrmHerancaCadEqu
  Height = 127
  Caption = 'Heran'#231'a de Cadastro de Equipamento de Loca'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitHeight = 127
  PixelsPerInch = 96
  TextHeight = 14
  object lblCodigo: TLabel [0]
    Left = 41
    Top = 24
    Width = 36
    Height = 14
    Caption = 'C'#243'digo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 56
    ExplicitTop = 56
  end
  inherited pnlStatus: TPanel
    Top = 82
    ExplicitTop = 82
  end
  object edtCodEqu: TEditFocus [3]
    Tag = 99
    Left = 83
    Top = 21
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    ParentFont = False
    TabOrder = 2
    OnKeyPress = edtCodEquKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtDesEqu: TEditFocus [4]
    Left = 142
    Top = 21
    Width = 320
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
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
