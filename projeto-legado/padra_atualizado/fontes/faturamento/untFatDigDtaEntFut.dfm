inherited frmFatDigDtaEntFut: TfrmFatDigDtaEntFut
  Width = 464
  Height = 233
  Caption = 'Altera'#231#227'o do Motivo da Entrega Futura'
  ExplicitWidth = 464
  ExplicitHeight = 233
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 162
    Width = 458
    TabOrder = 3
    ExplicitTop = 162
    ExplicitWidth = 458
    inherited FlwBotoes: TFlowPanel
      Width = 377
      ExplicitTop = 2
      ExplicitWidth = 377
    end
    inherited btnSair: TBitBtnLocked
      Left = 379
      Top = 2
      Align = alRight
      ExplicitLeft = 379
      ExplicitTop = 2
    end
  end
  object pnlMotivo: TPanel [2]
    Left = 0
    Top = 0
    Width = 458
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object lblMotEntFut: TLabel
      Left = 30
      Top = 23
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo:'
    end
    object lblDatEntFut: TLabel
      Left = 194
      Top = 23
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Entrega:'
    end
    object lblCliBus: TLabel
      Left = 309
      Top = 23
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente vai retirar?'
    end
    object cmbMotEntFut: TComboBoxFocus
      Tag = 99
      Left = 66
      Top = 15
      Width = 120
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnChange = cmbMotEntFutChange
      Items.Strings = (
        'Falta Produto'
        'Aguardando Cliente'
        'Previs'#227'o de Entrega')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object mskDtaEntFut: TMaskEditFocus
      Tag = 99
      Left = 237
      Top = 15
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      OnExit = mskDtaEntFutExit
      OnKeyPress = mskDtaEntFutKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object cmbCliBus: TComboBoxFocus
      Tag = 99
      Left = 398
      Top = 15
      Width = 48
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      OnChange = cmbCliBusChange
      Items.Strings = (
        'N'#195'O'
        'SIM')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  object pnlParticiona: TPanel [3]
    Left = 0
    Top = 48
    Width = 458
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object lblQtdIte: TLabel
      Left = 6
      Top = 17
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
      Enabled = False
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 66
      Top = 10
      Width = 120
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      OnExit = edtQtdIteExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object rdgQtdItens: TRadioGroup
      Left = 237
      Top = 2
      Width = 209
      Height = 37
      Caption = 'Replicar para'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        #218'nico item'
        'Todos os itens')
      TabOrder = 1
      OnClick = rdgQtdItensClick
    end
  end
  object pnlAviso: TPanel [4]
    Left = 0
    Top = 94
    Width = 458
    Height = 68
    Align = alClient
    BevelOuter = bvNone
    Color = clInfoBk
    Enabled = False
    ParentBackground = False
    TabOrder = 2
    ExplicitHeight = 66
    object mmoAviso: TMemo
      Left = 0
      Top = 0
      Width = 458
      Height = 68
      Align = alClient
      Color = clInfoBk
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Lines.Strings = (
        'Todos os itens com entrega futura pendentes, '
        'deste documento, cujo motivo seja "Previs'#227'o" '
        'ser'#227'o atualizados com a data acima.')
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      StyleElements = []
      ExplicitHeight = 66
    end
  end
  inherited pnlStatus: TPanel
    Top = 188
    Width = 458
    TabOrder = 4
    ExplicitTop = 188
    ExplicitWidth = 458
    inherited pnlNomeForm: TPanel
      Left = 287
      ExplicitLeft = 287
    end
    inherited pnlInfo: TPanel
      Width = 287
      ExplicitWidth = 287
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 136
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 104
    Top = 144
  end
end
