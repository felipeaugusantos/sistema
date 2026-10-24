inherited frmTrocarEmbalagem: TfrmTrocarEmbalagem
  Width = 656
  Height = 383
  Caption = 'Trocar Embalagem Tinta'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 656
  ExplicitHeight = 383
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 311
    Width = 650
    ExplicitTop = 311
    ExplicitWidth = 650
    DesignSize = (
      650
      28)
    inherited btnSair: TBitBtnLocked
      Left = 567
      ExplicitLeft = 567
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 100
      Height = 22
      Caption = '[ F10 ] Confirmar'
      Enabled = False
      ModalResult = 1
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 650
    Height = 311
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object cxgEmbalagens: TcxGrid
      Left = 1
      Top = 1
      Width = 648
      Height = 309
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgEmbalagensDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsEmbalagens
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibi'#231#227'o>'
        OptionsView.GroupByBox = False
        object cxgEmbalagensDBTableView1CODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Width = 70
        end
        object cxgEmbalagensDBTableView1DESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
        end
        object cxgEmbalagensDBTableView1PRINCI: TcxGridDBColumn
          Caption = 'Principal'
          DataBinding.FieldName = 'PRINCI'
          Width = 70
        end
      end
      object cxgEmbalagensLevel1: TcxGridLevel
        GridView = cxgEmbalagensDBTableView1
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 339
    Width = 650
    ExplicitTop = 339
    ExplicitWidth = 650
    inherited pnlNomeForm: TPanel
      Left = 479
      ExplicitLeft = 479
    end
    inherited pnlInfo: TPanel
      Width = 479
      ExplicitWidth = 479
    end
  end
  object dtsEmbalagens: TDataSource
    DataSet = cdsEmbalagens
    Left = 408
    Top = 32
  end
  object cdsEmbalagens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsEmbalagensAfterScroll
    Left = 440
    Top = 32
    object cdsEmbalagensCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsEmbalagensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsEmbalagensPRINCI: TStringField
      FieldName = 'PRINCI'
      Size = 1
    end
  end
end
