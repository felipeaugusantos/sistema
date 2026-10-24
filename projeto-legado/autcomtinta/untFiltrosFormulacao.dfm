inherited frmFiltrosFormulacao: TfrmFiltrosFormulacao
  Width = 674
  Height = 209
  Caption = 'Filtros de Consulta Para Formula'#231#227'o de Tinta de M'#225'quina'
  ExplicitWidth = 674
  ExplicitHeight = 209
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 138
    Width = 668
    TabOrder = 1
    ExplicitTop = 138
    ExplicitWidth = 668
    inherited FlwBotoes: TFlowPanel
      Width = 664
      ExplicitWidth = 664
      inherited btnConfirma: TBitBtnLocked
        Width = 89
        Caption = '&Confirmar'
        ExplicitWidth = 89
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 585
      Caption = '&Sair'
      ExplicitLeft = 585
    end
  end
  inherited pnlStatus: TPanel
    Top = 164
    Width = 668
    TabOrder = 2
    ExplicitTop = 164
    ExplicitWidth = 668
    inherited pnlNomeForm: TPanel
      Left = 497
      ExplicitLeft = 497
    end
    inherited pnlInfo: TPanel
      Width = 497
      ExplicitWidth = 497
    end
  end
  object pnlOpcoes: TPanel [2]
    Left = 0
    Top = 128
    Width = 668
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 668
    Height = 128
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label4: TLabel
      Left = 25
      Top = 10
      Width = 84
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Produto:'
    end
    object Label11: TLabel
      Left = 25
      Top = 36
      Width = 84
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDescricao: TLabel
      Left = 25
      Top = 81
      Width = 84
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'N'#176' Documento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDocFat: TLabel
      Left = -1
      Top = 105
      Width = 110
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Documento Faturado:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label1: TLabel
      Left = 25
      Top = 59
      Width = 84
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Entrada:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 115
      Top = 8
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 186
      Top = 8
      Width = 458
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
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 115
      Top = 31
      Width = 70
      Height = 22
      ParentCustomHint = False
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCli: TEditFocus
      Left = 186
      Top = 31
      Width = 458
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 115
      Top = 77
      Width = 102
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtDocFat: TEditFocus
      Tag = 99
      Left = 115
      Top = 100
      Width = 102
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      ParentFont = False
      TabOrder = 6
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 115
      Top = 54
      Width = 70
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 65533
  end
end
