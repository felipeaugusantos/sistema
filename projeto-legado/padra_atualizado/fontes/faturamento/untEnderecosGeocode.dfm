inherited frmEnderecosGeocode: TfrmEnderecosGeocode
  Width = 764
  Height = 379
  Caption = 'Endere'#231'os Geocode'
  ExplicitWidth = 764
  ExplicitHeight = 379
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 308
    Width = 758
    inherited FlwBotoes: TFlowPanel
      Width = 754
    end
    inherited btnSair: TBitBtnLocked
      Left = 678
    end
  end
  inherited pnlStatus: TPanel
    Top = 334
    Width = 758
    inherited pnlNomeForm: TPanel
      Left = 587
    end
    inherited pnlInfo: TPanel
      Width = 587
    end
  end
  object gpbEnderecos: TGroupBox [2]
    Left = 0
    Top = 37
    Width = 758
    Height = 200
    Align = alTop
    TabOrder = 2
    ExplicitTop = 137
    object cxgEnderecos: TcxGridCitel
      Left = 2
      Top = 16
      Width = 754
      Height = 182
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitLeft = 72
      ExplicitTop = 80
      ExplicitWidth = 250
      ExplicitHeight = 200
      object cxgEnderecosDBTableViewCitel1: TcxGridDBTableViewCitel
        OnDblClick = cxgEnderecosDBTableViewCitel1DblClick
        OnKeyDown = cxgEnderecosDBTableViewCitel1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgEnderecosDBTableViewCitel1CustomDrawCell
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxgEnderecosMARDES: TcxGridDBColumn
          DataBinding.FieldName = 'MARDES'
          Visible = False
        end
        object cxgEnderecosENDERECO: TcxGridDBColumn
          Caption = 'Endere'#231'o'
          DataBinding.FieldName = 'ENDERECO'
          Width = 417
        end
        object cxgEnderecosLATITUDE: TcxGridDBColumn
          Caption = 'Latitude'
          DataBinding.FieldName = 'LATITUDE'
          Width = 159
        end
        object cxgEnderecosLONGITUDE: TcxGridDBColumn
          Caption = 'Longitude'
          DataBinding.FieldName = 'LONGITUDE'
          Width = 159
        end
      end
      object cxgEnderecosLevel1: TcxGridLevel
        GridView = cxgEnderecosDBTableViewCitel1
      end
    end
  end
  object gpbCoordenadas: TGroupBox [3]
    Left = 0
    Top = 249
    Width = 758
    Height = 56
    Align = alTop
    Enabled = False
    TabOrder = 3
    object lblLatitude: TLabel
      Left = 9
      Top = 24
      Width = 41
      Height = 14
      Caption = 'Latitude:'
    end
    object lblLongitude: TLabel
      Left = 385
      Top = 24
      Width = 50
      Height = 14
      Caption = 'Longitude:'
    end
    object edtLatitude: TEditFocus
      Left = 54
      Top = 20
      Width = 307
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtLongitude: TEditFocus
      Left = 439
      Top = 20
      Width = 307
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  object pnlEndereco: TPanel [4]
    Left = 0
    Top = 0
    Width = 758
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 25
    Width = 758
    Height = 12
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object Panel2: TPanel [6]
    Left = 0
    Top = 237
    Width = 758
    Height = 12
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    ExplicitLeft = 8
    ExplicitTop = 381
  end
  object rdgSelecionar: TRadioButton [7]
    Left = 8
    Top = 30
    Width = 209
    Height = 17
    Caption = 'Selecionar endere'#231'o correspondente.'
    Checked = True
    TabOrder = 7
    TabStop = True
    OnClick = rdgSelecionarClick
  end
  object rdgDefinir: TRadioButton [8]
    Left = 8
    Top = 242
    Width = 193
    Height = 17
    Caption = 'Definir coordenadas manualmente.'
    TabOrder = 8
    OnClick = rdgDefinirClick
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 952
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 904
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 832
    Top = 88
  end
end
