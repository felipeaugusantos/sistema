inherited frmProdutoAcabadoAlteraDados: TfrmProdutoAcabadoAlteraDados
  Width = 514
  Height = 156
  Caption = 'Alterar dados do produto acabado '
  ExplicitWidth = 514
  ExplicitHeight = 156
  PixelsPerInch = 96
  TextHeight = 14
  object Label6: TLabel [0]
    Left = 46
    Top = 18
    Width = 33
    Height = 14
    Alignment = taRightJustify
    Caption = 'Marca:'
  end
  object Label3: TLabel [1]
    Left = 11
    Top = 46
    Width = 68
    Height = 14
    Alignment = taRightJustify
    Caption = 'Linha / Grupo:'
  end
  inherited pnlBotoes: TPanel
    Top = 84
    Width = 508
    TabOrder = 2
    ExplicitTop = 84
    ExplicitWidth = 508
    inherited btnSair: TBitBtnLocked
      Left = 429
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 429
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Height = 24
      Align = alLeft
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 112
    Width = 508
    TabOrder = 3
    ExplicitTop = 112
    ExplicitWidth = 508
    inherited pnlNomeForm: TPanel
      Left = 337
      ExplicitLeft = 337
    end
    inherited pnlInfo: TPanel
      Width = 337
      ExplicitWidth = 337
    end
  end
  object edtCodMar: TEditFocus [5]
    Tag = 99
    Left = 80
    Top = 14
    Width = 50
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
    MaxLength = 6
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtCodMarKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 6
    TipoTexto = ttInteiro
  end
  object edtDesMar: TEditFocus [6]
    Left = 131
    Top = 14
    Width = 350
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
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
  object edtLinGru: TEditFocus [7]
    Left = 145
    Top = 42
    Width = 336
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
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
  object edtCodGru: TMaskEditFocus [8]
    Tag = 99
    Left = 80
    Top = 42
    Width = 64
    Height = 22
    EditMask = '999.999;0;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ParentFont = False
    TabOrder = 1
    Text = ''
    OnKeyPress = edtCodGruKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 984
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 984
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 984
    Top = 96
  end
end
