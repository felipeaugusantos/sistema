inherited frmCadUnidades: TfrmCadUnidades
  Left = 305
  Top = 336
  Width = 624
  Height = 253
  Caption = 'Cadastro de Unidades'
  ExplicitWidth = 624
  ExplicitHeight = 253
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 183
    Width = 618
    Height = 25
    TabOrder = 1
    ExplicitTop = 153
    ExplicitWidth = 618
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 537
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 537
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        ExplicitLeft = 75
        ExplicitWidth = 75
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        ExplicitLeft = 150
        ExplicitWidth = 75
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        ExplicitLeft = 225
        ExplicitWidth = 75
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        ExplicitLeft = 300
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        ExplicitLeft = 375
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 539
      Height = 21
      Align = alRight
      ExplicitLeft = 539
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 618
    Height = 183
    Visible = False
    ExplicitWidth = 618
    ExplicitHeight = 153
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 610
      ExplicitHeight = 121
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 618
    Height = 183
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitLeft = -8
    ExplicitTop = -4
    ExplicitHeight = 192
    object Label1: TLabel
      Left = 51
      Top = 16
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 35
      Top = 38
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 391
      Top = 39
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso / Litro:'
    end
    object Label4: TLabel
      Left = 9
      Top = 61
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item Fracionado:'
    end
    object ColorLabel1: TColorLabel
      Left = 123
      Top = 61
      Width = 58
      Height = 14
      Caption = '(S)im (N)'#227'o '
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 296
      Top = 61
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sigla:'
    end
    object lblDesRed: TLabel
      Left = 3
      Top = 109
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descr. Reduzida:'
    end
    object lblDesEti: TLabel
      Left = 12
      Top = 130
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descr. Etiqueta:'
    end
    object Label6: TLabel
      Left = 398
      Top = 61
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Kilo / Litro:'
    end
    object ColorLabel2: TColorLabel
      Left = 489
      Top = 61
      Width = 57
      Height = 14
      Caption = '(K)ilo (L)itro'
      CorDestaque = clRed
    end
    object dbePesLit: TDBEditFocus
      Tag = 99
      Left = 451
      Top = 33
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'UNI_PESLIT'
      DataSource = dtsCadUni
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 9
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'UNI_CODUNI'
      DataSource = dtsCadUni
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesUni: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 32
      Width = 288
      Height = 22
      CharCase = ecUpperCase
      DataField = 'UNI_DESUNI'
      DataSource = dtsCadUni
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeIteFra: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 55
      Width = 30
      Height = 22
      CharCase = ecUpperCase
      DataField = 'UNI_ITEFRA'
      DataSource = dtsCadUni
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSigUni: TDBEditFocus
      Tag = 99
      Left = 328
      Top = 55
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'UNI_SIGUNI'
      DataSource = dtsCadUni
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object chkMetFat: TDBCheckBox
      Left = 91
      Top = 80
      Width = 231
      Height = 17
      Caption = 'Permite informar metragem no faturamento'
      DataField = 'UNI_METFAT'
      DataSource = dtsCadUni
      TabOrder = 6
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbeDesRed: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 103
      Width = 448
      Height = 22
      DataField = 'UNI_DREUNI'
      DataSource = dtsCadUni
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesEti: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 126
      Width = 448
      Height = 22
      DataField = 'UNI_DETUNI'
      DataSource = dtsCadUni
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeKilLit: TDBEditFocus
      Tag = 99
      Left = 451
      Top = 55
      Width = 36
      Height = 22
      CharCase = ecUpperCase
      DataField = 'UNI_KILLIT'
      DataSource = dtsCadUni
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object chkPeApBe: TDBCheckBox
      Left = 328
      Top = 80
      Width = 231
      Height = 17
      Caption = 'Permite Aparelhamento / Beneficiamento'
      DataField = 'UNI_PEAPBE'
      DataSource = dtsCadUni
      TabOrder = 7
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object pnlUniMedGS1: TPanel
      Left = 2
      Top = 155
      Width = 614
      Height = 26
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 10
      ExplicitTop = 154
      object lblUniGs1: TLabel
        Left = 7
        Top = 5
        Width = 160
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo unidade de medida - GS1:'
      end
      object dbeCodUniGs1: TDBEditFocus
        Tag = 99
        Left = 170
        Top = 2
        Width = 30
        Height = 22
        CharCase = ecUpperCase
        DataField = 'UNI_CODUNG'
        DataSource = dtsCadUni
        TabOrder = 0
        OnKeyPress = dbeCodUniGs1KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtDesUniGs1: TEditFocus
        Left = 200
        Top = 2
        Width = 254
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
  end
  inherited pnlStatus: TPanel
    Top = 208
    Width = 618
    TabOrder = 3
    ExplicitTop = 178
    ExplicitWidth = 618
    inherited pnlNomeForm: TPanel
      Left = 450
      Width = 168
      ExplicitLeft = 450
      ExplicitWidth = 168
    end
    inherited pnlInfo: TPanel
      Width = 450
      ExplicitWidth = 450
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
    Top = 176
  end
  object dtsCadUni: TDataSource
    Left = 448
    Top = 176
  end
end
