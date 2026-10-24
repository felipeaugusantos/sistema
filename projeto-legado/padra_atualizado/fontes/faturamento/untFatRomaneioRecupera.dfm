inherited frmFatRomaneioRecupera: TfrmFatRomaneioRecupera
  Width = 689
  Height = 422
  Caption = 'Romaneios que n'#227'o foram finalizados corretamente'
  OnDestroy = FormDestroy
  ExplicitWidth = 689
  ExplicitHeight = 422
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 336
    Width = 683
    Height = 41
    ExplicitTop = 336
    ExplicitWidth = 683
    ExplicitHeight = 41
    inherited FlwBotoes: TFlowPanel
      Top = 16
      Width = 679
      Height = 23
      ExplicitTop = 2
      ExplicitWidth = 679
      inherited btnConfirma: TBitBtnLocked
        Width = 153
        Caption = '&Recuperar romaneio'
        ExplicitWidth = 153
      end
      object btnDescarta: TBitBtnLocked
        Left = 153
        Top = 0
        Width = 237
        Height = 22
        Caption = '&Descarta c'#243'pia de seguran'#231'a do romaneio'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000C05031A46110852AB190C76E31D0E89FF1C0E89FF190C
          76E4120852AD06031B4D0000000E000000030000000000000000000000000000
          000301010519130A55A9211593FF2225AEFF2430C2FF2535CBFF2535CCFF2430
          C3FF2225AFFF211594FF140B58B20101051E0000000400000000000000020101
          03151C1270CD2522A6FF2D3DCCFF394BD3FF3445D1FF2939CDFF2839CDFF3344
          D0FF394AD4FF2D3CCDFF2523A8FF1C1270D20101051D00000003000000091912
          5BA72A27AAFF2F41D0FF3541C7FF2726ABFF3137BCFF384AD3FF384BD3FF3137
          BCFF2726ABFF3540C7FF2E40D0FF2927ACFF1A115EB10000000D08061C3D3129
          A2FD2C3CCCFF3842C6FF5F5DBDFFEDEDF8FF8B89CEFF3337B9FF3437B9FF8B89
          CEFFEDEDF8FF5F5DBDFF3741C6FF2B3ACDFF3028A4FF0907204A1E185F9F373B
          BCFF3042D0FF2621A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
          EDFFF3E9E2FFECE6EBFF2621A5FF2E3FCFFF343ABEFF201A66B0312A92E03542
          CBFF3446D1FF2C2FB5FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
          E2FFEADAD1FF7F6FACFF2B2EB5FF3144D0FF3040CBFF312A95E53E37AEFA3648
          D0FF374AD3FF3A4ED5FF3234B4FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
          E5FF897DB8FF3233B4FF384BD3FF3547D2FF3446D1FF3E37AEFA453FB4FA4557
          D7FF3B50D5FF4C5FDAFF4343B7FF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
          E8FF9087C5FF4242B7FF495DD8FF394CD4FF3F52D4FF443FB3FA403DA1DC5967
          DAFF5B6EDDFF4F4DBAFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
          EAFFFAF5F2FF8F89CAFF4E4DB9FF576ADCFF5765D9FF403EA4E12E2D70987C85
          DDFF8798E8FF291D9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
          D8FFF4ECE7FFE5D9DCFF291D9BFF8494E7FF7A81DDFF33317BAC111125356768
          D0FC9EACEDFF686FCEFF5646A1FFCCB6BCFF7A68A8FF4C4AB6FF4D4BB7FF7A68
          A8FFCBB5BCFF5646A1FF666DCCFF9BAAEEFF696CD0FD1212273F000000043B3B
          79977D84DFFFA5B6F1FF6D74D0FF2D219BFF5151B9FF8EA2ECFF8EA1ECFF5252
          BBFF2D219BFF6B72D0FFA2B3F0FF8086E0FF404183A700000008000000010303
          050C4E509DBC8087E2FFAEBDF3FFA3B6F1FF9DAFF0FF95A9EEFF95A8EEFF9BAD
          EFFFA2B3F0FFACBCF3FF838AE3FF4F52A0C10303051100000002000000000000
          000100000005323464797378D9F8929CEAFFA1AEEFFFB0BFF3FFB0BFF4FFA2AE
          EFFF939DE9FF7479DAF83234647D000000080000000200000000000000000000
          000000000000000000031213232D40437D935D61B5D07378DFFC7378DFFC5D61
          B5D040437D951212223000000004000000010000000000000000}
        TabOrder = 1
        OnClick = btnDescartaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 603
      Top = 16
      ExplicitLeft = 603
    end
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 679
      Height = 14
      Align = alTop
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      ShowCaption = False
      TabOrder = 2
      ExplicitLeft = -8
      ExplicitTop = 333
      ExplicitWidth = 683
      object Label1: TLabel
        Left = 3
        Top = 0
        Width = 230
        Height = 14
        Caption = '[ENTER] Mostra os Documentos Marcados'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 377
    Width = 683
    ExplicitTop = 377
    ExplicitWidth = 683
    inherited pnlNomeForm: TPanel
      Left = 512
      ExplicitLeft = 512
    end
    inherited pnlInfo: TPanel
      Width = 512
      ExplicitWidth = 512
    end
  end
  object cxgRomaneio: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 683
    Height = 336
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = -32
    ExplicitTop = -162
    ExplicitHeight = 337
    object cxvRomaneios: TcxGridDBTableViewCitel
      OnKeyDown = cxvRomaneiosKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsGrid
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
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvRomaneiosColumn1: TcxGridDBColumn
        Caption = 'C'#243'd. Ope.'
        DataBinding.FieldName = 'GER_CODOPE'
        HeaderAlignmentHorz = taCenter
        Width = 87
      end
      object cxvRomaneiosColumn2: TcxGridDBColumn
        Caption = 'Nome Operador'
        DataBinding.FieldName = 'OPE_NOMOPE'
        Width = 207
      end
      object cxvRomaneiosColumn3: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'GER_CODEMP'
        HeaderAlignmentHorz = taCenter
        Width = 67
      end
      object cxvRomaneiosNUMROM: TcxGridDBColumn
        Caption = 'Numero Romaneio'
        DataBinding.FieldName = 'GER_NUMROM'
        HeaderAlignmentHorz = taCenter
        Width = 123
      end
      object cxvRomaneiosColumn7: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'GER_DTACAD'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object cxvRomaneiosColumn4: TcxGridDBColumn
        Caption = 'Hora'
        DataBinding.FieldName = 'GER_HORCAD'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
    end
    object cxgRomaneioLevel1: TcxGridLevel
      GridView = cxvRomaneios
    end
  end
  object dsGrid: TDataSource
    Left = 328
    Top = 200
  end
end
