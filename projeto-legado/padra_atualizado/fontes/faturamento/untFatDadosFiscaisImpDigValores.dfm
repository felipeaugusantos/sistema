inherited frmFatDadosFiscaisImpDigValores: TfrmFatDadosFiscaisImpDigValores
  Width = 203
  Height = 156
  Caption = 'Valor Do Imposto'
  ExplicitWidth = 203
  ExplicitHeight = 156
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 85
    Width = 197
    TabOrder = 1
    ExplicitTop = 85
    ExplicitWidth = 197
    inherited FlwBotoes: TFlowPanel
      Width = 116
      ExplicitWidth = 193
      ExplicitHeight = 22
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 118
      Top = 2
      Align = alRight
      ExplicitLeft = 116
      ExplicitTop = 1
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 197
    Height = 85
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblBase: TLabel
      Left = 54
      Top = 13
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base:'
    end
    object Label15: TLabel
      Left = 40
      Top = 34
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'quota:'
    end
    object Label1: TLabel
      Left = 54
      Top = 56
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object edtBase: TEditFocus
      Tag = 99
      Left = 84
      Top = 6
      Width = 94
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtAlq: TEditFocus
      Tag = 99
      Left = 84
      Top = 28
      Width = 94
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValor: TEditFocus
      Tag = 99
      Left = 84
      Top = 50
      Width = 94
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      Text = '0,00'
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
  inherited pnlStatus: TPanel
    Top = 111
    Width = 197
    TabOrder = 2
    ExplicitTop = 111
    ExplicitWidth = 197
    inherited pnlNomeForm: TPanel
      Left = 104
      Width = 93
      ExplicitLeft = 104
      ExplicitWidth = 93
    end
    inherited pnlInfo: TPanel
      Width = 104
      ExplicitWidth = 104
    end
  end
end
