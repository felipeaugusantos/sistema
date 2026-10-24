inherited frmCadCaixas: TfrmCadCaixas
  Width = 530
  Height = 201
  Caption = 'Cadastro de Caixas'
  ExplicitWidth = 530
  ExplicitHeight = 201
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 132
    Width = 524
    Height = 24
    ExplicitTop = 132
    ExplicitWidth = 524
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Width = 448
      Height = 20
      ExplicitTop = 2
      ExplicitWidth = 448
      ExplicitHeight = 20
      inherited btnIncluir: TBitBtnLocked
        Spacing = 2
      end
      inherited btnGravar: TBitBtnLocked
        Spacing = 2
      end
      inherited btnAlterar: TBitBtnLocked
        Spacing = 2
      end
      inherited btnExcluir: TBitBtnLocked
        Spacing = 2
      end
      inherited btnCancela: TBitBtnLocked
        Spacing = 2
      end
      inherited btnPesquisa: TBitBtnLocked
        Spacing = 2
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 450
      Width = 72
      Height = 20
      Align = alRight
      Spacing = 2
      ExplicitLeft = 450
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 156
    Width = 524
    ExplicitTop = 156
    ExplicitWidth = 524
    inherited pnlNomeForm: TPanel
      Left = 177
      ExplicitLeft = 177
    end
    inherited pnlInfo: TPanel
      Width = 177
      ExplicitWidth = 177
    end
  end
  inherited pgcDados: TPageControl
    Left = 591
    Top = 248
    Width = 2
    Height = 10
    Align = alNone
    ExplicitLeft = 591
    ExplicitTop = 248
    ExplicitWidth = 2
    ExplicitHeight = 10
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 524
    Height = 132
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 11
      Top = 39
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label37: TLabel
      Left = 17
      Top = 83
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object ColorLabel1: TColorLabel
      Left = 103
      Top = 83
      Width = 75
      Height = 14
      Caption = '(A)tivo (I)nativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label148: TLabel
      Left = 17
      Top = 61
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 36
      Width = 445
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CAX_DESCRI'
      DataSource = dtsCadCax
      MaxLength = 40
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 14
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CAX_CODCAX'
      DataSource = dtsCadCax
      MaxLength = 5
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeStatus: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 80
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CAX_STATUS'
      DataSource = dtsCadCax
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmpresa: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 58
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CAX_CODEMP'
      DataSource = dtsCadCax
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 125
      Top = 58
      Width = 385
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlChavePix: TPanel
      Left = 0
      Top = 102
      Width = 520
      Height = 23
      BevelOuter = bvNone
      TabOrder = 4
      object lblChavePix: TLabel
        Left = 6
        Top = 3
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Chave Pix:'
      end
      object edtChavePix: TEditFocus
        Left = 65
        Top = 0
        Width = 335
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnVincularChavePix: TBitBtnLocked
        Left = 402
        Top = 0
        Width = 108
        Height = 22
        Caption = 'Vincular Chave'
        Enabled = False
        TabOrder = 1
        TabStop = False
        OnClick = btnVincularChavePixClick
      end
    end
    object pnlArmazem: TPanel
      Left = 224
      Top = 80
      Width = 286
      Height = 22
      BevelOuter = bvNone
      TabOrder = 6
      object lblNumLot: TLabel
        Left = 7
        Top = 3
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'd Armaz.:'
      end
      object edtNomArm: TEditFocus
        Left = 118
        Top = 0
        Width = 168
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodArm: TDBEditFocus
        Tag = 99
        Left = 70
        Top = 0
        Width = 48
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAX_CODAMZ'
        DataSource = dtsCadCax
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        OnKeyPress = edtCodArmKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 392
    Top = 8
  end
  object dtsCadCax: TDataSource
    AutoEdit = False
    Left = 208
  end
end
