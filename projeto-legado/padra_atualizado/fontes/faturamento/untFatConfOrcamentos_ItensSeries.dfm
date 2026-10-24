inherited frmFatConfOrcamentos_ItensSeries: TfrmFatConfOrcamentos_ItensSeries
  Width = 633
  Height = 429
  Caption = 'Itens do Pedido'
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 633
  ExplicitHeight = 429
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 356
    Width = 627
    TabOrder = 1
    ExplicitTop = 356
    ExplicitWidth = 627
    inherited FlwBotoes: TFlowPanel
      Width = 623
      ExplicitWidth = 623
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Align = alLeft
        Caption = '[F10] Confirmar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 546
      ExplicitLeft = 546
    end
  end
  inherited pnlStatus: TPanel
    Top = 384
    Width = 627
    TabOrder = 2
    ExplicitTop = 384
    ExplicitWidth = 627
    inherited pnlNomeForm: TPanel
      Left = 377
      Width = 250
      ExplicitLeft = 377
      ExplicitWidth = 250
    end
    inherited pnlInfo: TPanel
      Width = 377
      ExplicitWidth = 377
    end
  end
  object cxgItens: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 627
    Height = 356
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ShowEditButtons = gsebAlways
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensTableViewFDO_CODITE: TcxGridDBColumn
        DataBinding.FieldName = 'FDO_CODITE'
        Options.Editing = False
      end
      object cxgItensTableViewFDO_DESCRI: TcxGridDBColumn
        DataBinding.FieldName = 'FDO_DESCRI'
        Options.Editing = False
        Width = 400
      end
      object cxgItensTableViewFDO_QTDITE: TcxGridDBColumn
        DataBinding.FieldName = 'FDO_QTDITE'
        Options.Editing = False
      end
      object cxgItensTableViewSERIES: TcxGridDBColumn
        DataBinding.FieldName = 'SERIES'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = 's'#233'ries'
            Default = True
            Kind = bkText
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = cxgItensTableViewSERIESPropertiesButtonClick
        Width = 70
        IsCaptionAssigned = True
      end
    end
    object cxgItensLevel: TcxGridLevel
      GridView = cxgItensTableView
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 512
    Top = 180
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 512
    Top = 124
    object cdsItensAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsItensFDO_CODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'FDO_CODITE'
      Size = 7
    end
    object cdsItensFDO_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'FDO_DESCRI'
      Size = 100
    end
    object cdsItensFDO_QTDITE: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'FDO_QTDITE'
    end
    object cdsItensFDO_SEQFDO: TStringField
      FieldName = 'FDO_SEQFDO'
    end
    object cdsItensSERIES: TIntegerField
      FieldName = 'SERIES'
    end
    object cdsItensFDO_EMPITE: TStringField
      FieldName = 'FDO_EMPITE'
      Size = 3
    end
    object cdsItensFDO_TEMNSE: TStringField
      FieldName = 'FDO_TEMNSE'
      Size = 1
    end
  end
end
