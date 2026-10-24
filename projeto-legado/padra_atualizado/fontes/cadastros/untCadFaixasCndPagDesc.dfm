inherited frmCadFaixasCndPagDesc: TfrmCadFaixasCndPagDesc
  Width = 537
  Height = 336
  Caption = 'Cadastro de Faixas de Desconto por Condi'#231#227'o de Pagamento'
  ExplicitWidth = 537
  ExplicitHeight = 336
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 267
    Width = 531
    Height = 25
    ExplicitTop = 267
    ExplicitWidth = 518
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 527
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 514
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      Width = 69
      Height = 20
      ExplicitLeft = 446
      ExplicitWidth = 69
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 531
    Height = 267
    ExplicitWidth = 518
    ExplicitHeight = 267
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 510
      ExplicitHeight = 235
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 531
    Height = 267
    Align = alClient
    ParentColor = True
    TabOrder = 3
    ExplicitWidth = 518
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 529
      Height = 50
      Align = alTop
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      ExplicitWidth = 516
      object Label4: TLabel
        Left = 13
        Top = 20
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cond. Pagamento:'
      end
      object dbeCodCnd: TDBEditFocus
        Tag = 99
        Left = 101
        Top = 16
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FXA_CODCND'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeCodCndKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtDesCnd: TEditFocus
        Left = 177
        Top = 16
        Width = 320
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlFaixas: TPanel
      Left = 1
      Top = 51
      Width = 529
      Height = 215
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      ExplicitWidth = 516
      object Label12: TLabel
        Left = 29
        Top = 19
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = '% Desc. In'#237'cio:'
      end
      object Label1: TLabel
        Left = 197
        Top = 19
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = '% Desc. Fim:'
      end
      object Label2: TLabel
        Left = 357
        Top = 19
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = '% Comiss'#227'o:'
      end
      object edtDesIni: TEditFocus
        Tag = 99
        Left = 101
        Top = 13
        Width = 75
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
        OnExit = edtDesIniExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDesFin: TEditFocus
        Tag = 99
        Left = 261
        Top = 13
        Width = 75
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
        OnExit = edtDesFinExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtPerCom: TEditFocus
        Tag = 99
        Left = 422
        Top = 13
        Width = 75
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
        OnExit = edtPerComExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object cxgFaiDes: TcxGrid
        Left = 1
        Top = 52
        Width = 527
        Height = 162
        Align = alBottom
        TabOrder = 3
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitTop = 50
        ExplicitWidth = 523
        object cxgFaiDesDBTableView1: TcxGridDBTableView
          OnKeyDown = cxgFaiDesDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsFaiDes
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
          object cxgFaiDesDBTableView1Column1: TcxGridDBColumn
            Caption = '% Desconto Inicial'
            DataBinding.FieldName = 'FAI_DESINI'
            Width = 160
          end
          object cxgFaiDesDBTableView1Column2: TcxGridDBColumn
            Caption = '% Desconto Final'
            DataBinding.FieldName = 'FAI_DESFIN'
            Width = 160
          end
          object cxgFaiDesDBTableView1Column3: TcxGridDBColumn
            Caption = '% Comiss'#227'o'
            DataBinding.FieldName = 'FAI_PERCOM'
            Width = 160
          end
        end
        object cxgFaiDesLevel1: TcxGridLevel
          GridView = cxgFaiDesDBTableView1
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 292
    Width = 531
    ExplicitTop = 292
    ExplicitWidth = 518
    inherited pnlNomeForm: TPanel
      Left = 184
      ExplicitLeft = 171
    end
    inherited pnlInfo: TPanel
      Width = 184
      ExplicitWidth = 171
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 156
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 156
  end
  object dtsFaiDes: TDataSource
    DataSet = cdsFaiDes
    Left = 416
    Top = 124
  end
  object cdsFaiDes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtpIndFin'
    Left = 384
    Top = 124
  end
  object dspFaiDes: TUniDataSetProvider
    Options = []
    Left = 352
    Top = 124
  end
  object dtsTabela: TDataSource
    Left = 376
    Top = 8
  end
  object cxStyleRepository: TcxStyleRepository
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
