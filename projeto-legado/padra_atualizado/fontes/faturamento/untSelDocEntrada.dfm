inherited frmSelDocEntrada: TfrmSelDocEntrada
  Height = 182
  Caption = 'Selecionar documento de entrada'
  ExplicitHeight = 182
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 9
    Top = 12
    Width = 111
    Height = 14
    Caption = 'N'#250'mero do documento:'
  end
  object Label2: TLabel [1]
    Left = 79
    Top = 35
    Width = 41
    Height = 14
    Caption = 'Esp'#233'cie:'
  end
  object Label3: TLabel [2]
    Left = 75
    Top = 58
    Width = 45
    Height = 14
    Caption = 'Empresa:'
  end
  object Label4: TLabel [3]
    Left = 92
    Top = 81
    Width = 28
    Height = 14
    Caption = 'S'#233'rie:'
  end
  inherited pnlBotoes: TPanel
    Top = 111
    TabOrder = 5
    ExplicitTop = 111
    inherited FlwBotoes: TFlowPanel
      Width = 402
      ExplicitTop = 2
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Align = alRight
    end
  end
  inherited pnlStatus: TPanel
    Top = 137
    TabOrder = 6
    ExplicitTop = 137
  end
  object edtNumDoc: TEditFocus [7]
    Tag = 99
    Left = 122
    Top = 9
    Width = 121
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 0
    OnKeyPress = edtNumDocKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 12
    TipoTexto = ttInteiro
  end
  object edtEspDoc: TEditFocus [8]
    Tag = 99
    Left = 122
    Top = 32
    Width = 44
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    TabOrder = 1
    Text = 'NF'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 2
    TipoTexto = ttAlfabetico
  end
  object edtEmpDoc: TEditFocus [9]
    Tag = 99
    Left = 122
    Top = 55
    Width = 44
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 2
    OnKeyPress = edtEmpDocKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttInteiro
  end
  object edtSerDoc: TEditFocus [10]
    Tag = 99
    Left = 122
    Top = 78
    Width = 44
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtNomEmp: TEditFocus [11]
    Left = 167
    Top = 55
    Width = 303
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
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
