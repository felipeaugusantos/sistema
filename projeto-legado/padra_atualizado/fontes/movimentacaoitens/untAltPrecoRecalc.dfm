inherited frmAltPrecoRecalc: TfrmAltPrecoRecalc
  Width = 533
  Height = 297
  Caption = 'Fornecedores dos Produtos - Geral'
  ExplicitWidth = 533
  ExplicitHeight = 297
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 226
    Width = 527
    ExplicitTop = 172
    ExplicitWidth = 527
    object lblContReg: TLabel [0]
      Left = 120
      Top = 4
      Width = 217
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = '0000000/0000000'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 523
      ExplicitWidth = 523
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 444
      ExplicitLeft = 444
    end
  end
  inherited pnlStatus: TPanel
    Top = 252
    Width = 527
    ExplicitTop = 198
    ExplicitWidth = 527
    inherited pnlNomeForm: TPanel
      Left = 356
      ExplicitLeft = 356
    end
    inherited pnlInfo: TPanel
      Width = 356
      ExplicitWidth = 356
    end
  end
  object pgbProIte: TProgressBar [2]
    Left = 0
    Top = 215
    Width = 527
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 2
    Visible = False
    ExplicitTop = 161
  end
  object pnlTipAlt: TPanel [3]
    Left = 0
    Top = 0
    Width = 527
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    ExplicitTop = -6
    object rdgTipAltGer: TRadioGroup
      Left = 0
      Top = 0
      Width = 527
      Height = 56
      Align = alTop
      Caption = 'Tipo de Altera'#231#227'o'
      ItemIndex = 1
      Items.Strings = (
        'Alterar Pre'#231'o de Venda mantendo a margem'
        'Alterar Margem de Lucro mantendo o pre'#231'o de venda')
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitTop = 12
      ExplicitWidth = 461
    end
  end
  object pnlTabPre: TPanel [4]
    Left = 0
    Top = 57
    Width = 527
    Height = 158
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    ExplicitTop = 74
    ExplicitHeight = 87
    object lbl1: TLabel
      Left = 22
      Top = 100
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela de Pre'#231'o:'
    end
    object lbl2: TLabel
      Left = 12
      Top = 125
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrevia'#231#227'o Fiscal:'
    end
    object chkRecCus: TCheckBox
      Left = 8
      Top = 71
      Width = 265
      Height = 17
      Caption = 'Recalcular / atualizar os custos'
      Checked = True
      State = cbChecked
      TabOrder = 0
      Visible = False
    end
    object edtTabPre: TEditFocus
      Tag = 99
      Left = 106
      Top = 94
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 1
      OnExit = edtTabPreExit
      OnKeyPress = edtTabPreKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtNomTab: TEditFocus
      Left = 171
      Top = 94
      Width = 315
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodAbf: TEditFocus
      Tag = 99
      Left = 106
      Top = 117
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 3
      OnExit = edtCodAbfExit
      OnKeyPress = edtCodAbfKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesAbf: TEditFocus
      Left = 170
      Top = 117
      Width = 316
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
    object rdgTipoCalc: TRadioGroup
      Left = 0
      Top = 0
      Width = 527
      Height = 65
      Align = alTop
      Caption = 'Op'#231#227'o de Recalculo'
      ItemIndex = 0
      Items.Strings = (
        'Todas as tabelas de pre'#231'o'
        'Apenas tabelas com pre'#231'o ativo no cadastro de produto')
      TabOrder = 5
      ExplicitTop = 8
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 8
  end
end
