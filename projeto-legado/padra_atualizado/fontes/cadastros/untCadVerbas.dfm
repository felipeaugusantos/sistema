inherited frmCadVerbas: TfrmCadVerbas
  Left = 318
  Top = 262
  Width = 535
  Height = 247
  Caption = 'Cadastro de Verbas'
  ExplicitWidth = 535
  ExplicitHeight = 247
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 177
    Width = 529
    Height = 25
    ExplicitTop = 173
    ExplicitWidth = 523
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 455
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 449
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Width = 74
        Height = 21
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 362
        Width = 74
        Height = 21
        ExplicitLeft = 362
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 457
      Width = 70
      Height = 21
      Align = alRight
      ExplicitLeft = 451
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 202
    Width = 529
    ExplicitTop = 198
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 342
      Width = 187
      ExplicitLeft = 336
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 342
      ExplicitWidth = 336
    end
  end
  inherited pgcDados: TPageControl
    Width = 529
    Height = 177
    ActivePage = nil
    Visible = False
    ExplicitWidth = 523
    ExplicitHeight = 173
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 515
      ExplicitHeight = 163
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 177
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitWidth = 523
    ExplicitHeight = 173
    object Label1: TLabel
      Left = 50
      Top = 20
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 34
      Top = 43
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 63
      Top = 66
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object ColorLabel1: TColorLabel
      Left = 131
      Top = 66
      Width = 83
      Height = 14
      Caption = '(D)'#233'bito (C)r'#233'dito'
      CorDestaque = clRed
    end
    object dbeCodVer: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 16
      Width = 37
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VER_CODVER'
      DataSource = dtsCadVer
      MaxLength = 3
      TabOrder = 0
      OnExit = dbeCodVerExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDesVer: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 39
      Width = 338
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VER_DESVER'
      DataSource = dtsCadVer
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDebCre: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 62
      Width = 37
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VER_DEBCRE'
      DataSource = dtsCadVer
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 90
      Top = 88
      Width = 338
      Height = 53
      Caption = 'Integra'#231#227'o Citel'
      TabOrder = 5
      object Label4: TLabel
        Left = 7
        Top = 25
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo da Verba:'
      end
      object dbEdtVerTes: TDBEditFocus
        Tag = 99
        Left = 91
        Top = 22
        Width = 149
        Height = 22
        CharCase = ecUpperCase
        DataField = 'VER_CODTES'
        DataSource = dtsCadVer
        MaxLength = 20
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object chkSalBas: TcxDBCheckBox
      Left = 220
      Top = 63
      Caption = 'Sal'#225'rio Base'
      DataBinding.DataField = 'VER_SALBAS'
      DataBinding.DataSource = dtsCadVer
      Enabled = False
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 'S'
      Properties.ValueUnchecked = 'N'
      Style.LookAndFeel.Kind = lfOffice11
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'BLue'
      Style.Shadow = False
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'BLue'
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'BLue'
      StyleHot.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'BLue'
      TabOrder = 4
      OnKeyPress = chkSalBasKeyPress
    end
    object chkStatus: TDBCheckBox
      Left = 368
      Top = 16
      Width = 60
      Height = 17
      Caption = 'Ativado'
      DataField = 'VER_STATUS'
      DataSource = dtsCadVer
      Enabled = False
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object pnlPlanoContas: TPanel
      Left = 1
      Top = 146
      Width = 527
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 6
      ExplicitTop = 142
      ExplicitWidth = 521
      inline fraPlanoDeContas: TfraPlanoDeContasDBEditFocus
        Left = 0
        Top = 0
        Width = 521
        Height = 31
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitWidth = 521
        ExplicitHeight = 31
        inherited lblPlaContas: TLabel
          Left = 4
          Top = 8
          Width = 84
          Height = 14
          ExplicitLeft = 4
          ExplicitTop = 8
          ExplicitWidth = 84
          ExplicitHeight = 14
        end
        inherited dbeCodCta: TDBEditFocus
          Left = 89
          Top = 4
          Height = 22
          DataField = 'VER_CODCTA'
          DataSource = dtsCadVer
          OnExit = fraPlanoDeContasdbeCodCtaExit
          OnKeyPress = fraPlanoDeContasdbeCodCtaKeyPress
          ExplicitLeft = 89
          ExplicitTop = 4
          ExplicitHeight = 22
        end
        inherited edtDesCta: TEditFocus
          Left = 145
          Top = 4
          Width = 184
          Height = 22
          ExplicitLeft = 145
          ExplicitTop = 4
          ExplicitWidth = 184
          ExplicitHeight = 22
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 520
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 472
    Top = 48
  end
  object dtsCadVer: TDataSource
    Left = 440
    Top = 8
  end
end
