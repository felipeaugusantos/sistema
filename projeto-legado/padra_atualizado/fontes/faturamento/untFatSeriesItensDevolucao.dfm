inherited frmFatSeriesItensDevolucao: TfrmFatSeriesItensDevolucao
  Width = 1013
  Height = 767
  Caption = 'S'#233'ries dos Produtos para Devolu'#231#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 1013
  ExplicitHeight = 767
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 694
    Width = 1007
    Height = 28
    Enabled = True
    Visible = True
    ExplicitTop = 694
    ExplicitWidth = 1007
    ExplicitHeight = 28
    inherited FlwBotoes: TFlowPanel
      Width = 1003
      ExplicitWidth = 1003
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Caption = '&Confirma'
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
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 922
      Top = 2
      Caption = 'C&ancela'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ExplicitLeft = 922
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 722
    Width = 1007
    ExplicitTop = 722
    ExplicitWidth = 1007
    inherited pnlNomeForm: TPanel
      Left = 836
      ExplicitLeft = 836
    end
    inherited pnlInfo: TPanel
      Width = 836
      ExplicitWidth = 836
    end
  end
  inherited pgcDados: TPageControl
    Width = 1007
    Height = 665
    ExplicitWidth = 1007
    ExplicitHeight = 665
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 999
      ExplicitHeight = 633
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 1007
    Height = 665
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object cxgSeries: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1005
      Height = 663
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgSeriesDBTableViewCitel: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgSeriesDBTableViewCitelCustomDrawCell
        DataController.DataSource = dtsSeries
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxgSeriesCODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
        end
        object cxgSeriesDESITE: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 390
        end
        object cxgSeriesQTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
          Options.Editing = False
        end
        object cxgSeriesNUMSER: TcxGridDBColumn
          Caption = 'N'#250'mero S'#233'rie'
          DataBinding.FieldName = 'NUMSER'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 443
        end
      end
      object cxgSeriesLevel: TcxGridLevel
        GridView = cxgSeriesDBTableViewCitel
      end
    end
  end
  object pnlLegenda: TPanel [4]
    Left = 0
    Top = 665
    Width = 1007
    Height = 29
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object shpLegEdit: TShape
      Left = 8
      Top = 4
      Width = 20
      Height = 20
      Brush.Color = clYellow
    end
    object lblLegEdit: TLabel
      Left = 33
      Top = 7
      Width = 99
      Height = 13
      Caption = 'Campos Editaveis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblInformacaoSerie: TLabel
      Left = 213
      Top = 7
      Width = 539
      Height = 14
      Caption = 
        '(*) Ao informar mais de um n'#250'mero de s'#233'rie por item, utilizar po' +
        'nto e v'#237'rgula " ; " como separador'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 224
    Top = 584
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 192
    Top = 584
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 608
  end
  object cdsSeries: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 392
    Top = 616
    object cdsSeriesAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsSeriesCODITE: TStringField
      FieldName = 'CODITE'
      Size = 7
    end
    object cdsSeriesDESITE: TStringField
      FieldName = 'DESITE'
      Size = 100
    end
    object cdsSeriesQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsSeriesNUMSER: TStringField
      DisplayWidth = 300
      FieldName = 'NUMSER'
      Size = 300
    end
    object cdsSeriesEMPDOC: TStringField
      FieldName = 'EMPDOC'
      Size = 3
    end
    object cdsSeriesEMPITE: TStringField
      FieldName = 'EMPITE'
      Size = 3
    end
    object cdsSeriesTABDEV: TStringField
      FieldName = 'TABDEV'
      Size = 8
    end
  end
  object dtsSeries: TDataSource
    DataSet = cdsSeries
    Left = 456
    Top = 616
  end
end
