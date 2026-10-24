inherited frmCadAcessorioLocacao: TfrmCadAcessorioLocacao
  Width = 773
  Height = 494
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Cadastro de Acess'#243'rios para Loca'#231#227'o'
  ExplicitWidth = 773
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 421
    Width = 767
    ExplicitTop = 421
    ExplicitWidth = 767
    inherited FlwBotoes: TFlowPanel
      Width = 763
      ExplicitTop = 2
      ExplicitWidth = 763
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Height = 22
        Caption = 'Pesquisar'
        ExplicitHeight = 22
      end
      object btnHeranca: TBitBtnLocked
        Left = 432
        Top = 0
        Width = 99
        Height = 22
        Caption = '&Heran'#231'a de itens'
        Enabled = False
        TabOrder = 6
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 681
      ExplicitLeft = 681
    end
  end
  inherited pnlStatus: TPanel
    Top = 449
    Width = 767
    ExplicitTop = 449
    ExplicitWidth = 767
    inherited pnlNomeForm: TPanel
      Left = 420
      ExplicitLeft = 420
    end
    inherited pnlInfo: TPanel
      Width = 420
      ExplicitWidth = 420
    end
  end
  inherited pgcDados: TPageControl
    Width = 767
    Height = 421
    StyleElements = []
    ExplicitWidth = 767
    ExplicitHeight = 421
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 759
      ExplicitHeight = 389
      DesignSize = (
        759
        389)
      object lblCodigo: TLabel
        Left = 81
        Top = 10
        Width = 36
        Height = 14
        Caption = 'C'#243'digo:'
      end
      object lblStatus: TLabel
        Left = 264
        Top = 10
        Width = 45
        Height = 14
        Caption = 'Situa'#231#227'o:'
      end
      object lblDescri: TLabel
        Left = 65
        Top = 34
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object lblDtaAqu: TLabel
        Left = 296
        Top = 58
        Width = 75
        Height = 14
        Caption = 'Data Aquisi'#231#227'o:'
      end
      object lblValAqu: TLabel
        Left = 24
        Top = 58
        Width = 93
        Height = 14
        Caption = 'Valor de Aquisi'#231#227'o:'
      end
      object lblRpUlMn: TLabel
        Left = 6
        Top = 82
        Width = 111
        Height = 14
        Caption = 'Resp. Ult. Manuten'#231#227'o:'
      end
      object lblModelo: TLabel
        Left = 80
        Top = 106
        Width = 37
        Height = 14
        Caption = 'Modelo:'
      end
      object lblCodIte: TLabel
        Left = 77
        Top = 154
        Width = 40
        Height = 14
        Caption = 'Produto:'
      end
      object lblEspecf: TLabel
        Left = 40
        Top = 176
        Width = 77
        Height = 14
        Caption = 'Especifica'#231#245'es:'
      end
      object lblDtUlMn: TLabel
        Left = 506
        Top = 83
        Width = 105
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Data Ult. Manuten'#231#227'o:'
      end
      object lblGarant: TLabel
        Left = 524
        Top = 59
        Width = 87
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Garantia (meses):'
      end
      object lblAnoFab: TLabel
        Left = 516
        Top = 108
        Width = 95
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Ano de Fabrica'#231#227'o:'
      end
      object lblDtaVen: TLabel
        Left = 537
        Top = 131
        Width = 74
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Data de Venda:'
      end
      object Label1: TLabel
        Left = 25
        Top = 130
        Width = 92
        Height = 14
        Caption = 'Localiza'#231#227'o F'#237'sica:'
      end
      object ColorLabel26: TColorLabel
        Left = 340
        Top = 10
        Width = 137
        Height = 14
        Caption = '(A)tivo (I)nativo (B)loqueado'
        CorDestaque = clRed
      end
      object Label7: TLabel
        Left = 49
        Top = 347
        Width = 68
        Height = 14
        Caption = 'Valor Cau'#231#227'o:'
      end
      object lblValorAdicional: TLabel
        Left = 464
        Top = 347
        Width = 144
        Height = 14
        Caption = 'Valor Adicional para Loca'#231#227'o:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 7
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ACL_CODIGO'
        DataSource = dtsCadAcl
        MaxLength = 5
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeStatus: TDBEditFocus
        Tag = 99
        Left = 314
        Top = 7
        Width = 20
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ACL_STATUS'
        DataSource = dtsCadAcl
        MaxLength = 1
        TabOrder = 1
        OnExit = dbeStatusExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 31
        Width = 611
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'ACL_DESCRI'
        DataSource = dtsCadAcl
        MaxLength = 70
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object mskDtaAqu: TMaskEditFocus
        Tag = 99
        Left = 378
        Top = 55
        Width = 118
        Height = 22
        CharCase = ecUpperCase
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 4
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtValAqu: TCurrencyEditFocus
        Tag = 99
        Left = 123
        Top = 55
        StyleFocused.Color = clInfoBk
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 121
      end
      object dbeRpUlMn: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 79
        Width = 373
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'ACL_RPULMN'
        DataSource = dtsCadAcl
        MaxLength = 70
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeModelo: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 103
        Width = 373
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'ACL_MODELO'
        DataSource = dtsCadAcl
        MaxLength = 40
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeLocFis: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 127
        Width = 373
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'ACL_LOCFIS'
        DataSource = dtsCadAcl
        MaxLength = 30
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtDesIte: TEditFocus
        Tag = 50
        Left = 190
        Top = 151
        Width = 544
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 67
        ReadOnly = True
        TabOrder = 13
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mmoEspecf: TMemoFocus
        Left = 123
        Top = 175
        Width = 612
        Height = 166
        Anchors = [akLeft, akTop, akRight, akBottom]
        CharCase = ecUpperCase
        ScrollBars = ssVertical
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object mskDtUlMn: TMaskEditFocus
        Tag = 99
        Left = 616
        Top = 79
        Width = 118
        Height = 22
        Anchors = [akTop, akRight]
        CharCase = ecUpperCase
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 7
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object dbeGarant: TDBEditFocus
        Tag = 99
        Left = 616
        Top = 55
        Width = 118
        Height = 22
        Anchors = [akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'ACL_GARANT'
        DataSource = dtsCadAcl
        MaxLength = 3
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeAnoFab: TDBEditFocus
        Tag = 99
        Left = 616
        Top = 103
        Width = 118
        Height = 22
        Anchors = [akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'ACL_ANOFAB'
        DataSource = dtsCadAcl
        MaxLength = 4
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object mskDtaVen: TMaskEditFocus
        Tag = 99
        Left = 616
        Top = 127
        Width = 118
        Height = 22
        Anchors = [akTop, akRight]
        CharCase = ecUpperCase
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 11
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object DBECODITE: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 151
        Width = 64
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ACL_CODITE'
        DataSource = dtsCadAcl
        MaxLength = 5
        TabOrder = 12
        OnKeyPress = DBECODITEKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtVlrCau: TCurrencyEditFocus
        Tag = 99
        Left = 123
        Top = 343
        StyleFocused.Color = clInfoBk
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 121
      end
      object edtVlrAdc: TCurrencyEditFocus
        Tag = 99
        Left = 614
        Top = 343
        StyleFocused.Color = clInfoBk
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 121
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 616
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 712
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 560
    Top = 8
  end
  object dtsCadAcl: TDataSource
    AutoEdit = False
    Left = 664
    Top = 8
  end
end
