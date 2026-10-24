inherited frmCadMetasGalonagem: TfrmCadMetasGalonagem
  Left = 278
  Top = 84
  Width = 635
  Height = 585
  Caption = 'Cadastro de Metas de Vendedores em Galonagem'
  OnKeyPress = FormKeyPress
  ExplicitWidth = 635
  ExplicitHeight = 585
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 287
    Width = 629
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Color = clInfoBk
    ParentColor = False
    ExplicitTop = 340
    ExplicitWidth = 630
  end
  inherited pnlBotoes: TPanel
    Top = 514
    Width = 629
    Height = 26
    TabOrder = 5
    ExplicitTop = 514
    ExplicitWidth = 629
    ExplicitHeight = 26
    DesignSize = (
      629
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 625
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 625
      ExplicitHeight = 24
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 179
        Height = 22
        Caption = '[ F10 ] Confirmar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnCopMet: TBitBtnLocked
        Left = 179
        Top = 0
        Width = 179
        Height = 22
        Caption = '[ F5 ] Copiar essa meta para...'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
          000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
          99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
          0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
          FFFF3333337F337F333333333307B70FFFFF33333373FF733F333333333000FF
          0FFF3333333777337FF3333333333FF000FF33FFFFF3333777FF300000333300
          000F377777F33377777F30EEE0333000000037F337F33777777730EEE0333330
          00FF37F337F3333777F330EEE033333000FF37FFF7F3333777F3300000333330
          00FF3777773333F77733333333333000033F3333333337777333}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnCopMetClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 550
      Top = 2
      ModalResult = 0
      ExplicitLeft = 550
      ExplicitTop = 2
    end
  end
  object pnlPeriodo: TPanel [3]
    Left = 0
    Top = 0
    Width = 629
    Height = 37
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 12
      Width = 49
      Height = 14
      Caption = 'Per'#237'odo: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 119
      Top = 12
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object mskDtaAtual: TMaskEditFocus
      Tag = 99
      Left = 59
      Top = 8
      Width = 47
      Height = 22
      EditMask = '99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 172
      Top = 8
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 220
      Top = 8
      Width = 294
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
  end
  object pnlGruFor: TPanel [4]
    Left = 0
    Top = 37
    Width = 629
    Height = 250
    Align = alTop
    ParentColor = True
    TabOrder = 2
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 627
      Height = 21
      Align = alTop
      Caption = 'Fornecedores'
      ParentColor = True
      TabOrder = 0
    end
    object cxgFornecedores: TcxGrid
      Left = 1
      Top = 93
      Width = 627
      Height = 156
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgFornecedoresDBTableView1: TcxGridDBTableView
        OnKeyDown = cxgFornecedoresDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.PriorPage.Visible = False
        Navigator.Buttons.NextPage.Visible = False
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Enabled = False
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = False
        Navigator.Buttons.SaveBookmark.Visible = False
        Navigator.Buttons.GotoBookmark.Enabled = False
        Navigator.Buttons.GotoBookmark.Visible = False
        Navigator.Buttons.Filter.Enabled = False
        Navigator.Buttons.Filter.Visible = False
        DataController.DataSource = dtsForGer
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '-'
        OptionsView.GroupByBox = False
        object cxgFornecedoresDBTableView1Column1: TcxGridDBColumn
          Caption = 'C'#243'd.Fornecedor'
          DataBinding.FieldName = 'GER_CODFOR'
          Width = 87
        end
        object cxgFornecedoresDBTableView1Column2: TcxGridDBColumn
          Caption = 'Nome do Fornecedor'
          DataBinding.FieldName = 'GER_CODFOR'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'FOR_CODFOR'
          Properties.ListColumns = <
            item
              FieldName = 'FOR_NOMFOR'
            end>
          Properties.ListSource = dtsCadFor
          Options.Editing = False
          Width = 419
        end
        object cxgFornecedoresDBTableView1Column3: TcxGridDBColumn
          Caption = 'Galonagem'
          DataBinding.FieldName = 'GER_TOTGAL'
          HeaderAlignmentHorz = taRightJustify
          Width = 99
        end
      end
      object cxgFornecedoresLevel1: TcxGridLevel
        GridView = cxgFornecedoresDBTableView1
      end
    end
    object pnlFornecedor: TPanel
      Left = 1
      Top = 22
      Width = 627
      Height = 71
      Align = alTop
      ParentColor = True
      TabOrder = 2
      object Label1: TLabel
        Left = 449
        Top = 19
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Galonagem:'
      end
      object Label6: TLabel
        Left = 12
        Top = 19
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object Label8: TLabel
        Left = 409
        Top = 42
        Width = 97
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total da Galonagem:'
      end
      object edtTotGal: TEditFocus
        Tag = 99
        Left = 508
        Top = 15
        Width = 99
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
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
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 74
        Top = 15
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 0
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomFor: TEditFocus
        Left = 147
        Top = 15
        Width = 286
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtGalGer: TEditFocus
        Tag = 99
        Left = 508
        Top = 38
        Width = 99
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
  end
  object pnlGruProd: TPanel [5]
    Left = 0
    Top = 290
    Width = 629
    Height = 224
    Align = alClient
    ParentColor = True
    TabOrder = 3
    ExplicitHeight = 222
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 627
      Height = 21
      Align = alTop
      Caption = 'Grupos de Produtos'
      ParentColor = True
      TabOrder = 0
    end
    object cxgGrupos: TcxGrid
      Left = 1
      Top = 22
      Width = 627
      Height = 133
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitHeight = 131
      object cxgGruposDBTableView1: TcxGridDBTableView
        OnKeyDown = cxgGruposDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.PriorPage.Visible = False
        Navigator.Buttons.NextPage.Visible = False
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Refresh.Visible = False
        Navigator.Buttons.SaveBookmark.Visible = False
        Navigator.Buttons.GotoBookmark.Visible = False
        Navigator.Buttons.Filter.Visible = False
        DataController.DataSource = dtsForDet
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '-'
        OptionsView.GroupByBox = False
        object cxgGruposDBTableView1Column1: TcxGridDBColumn
          Caption = 'Linha/Grupo'
          DataBinding.FieldName = 'DET_CODGRU'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'GRU_CODGRU'
          Properties.ListColumns = <
            item
              FieldName = 'GRU_CODGRU'
            end>
          Properties.ListSource = dtsCadGru
          Width = 87
        end
        object cxgGruposDBTableView1Column2: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DET_CODGRU'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'GRU_CODGRU'
          Properties.ListColumns = <
            item
              FieldName = 'GRU_DESGRU'
            end>
          Properties.ListSource = dtsCadGru
          Options.Editing = False
          Width = 419
        end
        object cxgGruposDBTableView1Column3: TcxGridDBColumn
          Caption = 'Percentual'
          DataBinding.FieldName = 'DET_PERGRU'
          HeaderAlignmentHorz = taRightJustify
          Width = 99
        end
      end
      object cxgGruposLevel1: TcxGridLevel
        GridView = cxgGruposDBTableView1
      end
    end
    object pnlGrupo: TPanel
      Left = 1
      Top = 155
      Width = 627
      Height = 68
      Align = alBottom
      ParentColor = True
      TabOrder = 2
      ExplicitTop = 153
      object Label4: TLabel
        Left = 6
        Top = 19
        Width = 62
        Height = 14
        Caption = 'Linha/Grupo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 452
        Top = 19
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Percentual:'
      end
      object Label7: TLabel
        Left = 427
        Top = 42
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Percentual Total:'
      end
      object mskLinhaGrupo: TMaskEditFocus
        Tag = 99
        Left = 71
        Top = 15
        Width = 48
        Height = 22
        EditMask = '999.999;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 7
        ParentFont = False
        TabOrder = 0
        Text = ''
        OnKeyPress = mskLinhaGrupoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGrupo: TEditFocus
        Left = 120
        Top = 15
        Width = 260
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPerGru: TEditFocus
        Tag = 99
        Left = 508
        Top = 15
        Width = 99
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
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
      object edtTotPer: TEditFocus
        Tag = 99
        Left = 508
        Top = 38
        Width = 99
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 540
    Width = 629
    ExplicitTop = 540
    ExplicitWidth = 629
    inherited pnlNomeForm: TPanel
      Left = 458
      ExplicitLeft = 458
    end
    inherited pnlInfo: TPanel
      Width = 458
      ExplicitWidth = 458
      object shpLiberado: TShape
        Left = 440
        Top = 2
        Width = 16
        Height = 14
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 0
  end
  object qryForDet: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 104
    Top = 376
  end
  object dspForDet: TUniDataSetProvider
    DataSet = qryForDet
    ResolveToDataSet = True
    Options = [poAutoRefresh]
    Left = 136
    Top = 376
  end
  object cdsForDet: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspForDet'
    AfterPost = cdsForDetAfterPost
    AfterScroll = cdsForDetAfterScroll
    Left = 168
    Top = 376
    object cdsForDetTOT_PERGRU: TAggregateField
      FieldName = 'TOT_PERGRU'
      Active = True
      DisplayName = ''
      Expression = 'SUM(DET_PERGRU)'
    end
  end
  object dtsForDet: TDataSource
    DataSet = cdsForDet
    Left = 200
    Top = 376
  end
  object qryForGer: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 104
    Top = 176
  end
  object dspForGer: TUniDataSetProvider
    DataSet = qryForGer
    ResolveToDataSet = True
    Options = [poAutoRefresh]
    Left = 136
    Top = 176
  end
  object cdsForGer: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspForGer'
    BeforePost = cdsForGerBeforePost
    AfterScroll = cdsForGerAfterScroll
    Left = 168
    Top = 176
    object cdsForGerTOT_TOTGAL: TAggregateField
      FieldName = 'TOT_TOTGAL'
      Active = True
      DisplayName = ''
      Expression = 'SUM(GER_TOTGAL)'
    end
  end
  object dtsForGer: TDataSource
    DataSet = cdsForGer
    Left = 200
    Top = 176
  end
  object qryCadGru: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CADGRU')
    Constraints = <>
    Left = 240
    Top = 376
  end
  object dtsCadGru: TDataSource
    DataSet = qryCadGru
    Left = 272
    Top = 376
  end
  object qryCadFor: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 240
    Top = 176
  end
  object dtsCadFor: TDataSource
    DataSet = qryCadFor
    Left = 272
    Top = 176
  end
end
