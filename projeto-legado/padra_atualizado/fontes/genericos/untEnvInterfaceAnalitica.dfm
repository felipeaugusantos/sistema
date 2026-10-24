inherited frmEnvInterfaceAnalitica: TfrmEnvInterfaceAnalitica
  Width = 424
  Height = 331
  BorderIcons = [biSystemMenu]
  Caption = 'Enviar Interface Anal'#237'tica'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 424
  ExplicitHeight = 331
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 259
    Width = 418
    ExplicitTop = 259
    ExplicitWidth = 418
    inherited btnSair: TBitBtnLocked
      Left = 335
      ExplicitLeft = 335
    end
  end
  inherited pnlStatus: TPanel
    Top = 287
    Width = 418
    ExplicitTop = 287
    ExplicitWidth = 418
    inherited pnlNomeForm: TPanel
      Left = 247
      ExplicitLeft = 247
    end
    inherited pnlInfo: TPanel
      Width = 247
      ExplicitWidth = 247
    end
  end
  object pnlGrid: TPanel [3]
    Left = 0
    Top = 49
    Width = 418
    Height = 210
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object cxGridCitel1: TcxGridCitel
      Left = 0
      Top = 0
      Width = 418
      Height = 193
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridCitel1TableView1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridCitel1TableView1Column1: TcxGridDBColumn
          Caption = 'Data Movimento'
          DataBinding.FieldName = 'NPS_DTAMOV'
          Width = 109
        end
        object cxGridCitel1TableView1Column2: TcxGridDBColumn
          Caption = 'Data/Hora do Envio'
          DataBinding.FieldName = 'NPS_INTANA'
          Width = 192
        end
      end
      object cxGridCitel1Level1: TcxGridLevel
        GridView = cxGridCitel1TableView1
      end
    end
    object pgbProgresso: TProgressBar
      Left = 0
      Top = 193
      Width = 418
      Height = 17
      Align = alBottom
      TabOrder = 1
      Visible = False
    end
  end
  object pnlFiltros: TPanel [4]
    Left = 0
    Top = 0
    Width = 418
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object Label12: TLabel
      Left = 8
      Top = 6
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
    object Label11: TLabel
      Left = 79
      Top = 6
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 20
      Width = 63
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 79
      Top = 20
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnEnviar: TBitBtnLocked
      Left = 192
      Top = 17
      Width = 121
      Height = 25
      Caption = 'Enviar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000090000
        000D0000000F0000000F0000000F0000000F0000000F0000000F0000000F0000
        000F0000000F00000010000000100000000F0000000A000000021D5A42C0287D
        5AFF277D5AFF277C5AFF277C59FF277B59FF277B58FF277A58FF267A58FF2678
        57FF267A56FF267856FF267755FF257756FF1B563DC1000000092B825FFF53C8
        A2FF51C7A0FF50C7A0FF4EC69FFF4DC59DFF4CC59DFF4AC49BFF49C39BFF47C3
        99FF45C298FF45C198FF43C096FF42C095FF277B59FF0000000D2C8664FF5DCC
        AAFF43C398FF42C299FF42C298FF43C298FF65CFADFF74D5B6FF4CC59DFF40C0
        95FF3EC095FF3EBF94FF3DBF94FF4BC49CFF297F5CFF0000000E2F8B68FF67D1
        B0FF48C69EFF48C59CFF47C59CFF5FCDABFF25825DFF00673BFF51BA96FF44C3
        9AFF43C399FF43C298FF42C298FF54C9A4FF2B8360FF0000000D31906DFF71D5
        B8FF4DC9A3FF4DC9A1FF60CFADFF3B9372FF87AF9DFFB1CFC1FF26875FFF53CA
        A5FF48C69EFF47C59DFF47C59DFF5DCEABFF2D8865FF0000000C339671FF7ADA
        BFFF52CCA7FF60D1AFFF4BA183FF699782FFF8F1EEFFF9F3EEFF357F5DFF5CBD
        9DFF4EC9A2FF4CC9A2FF4CC8A1FF67D2B2FF2F8C69FF0000000B359A76FF83DE
        C6FF59D0ADFF5AB094FF4F826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1C74
        4FFF69D5B4FF53CDA7FF52CCA6FF72D7B9FF32926EFF0000000B39A07CFF8CE2
        CBFF5FD4B3FF0D6742FFD2D2CBFF6A8F77FF136A43FF73967EFFF1E8E3FF72A2
        8BFF4CA384FF6AD9BAFF5AD2AFFF7BDBC0FF339773FF0000000A3AA681FF97E9
        D5FF69DEBFFF52BC9DFF0B6942FF389B79FF66DABAFF349773FF73967EFFF0EA
        E7FF4F886CFF60B89BFF67DABAFF87E2CAFF359C78FF000000093FAD88FF9FEC
        DAFF6DE1C3FF6DE1C3FF6DE0C2FF6CDFC1FF6BE0C1FF6BDFC0FF2C8966FF698E
        76FFE6E1DCFF176B47FF5FD1B2FF90E7D1FF3CA481FF0000000842B28DFFA5EE
        DDFF70E4C7FF70E4C6FF70E3C6FF6FE3C5FF6FE2C5FF6EE2C4FF6EE2C4FF3C9E
        7DFF1F6D4AFF2D8965FF6CE0C2FF97EAD6FF3DAA86FF0000000744B691FFAAEF
        E0FF73E6C9FF73E6C9FF72E5C9FF72E5C8FF71E5C8FF71E5C8FF71E4C7FF71E4
        C7FF64D3B5FF6DDFC2FF6FE3C6FF9EECDAFF41AF8BFF0000000746B994FFAEF1
        E2FF74E8CBFF74E7CBFF74E7CBFF74E7CAFF74E6CAFF73E6CAFF73E6CAFF73E6
        C9FF73E5C9FF72E5C9FF72E5C8FFA4EEDDFF42B38EFF0000000647BC97FFC5F4
        EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4
        EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFF44B792FF00000005348B70BF47BC
        97FF47BC97FF47BC97FF47BC97FF47BC97FF47BC97FF47BC97FF47BB97FF47BB
        97FF47BB96FF46BB96FF47BA95FF45BA94FF338A6EC000000003}
      TabOrder = 2
      OnClick = btnEnviarClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 328
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 328
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 464
    Top = 328
  end
  object dtsDados: TDataSource
    Left = 104
    Top = 105
  end
end
