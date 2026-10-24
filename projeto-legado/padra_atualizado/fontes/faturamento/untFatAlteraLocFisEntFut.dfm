inherited frmAlteraLocFisEntFut: TfrmAlteraLocFisEntFut
  Width = 644
  Height = 216
  Caption = 'Altera'#231#227'o da Loc. F'#237'sica da Entrega Futura'
  ExplicitWidth = 644
  ExplicitHeight = 216
  PixelsPerInch = 96
  TextHeight = 14
  object lbl1: TLabel [0]
    Left = 20
    Top = 3
    Width = 37
    Height = 14
    Caption = 'Produto'
  end
  object Label1: TLabel [1]
    Left = 20
    Top = 41
    Width = 53
    Height = 14
    Caption = 'Refer'#234'ncia'
  end
  object Label2: TLabel [2]
    Left = 564
    Top = 41
    Width = 39
    Height = 14
    Caption = 'Unidade'
  end
  object bvl1: TBevel [3]
    Left = 20
    Top = 80
    Width = 597
    Height = 12
    Shape = bsBottomLine
  end
  object Label152: TLabel [4]
    Left = 22
    Top = 111
    Width = 92
    Height = 14
    Alignment = taRightJustify
    Caption = 'Localiza'#231#227'o F'#237'sica:'
  end
  inherited pnlBotoes: TPanel
    Top = 145
    Width = 638
    ExplicitTop = 145
    ExplicitWidth = 638
    inherited FlwBotoes: TFlowPanel
      Width = 634
      ExplicitWidth = 634
    end
    inherited btnSair: TBitBtnLocked
      Left = 555
      ExplicitLeft = 555
    end
  end
  inherited pnlStatus: TPanel
    Top = 171
    Width = 638
    ExplicitTop = 171
    ExplicitWidth = 638
    inherited pnlNomeForm: TPanel
      Left = 467
      ExplicitLeft = 467
    end
    inherited pnlInfo: TPanel
      Width = 467
      ExplicitWidth = 467
    end
  end
  object edtProduto: TEditFocus [7]
    Left = 20
    Top = 17
    Width = 597
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 2
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtRefere: TEditFocus [8]
    Left = 20
    Top = 56
    Width = 538
    Height = 22
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
  object edtUnidad: TEditFocus [9]
    Left = 564
    Top = 56
    Width = 53
    Height = 22
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
  object edtLocFis: TEditFocus [10]
    Tag = 99
    Left = 120
    Top = 106
    Width = 497
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 30
    TabOrder = 4
    OnKeyPress = edtLocFisKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
end
