inherited frmIntegracaoReinf: TfrmIntegracaoReinf
  Width = 1117
  Height = 689
  BorderStyle = bsSizeable
  Caption = 'Integra'#231#227'o REINF'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnPaint = nil
  OnShortCut = nil
  ExplicitWidth = 1117
  ExplicitHeight = 689
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 608
    Width = 1101
    TabOrder = 3
    ExplicitTop = 608
    ExplicitWidth = 1101
    inherited FlwBotoes: TFlowPanel
      Width = 1020
      ExplicitWidth = 1020
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1022
      Top = 2
      Align = alRight
      ExplicitLeft = 1022
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 634
    Width = 1101
    TabOrder = 4
    ExplicitTop = 634
    ExplicitWidth = 1101
    inherited pnlNomeForm: TPanel
      Left = 930
      ExplicitLeft = 930
    end
    inherited pnlInfo: TPanel
      Width = 930
      ExplicitWidth = 930
    end
  end
  object pnlSuperior: TPanel [2]
    Left = 0
    Top = 0
    Width = 1101
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblEmpresa: TLabel
      Left = 10
      Top = 14
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lblAmbiente: TLabel
      Left = 946
      Top = 0
      Width = 155
      Height = 41
      Align = alRight
      Alignment = taRightJustify
      Caption = 'AMBIENTE: HOMOLOGA'#199#195'O     '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 14
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 57
      Top = 11
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnChange = edtCodEmpChange
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 122
      Top = 11
      Width = 683
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object rdgEventos: TRadioGroup [3]
    Left = 0
    Top = 41
    Width = 227
    Height = 567
    Align = alLeft
    Caption = 'Selecione o evento'
    ItemIndex = 0
    Items.Strings = (
      'R-1000 Informa'#231#245'es do Contribuinte'
      
        'R-2010 Reten'#231#227'o de Contribui'#231#227'o Previdenci'#225'ria de Servi'#231'os Tomad' +
        'os'
      
        'R-2020 Reten'#231#227'o de Contribui'#231#227'o Previdenci'#225'ria de Servi'#231'os Prest' +
        'ados'
      'R-2099/R-2098 Fechamento/Reabertura dos Eventos da S'#233'rie R-2000'
      'R-4010 Pagamentos/Cr'#233'ditos a Benefici'#225'rio Pessoa F'#237'sica'
      'R-4020 Pagamentos/Cr'#233'ditos a Benefici'#225'rio Pessoa Jur'#237'dica'
      'R-4080 Reten'#231#227'o no Recebimento'
      'R-4099 Fechamento/Reabertura dos Eventos da S'#233'rie R-4000')
    TabOrder = 1
    WordWrap = True
    OnClick = rdgEventosClick
  end
  object pnlEventos: TPanel [4]
    Left = 227
    Top = 41
    Width = 874
    Height = 567
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1040
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 992
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 986
    Top = 152
  end
end
