inherited frmConfiguracoes: TfrmConfiguracoes
  Left = 377
  Top = 191
  Width = 442
  Height = 466
  Caption = 'Configura'#231#245'es'
  Position = poMainFormCenter
  ExplicitWidth = 442
  ExplicitHeight = 466
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 393
    Width = 436
    ExplicitTop = 393
    ExplicitWidth = 436
    DesignSize = (
      436
      0)
  end
  inherited pnlStatus: TPanel
    Top = 421
    Width = 436
    ExplicitTop = 421
    ExplicitWidth = 436
    inherited pnlNomeForm: TPanel
      Left = 265
      ExplicitLeft = 265
    end
    inherited pnlInfo: TPanel
      Width = 265
      ExplicitWidth = 265
    end
  end
  inherited pgcDados: TPageControl
    Top = 772
    Width = 748
    Height = 0
    Align = alNone
    Font.Height = -13
    ParentFont = False
    Visible = False
    ExplicitTop = 772
    ExplicitWidth = 748
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      Font.Height = -13
      ParentFont = False
      ExplicitLeft = 4
      ExplicitTop = 30
      ExplicitWidth = 740
      ExplicitHeight = 428
    end
  end
  object pnlBotoesConf: TPanel [3]
    Left = 0
    Top = 393
    Width = 436
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      436
      28)
    object btnSairConf: TBitBtnLocked
      Left = 354
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 1
      OnClick = btnSairConfClick
    end
    object btnGravarConf: TBitBtnLocked
      Left = 2
      Top = 3
      Width = 77
      Height = 22
      Caption = 'Gra&var'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnGravarConfClick
    end
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 0
    Width = 436
    Height = 393
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object GroupBox1: TGroupBox
      Left = 1
      Top = 295
      Width = 434
      Height = 97
      Align = alBottom
      Caption = 'Qual pre'#231'o utilizar?'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object Label1: TLabel
        Left = 152
        Top = 48
        Width = 34
        Height = 14
        Caption = 'Tabela:'
      end
      object rdbBases: TRadioButton
        Left = 8
        Top = 24
        Width = 113
        Height = 17
        Caption = 'Cadastro de Bases'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rdbBasesClick
      end
      object rdbProdutos: TRadioButton
        Left = 8
        Top = 48
        Width = 137
        Height = 17
        Caption = 'Cadastro de Produtos'
        TabOrder = 1
        OnClick = rdbProdutosClick
      end
      object cmbTabela: TComboBox
        Left = 192
        Top = 40
        Width = 51
        Height = 22
        Style = csOwnerDrawFixed
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        OnChange = cmbTabelaChange
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7')
      end
      object rdbTabelaCliente: TRadioButton
        Left = 8
        Top = 72
        Width = 105
        Height = 17
        Caption = 'Tabela do cliente'
        TabOrder = 3
        OnClick = rdbTabelaClienteClick
      end
    end
    object dbgConfs: TcxGrid
      Left = 1
      Top = 1
      Width = 434
      Height = 294
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgViewConfs: TcxGridDBTableView
        OnKeyPress = dbgViewConfsKeyPress
        OnKeyUp = dbgViewConfsKeyUp
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsConfs
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.IncSearchItem = dbgViewConfsTINTA
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.GroupRowStyle = grsOffice11
        object dbgViewConfsUSATIN: TcxGridDBColumn
          Caption = 'Usar'
          DataBinding.FieldName = 'USATIN'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ClearKey = 46
          Properties.DisplayChecked = 'S'
          Properties.DisplayUnchecked = 'N'
          Properties.FullFocusRect = True
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          Width = 38
        end
        object dbgViewConfsTINTA: TcxGridDBColumn
          Caption = 'Tinta de M'#225'quina'
          DataBinding.FieldName = 'TINTA'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 392
        end
        object dbgViewConfsTIPTIN: TcxGridDBColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'TIPTIN'
          Options.Editing = False
        end
      end
      object dbgLvlConfs: TcxGridLevel
        GridView = dbgViewConfs
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 287
    Top = 20
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 298
    Top = 124
  end
  object cdsConfs: TUniClientDataSet
    PersistDataPacket.Data = {
      6A0000009619E0BD0100000018000000030000000000030000006A000554494E
      544101004900000001000557494454480200020032000655534154494E010049
      00000001000557494454480200020001000654495054494E0100490000000100
      055749445448020002000F000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TINTA'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'USATIN'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'TIPTIN'
        DataType = ftString
        Size = 15
      end>
    IndexDefs = <
      item
        Name = 'IDX_TINTA'
        Fields = 'TINTA'
        Options = [ixPrimary]
      end>
    IndexFieldNames = 'TINTA'
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 20
    object cdsConfsTINTA: TStringField
      FieldName = 'TINTA'
      Size = 50
    end
    object cdsConfsUSATIN: TStringField
      FieldName = 'USATIN'
      Size = 1
    end
    object cdsConfsTIPTIN: TStringField
      FieldName = 'TIPTIN'
      Size = 15
    end
  end
  object dtsConfs: TDataSource
    DataSet = cdsConfs
    Left = 353
    Top = 20
  end
end
