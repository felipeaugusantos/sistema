inherited frmCadElemCombo: TfrmCadElemCombo
  Width = 615
  Height = 433
  Caption = 'Linha / Grupo - Elementos para Indica'#231#227'o na Venda'
  ExplicitWidth = 615
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 361
    Width = 609
    ExplicitTop = 361
    ExplicitWidth = 609
    inherited btnSair: TBitBtnLocked
      Left = 526
      Cancel = False
      ModalResult = 0
      ExplicitLeft = 526
    end
  end
  inherited pnlStatus: TPanel
    Top = 389
    Width = 609
    ExplicitTop = 389
    ExplicitWidth = 609
    inherited pnlNomeForm: TPanel
      Left = 438
      ExplicitLeft = 438
    end
    inherited pnlInfo: TPanel
      Width = 438
      ExplicitWidth = 438
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 609
    Height = 361
    Align = alClient
    TabOrder = 3
    object pnlCabeca: TPanel
      Left = 1
      Top = 1
      Width = 607
      Height = 63
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 10
        Width = 39
        Height = 14
        Caption = 'C'#243'digo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 107
        Top = 10
        Width = 54
        Height = 14
        Caption = 'Descri'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCodigo: TEditFocus
        Tag = 99
        Left = 8
        Top = 26
        Width = 97
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 0
        OnKeyPress = edtCodigoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 8
        Top = 26
        Width = 97
        Height = 22
        EditMask = '999.999;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        ParentFont = False
        TabOrder = 1
        Text = ''
        OnKeyPress = mskLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDescri: TEditFocus
        Left = 105
        Top = 26
        Width = 407
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16770261
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnInserir: TBitBtnLocked
        Left = 514
        Top = 25
        Width = 78
        Height = 23
        Caption = '&Inserir'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000C0E0A1500000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000031362652909F70F32D32234C000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000003136265293A373F997A776FF93A373F92B3022490000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000003136265293A373F997A776FF97A776FF97A776FF93A273F82B2F
          2148000000000000000000000000000000000000000000000000000000000000
          00003136265393A373F997A776FF91A071F54951397B93A273F897A776FF93A2
          73F82B2F21480000000000000000000000000000000000000000000000000506
          0409839166DD97A776FF91A071F5262A1E40000000002B2F214893A273F897A7
          76FF93A273F82B30224900000000000000000000000000000000000000000000
          000015171023808D64D8262A1E400000000000000000000000002B2F214893A2
          73F897A776FF93A273F82B302249000000000000000000000000000000000000
          0000000000000202010300000000000000000000000000000000000000002B2F
          214893A273F897A776FF93A273F82B3022490000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00002B2F214893A273F897A776FF93A273F82B30224900000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000002B2F214893A273F897A776FF76825CC701010001000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000002B2F214875825CC60B0C081200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000010100010000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 3
        OnClick = btnInserirClick
      end
    end
    object cxgElemen: TcxGrid
      Left = 1
      Top = 64
      Width = 607
      Height = 270
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgElemenDBTableView1: TcxGridDBTableViewCitel
        OnKeyDown = cxgElemenDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsElemen
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = True
        Destaque = True
        CorZebra = clMoneyGreen
        object CODIGO: TcxGridDBColumn
          AlternateCaption = 'CODIGO'
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODIGO'
          Styles.Header = cxStyle1
          Width = 97
        end
        object DESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          Styles.Header = cxStyle1
          Width = 490
        end
      end
      object cxgElemenLevel1: TcxGridLevel
        GridView = cxgElemenDBTableView1
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 334
      Width = 607
      Height = 26
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object Label2: TLabel
        Left = 9
        Top = 6
        Width = 140
        Height = 14
        Caption = '[ Delete ] - Excluir Registo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 369
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 457
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 289
    Top = 8
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 410
    Top = 9
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dtsElemen: TDataSource
    Left = 232
    Top = 136
  end
end
