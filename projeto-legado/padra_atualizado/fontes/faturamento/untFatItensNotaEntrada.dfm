inherited frmFatItensNotaEntrada: TfrmFatItensNotaEntrada
  Width = 453
  Height = 241
  Caption = 'Carrega itens da Nota de Entrada'
  ExplicitWidth = 453
  ExplicitHeight = 241
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 13
    Top = 16
    Width = 57
    Height = 14
    Alignment = taRightJustify
    Caption = 'Documento:'
  end
  object Label4: TLabel [1]
    Left = 359
    Top = 16
    Width = 28
    Height = 14
    Alignment = taRightJustify
    Caption = 'S'#233'rie:'
  end
  object Label6: TLabel [2]
    Left = 208
    Top = 16
    Width = 41
    Height = 14
    Alignment = taRightJustify
    Caption = 'Esp'#233'cie:'
  end
  object lblCliFor: TLabel [3]
    Left = 11
    Top = 39
    Width = 59
    Height = 14
    Alignment = taRightJustify
    Caption = 'Fornecedor:'
  end
  object lblCodEmp: TLabel [4]
    Left = 25
    Top = 63
    Width = 45
    Height = 14
    Caption = 'Empresa:'
  end
  inherited pnlBotoes: TPanel
    Top = 170
    Width = 447
    TabOrder = 7
    ExplicitTop = 170
    ExplicitWidth = 447
    inherited FlwBotoes: TFlowPanel
      Width = 366
      ExplicitTop = 2
      ExplicitWidth = 366
    end
    inherited btnSair: TBitBtnLocked
      Left = 368
      Top = 2
      Align = alRight
      ExplicitLeft = 368
      ExplicitTop = 2
    end
  end
  object edtNumDoc: TEditFocus [7]
    Tag = 99
    Left = 73
    Top = 12
    Width = 81
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 12
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnKeyPress = edtNumDocKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 12
    TipoTexto = ttNumerico
  end
  object edtSerie: TEditFocus [8]
    Tag = 99
    Left = 391
    Top = 12
    Width = 41
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodCliFor: TEditFocus [9]
    Tag = 99
    Left = 73
    Top = 35
    Width = 81
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 8
    TabOrder = 3
    OnKeyPress = edtCodCliForKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttNumerico
  end
  object edtNomCliFor: TEditFocus [10]
    Left = 154
    Top = 35
    Width = 278
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 9
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodEmp: TEditFocus [11]
    Tag = 99
    Left = 73
    Top = 59
    Width = 46
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 4
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmp: TEditFocus [12]
    Left = 119
    Top = 59
    Width = 313
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 10
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object cbxEspDoc: TComboBox [13]
    Tag = 99
    Left = 252
    Top = 12
    Width = 49
    Height = 22
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = 'NF'
    OnChange = cbxEspDocChange
    Items.Strings = (
      'NF'
      'PD'
      'TE')
  end
  inherited pnlStatus: TPanel
    Top = 196
    Width = 447
    TabOrder = 8
    ExplicitTop = 196
    ExplicitWidth = 447
    inherited pnlNomeForm: TPanel
      Left = 276
      ExplicitLeft = 276
    end
    inherited pnlInfo: TPanel
      Width = 276
      ExplicitWidth = 276
    end
  end
  object rdgUtiPre: TRadioGroup [15]
    Left = 8
    Top = 87
    Width = 424
    Height = 70
    Caption = 'Utilizar Pre'#231'o'
    ItemIndex = 0
    Items.Strings = (
      'Pre'#231'o da Nota de Entrada'
      
        'Pre'#231'o Padr'#227'o para TE (Cad. Empresas, aba: configura'#231#227'o de transf' +
        '. de estoque)'
      'Pre'#231'o Padr'#227'o para Faturamento')
    TabOrder = 5
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 144
  end
end
