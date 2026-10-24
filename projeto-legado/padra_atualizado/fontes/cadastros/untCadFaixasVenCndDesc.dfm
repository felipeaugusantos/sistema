inherited frmCadFaixasVenCndDesc: TfrmCadFaixasVenCndDesc
  Width = 536
  Height = 400
  Caption = 
    'Cadastro de Faixas de Desconto por Vendedor e Condi'#231#227'o de Pagame' +
    'nto'
  ExplicitWidth = 536
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 307
    Width = 530
    Height = 49
    ExplicitTop = 307
    ExplicitWidth = 518
    ExplicitHeight = 49
    inherited FlwBotoes: TFlowPanel
      Top = 26
      Width = 526
      Height = 21
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 26
      ExplicitWidth = 514
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        Anchors = [akRight, akBottom]
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        Anchors = [akRight, akBottom]
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        Anchors = [akRight, akBottom]
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        Anchors = [akRight, akBottom]
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        Anchors = [akRight, akBottom]
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        Anchors = [akRight, akBottom]
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      Top = 26
      Width = 69
      Height = 20
      Anchors = [akLeft, akBottom]
      TabOrder = 2
      ExplicitLeft = 446
      ExplicitTop = 26
      ExplicitWidth = 69
      ExplicitHeight = 20
    end
    object btnHerFai: TBitBtnLocked
      Left = 2
      Top = 4
      Width = 513
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '&Heran'#231'a de Faixas de Descontos Entre Vendedores'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      TabStop = False
      OnClick = btnHerFaiClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 530
    Height = 307
    ExplicitWidth = 518
    ExplicitHeight = 307
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 510
      ExplicitHeight = 275
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 530
    Height = 307
    Align = alClient
    ParentColor = True
    TabOrder = 3
    ExplicitWidth = 518
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 528
      Height = 89
      Align = alTop
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      ExplicitWidth = 516
      object Label4: TLabel
        Left = 13
        Top = 54
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cond. Pagamento:'
      end
      object Label3: TLabel
        Left = 50
        Top = 26
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object dbeCodCnd: TDBEditFocus
        Tag = 99
        Left = 101
        Top = 50
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
        TabOrder = 2
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
        Top = 50
        Width = 320
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeCodVen: TDBEditFocus
        Tag = 99
        Left = 101
        Top = 22
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FXA_CODOPE'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeCodVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtNomVen: TEditFocus
        Left = 177
        Top = 22
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
      Top = 90
      Width = 528
      Height = 216
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 89
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
      object cxgFavDes: TcxGrid
        Left = 1
        Top = 53
        Width = 526
        Height = 162
        Align = alBottom
        TabOrder = 3
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitWidth = 514
        object cxgFavDesDBTableView1: TcxGridDBTableView
          OnKeyDown = cxgFavDesDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsFavDes
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
          object cxgFavDesDBTableView1Column1: TcxGridDBColumn
            Caption = '% Desconto Inicial'
            DataBinding.FieldName = 'FAV_DESINI'
            Width = 160
          end
          object cxgFavDesDBTableView1Column2: TcxGridDBColumn
            Caption = '% Desconto Final'
            DataBinding.FieldName = 'FAV_DESFIN'
            Width = 160
          end
          object cxgFavDesDBTableView1Column3: TcxGridDBColumn
            Caption = '% Comiss'#227'o'
            DataBinding.FieldName = 'FAV_PERCOM'
            Width = 160
          end
        end
        object cxgFavDesLevel1: TcxGridLevel
          GridView = cxgFavDesDBTableView1
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 356
    Width = 530
    ExplicitTop = 356
    ExplicitWidth = 518
    inherited pnlNomeForm: TPanel
      Left = 183
      ExplicitLeft = 171
    end
    inherited pnlInfo: TPanel
      Width = 183
      ExplicitWidth = 171
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
  object dtsFavDes: TDataSource
    DataSet = cdsFavDes
    Left = 280
    Top = 232
  end
  object cdsFavDes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFavDes'
    Left = 248
    Top = 232
  end
  object dspFavDes: TUniDataSetProvider
    Options = []
    Left = 216
    Top = 232
  end
  object dtsTabela: TDataSource
    Left = 184
    Top = 232
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
