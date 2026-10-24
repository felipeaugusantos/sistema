inherited frmCadRecursosProjeto: TfrmCadRecursosProjeto
  Width = 592
  Height = 229
  Caption = 'Recursos de Projeto'
  ExplicitWidth = 592
  ExplicitHeight = 229
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 156
    Width = 586
    ExplicitTop = 156
    ExplicitWidth = 586
    inherited FlwBotoes: TFlowPanel
      Width = 582
      ExplicitTop = 2
      ExplicitWidth = 582
      inherited btnIncluir: TBitBtnLocked
        Width = 82
        ExplicitWidth = 82
      end
      inherited btnGravar: TBitBtnLocked
        Left = 82
        Width = 82
        ExplicitLeft = 82
        ExplicitWidth = 82
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 164
        Width = 82
        ExplicitLeft = 164
        ExplicitWidth = 82
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 246
        Width = 82
        ExplicitLeft = 246
        ExplicitWidth = 82
      end
      inherited btnCancela: TBitBtnLocked
        Left = 328
        Width = 82
        ExplicitLeft = 328
        ExplicitWidth = 82
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 410
        Width = 82
        ExplicitLeft = 410
        ExplicitWidth = 82
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 494
      Width = 80
      Height = 20
      ExplicitLeft = 494
      ExplicitWidth = 80
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 586
    Height = 156
    Visible = False
    ExplicitWidth = 586
    ExplicitHeight = 156
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 578
      ExplicitHeight = 124
    end
  end
  inherited pnlStatus: TPanel
    Top = 184
    Width = 586
    ExplicitTop = 184
    ExplicitWidth = 586
    inherited pnlNomeForm: TPanel
      Left = 399
      Width = 187
      ExplicitLeft = 399
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 399
      ExplicitWidth = 399
    end
  end
  object pnlGeral: TPanel [4]
    Left = 0
    Top = 0
    Width = 586
    Height = 156
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object pnlTopGeral: TPanel
      Left = 0
      Top = 0
      Width = 586
      Height = 80
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label2: TLabel
        Left = 56
        Top = 38
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label1: TLabel
        Left = 50
        Top = 15
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label17: TLabel
        Left = 19
        Top = 62
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo Recurso:'
      end
      object ColorLabel2: TColorLabel
        Left = 116
        Top = 62
        Width = 180
        Height = 14
        Caption = '(C)olaborador (F)erramenta (V)e'#237'culo'
        CorDestaque = clRed
      end
      object dbeCodRep: TDBEditFocus
        Tag = 99
        Left = 88
        Top = 11
        Width = 87
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REP_CODREP'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeNomRep: TDBEditFocus
        Tag = 99
        Left = 88
        Top = 34
        Width = 403
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REP_NOMREP'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTipRep: TDBEditFocus
        Tag = 99
        Left = 88
        Top = 57
        Width = 22
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REP_TIPREP'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        OnExit = dbeTipRepExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
    end
    object pnlTopGeral2: TPanel
      Left = 0
      Top = 80
      Width = 586
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object Label4: TLabel
        Left = 27
        Top = 27
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Custo:'
      end
      object ColorLabel1: TColorLabel
        Left = 116
        Top = 5
        Width = 95
        Height = 14
        Caption = '(H)ora (K)m (D)i'#225'ria'
        CorDestaque = clRed
      end
      object Label3: TLabel
        Left = 19
        Top = 4
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo Controle:'
      end
      object ColorLabel3: TColorLabel
        Left = 279
        Top = 27
        Width = 75
        Height = 14
        Caption = '(A)tivo (I)nativo'
        CorDestaque = clRed
      end
      object Label5: TLabel
        Left = 203
        Top = 28
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Situa'#231#227'o:'
      end
      object dbeTipCap: TDBEditFocus
        Tag = 99
        Left = 88
        Top = 0
        Width = 22
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REP_TIPCAP'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object dbeValCus: TDBEditFocus
        Tag = 99
        Left = 88
        Top = 24
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REP_VALCUS'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSituac: TDBEditFocus
        Tag = 99
        Left = 251
        Top = 24
        Width = 22
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REP_SITUAC'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
    end
    object pnlTopCliente: TPanel
      Left = 0
      Top = 128
      Width = 586
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
      Visible = False
      object lblCndPag: TLabel
        Left = 34
        Top = 3
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador: '
      end
      object dbeCodOpe: TDBEditFocus
        Tag = 99
        Left = 88
        Top = 0
        Width = 48
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REP_CODOPE'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeCodOpeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtNomOpe: TEditFocus
        Left = 137
        Top = 0
        Width = 239
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 528
    Top = 16
  end
  object dtsTabela: TDataSource
    Left = 408
    Top = 16
  end
end
