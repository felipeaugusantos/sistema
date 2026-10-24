inherited frmCadPerguntas: TfrmCadPerguntas
  Width = 520
  Height = 405
  Caption = 'Cadastro de Perguntas (Pesquisa de Mercado)'
  ExplicitWidth = 520
  ExplicitHeight = 405
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 336
    Width = 514
    Height = 24
    ExplicitTop = 336
    ExplicitWidth = 514
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Width = 444
      Height = 20
      ExplicitTop = 2
      ExplicitWidth = 444
      ExplicitHeight = 20
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 71
        ExplicitLeft = 73
        ExplicitWidth = 71
      end
      inherited btnAlterar: TBitBtnLocked
        Width = 68
        ExplicitWidth = 68
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 212
        ExplicitLeft = 212
      end
      inherited btnCancela: TBitBtnLocked
        Left = 284
        Width = 73
        ExplicitLeft = 284
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 357
        Width = 74
        ExplicitLeft = 357
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      Width = 66
      Height = 20
      Align = alRight
      ExplicitLeft = 446
      ExplicitWidth = 66
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 360
    Width = 514
    ExplicitTop = 360
    ExplicitWidth = 514
    inherited pnlNomeForm: TPanel
      Left = 336
      Width = 178
      ExplicitLeft = 336
      ExplicitWidth = 178
    end
    inherited pnlInfo: TPanel
      Width = 336
      ExplicitWidth = 336
    end
  end
  inherited pgcDados: TPageControl
    Width = 514
    Height = 336
    ExplicitWidth = 514
    ExplicitHeight = 336
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 506
      ExplicitHeight = 304
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 514
    Height = 336
    Align = alClient
    ParentColor = True
    TabOrder = 3
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 512
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
        Left = 21
        Top = 45
        Width = 46
        Height = 14
        Caption = 'Pergunta:'
      end
      object Label1: TLabel
        Left = 343
        Top = 22
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data de Cadastro:'
      end
      object dbeCodPer: TDBEditFocus
        Tag = 99
        Left = 69
        Top = 18
        Width = 64
        Height = 22
        CharCase = ecUpperCase
        DataField = 'PER_CODPER'
        DataSource = dtsTabela
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDesPer: TDBEditFocus
        Tag = 99
        Left = 69
        Top = 41
        Width = 427
        Height = 22
        AutoSize = False
        CharCase = ecUpperCase
        DataField = 'PER_DESPER'
        DataSource = dtsTabela
        MaxLength = 255
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDtaCad: TDBEditFocus
        Tag = 99
        Left = 432
        Top = 18
        Width = 64
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'PER_DTACAD'
        DataSource = dtsTabela
        Enabled = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
    end
    object pnlRespostas: TPanel
      Left = 1
      Top = 80
      Width = 512
      Height = 255
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      object lbl1: TLabel
        Left = 18
        Top = 22
        Width = 49
        Height = 14
        Caption = 'Resposta:'
      end
      object cxgPerRes: TcxGrid
        Left = 1
        Top = 61
        Width = 510
        Height = 193
        Align = alBottom
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgPerResDBTableView1: TcxGridDBTableView
          OnKeyDown = cxgPerResDBTableView1KeyDown
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
          object cxgPerResDBTableView1Column1: TcxGridDBColumn
            Caption = 'Op'#231#227'o de Resposta'
            DataBinding.FieldName = 'RES_DESRES'
            Width = 490
          end
        end
        object cxgPerResLevel1: TcxGridLevel
          GridView = cxgPerResDBTableView1
        end
      end
      object edtDesRes: TEditFocus
        Tag = 99
        Left = 69
        Top = 18
        Width = 427
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
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
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
    Left = 32
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 80
    Top = 168
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 32
    Top = 172
  end
  object dtsPerRes: TDataSource
    DataSet = cdsPerRes
    Left = 80
    Top = 216
  end
  object cdsPerRes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtpIndFin'
    Left = 28
    Top = 264
  end
  object dspPerRes: TUniDataSetProvider
    Options = []
    Left = 76
    Top = 264
  end
  object dtsTabela: TDataSource
    Left = 132
    Top = 264
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 184
    Top = 264
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
