inherited frmImportacao_e_Entrada_de_Retorno_Simbolico: TfrmImportacao_e_Entrada_de_Retorno_Simbolico
  Width = 1124
  Height = 574
  BorderStyle = bsSizeable
  Caption = 'Importa'#231#227'o e Entrada de Retorno Simb'#243'lico'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1124
  ExplicitHeight = 574
  PixelsPerInch = 96
  TextHeight = 14
  object Label12: TLabel [0]
    Left = 580
    Top = 7
    Width = 51
    Height = 14
    Caption = 'Data Inicial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel [1]
    Left = 645
    Top = 7
    Width = 47
    Height = 14
    Caption = 'Data Final'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 491
    Width = 1108
    ExplicitTop = 491
    ExplicitWidth = 1108
    inherited FlwBotoes: TFlowPanel
      Width = 1104
      ExplicitWidth = 1104
      object btnMarcarTodos: TSpeedButton
        Left = 0
        Top = 0
        Width = 137
        Height = 22
        Caption = ' [ F5 ] Marcar Todos'
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TSpeedButton
        Left = 137
        Top = 0
        Width = 137
        Height = 22
        Caption = '[ F6 ] Desmarcar Todos'
        OnClick = btnDesmarcarTodosClick
      end
      object btnRealizarEntrada: TSpeedButton
        Left = 274
        Top = 0
        Width = 137
        Height = 22
        Caption = '[ F10 ] Realizar entrada '
        OnClick = btnRealizarEntradaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1028
      ExplicitLeft = 1028
    end
  end
  inherited pnlStatus: TPanel
    Top = 519
    Width = 1108
    ExplicitTop = 519
    ExplicitWidth = 1108
    inherited pnlNomeForm: TPanel
      Left = 784
      Width = 324
      ExplicitLeft = 784
      ExplicitWidth = 324
    end
    inherited pnlInfo: TPanel
      Width = 784
      ExplicitWidth = 784
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 1108
    Height = 47
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 4
      Top = 6
      Width = 97
      Height = 14
      Caption = 'Caminho dos XML'#39's:'
    end
    inline fraPathXml: TfraDirectoryEditFocus
      Left = 4
      Top = 20
      Width = 485
      Height = 22
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 20
      ExplicitWidth = 485
      inherited edtDirectory: TEditFocus
        Width = 460
        ExplicitWidth = 460
        ExplicitHeight = 22
      end
      inherited btnOpenDirectory: TcxButton
        Left = 462
        ExplicitLeft = 462
      end
    end
    object mskDtaEntIni: TMaskEditFocus
      Tag = 99
      Left = 580
      Top = 20
      Width = 62
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaEntFin: TMaskEditFocus
      Tag = 99
      Left = 645
      Top = 20
      Width = 61
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnImportaXML: TBitBtnLocked
      Left = 493
      Top = 20
      Width = 75
      Height = 22
      Caption = 'Importa'#231#227'o'
      TabOrder = 1
      OnClick = btnImportaXMLClick
    end
    object btnCarregaDados: TBitBtnLocked
      Left = 710
      Top = 20
      Width = 75
      Height = 22
      Caption = 'Carregar'
      TabOrder = 4
      OnClick = btnCarregaDadosClick
    end
  end
  object Memo1: TMemo [5]
    Left = 0
    Top = 416
    Width = 1108
    Height = 75
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
    Visible = False
  end
  object cxGridCitel1: TcxGridCitel [6]
    Left = 0
    Top = 47
    Width = 1108
    Height = 347
    Align = alClient
    TabOrder = 3
    ExplicitHeight = 348
    object cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsArquivos
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn
        Caption = 'Sel.'
        DataBinding.FieldName = 'MARCADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Width = 31
      end
      object cxGridCitel1DBTableViewCitel1Column2: TcxGridDBColumn
        Caption = 'Arquivo'
        DataBinding.FieldName = 'ARQUIVO'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        Properties.OnButtonClick = cxGridCitel1DBTableViewCitel1Column2PropertiesButtonClick
        MinWidth = 274
        Options.ShowEditButtons = isebAlways
        Width = 274
      end
      object cxGridCitel1DBTableViewCitel1Column3: TcxGridDBColumn
        Caption = 'Chave de Acesso'
        DataBinding.FieldName = 'CHAVE'
        MinWidth = 274
        Options.Editing = False
        Width = 274
      end
      object cxGridCitel1DBTableViewCitel1Column4: TcxGridDBColumn
        Caption = 'Data de Emiss'#227'o'
        DataBinding.FieldName = 'DTAEMI'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 100
      end
      object cxGridCitel1DBTableViewCitel1Column5: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Options.Editing = False
      end
      object cxGridCitel1DBTableViewCitel1Column6: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FORNEC'
        Options.Editing = False
      end
      object cxGridCitel1DBTableViewCitel1Column7: TcxGridDBColumn
        Caption = 'Valor Total'
        DataBinding.FieldName = 'VALDOC'
        Options.Editing = False
      end
      object cxGridCitel1DBTableViewCitel1Column8: TcxGridDBColumn
        Caption = 'Status do XML'
        DataBinding.FieldName = 'STATUS_XML'
        MinWidth = 160
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 160
      end
      object cxGridCitel1DBTableViewCitel1Column9: TcxGridDBColumn
        Caption = 'Status Entrada'
        DataBinding.FieldName = 'STATUS_ENT'
        MinWidth = 160
        Options.Editing = False
        Width = 160
      end
    end
    object cxGridCitel1Level1: TcxGridLevel
      GridView = cxGridCitel1DBTableViewCitel1
    end
  end
  object cxgProgresso_bw2: TcxProgressBar [7]
    Left = 0
    Top = 394
    Align = alBottom
    TabOrder = 5
    Visible = False
    Width = 1108
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 308
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 184
  end
  object dtsArquivos: TDataSource
    Left = 400
    Top = 232
  end

end
