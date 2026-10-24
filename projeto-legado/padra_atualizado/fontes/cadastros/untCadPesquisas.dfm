inherited frmCadPesquisas: TfrmCadPesquisas
  Left = 343
  Top = 216
  Width = 715
  Height = 402
  Caption = 'Cadastro de Pesquisas de Mercado'
  ExplicitWidth = 715
  ExplicitHeight = 402
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 332
    Width = 709
    Height = 25
    TabOrder = 3
    ExplicitTop = 332
    ExplicitWidth = 709
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 629
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 629
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 69
        ExplicitWidth = 69
      end
      inherited btnGravar: TBitBtnLocked
        Left = 69
        Width = 69
        ExplicitLeft = 69
        ExplicitWidth = 69
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 138
        Width = 69
        ExplicitLeft = 138
        ExplicitWidth = 69
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 207
        Width = 69
        ExplicitLeft = 207
        ExplicitWidth = 69
      end
      inherited btnCancela: TBitBtnLocked
        Left = 276
        Width = 69
        ExplicitLeft = 276
        ExplicitWidth = 69
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 345
        Width = 74
        ExplicitLeft = 345
        ExplicitWidth = 74
      end
      object btnMoveCima: TBitBtnLocked
        Left = 419
        Top = 0
        Width = 95
        Height = 20
        Caption = 'Move Item p/ Cima'
        TabOrder = 6
        OnClick = btnMoveCimaClick
      end
      object btnMoveBaixo: TBitBtnLocked
        Left = 514
        Top = 0
        Width = 100
        Height = 20
        Caption = 'Move Item p/ Baixo'
        TabOrder = 7
        OnClick = btnMoveBaixoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 631
      Width = 76
      Height = 21
      Align = alRight
      ExplicitLeft = 631
      ExplicitWidth = 76
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 709
    Height = 332
    TabOrder = 0
    ExplicitWidth = 709
    ExplicitHeight = 332
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 701
      ExplicitHeight = 300
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 709
    Height = 332
    Align = alClient
    ParentColor = True
    TabOrder = 1
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 707
      Height = 79
      Align = alTop
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      object lbl3: TLabel
        Left = 31
        Top = 22
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object lbl2: TLabel
        Left = 15
        Top = 44
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object Label67: TLabel
        Left = 213
        Top = 22
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ativo:'
      end
      object ColorLabel4: TColorLabel
        Left = 308
        Top = 21
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object dbeCodPes: TDBEditFocus
        Tag = 99
        Left = 69
        Top = 18
        Width = 64
        Height = 22
        CharCase = ecUpperCase
        DataField = 'PES_CODPES'
        DataSource = dtsTabela
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDesPes: TDBEditFocus
        Tag = 99
        Left = 69
        Top = 41
        Width = 560
        Height = 22
        AutoSize = False
        CharCase = ecUpperCase
        DataField = 'PES_DESPES'
        DataSource = dtsTabela
        MaxLength = 40
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeAtivo: TDBEditFocus
        Tag = 99
        Left = 243
        Top = 18
        Width = 63
        Height = 22
        CharCase = ecUpperCase
        DataField = 'PES_ATIVO_'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
    end
    object pnlPerguntas: TPanel
      Left = 1
      Top = 80
      Width = 707
      Height = 251
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      object lblSitPro: TLabel
        Left = 15
        Top = 21
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Perguntas:'
      end
      object cxgPesPer: TcxGrid
        Left = 1
        Top = 57
        Width = 705
        Height = 193
        Align = alBottom
        TabOrder = 2
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgPesPerDBTableView1: TcxGridDBTableView
          OnKeyDown = cxgPesPerDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsPerRes
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxsWhite
          Styles.ContentOdd = cxsGreen
          object cxgPesPerDBTableView1Column1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'PER_CODPER'
            Options.Sorting = False
            Width = 60
          end
          object cxgPesPerDBTableView1Column2: TcxGridDBColumn
            Caption = 'Pergunta'
            DataBinding.FieldName = 'PER_DESPER'
            Options.Sorting = False
            Width = 566
          end
        end
        object cxgPesPerLevel1: TcxGridLevel
          GridView = cxgPesPerDBTableView1
        end
      end
      object edtDesPer: TEditFocus
        Left = 133
        Top = 18
        Width = 496
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
      object edtCodPer: TEditFocus
        Tag = 99
        Left = 69
        Top = 18
        Width = 63
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
        MaxLength = 5
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodPerKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 357
    Width = 709
    TabOrder = 2
    ExplicitTop = 357
    ExplicitWidth = 709
    inherited pnlNomeForm: TPanel
      Left = 531
      Width = 178
      TabOrder = 1
      ExplicitLeft = 531
      ExplicitWidth = 178
    end
    inherited pnlInfo: TPanel
      Width = 531
      TabOrder = 0
      ExplicitWidth = 531
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 80
    Top = 256
  end
  object dtsPerRes: TDataSource
    DataSet = cdsPesPer
    Left = 80
    Top = 288
  end
  object cdsPesPer: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtpIndFin'
    AfterOpen = cdsPesPerAfterOpen
    AfterClose = cdsPesPerAfterClose
    AfterScroll = cdsPesPerAfterScroll
    Left = 16
    Top = 288
  end
  object dspPesPer: TUniDataSetProvider
    Options = []
    Left = 48
    Top = 288
  end
  object dtsTabela: TDataSource
    Left = 112
    Top = 288
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 16
    Top = 256
    PixelsPerInch = 96
    object cxsWhite: TcxStyle
      AssignedValues = [svColor]
      Color = clWhite
    end
    object cxsGreen: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
