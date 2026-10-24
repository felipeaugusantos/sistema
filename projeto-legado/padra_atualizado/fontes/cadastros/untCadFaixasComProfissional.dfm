inherited frmCadFaixasComProfissional: TfrmCadFaixasComProfissional
  Width = 538
  Height = 336
  Caption = 'Cadastro de Faixas de Faturamento por Profissional'
  ExplicitWidth = 538
  ExplicitHeight = 336
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 267
    Width = 532
    Height = 25
    TabOrder = 1
    ExplicitTop = 267
    ExplicitWidth = 518
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 528
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 514
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Tag = 88
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
        Tag = 88
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Tag = 88
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
        Tag = 88
        Left = 370
        Width = 74
        Enabled = False
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
    Width = 532
    Height = 267
    TabOrder = 3
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
    Width = 532
    Height = 267
    Align = alClient
    ParentColor = True
    TabOrder = 0
    ExplicitWidth = 518
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 530
      Height = 50
      Align = alTop
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      ExplicitWidth = 516
      object Label4: TLabel
        Left = 41
        Top = 20
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Profissional:'
      end
      object dbeCodDiv: TDBEditFocus
        Tag = 99
        Left = 101
        Top = 16
        Width = 25
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FAI_CODDIV'
        DataSource = dtsTabela
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtNomDiv: TEditFocus
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
      object edtCodDiv: TEditFocus
        Left = 101
        Top = 16
        Width = 75
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
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
      Width = 530
      Height = 215
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      ExplicitWidth = 516
      object Label12: TLabel
        Left = 45
        Top = 19
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor In'#237'cio:'
      end
      object Label1: TLabel
        Left = 213
        Top = 19
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Fim:'
      end
      object Label2: TLabel
        Left = 357
        Top = 19
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = '% Comiss'#227'o:'
      end
      object edtVlrIni: TEditFocus
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
        OnExit = edtVlrIniExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtVlrFin: TEditFocus
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
        OnExit = edtVlrFinExit
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
        Width = 528
        Height = 162
        Align = alBottom
        TabOrder = 3
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitWidth = 514
        object cxgFaiDesDBTableView1: TcxGridDBTableView
          OnKeyDown = cxgFaiDesDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsFaiDiv
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
            Caption = 'Valor Inicial'
            DataBinding.FieldName = 'FAI_VLRINI'
            Width = 160
          end
          object cxgFaiDesDBTableView1Column2: TcxGridDBColumn
            Caption = 'Valor Final'
            DataBinding.FieldName = 'FAI_VLRFIN'
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
    Width = 532
    TabOrder = 2
    ExplicitTop = 292
    ExplicitWidth = 518
    inherited pnlNomeForm: TPanel
      Left = 372
      Width = 160
      ExplicitLeft = 358
      ExplicitWidth = 160
    end
    inherited pnlInfo: TPanel
      Width = 372
      ExplicitWidth = 358
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 264
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 264
  end
  object dtsFaiDiv: TDataSource
    DataSet = cdsFaiDiv
    Left = 280
    Top = 232
  end
  object cdsFaiDiv: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFaiDiv'
    Left = 248
    Top = 232
  end
  object dspFaiDiv: TUniDataSetProvider
    Options = []
    Left = 216
    Top = 232
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
