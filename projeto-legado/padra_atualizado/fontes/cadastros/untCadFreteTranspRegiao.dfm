inherited frmCadFreteTranspRegiao: TfrmCadFreteTranspRegiao
  Width = 535
  Height = 375
  Caption = 'Cadastro de frete por transportadora / regi'#227'o'
  ExplicitWidth = 535
  ExplicitHeight = 375
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 285
    Width = 529
    Height = 45
    ExplicitTop = 277
    ExplicitWidth = 529
    ExplicitHeight = 45
    inherited FlwBotoes: TFlowPanel
      Width = 525
      Height = 41
      ExplicitTop = 2
      ExplicitWidth = 525
      ExplicitHeight = 41
      inherited btnIncluir: TBitBtnLocked
        Width = 71
        ExplicitWidth = 71
      end
      inherited btnGravar: TBitBtnLocked
        Left = 71
        Width = 71
        ExplicitLeft = 71
        ExplicitWidth = 71
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 142
        Width = 71
        ExplicitLeft = 142
        ExplicitWidth = 71
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 213
        Width = 71
        ExplicitLeft = 213
        ExplicitWidth = 71
      end
      inherited btnCancela: TBitBtnLocked
        Left = 284
        Width = 70
        ExplicitLeft = 284
        ExplicitWidth = 70
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 354
        Width = 160
        ExplicitLeft = 354
        ExplicitWidth = 160
      end
      object btnCadRapTra: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 220
        Height = 20
        Caption = 'Cadastro R'#225'pido por Transportadora'
        TabOrder = 6
        OnClick = btnCadRapTraClick
      end
      object btnCadRapReg: TBitBtnLocked
        Left = 220
        Top = 20
        Width = 220
        Height = 20
        Caption = 'Cadastro R'#225'pido por Regi'#227'o'
        TabOrder = 7
        OnClick = btnCadRapRegClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 441
      Top = 22
      Width = 75
      Height = 20
      ExplicitLeft = 441
      ExplicitTop = 22
      ExplicitWidth = 75
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 330
    Width = 529
    ExplicitTop = 322
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 358
      Width = 171
      ExplicitLeft = 358
      ExplicitWidth = 171
    end
    inherited pnlInfo: TPanel
      Width = 358
      ExplicitWidth = 358
    end
  end
  inherited pgcDados: TPageControl
    Width = 529
    Height = 285
    ExplicitWidth = 529
    ExplicitHeight = 277
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 521
      ExplicitHeight = 245
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 285
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 277
    object pnlTransp: TPanel
      Left = 1
      Top = 1
      Width = 527
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label31: TLabel
        Left = 65
        Top = 8
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Transportadora:'
      end
      object Label7: TLabel
        Left = 107
        Top = 31
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Regi'#227'o:'
      end
      object dbeCodTra: TDBEditFocus
        Tag = 99
        Left = 145
        Top = 4
        Width = 50
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRE_CODTRA'
        DataSource = dtsTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnKeyPress = dbeCodTraKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object edtNomTra: TEditFocus
        Left = 195
        Top = 4
        Width = 324
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
      object dbeCodReg: TDBEditFocus
        Tag = 99
        Left = 145
        Top = 27
        Width = 50
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRE_CODREG'
        DataSource = dtsTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        OnKeyPress = dbeCodRegKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
      end
      object edtRegiao: TEditFocus
        Left = 195
        Top = 27
        Width = 324
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlTomador: TPanel
      Left = 1
      Top = 50
      Width = 527
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label37: TLabel
        Left = 50
        Top = 5
        Width = 93
        Height = 14
        Alignment = taRightJustify
        Caption = 'Frete por Conta do:'
      end
      object ColorLabel1: TColorLabel
        Left = 185
        Top = 5
        Width = 116
        Height = 14
        Caption = '(E)mitente (D)estinat'#225'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object dbeTomado: TDBEditFocus
        Tag = 99
        Left = 145
        Top = 1
        Width = 35
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRE_TOMADO'
        DataSource = dtsTraReg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlValores: TPanel
      Left = 1
      Top = 73
      Width = 527
      Height = 211
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitLeft = -1
      ExplicitTop = 88
      ExplicitWidth = 529
      object Label1: TLabel
        Left = 10
        Top = 9
        Width = 133
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor da nota para isen'#231#227'o:'
      end
      object dbeValIse: TDBEditFocus
        Tag = 99
        Left = 145
        Top = 1
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRE_VALISE'
        DataSource = dtsTraReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object gpbCalculoFrete: TGroupBox
        Left = 10
        Top = 25
        Width = 271
        Height = 184
        Caption = 'C'#225'lculo do frete'
        TabOrder = 1
        object Label2: TLabel
          Left = 64
          Top = 20
          Width = 104
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor m'#237'nimo do frete:'
        end
        object Label3: TLabel
          Left = 17
          Top = 43
          Width = 151
          Height = 14
          Alignment = taRightJustify
          Caption = 'Percentual sobre valor da nota:'
        end
        object Label4: TLabel
          Left = 101
          Top = 66
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor por Kilo:'
        end
        object Label5: TLabel
          Left = 14
          Top = 89
          Width = 154
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor do ped'#225'gio a cada 100Kg:'
        end
        object Label6: TLabel
          Left = 63
          Top = 135
          Width = 105
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor m'#237'nimo do GRIS:'
        end
        object Label8: TLabel
          Left = 72
          Top = 112
          Width = 96
          Height = 14
          Alignment = taRightJustify
          Caption = 'Percentual do GRIS:'
        end
        object Label9: TLabel
          Left = 102
          Top = 158
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor da TAS:'
        end
        object dbeMinFre: TDBEditFocus
          Tag = 99
          Left = 172
          Top = 16
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRE_MINFRE'
          DataSource = dtsTraReg
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object dbePerTot: TDBEditFocus
          Tag = 99
          Left = 172
          Top = 39
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRE_PERTOT'
          DataSource = dtsTraReg
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object dbeValKil: TDBEditFocus
          Tag = 99
          Left = 172
          Top = 62
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRE_VALKIL'
          DataSource = dtsTraReg
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object dbePd100K: TDBEditFocus
          Tag = 99
          Left = 172
          Top = 85
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRE_PD100K'
          DataSource = dtsTraReg
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object dbeMinGri: TDBEditFocus
          Tag = 99
          Left = 172
          Top = 131
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRE_MINGRI'
          DataSource = dtsTraReg
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object dbePerGri: TDBEditFocus
          Tag = 99
          Left = 172
          Top = 108
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRE_PERGRI'
          DataSource = dtsTraReg
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object dbeValTas: TDBEditFocus
          Tag = 99
          Left = 172
          Top = 154
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRE_VALTAS'
          DataSource = dtsTraReg
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 380
    Top = 68
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 348
    Top = 68
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 348
    Top = 172
  end
  object dtsTraReg: TDataSource
    Left = 416
    Top = 112
  end
end
