inherited frmSelCtrExportaCobranca: TfrmSelCtrExportaCobranca
  Width = 985
  Height = 562
  Caption = 'Selecione os t'#237'tulos a serem exportados'
  Position = poScreenCenter
  ExplicitWidth = 985
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 490
    Width = 979
    ExplicitTop = 490
    ExplicitWidth = 979
    inherited btnSair: TBitBtnLocked
      Left = 896
      ExplicitLeft = 896
    end
    object btnConfirma: TBitBtnLocked
      Left = 0
      Top = 3
      Width = 115
      Height = 22
      Caption = '[ F10 ] Confirma'
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
      OnClick = btnConfirmaClick
    end
    object btnMarcarTodas: TBitBtnLocked
      Left = 120
      Top = 3
      Width = 115
      Height = 22
      Caption = '[ F7 ] Marcar Todas'
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnMarcarTodasClick
    end
    object btnDesmarcarTodas: TBitBtnLocked
      Left = 238
      Top = 3
      Width = 128
      Height = 22
      Caption = '[ F8 ] Desmarcar Todas'
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnDesmarcarTodasClick
    end
    object btnGeraCSV: TBitBtnLocked
      Left = 368
      Top = 3
      Width = 137
      Height = 22
      Caption = '[ F9 ] Gerar Arquivo CSV'
      TabOrder = 4
      OnClick = btnGeraCSVClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 518
    Width = 979
    ExplicitTop = 518
    ExplicitWidth = 979
    inherited pnlNomeForm: TPanel
      Left = 808
      ExplicitLeft = 808
    end
    inherited pnlInfo: TPanel
      Width = 808
      ExplicitWidth = 808
    end
  end
  object grdReceber: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 979
    Height = 490
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdReceberTableView: TcxGridDBTableViewCitel
      OnDblClick = grdReceberTableViewDblClick
      OnKeyDown = grdReceberTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdReceberTableViewCustomDrawCell
      DataController.DataSource = dsrReceber
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdReceberTableViewMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object grdReceberTableViewCTR_NUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'CTR_NUMDUP'
        Width = 90
      end
      object grdReceberTableViewCTR_PARCEL: TcxGridDBColumn
        Caption = 'Parcela'
        DataBinding.FieldName = 'CTR_PARCEL'
        Width = 54
      end
      object grdReceberTableViewCTR_ESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'CTR_ESPDOC'
        Width = 54
      end
      object grdReceberTableViewCTR_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CTR_CODEMP'
        Width = 60
      end
      object grdReceberTableViewCTR_CODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CTR_CODCLI'
        Width = 73
      end
      object grdReceberTableViewCLI_NOMCLI: TcxGridDBColumn
        Caption = 'Nome cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Width = 267
      end
      object grdReceberTableViewCTR_DTACAD: TcxGridDBColumn
        Caption = 'Dt. Cadastro'
        DataBinding.FieldName = 'CTR_DTACAD'
        Width = 80
      end
      object grdReceberTableViewCTR_DTAVEN: TcxGridDBColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'CTR_DTAVEN'
        Width = 80
      end
      object grdReceberTableViewCTR_VALORI: TcxGridDBColumn
        Caption = 'Valor original'
        DataBinding.FieldName = 'CTR_VALORI'
        Width = 100
      end
      object grdReceberTableViewCTR_VALDUP: TcxGridDBColumn
        Caption = 'Valor da duplicata'
        DataBinding.FieldName = 'CTR_VALDUP'
        Width = 100
      end
    end
    object grdReceberLevel1: TcxGridLevel
      GridView = grdReceberTableView
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 152
    Top = 256
  end
  object dsrReceber: TDataSource
    Left = 456
    Top = 160
  end
end
