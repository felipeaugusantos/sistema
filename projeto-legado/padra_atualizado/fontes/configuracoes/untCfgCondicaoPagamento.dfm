inherited frmCfgCondicaoPagamento: TfrmCfgCondicaoPagamento
  Caption = 'Defini'#231#227'o de Condi'#231#227'o de Pagamento para Novos Clientes'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 432
    Height = 28
    Enabled = True
    Visible = True
    ExplicitTop = 432
    ExplicitHeight = 28
    inherited FlwBotoes: TFlowPanel
      Visible = True
      ExplicitWidth = 765
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 89
        Height = 24
        Caption = '[F10] Gravar'
        TabOrder = 0
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 687
      Top = 3
      ExplicitLeft = 687
      ExplicitTop = 3
    end
  end
  inherited pgcDados: TPageControl
    Height = 406
    ExplicitHeight = 406
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 374
    end
  end
  inherited pnlStatus: TPanel
    ExplicitTop = 460
    inherited pnlInfo: TPanel
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 769
    Height = 406
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object pnlAtividade: TPanel
      Left = 0
      Top = 0
      Width = 769
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblAtividade: TLabel
        Left = 8
        Top = 9
        Width = 48
        Height = 14
        Caption = 'Atividade:'
      end
      object edtDesAti: TEditFocus
        Left = 133
        Top = 6
        Width = 452
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodAti: TEditFocus
        Left = 59
        Top = 6
        Width = 73
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodAtiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object btnAtividade: TBitBtnLocked
        Left = 594
        Top = 5
        Width = 75
        Height = 25
        Caption = '&Incluir'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnAtividadeClick
      end
    end
    object grdAtividade: TcxGrid
      Left = 0
      Top = 32
      Width = 769
      Height = 200
      Align = alTop
      TabOrder = 1
      object grdAtividadeDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsAtividade
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object grdAtividadeCODATI: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODATI'
          Options.Editing = False
          Width = 57
        end
        object grdAtividadeDESATI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o da Atividade'
          DataBinding.FieldName = 'DESATI'
          Options.Editing = False
        end
      end
      object grdAtividadeLevel: TcxGridLevel
        GridView = grdAtividadeDBTableView
      end
    end
    object pnlPagamento: TPanel
      Left = 0
      Top = 232
      Width = 769
      Height = 32
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object lblPagamento: TLabel
        Left = 8
        Top = 11
        Width = 119
        Height = 14
        Caption = 'Condi'#231#227'o de Pagamento:'
      end
      object edtCodPag: TEditFocus
        Left = 129
        Top = 6
        Width = 73
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodPagKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesPag: TEditFocus
        Left = 203
        Top = 6
        Width = 452
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnPagamento: TBitBtnLocked
        Left = 664
        Top = 5
        Width = 75
        Height = 25
        Caption = '&Incluir'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnPagamentoClick
      end
    end
    object grdPagamento: TcxGrid
      Left = 0
      Top = 264
      Width = 769
      Height = 142
      Align = alClient
      TabOrder = 3
      object grdPagamentoDBTableView: TcxGridDBTableView
        OnKeyDown = grdPagamentoDBTableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsPagamento
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object grdPagamentoCODPAG: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODPAG'
          Options.Editing = False
          Width = 68
        end
        object grdPagamentoDESPAG: TcxGridDBColumn
          Caption = 'Descri'#231#227'o da Condi'#231#227'o'
          DataBinding.FieldName = 'DESPAG'
          Options.Editing = False
        end
        object grdPagamentoSEGPAG: TcxGridDBColumn
          Caption = 'Sugest'#227'o'
          DataBinding.FieldName = 'SEGPAG'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.OnChange = grdPagamentoSEGPAGPropertiesChange
          Width = 56
        end
        object grdPagamentoCODATI: TcxGridDBColumn
          DataBinding.FieldName = 'CODATI'
          Visible = False
        end
      end
      object grdPagamentoLevel: TcxGridLevel
        GridView = grdPagamentoDBTableView
      end
    end
  end
  object Panel3: TPanel [5]
    Left = 0
    Top = 406
    Width = 769
    Height = 26
    Align = alBottom
    Caption = '* Pressione Delete para excluir uma linha *'
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 696
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 704
    Top = 264
  end
  object cdsAtividade: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsAtividadeAfterScroll
    Left = 136
    Top = 80
    object cdsAtividadeCODATI: TStringField
      FieldName = 'CODATI'
      Size = 3
    end
    object cdsAtividadeDESATI: TStringField
      FieldName = 'DESATI'
      Size = 70
    end
  end
  object cdsPagamento: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterPost = cdsPagamentoAfterPost
    Left = 144
    Top = 312
    object cdsPagamentoCODPAG: TStringField
      FieldName = 'CODPAG'
      Size = 3
    end
    object cdsPagamentoDESPAG: TStringField
      FieldName = 'DESPAG'
      Size = 70
    end
    object cdsPagamentoSEGPAG: TBooleanField
      FieldName = 'SEGPAG'
    end
    object cdsPagamentoCODATI: TStringField
      FieldName = 'CODATI'
      Size = 3
    end
  end
  object dtsAtividade: TDataSource
    DataSet = cdsAtividade
    Left = 200
    Top = 80
  end
  object dtsPagamento: TDataSource
    DataSet = cdsPagamento
    Left = 224
    Top = 312
  end
  object UniQuery1: TUniQuery
    Constraints = <>
    Left = 432
    Top = 88
  end
end
