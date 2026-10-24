inherited frmArquivosBanco: TfrmArquivosBanco
  Width = 1030
  Height = 634
  Caption = 'frmArquivosBanco'
  ExplicitWidth = 1030
  ExplicitHeight = 634
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 563
    Width = 1024
    ExplicitTop = 563
    ExplicitWidth = 1024
    inherited FlwBotoes: TFlowPanel
      Width = 1020
      ExplicitWidth = 1020
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
      object btnIncluir: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 164
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[ F1 ] Adicionar Arquivo'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000080000
          000D0000000E0000000E0000000F0000000F0000000F0000000F000000100000
          0010000000100000001100000011000000100000000B00000003815749BFB478
          65FFB47865FFB47864FFB37764FFB37764FFB37764FFB37663FFB37663FFB276
          63FFB27663FFB27562FFB27562FFB27562FF7F5447C20000000AB67D6AFFFBF6
          F3FFFBF6F3FFFBF5F2FFFAF5F2FFFAF5F2FFFAF5F1FFFBF5F1FFFAF5F1FFFAF4
          F1FFFAF4F0FFFAF3EEFFFAF2EEFFFAF2EEFFB47967FF0000000FB87F6DFFFBF7
          F5FF2FB487FF2EB485FF2EB485FF2EB388FF2FB487FF2EB485FF2EB388FF2A9C
          73FF278661FF2B916AFF1D6A4AFFFAF4F1FFB57B69FF0000000FBA8270FFFCF9
          F7FF36BB8FFF36BB8FFF36BA90FF33B187FF278D67FF23815DFF2DA179FF2FA3
          7AFF278561FF2E9770FF23815CFFFBF6F3FFB77E6BFF0000000EBC8573FFFDFA
          F9FF3FC398FF3FC398FF3EC398FF32A27DFF68C8B2FF34AC85FF226C75FF275D
          B9FF26747AFF2B8E69FF278964FFFCF8F5FFB9816EFF0000000DBE8876FFFDFB
          FAFF4FCEA6FF50CFA7FF50CFA7FF40AE8AFF3678B4FF336ABBFF3168B6FF6EC2
          F1FF306BB7FF3066B4FF2D6DAAFFFCF9F7FFBB8471FF0000000CC08B7AFFFEFC
          FBFF5BD5AEFF5BD5AFFF5AD6AEFF50C29EFF437BBFFF8BD5F6FF63A5E4FF73D7
          FCFF569EE1FF66C7F5FF3B74BEFFFDFAF9FFBE8674FF0000000BC28E7DFFFEFD
          FCFF62DBB5FF62DBB5FF5FD6B1FF53AEAFFF528DCCFF6EB1E7FF5B9DD2FF305D
          AAFF4F95CFFF5DA7E5FF4581C7FFFEFBFAFFBF8A77FF0000000AC59280FFFEFE
          FDFFF4DCAFFFF4DCAEFFEBD5A9FF628FD0FF94D5F6FFA9ECFFFF3B76BEFF4390
          D3FF3876BEFF7CDFFFFF74C9F4FFFEFCFBFFC18D7CFF00000009C79584FFFFFE
          FEFFF8E7C6FFF8E6C5FFF3E3C2FFBABEBDFF7CA8D8FF8DC8F1FF6CB6E4FF3A80
          C9FF67B5E4FF85D0F4FF6B9AD1FFFEFDFCFFC3907EFF00000008C99887FFFFFE
          FEFFFBEDD3FFFBEDD3FFFAEDD2FFEDE0C7FF87B2DCFFAAE8FDFF9CD5F6FFAFEF
          FFFF96DAF9FFA7ECFFFF7AA8D7FFFEFEFDFFC69381FF00000007CB9C8AFFFFFF
          FEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFC89785FF000000069C7C6EBED2A7
          95FFD2A795FFD2A694FFD1A694FFD1A594FFD1A593FFD1A593FFD0A492FFD0A4
          92FFD0A391FFCFA290FFCFA190FFCFA18FFF997669C000000003000000010000
          0001000000020000000200000002000000020000000200000003000000030000
          0003000000030000000300000004000000040000000300000001}
        TabOrder = 1
        OnClick = btnIncluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 941
      Caption = '&Sair'
      ExplicitLeft = 941
    end
  end
  inherited pnlStatus: TPanel
    Top = 589
    Width = 1024
    ExplicitTop = 589
    ExplicitWidth = 1024
    inherited pnlNomeForm: TPanel
      Left = 853
      ExplicitLeft = 853
    end
    inherited pnlInfo: TPanel
      Width = 853
      ExplicitWidth = 853
    end
  end
  object grdArquivos: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1024
    Height = 563
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdArquivosWev: TcxGridDBWinExplorerView
      OnKeyDown = grdArquivosWevKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = grdArquivosWevCellDblClick
      ActiveDisplayMode = dmList
      DataController.DataSource = dtsArquivos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      ItemSet.ExtraLargeImageIndexItem = grdArquivosWevIIDXIMG
      ItemSet.LargeImageIndexItem = grdArquivosWevIIDXIMG
      ItemSet.MediumImageIndexItem = grdArquivosWevIIDXIMG
      ItemSet.SmallImageIndexItem = grdArquivosWevIIDXIMG
      ItemSet.TextItem = grdArquivosWevNOMARQ
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      ImageSet.ExtraLargeImages = imlThumb
      ImageSet.LargeImages = imlThumb
      ImageSet.MediumImages = imlThumb
      ImageSet.SmallImages = imlThumb
      object grdArquivosWevNOMARQ: TcxGridDBWinExplorerViewItem
        DataBinding.FieldName = 'NOMARQ'
      end
      object grdArquivosWevIIDXIMG: TcxGridDBWinExplorerViewItem
        DataBinding.FieldName = 'IDXIMG'
      end
    end
    object grdArquivosLvl: TcxGridLevel
      GridView = grdArquivosWev
    end
  end
  object cdsArquivos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 304
    Top = 160
    object cdsArquivosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsArquivosARQB64: TStringField
      FieldName = 'ARQB64'
      Size = 9999
    end
    object cdsArquivosARQUIV: TBlobField
      FieldName = 'ARQUIV'
      Size = 38
    end
    object cdsArquivosNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 100
    end
    object cdsArquivosIDXIMAGE: TIntegerField
      FieldName = 'IDXIMG'
    end
  end
  object dtsArquivos: TDataSource
    DataSet = cdsArquivos
    Left = 368
    Top = 160
  end
  object imlThumb: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 23593704
  end
end
