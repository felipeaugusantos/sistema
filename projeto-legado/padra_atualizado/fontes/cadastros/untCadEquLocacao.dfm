inherited frmCadEquLocacao: TfrmCadEquLocacao
  Width = 747
  Height = 539
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Cadastro de Loca'#231#227'o de Equipamentos'
  OnDestroy = FormDestroy
  ExplicitWidth = 747
  ExplicitHeight = 539
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 468
    Width = 741
    Height = 26
    ExplicitTop = 468
    ExplicitWidth = 741
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 660
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 660
      ExplicitHeight = 22
      inherited btnIncluir: TBitBtnLocked
        Width = 85
        Height = 22
        ExplicitWidth = 85
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 85
        Width = 85
        Height = 22
        ExplicitLeft = 85
        ExplicitWidth = 85
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 170
        Width = 85
        Height = 22
        ExplicitLeft = 170
        ExplicitWidth = 85
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 255
        Width = 85
        Height = 22
        ExplicitLeft = 255
        ExplicitWidth = 85
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 340
        Width = 85
        Height = 22
        ExplicitLeft = 340
        ExplicitWidth = 85
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 425
        Width = 85
        Height = 22
        ExplicitLeft = 425
        ExplicitWidth = 85
        ExplicitHeight = 22
      end
      object btnHeranca: TBitBtnLocked
        Left = 510
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
      Left = 662
      Align = alRight
      ExplicitLeft = 662
    end
  end
  inherited pnlStatus: TPanel
    Top = 494
    Width = 741
    ExplicitTop = 494
    ExplicitWidth = 741
    inherited pnlNomeForm: TPanel
      Left = 503
      Width = 238
      ExplicitLeft = 503
      ExplicitWidth = 238
    end
    inherited pnlInfo: TPanel
      Width = 503
      ExplicitWidth = 503
    end
  end
  inherited pgcDados: TPageControl
    Width = 741
    Height = 468
    ActivePage = tsAcessorios
    ExplicitWidth = 741
    ExplicitHeight = 468
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 733
      ExplicitHeight = 436
      object lblCodigo: TLabel
        Left = 85
        Top = 10
        Width = 36
        Height = 14
        Caption = 'C'#243'digo:'
      end
      object lblStatus: TLabel
        Left = 264
        Top = 11
        Width = 45
        Height = 14
        Caption = 'Situa'#231#227'o:'
      end
      object ColorLabel26: TColorLabel
        Left = 339
        Top = 11
        Width = 137
        Height = 14
        Caption = '(A)tivo (I)nativo (B)loqueado'
        CorDestaque = clRed
      end
      object lblDescri: TLabel
        Left = 69
        Top = 35
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object lblNSerie: TLabel
        Left = 73
        Top = 59
        Width = 48
        Height = 14
        Caption = 'Nro S'#233'rie:'
      end
      object lblValAqu: TLabel
        Left = 28
        Top = 84
        Width = 93
        Height = 14
        Caption = 'Valor de Aquisi'#231#227'o:'
      end
      object lblRpUlMn: TLabel
        Left = 10
        Top = 131
        Width = 111
        Height = 14
        Caption = 'Resp. Ult. Manuten'#231#227'o:'
      end
      object lblGarant: TLabel
        Left = 34
        Top = 155
        Width = 87
        Height = 14
        Caption = 'Garantia (meses):'
      end
      object lblModelo: TLabel
        Left = 84
        Top = 180
        Width = 37
        Height = 14
        Caption = 'Modelo:'
      end
      object lblLocFis: TLabel
        Left = 29
        Top = 203
        Width = 92
        Height = 14
        Caption = 'Localiza'#231#227'o F'#237'sica:'
      end
      object lblCodIte: TLabel
        Left = 81
        Top = 228
        Width = 40
        Height = 14
        Caption = 'Produto:'
      end
      object lblEspecf: TLabel
        Left = 44
        Top = 273
        Width = 77
        Height = 14
        Caption = 'Especifica'#231#245'es:'
      end
      object lblDtUlMn: TLabel
        Left = 502
        Top = 84
        Width = 105
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Data Ult. Manuten'#231#227'o:'
      end
      object lblDtaAqu: TLabel
        Left = 282
        Top = 84
        Width = 75
        Height = 14
        Caption = 'Data Aquisi'#231#227'o:'
      end
      object lblValLoc: TLabel
        Left = 0
        Top = 108
        Width = 121
        Height = 14
        Caption = 'Valor de Loca'#231#227'o (hora):'
      end
      object Label1: TLabel
        Left = 260
        Top = 108
        Width = 97
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Valor de Loc. Di'#225'ria:'
      end
      object lblAnoFab: TLabel
        Left = 513
        Top = 155
        Width = 95
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Ano de Fabrica'#231#227'o:'
      end
      object lblDtaVen: TLabel
        Left = 533
        Top = 179
        Width = 74
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Data de Venda:'
      end
      object Label3: TLabel
        Left = 9
        Top = 387
        Width = 112
        Height = 14
        Caption = 'Desc. M'#225'x. Gerente %:'
      end
      object Label4: TLabel
        Left = 250
        Top = 388
        Width = 125
        Height = 14
        Caption = 'Desc.M'#225'x.SubGerente %:'
      end
      object Label2: TLabel
        Left = 544
        Top = 388
        Width = 114
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Desc.M'#225'x.Vendedor %:'
      end
      object Label7: TLabel
        Left = 53
        Top = 412
        Width = 68
        Height = 14
        Caption = 'Valor Cau'#231#227'o:'
      end
      object lblLocacaoMensal: TLabel
        Left = 505
        Top = 108
        Width = 104
        Height = 14
        Anchors = [akTop, akRight]
        Caption = 'Valor de Loc. Mensal:'
      end
      object lblNroPatrimonio: TLabel
        Left = 430
        Top = 60
        Width = 72
        Height = 14
        Caption = 'Nro Patrim'#244'nio:'
      end
      object lblEquipOS: TLabel
        Left = 14
        Top = 252
        Width = 107
        Height = 14
        Caption = 'Equipamento para OS:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 7
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EQL_CODIGO'
        DataSource = dtsCadEqu
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
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 32
        Width = 598
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'EQL_DESCRI'
        DataSource = dtsCadEqu
        MaxLength = 70
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNSerie: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 56
        Width = 150
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EQL_NSERIE'
        DataSource = dtsCadEqu
        MaxLength = 20
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtValAqu: TCurrencyEditFocus
        Tag = 99
        Left = 123
        Top = 80
        StyleFocused.Color = clInfoBk
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 121
      end
      object dbeRpUlMn: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 128
        Width = 598
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'EQL_RPULMN'
        DataSource = dtsCadEqu
        MaxLength = 70
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeGarant: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 152
        Width = 118
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EQL_GARANT'
        DataSource = dtsCadEqu
        MaxLength = 3
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeModelo: TDBEditFocus
        Tag = 99
        Left = 123
        Top = 176
        Width = 366
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'EQL_MODELO'
        DataSource = dtsCadEqu
        MaxLength = 40
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 123
        Top = 224
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 17
        OnKeyPress = edtCodIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesIte: TEditFocus
        Tag = 50
        Left = 191
        Top = 224
        Width = 530
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 67
        ReadOnly = True
        TabOrder = 18
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
        Top = 272
        Width = 598
        Height = 109
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        ScrollBars = ssVertical
        TabOrder = 21
        OnKeyDown = mmoEspecfKeyDown
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object mskDtaAqu: TMaskEditFocus
        Tag = 99
        Left = 360
        Top = 80
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 6
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtValLoc: TCurrencyEditFocus
        Tag = 99
        Left = 123
        Top = 104
        StyleFocused.Color = clInfoBk
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 121
      end
      object mskDtUlMn: TMaskEditFocus
        Tag = 99
        Left = 611
        Top = 80
        Width = 110
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
      object edtVlLocD: TCurrencyEditFocus
        Tag = 99
        Left = 360
        Top = 104
        Anchors = [akTop, akRight]
        StyleFocused.Color = clInfoBk
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 121
      end
      object dbeAnoFab: TDBEditFocus
        Tag = 99
        Left = 611
        Top = 152
        Width = 110
        Height = 22
        Anchors = [akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'EQL_ANOFAB'
        DataSource = dtsCadEqu
        MaxLength = 4
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object mskDtaVen: TMaskEditFocus
        Tag = 99
        Left = 611
        Top = 176
        Width = 110
        Height = 22
        Anchors = [akTop, akRight]
        CharCase = ecUpperCase
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 15
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtDscGer: TEditFocus
        Tag = 99
        Left = 127
        Top = 384
        Width = 58
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 22
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDscSGe: TEditFocus
        Tag = 99
        Left = 381
        Top = 383
        Width = 58
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDscVen: TEditFocus
        Tag = 99
        Left = 663
        Top = 383
        Width = 58
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 24
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object dbeStatus: TDBEditFocus
        Tag = 99
        Left = 315
        Top = 7
        Width = 20
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EQL_STATUS'
        DataSource = dtsCadEqu
        MaxLength = 1
        TabOrder = 1
        OnExit = dbeStatusExit
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
        Top = 200
        Width = 366
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'EQL_LOCFIS'
        DataSource = dtsCadEqu
        MaxLength = 30
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtVlrCau: TCurrencyEditFocus
        Tag = 99
        Left = 123
        Top = 407
        StyleFocused.Color = clInfoBk
        TabOrder = 25
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 121
      end
      object edtVlLocM: TCurrencyEditFocus
        Tag = 99
        Left = 612
        Top = 104
        Anchors = [akTop, akRight]
        StyleFocused.Color = clInfoBk
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 109
      end
      object dbeNroPat: TDBEditFocus
        Tag = 99
        Left = 508
        Top = 56
        Width = 213
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EQL_NUMPAT'
        DataSource = dtsCadEqu
        MaxLength = 20
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtCodEqu: TEditFocus
        Tag = 99
        Left = 123
        Top = 248
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 19
        OnKeyPress = edtCodEquKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesEqu: TEditFocus
        Tag = 50
        Left = 191
        Top = 248
        Width = 530
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 67
        ReadOnly = True
        TabOrder = 20
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object ckSemSerie: TcxCheckBox
        Left = 296
        Top = 56
        Caption = 'N'#227'o possui s'#233'rie'
        TabOrder = 26
        OnClick = ckSemSerieClick
      end
    end
    object tsAcessorios: TTabSheet
      Caption = '2 - Acess'#243'rios do Equipamento'
      ImageIndex = 1
      object pnlLancamentoAcessorio: TPanel
        Left = 0
        Top = 0
        Width = 733
        Height = 65
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          733
          65)
        object Label5: TLabel
          Left = 24
          Top = 12
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acess'#243'rio:'
        end
        object Label6: TLabel
          Left = 19
          Top = 37
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade:'
        end
        object btnCancelaItem: TBitBtnLocked
          Left = 612
          Top = 37
          Width = 104
          Height = 22
          Caption = 'C&ancelar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
            015603015603FF00FF0000820000820000820000820000820000820000820000
            820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
            27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
            30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
            FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
            0082000082000082000082000082000082000082000082000082FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
            00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
            0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
            50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
            5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
            8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 4
          OnClick = btnCancelaItemClick
        end
        object edtQtdAcl: TEditFocus
          Tag = 99
          Left = 83
          Top = 33
          Width = 71
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesAcl: TEditFocus
          Tag = 50
          Left = 156
          Top = 9
          Width = 564
          Height = 22
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 67
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
        object btnAdicionar: TBitBtnLocked
          Left = 502
          Top = 37
          Width = 104
          Height = 22
          Caption = '&Adicionar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
            609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
            D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
            9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
            95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
            8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
            A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
            A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
            E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
            B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
            ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
            E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
            BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
            27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
            EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
            C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
            C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
            8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
            CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
            D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
            FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
            CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
            68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 3
          OnClick = btnAdicionarClick
        end
        object edtCodAcl: TEditFocus
          Tag = 99
          Left = 83
          Top = 9
          Width = 71
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnExit = edtCodAclExit
          OnKeyPress = edtCodAclKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
      end
      object cxgAcessorios: TcxGridCitel
        Tag = 99
        Left = 0
        Top = 65
        Width = 733
        Height = 351
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgAcessoriosDBTableViewCitel1: TcxGridDBTableViewCitel
          OnKeyUp = cxgAcessoriosDBTableViewCitel1KeyUp
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsAcessorios
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgAcessoriosDBTableViewCitel1CODIGO: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODIGO'
            Options.Editing = False
          end
          object cxgAcessoriosDBTableViewCitel1DESCRICAO: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESCRICAO'
            Options.Editing = False
          end
          object cxgAcessoriosDBTableViewCitel1QUANTIDADE: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'QUANTIDADE'
          end
        end
        object cxgAcessoriosLevel1: TcxGridLevel
          GridView = cxgAcessoriosDBTableViewCitel1
        end
      end
      object pnlRodapeEquipamentos: TPanel
        Left = 0
        Top = 416
        Width = 733
        Height = 20
        Align = alBottom
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = ' Pressione DELETE para excluir algum registro do grid'
        ParentColor = True
        TabOrder = 2
      end
    end
    object tsNegociacao: TTabSheet
      Caption = '3 - Negocia'#231#227'o de Di'#225'rias'
      ImageIndex = 2
      object pnlLancamentoNegociacao: TPanel
        Left = 0
        Top = 0
        Width = 733
        Height = 65
        Align = alTop
        TabOrder = 0
        object Label8: TLabel
          Left = 28
          Top = 17
          Width = 97
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade de Dias:'
        end
        object Label9: TLabel
          Left = 72
          Top = 38
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Total:'
        end
        object edtQtdDias: TEditFocus
          Tag = 99
          Left = 131
          Top = 10
          Width = 71
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
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
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0'
        end
        object edtVlrTot: TEditFocus
          Tag = 99
          Left = 131
          Top = 35
          Width = 71
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object btnAdicionarNegociacaoDiaria: TBitBtnLocked
          Left = 502
          Top = 37
          Width = 104
          Height = 22
          Caption = '&Adicionar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
            609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
            D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
            9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
            95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
            8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
            A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
            A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
            E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
            B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
            ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
            E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
            BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
            27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
            EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
            C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
            C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
            8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
            CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
            D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
            FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
            CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
            68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 2
          OnClick = btnAdicionarNegociacaoDiariaClick
        end
        object btnCancelaItemNegociacao: TBitBtnLocked
          Left = 612
          Top = 37
          Width = 104
          Height = 22
          Caption = 'C&ancelar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
            015603015603FF00FF0000820000820000820000820000820000820000820000
            820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
            27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
            30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
            FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
            0082000082000082000082000082000082000082000082000082FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
            00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
            0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
            50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
            5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
            8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 3
          OnClick = btnCancelaItemNegociacaoClick
        end
      end
      object cxGridNegociacaoDiarias: TcxGridCitel
        Tag = 99
        Left = 0
        Top = 65
        Width = 733
        Height = 351
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableViewCitel1: TcxGridDBTableViewCitel
          OnKeyUp = cxGridDBTableViewCitel1KeyUp
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsNegociacaoDiarias
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridDBTableViewCitel1QTDDIA: TcxGridDBColumn
            Caption = 'Quantidade de Dias'
            DataBinding.FieldName = 'QTDDIA'
            Width = 150
          end
          object cxGridDBTableViewCitel1VLRTOT: TcxGridDBColumn
            Caption = 'Valor Total'
            DataBinding.FieldName = 'VLRTOT'
            Width = 178
          end
          object cxGridDBTableViewCitel1VLRDIA: TcxGridDBColumn
            Caption = 'Valor Calculado da Di'#225'ria'
            DataBinding.FieldName = 'VLRDIA'
            Width = 153
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableViewCitel1
        end
      end
      object pnlRodapeNegociacao: TPanel
        Left = 0
        Top = 416
        Width = 733
        Height = 20
        Align = alBottom
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '  Pressione DELETE para excluir algum registro do grid'
        ParentColor = True
        TabOrder = 2
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 691
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 651
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 611
    Top = 8
  end
  object dtsCadEqu: TDataSource
    OnStateChange = dtsCadEquStateChange
    Left = 568
    Top = 8
  end
  object cdsAcessorios: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CODIGO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFloat
      end
      item
        Name = 'EQA_SEQACL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQA_VLRADC'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsAcessoriosBeforePost
    Left = 652
    Top = 129
    object cdsAcessoriosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
    end
    object cdsAcessoriosCODIGO: TStringField
      FieldName = 'CODIGO'
    end
    object cdsAcessoriosQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
      DisplayFormat = '#,##0.00'
    end
    object cdsAcessoriosEQA_SEQACL: TStringField
      FieldName = 'EQA_SEQACL'
    end
    object cdsAcessoriosEQA_VLRADC: TFloatField
      FieldName = 'EQA_VLRADC'
    end
  end
  object dtsAcessorios: TUniDataSource
    DataSet = cdsAcessorios
    Left = 524
    Top = 137
  end
  object dtsNegociacaoDiarias: TUniDataSource
    DataSet = cdsNegociacaoDiarias
    Left = 524
    Top = 201
  end
  object cdsNegociacaoDiarias: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'QTDDIA'
        DataType = ftInteger
      end
      item
        Name = 'VLRTOT'
        DataType = ftFloat
      end
      item
        Name = 'VLRDIA'
        DataType = ftFloat
      end
      item
        Name = 'INDEX'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 652
    Top = 201
    object cdsNegociacaoDiariasQTDDIA: TIntegerField
      FieldName = 'QTDDIA'
    end
    object cdsNegociacaoDiariasVLRTOT: TFloatField
      FieldName = 'VLRTOT'
      DisplayFormat = '#,##0.00'
    end
    object cdsNegociacaoDiariasVLRDIA: TFloatField
      FieldName = 'VLRDIA'
      DisplayFormat = '#,##0.0000'
    end
  end
end
