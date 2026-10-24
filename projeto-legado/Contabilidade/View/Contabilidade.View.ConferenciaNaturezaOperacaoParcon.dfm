inherited frmConferenciaNaturezaOperacaoParcon: TfrmConferenciaNaturezaOperacaoParcon
  Width = 1026
  Height = 308
  Caption = 'Conferencia Natureza Opera'#231#227'o X Par'#226'metros Contabilidade'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1026
  ExplicitHeight = 308
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 235
    Width = 1020
    ExplicitTop = 235
    ExplicitWidth = 1020
    inherited FlwBotoes: TFlowPanel
      Width = 1016
      ExplicitWidth = 1016
      object btnExportar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Hint = 'Exportar os Dados para Planilha Eletr'#244'nica'
        Caption = '&Exportar'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
          333333333333337FF3333333333333903333333333333377FF33333333333399
          03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
          99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
          99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
          03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
          33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
          33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
          3333777777333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnExportarClick
      end
      object btnParametros: TBitBtnLocked
        Left = 77
        Top = 0
        Width = 172
        Height = 22
        Caption = '&Par'#226'metros Contabilidade'
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
        TabOrder = 1
        OnClick = btnParametrosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 940
      ExplicitLeft = 940
    end
  end
  inherited pnlStatus: TPanel
    Top = 263
    Width = 1020
    ExplicitTop = 263
    ExplicitWidth = 1020
    inherited pnlNomeForm: TPanel
      Left = 849
      ExplicitLeft = 849
    end
    inherited pnlInfo: TPanel
      Width = 849
      ExplicitWidth = 849
    end
  end
  object Grid: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1020
    Height = 235
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object TableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsConferencia
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsBehavior.CopyRecordsToClipboard = False
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object TableViewCON_TIPLAN: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'CON_TIPLAN'
        Width = 79
      end
      object TableViewCON_CLAFIS: TcxGridDBColumn
        Caption = 'CFOP'
        DataBinding.FieldName = 'CON_CLAFIS'
        Width = 99
      end
      object TableViewCON_NATCFO: TcxGridDBColumn
        Caption = 'C'#243'digo Natureza de Opera'#231#227'o'
        DataBinding.FieldName = 'CON_NATCFO'
        PropertiesClassName = 'TcxTextEditProperties'
        Visible = False
        Width = 161
      end
      object TableViewDES_NATCFO: TcxGridDBColumn
        Caption = 'Natureza de Opera'#231#227'o'
        DataBinding.FieldName = 'DES_NATCFO'
        Width = 309
      end
      object TableViewCON_DESVAL: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'CON_DESVAL'
        Width = 196
      end
    end
    object GridLevel1: TcxGridLevel
      GridView = TableView
    end
  end
  object dsConferencia: TDataSource
    AutoEdit = False
    Left = 776
    Top = 16
  end
end
