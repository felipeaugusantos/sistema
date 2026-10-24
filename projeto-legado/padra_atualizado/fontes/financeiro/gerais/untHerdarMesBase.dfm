inherited frmHerdarMesBase: TfrmHerdarMesBase
  Height = 294
  Caption = 'Herdar M'#234's Base'
  ExplicitHeight = 294
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 223
    Height = 26
    TabOrder = 1
    ExplicitTop = 223
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 89
      Width = 315
      Height = 22
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Align = alRight
    end
    object btnConfirmar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 87
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
      ExplicitLeft = 6
      ExplicitTop = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 249
    TabOrder = 2
    ExplicitTop = 249
  end
  object PanelPrincipal: TPanel [3]
    Left = 0
    Top = 0
    Width = 483
    Height = 223
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 221
    object gpbOrigem: TGroupBox
      Left = 5
      Top = 0
      Width = 469
      Height = 103
      Caption = 'Origem'
      TabOrder = 0
      object labelEmpOrig: TLabel
        Left = 9
        Top = 16
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object labelMesOrig: TLabel
        Left = 9
        Top = 57
        Width = 47
        Height = 14
        Caption = 'M'#234's base'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodEmpOrig: TEditFocus
        Tag = 99
        Left = 9
        Top = 30
        Width = 50
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpOrig: TEditFocus
        Left = 65
        Top = 30
        Width = 395
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskMesOrig: TMaskEditFocus
        Tag = 99
        Left = 10
        Top = 70
        Width = 49
        Height = 22
        EditMask = '!99/9999;1;_'
        MaxLength = 7
        TabOrder = 2
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtTipMovOrig: TEditFocus
        Tag = 99
        Left = 65
        Top = 70
        Width = 28
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 2
        TipoTexto = ttAlfanumerico
      end
    end
    object gpbDestino: TGroupBox
      Left = 5
      Top = 109
      Width = 469
      Height = 103
      Caption = 'Destino'
      TabOrder = 1
      object labelMesDest: TLabel
        Left = 9
        Top = 57
        Width = 47
        Height = 14
        Caption = 'M'#234's base'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object labelEmpDest: TLabel
        Left = 9
        Top = 16
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodEmpDest: TEditFocus
        Tag = 99
        Left = 9
        Top = 30
        Width = 49
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpDest: TEditFocus
        Left = 65
        Top = 30
        Width = 395
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskMesDest: TMaskEditFocus
        Tag = 99
        Left = 10
        Top = 74
        Width = 49
        Height = 22
        EditMask = '!99/9999;1;_'
        MaxLength = 7
        TabOrder = 2
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtTipMovDest: TEditFocus
        Tag = 99
        Left = 65
        Top = 74
        Width = 28
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 2
        TipoTexto = ttAlfanumerico
      end
    end
  end
end
