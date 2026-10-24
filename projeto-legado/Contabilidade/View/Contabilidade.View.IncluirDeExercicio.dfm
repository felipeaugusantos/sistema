inherited frmIncluirDeExercicio: TfrmIncluirDeExercicio
  Width = 564
  Height = 143
  Caption = 'Incluir de:'
  ExplicitWidth = 564
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 72
    Width = 558
    TabOrder = 1
    ExplicitTop = 72
    ExplicitWidth = 558
    inherited FlwBotoes: TFlowPanel
      Width = 554
      ExplicitWidth = 554
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 478
      ExplicitLeft = 478
    end
  end
  inherited pnlStatus: TPanel
    Top = 98
    Width = 558
    TabOrder = 2
    ExplicitTop = 98
    ExplicitWidth = 558
    inherited pnlNomeForm: TPanel
      Left = 387
      ExplicitLeft = 387
    end
    inherited pnlInfo: TPanel
      Width = 387
      ExplicitWidth = 387
    end
  end
  object gbExercicio: TcxGroupBox [2]
    Left = 0
    Top = 0
    Align = alClient
    TabOrder = 0
    Height = 72
    Width = 558
    object cbExercicio: TcxComboBox
      Left = 59
      Top = 41
      Properties.DropDownListStyle = lsEditFixedList
      TabOrder = 1
      Width = 248
    end
    object cxLabel8: TcxLabel
      Left = 6
      Top = 45
      Caption = 'Exerc'#237'cio:'
    end
    object cxLabel7: TcxLabel
      Left = 8
      Top = 15
      Caption = 'Empresa:'
    end
    object edtEmpSel: TEditFocus
      Tag = 99
      Left = 59
      Top = 14
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnExit = edtEmpSelExit
      OnKeyPress = edtEmpSelKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpSel: TEditFocus
      Left = 119
      Top = 14
      Width = 421
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 16
  end
end
