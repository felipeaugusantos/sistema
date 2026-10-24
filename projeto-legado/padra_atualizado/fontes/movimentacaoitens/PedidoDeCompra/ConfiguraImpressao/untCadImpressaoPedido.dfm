inherited frmCadImpressaoPedido: TfrmCadImpressaoPedido
  Width = 805
  Height = 528
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Op'#231#245'es de  Impress'#227'o do Pedido de Compra'
  ExplicitWidth = 805
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 445
    Width = 789
    inherited FlwBotoes: TFlowPanel
      Width = 785
      ExplicitTop = 2
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
        Visible = False
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 708
    end
  end
  inherited pgcDados: TPageControl
    Width = 789
    Height = 445
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  inherited pnlStatus: TPanel
    Top = 473
    Width = 789
    inherited pnlNomeForm: TPanel
      Left = 442
    end
    inherited pnlInfo: TPanel
      Width = 442
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 789
    Height = 445
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 4
    ExplicitWidth = 585
    ExplicitHeight = 258
    object cxgRelatorios: TcxGrid
      Left = 0
      Top = 89
      Width = 789
      Height = 356
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitWidth = 585
      ExplicitHeight = 169
      object cxvRelatorios: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxvRelatoriosCellDblClick
        DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique para definir um filtro'
        FilterRow.Visible = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.HideFocusRectOnExit = False
        OptionsView.NoDataToDisplayInfoText = '<Nenhum relat'#243'rio configurado>'
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        Styles.ContentEven = cxStyle1
        object cxvRelatoriosRPC_HABILI: TcxGridDBColumn
          Caption = 'Habilitar'
          DataBinding.FieldName = 'RPC_HABILI'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          Properties.OnChange = cxvRelatoriosRPC_HABILIPropertiesChange
          HeaderAlignmentHorz = taCenter
          Width = 65
        end
        object cxvRelatoriosRPC_EXEDIR: TcxGridDBColumn
          Caption = 'Execu'#231#227'o Direta'
          DataBinding.FieldName = 'RPC_EXEDIR'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          HeaderAlignmentHorz = taCenter
          Width = 89
        end
        object cxvRelatoriosColumn2: TcxGridDBColumn
          Caption = 'Sequencial'
          DataBinding.FieldName = 'RPC_CODIGO'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 72
        end
        object cxvRelatoriosColumn3: TcxGridDBColumn
          Caption = 'C'#243'digo do Relat'#243'rio'
          DataBinding.FieldName = 'RPC_CODREL'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 104
        end
        object cxvRelatoriosColumn4: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'RPC_DESCRI'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 429
        end
      end
      object cxgRelatoriosLevel1: TcxGridLevel
        GridView = cxvRelatorios
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 789
      Height = 89
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 0
      ExplicitWidth = 585
      object Label1: TLabel
        Left = 47
        Top = 11
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sequencial:'
      end
      object Label2: TLabel
        Left = 51
        Top = 60
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object Label148: TLabel
        Left = 7
        Top = 37
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo do Relat'#243'rio:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 105
        Top = 8
        Width = 55
        Height = 22
        CharCase = ecUpperCase
        DataField = 'RPC_CODIGO'
        DataSource = dtsTabela
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 105
        Top = 56
        Width = 528
        Height = 22
        DataField = 'RPC_DESCRI'
        DataSource = dtsTabela
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodRel: TDBEditFocus
        Tag = 99
        Left = 105
        Top = 32
        Width = 55
        Height = 22
        CharCase = ecUpperCase
        DataField = 'RPC_CODREL'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 3
        OnKeyPress = dbeCodRelKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtDesRel: TEditFocus
        Left = 161
        Top = 32
        Width = 472
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object dbeHabili: TDBCheckBox
        Tag = 99
        Left = 177
        Top = 11
        Width = 59
        Height = 17
        Caption = 'Habiltar'
        DataField = 'RPC_HABILI'
        DataSource = dtsTabela
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox1: TDBCheckBox
        Tag = 99
        Left = 257
        Top = 11
        Width = 97
        Height = 17
        Caption = 'Excu'#231#227'o direta'
        DataField = 'RPC_EXEDIR'
        DataSource = dtsTabela
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 136
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 176
  end
  object dtsTabela: TDataSource
    Left = 648
    Top = 16
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 176
    Top = 160
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
