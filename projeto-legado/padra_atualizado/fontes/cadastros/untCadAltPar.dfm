inherited frmCadAltPar: TfrmCadAltPar
  Width = 404
  Height = 185
  Caption = 'Altera'#231#227'o de Dados Cadastrais'
  ExplicitWidth = 404
  ExplicitHeight = 185
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 115
    Width = 398
    Height = 25
    ExplicitTop = 115
    ExplicitWidth = 398
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 328
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 328
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        Visible = False
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Width = 73
        Height = 21
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 217
        Width = 73
        Height = 21
        ExplicitLeft = 217
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 0
        Top = 21
        Width = 74
        Height = 21
        ExplicitLeft = 0
        ExplicitTop = 21
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 74
        Top = 21
        Width = 74
        Height = 21
        ExplicitLeft = 74
        ExplicitTop = 21
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 330
      Width = 66
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 330
      ExplicitWidth = 66
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 140
    Width = 398
    ExplicitTop = 140
    ExplicitWidth = 398
    inherited pnlNomeForm: TPanel
      Left = 207
      Width = 191
      ExplicitLeft = 207
      ExplicitWidth = 191
    end
    inherited pnlInfo: TPanel
      Width = 207
      ExplicitWidth = 207
    end
  end
  inherited pgcDados: TPageControl
    Width = 398
    Height = 115
    ExplicitWidth = 398
    ExplicitHeight = 115
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 390
      ExplicitHeight = 83
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 398
    Height = 115
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    DesignSize = (
      398
      115)
    object lbl1: TLabel
      Left = 29
      Top = 12
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Altera'#231#227'o:'
    end
    object lbl3: TLabel
      Left = 24
      Top = 59
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Campo Alterado:'
    end
    object lbl4: TLabel
      Left = 11
      Top = 82
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Conte'#250'do Alterado:'
    end
    object lbl2: TLabel
      Left = 5
      Top = 36
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador Altera'#231#227'o:'
    end
    object dbeDtaAlt: TDBEditFocus
      Tag = 99
      Left = 106
      Top = 10
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ALT_DTAALT'
      DataSource = dtsAltPar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCamAlt: TEditFocus
      Tag = 99
      Left = 106
      Top = 56
      Width = 280
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
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeValAnt: TEditFocus
      Tag = 99
      Left = 106
      Top = 79
      Width = 280
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      OnKeyPress = dbeValAntKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeOpeAlt: TDBEditFocus
      Tag = 99
      Left = 106
      Top = 33
      Width = 51
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ALT_OPEALT'
      DataSource = dtsAltPar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomOpe: TEditFocus
      Left = 158
      Top = 33
      Width = 228
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      Enabled = False
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
    Left = 288
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 104
  end
  object dtsAltPar: TDataSource
    Left = 320
    Top = 104
  end
end
