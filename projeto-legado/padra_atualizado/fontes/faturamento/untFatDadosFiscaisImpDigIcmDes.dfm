inherited frmFatDadosFiscaisImpDigIcmDes: TfrmFatDadosFiscaisImpDigIcmDes
  Width = 660
  Height = 190
  Caption = 'Dados ICMS Desonerado'
  ExplicitWidth = 660
  ExplicitHeight = 190
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 119
    Width = 654
    TabOrder = 1
    ExplicitTop = 111
    ExplicitWidth = 654
    inherited FlwBotoes: TFlowPanel
      Width = 573
      ExplicitTop = 2
      ExplicitWidth = 650
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 575
      Top = 2
      Align = alRight
      ExplicitLeft = 573
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 654
    Height = 119
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 111
    object lblBase: TLabel
      Left = 149
      Top = 13
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'ICMS Desonerado:'
    end
    object Label15: TLabel
      Left = 35
      Top = 37
      Width = 203
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo de Desonera'#231#227'o para produtos ST:'
    end
    object Label1: TLabel
      Left = 14
      Top = 85
      Width = 224
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo de Desonera'#231#227'o para produtos n'#227'o ST:'
    end
    object ColorLabel2: TColorLabel
      Left = 265
      Top = 13
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Label2: TLabel
      Left = 6
      Top = 61
      Width = 232
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo de Desonera'#231#227'o para produtos CST 020:'
    end
    object cmbMtdIcmST: TComboBoxFocus
      Tag = 99
      Left = 240
      Top = 34
      Width = 401
      Height = 22
      Style = csDropDownList
      Enabled = False
      ItemIndex = 0
      TabOrder = 1
      Items.Strings = (
        ''
        
          '6 - Utilit'#225'rios e Motocicletas da Amaz'#244'nia Ocidental e '#193'reas de ' +
          'Livre Com'#233'rcio (Resolu'#231#227'o 714/88 e 790/94 - CONTRAN e suas alter' +
          'a'#231#245'es)'
        '7 - SUFRAMA'
        '9 - Outros')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbMtdIcmNaoST: TComboBoxFocus
      Tag = 99
      Left = 240
      Top = 82
      Width = 401
      Height = 22
      Style = csDropDownList
      Enabled = False
      ItemIndex = 0
      TabOrder = 3
      Items.Strings = (
        ''
        '1 - T'#225'xi'
        '2 - Deficiente F'#237'sico'
        '3 - Produtor / Agropecu'#225'rio'
        '4 - Frotista / Locadora'
        '5 - Diplom'#225'tico / Consular'
        
          '6 - Utilit'#225'rios e Motocicletas da Amaz'#244'nia Ocidental e '#193'reas de ' +
          'Livre Com'#233'rcio (Resolu'#231#227'o 714/88 e 790/94 - CONTRAN e suas alter' +
          'a'#231#245'es)'
        '7 - SUFRAMA'
        '8 - Venda a '#211'rg'#227'o P'#250'blico'
        '9 - Outros (NT 2011-004)'
        '10 - Deficiente Condutor (Conv'#234'nio ICMS 38/12)'
        '11 - Deficiente N'#227'o Condutor (Conv'#234'nio ICMS 38/12)')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtIcmDes: TEditFocus
      Tag = 99
      Left = 240
      Top = 10
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'N'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object cmbMtdIcm020: TComboBoxFocus
      Tag = 99
      Left = 240
      Top = 58
      Width = 401
      Height = 22
      Style = csDropDownList
      Enabled = False
      TabOrder = 2
      Items.Strings = (
        ''
        '3 - Uso na agropecu'#225'ria'
        '9 - Outros'
        '12 - '#211'rg'#227'o de fomento e desenvolvimento agropecu'#225'rio')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 145
    Width = 654
    TabOrder = 2
    ExplicitTop = 137
    ExplicitWidth = 654
    inherited pnlNomeForm: TPanel
      Left = 561
      Width = 93
      ExplicitLeft = 561
      ExplicitWidth = 93
    end
    inherited pnlInfo: TPanel
      Width = 561
      ExplicitWidth = 561
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 160
    Top = 1
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 56
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 16
    Top = 0
  end
end
