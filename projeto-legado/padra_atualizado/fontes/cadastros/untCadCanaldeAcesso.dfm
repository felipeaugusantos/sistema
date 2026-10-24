inherited frmCadCanaldeAcesso: TfrmCadCanaldeAcesso
  Width = 544
  Height = 192
  Caption = 'Cadastro de Canais de Acesso'
  OnDestroy = FormDestroy
  ExplicitWidth = 544
  ExplicitHeight = 192
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl [0]
    Width = 538
    Height = 122
    ActivePage = nil
    ExplicitWidth = 538
    ExplicitHeight = 93
    inherited tbsGeral: TTabSheet
      Caption = ''
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 530
      ExplicitHeight = 112
    end
  end
  object pnDados: TPanel [1]
    Left = 0
    Top = 0
    Width = 538
    Height = 122
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 93
    object Label2: TLabel
      Left = 32
      Top = 14
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object Label3: TLabel
      Left = 16
      Top = 38
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label34: TLabel
      Left = 16
      Top = 65
      Width = 218
      Height = 14
      Cursor = crHandPoint
      Alignment = taRightJustify
      Caption = 'Cor de identifica'#231#227'o na Libera'#231#227'o de Pedidos'
      FocusControl = dbeCorFun
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label34Click
    end
    object dbeCodCac: TDBEditFocus
      Left = 70
      Top = 10
      Width = 51
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CAC_CODCAC'
      DataSource = dtsCadCac
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNomCac: TDBEditFocus
      Tag = 99
      Left = 70
      Top = 34
      Width = 443
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CAC_NOMCAC'
      DataSource = dtsCadCac
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCorFun: TDBEditFocus
      Tag = 50
      Left = 240
      Top = 62
      Width = 31
      Height = 22
      DataField = 'CAC_CORILP'
      DataSource = dtsCadCac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlCategoriaContele: TPanel
      Left = 2
      Top = 89
      Width = 534
      Height = 31
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      Visible = False
      ExplicitTop = 85
      object lblIdCatContele: TLabel
        Left = 14
        Top = 7
        Width = 100
        Height = 14
        Caption = 'ID Categoria Contele:'
      end
      object btnCatContele: TBitBtnLocked
        Left = 210
        Top = 1
        Width = 117
        Height = 25
        Caption = 'Relacionar Categoria'
        TabOrder = 0
        OnClick = btnCatConteleClick
      end
      object dbeIdCatContele: TDBEditFocus
        Left = 117
        Top = 3
        Width = 89
        Height = 22
        Color = 16768952
        DataField = 'CAC_IDCONT'
        DataSource = dtsCadCac
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 147
    Width = 538
    ExplicitTop = 118
    ExplicitWidth = 538
    inherited pnlNomeForm: TPanel
      Left = 191
      ExplicitLeft = 191
    end
    inherited pnlInfo: TPanel
      Width = 191
      ExplicitWidth = 191
    end
  end
  inherited pnlBotoes: TPanel [3]
    Top = 122
    Width = 538
    Height = 25
    ExplicitTop = 93
    ExplicitWidth = 538
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 459
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 459
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
      Left = 461
      Width = 75
      Height = 21
      Align = alRight
      ExplicitLeft = 461
      ExplicitWidth = 75
      ExplicitHeight = 21
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 8
  end
  object dtsCadCac: TDataSource
    Left = 472
    Top = 8
  end
  object cldCores: TColorDialog
    Left = 312
    Top = 3
  end
end
