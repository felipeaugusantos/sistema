inherited frmTabQtd: TfrmTabQtd
  Width = 424
  Height = 81
  VertScrollBar.Visible = False
  BorderIcons = []
  Caption = ''
  ExplicitWidth = 424
  ExplicitHeight = 81
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 52
    Width = 418
    Height = 0
    Visible = False
    ExplicitTop = 52
    ExplicitWidth = 418
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 414
      ExplicitTop = 2
      ExplicitWidth = 414
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 31
      Top = -25
      ExplicitLeft = 31
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 52
    Width = 418
    Height = 0
    Visible = False
    ExplicitTop = 52
    ExplicitWidth = 418
    ExplicitHeight = 0
    inherited pnlNomeForm: TPanel
      Left = 247
      Height = 0
      ExplicitLeft = 247
      ExplicitHeight = 0
    end
    inherited pnlInfo: TPanel
      Width = 247
      Height = 0
      ExplicitWidth = 247
      ExplicitHeight = 0
    end
  end
  object pnlQuantidade: TPanel [3]
    Left = 0
    Top = 0
    Width = 124
    Height = 52
    Align = alLeft
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblQuantidade: TLabel
      Left = 3
      Top = 2
      Width = 79
      Height = 17
      Caption = 'Quantidade:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtQtde: TEditFocus
      Tag = 99
      Left = 3
      Top = 22
      Width = 114
      Height = 22
      Alignment = taRightJustify
      BevelOuter = bvRaised
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      Text = '1,000'
      OnKeyPress = edtQtdeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object pnlAmbiente: TPanel [4]
    Left = 124
    Top = 0
    Width = 294
    Height = 52
    Align = alRight
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    Visible = False
    object lblAmbiente: TLabel
      Left = 9
      Top = 2
      Width = 65
      Height = 17
      Caption = 'Ambiente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object cbbAmbiente: TComboBoxFocus
      Tag = 99
      Left = 9
      Top = 22
      Width = 278
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ParentFont = False
      TabOrder = 0
      OnKeyPress = cbbAmbienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 368
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 208
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 320
    Top = 208
  end
end
