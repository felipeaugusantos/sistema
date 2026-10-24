inherited frmApuracaoLucroRealLalurLacsAlterar: TfrmApuracaoLucroRealLalurLacsAlterar
  Width = 657
  Height = 231
  Caption = 'Alterar/Incluir Apura'#231#227'o Lucro Real'
  OnDestroy = FormDestroy
  ExplicitWidth = 657
  ExplicitHeight = 231
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 160
    Width = 651
    TabOrder = 5
    ExplicitTop = 145
    ExplicitWidth = 341
    inherited FlwBotoes: TFlowPanel
      Width = 647
      ExplicitWidth = 337
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 571
      ExplicitLeft = 261
    end
  end
  inherited pnlStatus: TPanel
    Top = 186
    Width = 651
    TabOrder = 6
    ExplicitTop = 171
    ExplicitWidth = 341
    inherited pnlNomeForm: TPanel
      Left = 480
      ExplicitLeft = 170
    end
    inherited pnlInfo: TPanel
      Width = 480
      ExplicitWidth = 170
    end
  end
  object cxLabel1: TcxLabel [2]
    Left = 153
    Top = 37
    Caption = 'Exercicio:'
  end
  object cxLabel2: TcxLabel [3]
    Left = 8
    Top = 96
    Caption = 'Resultado Antes da Contribui'#231#227'o Social:'
  end
  object cxLabel3: TcxLabel [4]
    Left = 33
    Top = 126
    Caption = 'Contribui'#231#227'o Social Antes do LAIR:'
  end
  object edtExercicio: TEditFocus [5]
    Left = 208
    Top = 38
    Width = 121
    Height = 23
    Alignment = taLeftJustify
    MaxLength = 4
    TabOrder = 1
    OnChange = edtExercicioChange
    OnExit = edtExercicioExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttInteiro
  end
  object edtResultadoAntesCS: TCurrencyEditFocus [6]
    Left = 208
    Top = 95
    Enabled = False
    Properties.DisplayFormat = ' ,0.00;- ,0.00'
    StyleFocused.Color = clInfoBk
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    Width = 121
  end
  object edtContribuicaoAntesLAIR: TCurrencyEditFocus [7]
    Left = 208
    Top = 125
    Properties.DisplayFormat = ' ,0.00;- ,0.00'
    StyleFocused.Color = clInfoBk
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    Width = 121
  end
  object edtPeriodo: TcxComboBox [8]
    Left = 208
    Top = 66
    Properties.DropDownListStyle = lsEditFixedList
    Properties.OnChange = edtPeriodoPropertiesChange
    TabOrder = 2
    Width = 121
  end
  object cxLabel4: TcxLabel [9]
    Left = 161
    Top = 70
    Caption = 'Periodo:'
  end
  object cxLabel5: TcxLabel [10]
    Left = 153
    Top = 11
    Caption = 'Empresa:'
  end
  object edtEmpSel: TEditFocus [11]
    Tag = 99
    Left = 209
    Top = 10
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 0
    OnKeyPress = edtEmpSelKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmpSel: TEditFocus [12]
    Left = 269
    Top = 10
    Width = 372
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 12
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
end
