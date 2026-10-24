inherited frmCRMGeracaoGlobal: TfrmCRMGeracaoGlobal
  Width = 913
  Height = 741
  Caption = 'CRM - Gera'#231#227'o global de ocorr'#234'ncias'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 913
  ExplicitHeight = 741
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 664
    Width = 907
    Height = 32
    TabOrder = 1
    ExplicitTop = 664
    ExplicitWidth = 907
    ExplicitHeight = 32
    inherited FlwBotoes: TFlowPanel
      Left = 771
      Width = 57
      Height = 28
      TabOrder = 2
      ExplicitLeft = 771
      ExplicitWidth = 57
      ExplicitHeight = 28
      object btnAcoesAutomaticas: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 149
        Height = 28
        Caption = '[ F9 ] A'#231#245'es Autom'#225'ticas'
        TabOrder = 0
        Visible = False
        OnClick = btnAcoesAutomaticasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 828
      Top = 2
      Height = 28
      Align = alRight
      ExplicitLeft = 828
      ExplicitTop = 2
      ExplicitHeight = 28
    end
    object btnCarregarDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 99
      Height = 28
      Align = alLeft
      Caption = '&Carregar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0001000000050000000B0000000F0000000F0000000C00000005000000010000
        0000000000000000000000000000000000000000000000000000000000020000
        0009041A0E520C4826BE0F5D31EC0F5D31EC094222BE03140A540000000A0000
        0002000000000000000000000000000000000000000000000000000000080A34
        1D871C7A49FF25A773FF26B981FF24B880FF1EA36CFF116A3BFF052813890000
        000A000000010000000000000000000000000000000000000000061D104D2984
        56FC45CA9CFF33C792FF43CE9EFF68DDB9FF65DDB8FF3AC391FF157242FD0315
        0A4E000000040000000000000000000000000000000000000000155E36CA60C3
        9FFF41CF9FFF32B581FF21804EFF227E4EFF5AC39DFF6ADFBDFF28AB76FF0E4E
        2ACB000000160000000D0000000D0000000C0000000A000000071E7945F281E4
        C6FF4CD5A8FF1D7947FF061F115E1C7A46FF13592FFF3BAC7FFF40A279FF1C76
        46FE7B99BCFF0A448AFF083873DC07346DD4052B5AB8041F4089217E4BF18BE6
        CDFF65E0BBFF186C3DFF05190C561F804AFF58B08EFF27694BFF7AA6C2FF8EB9
        E0FF91C3EEFF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF1E6B40C773CE
        ADFF8EECD4FF48BD94FF1C7345FF23864FFF50DAAEFF41BE92FF237349FF7AAD
        BBFF9ACAF0FF67B1EEFF46A2ECFF56ADEDFF3B89CDFF0C447FDA0A2416453F9E
        6DFCBBF0E1FFC0F6EAFF9EF0DAFF84E9CEFF6BE3C0FF57DDB5FF4FD2A8FF2785
        57FF669F9CFF73B6E4FF58A6DFFF1A64A9FA0C3864A3020B1329000000021547
        2B7D3CA06AFF95D6BCFFBAEEDEFFCAF8EEFFC7F7EDFF81EBCEFF6CDEBBFF40A2
        73FF699F97FF5F84ABFF184F81DB02080E260000000500000002000000000000
        00020B261743206A42B4288754E52C965CFFCDF9F0FF95E0C7FF358F5FEC6B92
        98EEBBCFE3FF79A1CCFF1C4070DE000000190000000000000000000000000000
        00000000000100000002000000052F9A60FF8DD3B5FF277A4ECA09140F3A9DB3
        D0FCC5E4F6FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
        0000000000000000000000000001319E63FF1C5D39980104020E576B8BD26486
        B4FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
        0000000000000000000000000000000000010000000100000006235291F64F7C
        B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
        0000000000000000000000000000000000000000000000000003255A9AE66C9D
        D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
        00000000000000000000000000000000000000000000000000010C1F3249255B
        92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000}
      TabOrder = 0
      OnClick = btnCarregarDadosClick
    end
    object pnlBtnDadosCarregados: TPanel
      Left = 101
      Top = 2
      Width = 670
      Height = 28
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 3
      object lblQtdCli: TLabel
        Left = 569
        Top = 6
        Width = 46
        Height = 14
        Caption = 'lblQtdCli'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 99
        Height = 28
        Align = alLeft
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
        Visible = False
        OnClick = btnConfirmaClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 99
        Top = 0
        Width = 121
        Height = 28
        Align = alLeft
        Caption = '[ F7 ] Marcar Todos'
        TabOrder = 1
        Visible = False
        OnClick = btnMarcarTodosClick
      end
      object btnDesmTodos: TBitBtnLocked
        Left = 220
        Top = 0
        Width = 121
        Height = 28
        Align = alLeft
        Caption = '[ F8 ] Desmarcar Todos'
        Spacing = 0
        TabOrder = 2
        Visible = False
        OnClick = btnDesmTodosClick
      end
      object pnlQtdMarcar: TPanel
        Left = 341
        Top = 0
        Width = 172
        Height = 28
        ParentCustomHint = False
        Align = alLeft
        BevelEdges = []
        BiDiMode = bdLeftToRight
        BorderWidth = 10
        Color = clGray
        Ctl3D = True
        DoubleBuffered = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentBackground = False
        ParentCtl3D = False
        ParentDoubleBuffered = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
        Visible = False
        StyleElements = []
        object lblQtdMarcar: TLabel
          Left = 8
          Top = 7
          Width = 85
          Height = 14
          Caption = 'Qtd. para Marcar:'
        end
        object speQtdMarcar: TSpinEdit
          Left = 96
          Top = 3
          Width = 73
          Height = 23
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
      end
      object btnMarcarPorQtde: TBitBtnLocked
        Left = 513
        Top = 0
        Width = 50
        Height = 28
        Align = alLeft
        Caption = 'Marcar'
        TabOrder = 4
        Visible = False
        OnClick = btnMarcarPorQtdeClick
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 696
    Width = 907
    TabOrder = 2
    ExplicitTop = 696
    ExplicitWidth = 907
    inherited pnlNomeForm: TPanel
      Left = 736
      ExplicitLeft = 736
    end
    inherited pnlInfo: TPanel
      Width = 736
      ExplicitWidth = 736
      object Shape1: TShape
        Left = 714
        Top = 1
        Width = 16
        Height = 15
        Anchors = [akTop, akRight]
        Brush.Color = clBlue
        ExplicitLeft = 601
      end
    end
  end
  object Notebook: TNotebook [2]
    Left = 0
    Top = 0
    Width = 907
    Height = 664
    Align = alClient
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'Filtros'
      inline fraCRMGeracaoGlobalFrameParametros: TfraCRMGeracaoGlobalFrameParametros
        Left = 0
        Top = 0
        Width = 907
        Height = 664
        Align = alClient
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitWidth = 907
        ExplicitHeight = 664
        inherited pgcFiltros: TPageControl
          Width = 907
          Height = 664
          ExplicitWidth = 907
          ExplicitHeight = 664
          inherited tbsDadosContatoCliente: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 28
            ExplicitWidth = 782
            ExplicitHeight = 559
          end
          inherited tbsClientesSemCompra: TTabSheet
            ExplicitWidth = 899
            ExplicitHeight = 632
            inherited Label34: TLabel
              Top = 612
              Width = 899
              ExplicitTop = 539
              ExplicitWidth = 899
            end
          end
          inherited tbsFinanceiro: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 28
            ExplicitWidth = 782
            ExplicitHeight = 559
          end
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Dados'
      object pnlDados: TPanel
        Left = 0
        Top = 0
        Width = 907
        Height = 664
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object PCDados: TPageControl
          Left = 0
          Top = 0
          Width = 907
          Height = 664
          ActivePage = tsDadosCliente
          Align = alClient
          TabOrder = 0
          OnChange = PCDadosChange
          object tsDadosCliente: TTabSheet
            Caption = 'Dados Cliente'
            object cxDados: TcxGridCitel
              Left = 0
              Top = 0
              Width = 899
              Height = 635
              Align = alClient
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              LookAndFeel.ScrollbarMode = sbmClassic
              object cxDadosTableView: TcxGridDBTableViewCitel
                OnKeyDown = cxDadosTableViewKeyDown
                OnKeyPress = cxDadosTableViewKeyPress
                Navigator.Buttons.CustomButtons = <>
                FilterBox.Position = fpTop
                OnCustomDrawCell = cxDadosTableViewCustomDrawCell
                DataController.Filter.Options = [fcoCaseInsensitive]
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                FilterRow.InfoText = 'Clique aqui para definir um filtro'
                FilterRow.Visible = True
                FilterRow.ApplyChanges = fracDelayed
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
                OptionsView.GroupByBox = False
                Zebra = True
                Destaque = False
                CorZebra = clMoneyGreen
                object cxDadosTableViewColumnMARCA: TcxGridDBColumn
                  Caption = 'X'
                  DataBinding.FieldName = 'CLI_CODCLI'
                  HeaderAlignmentHorz = taCenter
                  Options.FilteringWithFindPanel = False
                  Options.Focusing = False
                  Options.FilteringAddValueItems = False
                  Options.FilteringFilteredItemsList = False
                  Options.FilteringMRUItemsList = False
                  Options.FilteringPopup = False
                  Options.FilteringPopupMultiSelect = False
                  Options.ShowCaption = False
                  Width = 24
                end
                object cxDadosTableViewColumn1: TcxGridDBColumn
                  Caption = 'Cliente'
                  DataBinding.FieldName = 'CLI_NOMCLI'
                end
                object cxDadosTableViewColumn2: TcxGridDBColumn
                  Caption = 'Cidade'
                  DataBinding.FieldName = 'CLI_CIDADE'
                end
                object cxDadosTableViewColumn3: TcxGridDBColumn
                  Caption = 'Status'
                  DataBinding.FieldName = 'CLI_STATUS'
                end
                object cxDadosTableViewColumn4: TcxGridDBColumn
                  Caption = 'Atividade'
                  DataBinding.FieldName = 'ATI_DESATI'
                end
                object cxDadosTableViewColumn5: TcxGridDBColumn
                  Caption = 'Vendedor'
                  DataBinding.FieldName = 'NOMVEN'
                end
                object cxDadosTableViewColumn6: TcxGridDBColumn
                  Caption = 'Representante'
                  DataBinding.FieldName = 'NOMREP'
                end
                object cxDadosTableViewColumn7: TcxGridDBColumn
                  Caption = 'Regi'#227'o'
                  DataBinding.FieldName = 'REG_DESREG'
                end
                object cxDadosTableViewColumn8: TcxGridDBColumn
                  Caption = 'Sub-regi'#227'o'
                  DataBinding.FieldName = 'SUB_DESSUB'
                end
                object cxDadosTableViewColumn9: TcxGridDBColumn
                  Caption = 'Rede de lojas'
                  DataBinding.FieldName = 'RED_DESRED'
                end
                object cxDadosTableViewColumn10: TcxGridDBColumn
                  Caption = 'Canal de acesso'
                  DataBinding.FieldName = 'CAC_NOMCAC'
                end
                object cxDadosTableViewColumn11: TcxGridDBColumn
                  Caption = 'Revista'
                  DataBinding.FieldName = 'CLI_REVIST'
                end
                object cxDadosTableViewColumn12: TcxGridDBColumn
                  Caption = 'Bol. por e-mail'
                  DataBinding.FieldName = 'CLI_ENVBOL'
                end
                object cxDadosTableViewColumn13: TcxGridDBColumn
                  Caption = 'E-mail'
                  DataBinding.FieldName = 'CLI_EMAIL_'
                end
                object cxDadosTableViewColumn14: TcxGridDBColumn
                  Caption = 'Org'#227'o P'#250'blico'
                  DataBinding.FieldName = 'CLI_ORGPUB'
                end
                object cxDadosTableViewColumn15: TcxGridDBColumn
                  Caption = 'Anivers'#225'rio'
                  DataBinding.FieldName = 'CLI_NASCIM'
                end
                object cxDadosTableViewColumn16: TcxGridDBColumn
                  Caption = 'Contato'
                  DataBinding.FieldName = 'CLI_NOMCTT'
                end
                object cxDadosTableViewColumn17: TcxGridDBColumn
                  Caption = 'Cargo contato'
                  DataBinding.FieldName = 'CAR_DESCAR'
                end
                object cxDadosTableViewColumn18: TcxGridDBColumn
                  Caption = 'Departamento contato'
                  DataBinding.FieldName = 'DEP_DESCRI'
                end
                object cxDadosTableViewColumn19: TcxGridDBColumn
                  Caption = 'Time de fut. contato'
                  DataBinding.FieldName = 'TFU_DESTFU'
                end
                object cxDadosTableViewColumn20: TcxGridDBColumn
                  Caption = 'Hobby contato'
                  DataBinding.FieldName = 'HOB_DESHOB'
                end
                object cxDadosTableViewColumn21: TcxGridDBColumn
                  Caption = 'Escolaridade contato'
                  DataBinding.FieldName = 'ESC_DESESC'
                end
                object cxDadosTableViewColumn22: TcxGridDBColumn
                  Caption = 'Gosto musical contato'
                  DataBinding.FieldName = 'GMU_DESGMU'
                end
                object cxDadosTableViewColumn23: TcxGridDBColumn
                  Caption = 'Estado civil contato'
                  DataBinding.FieldName = 'ECI_DESECI'
                end
                object cxDadosTableViewColumn24: TcxGridDBColumn
                  Caption = 'Anivers'#225'rio contato'
                  DataBinding.FieldName = 'CLI_NASCTT'
                end
                object cxDadosTableViewColumnESPORC: TcxGridDBColumn
                  Caption = 'Esp. Doc.'
                  DataBinding.FieldName = 'ESPORC'
                end
                object cxDadosTableViewColumnVLRORC: TcxGridDBColumn
                  Caption = 'Vlr. Doc'
                  DataBinding.FieldName = 'VLRORC'
                end
                object cxDadosTableViewColumn25: TcxGridDBColumn
                  Caption = 'Vendedor Ult.Compra'
                  DataBinding.FieldName = 'NOMULTVND'
                  Options.Editing = False
                end
                object cxDadosTableViewColumn26: TcxGridDBColumn
                  Caption = 'Digitador Ult.Compra'
                  DataBinding.FieldName = 'NOMULTDIG'
                  Options.Editing = False
                end
              end
              object cxDadosLevel1: TcxGridLevel
                GridView = cxDadosTableView
              end
            end
          end
          object tsDadosPromocaoGeral: TTabSheet
            Caption = 'Dados Promo'#231#227'o Geral'
            ImageIndex = 1
            object pnlPromocao: TPanel
              Left = 0
              Top = 0
              Width = 899
              Height = 635
              Align = alClient
              TabOrder = 0
            end
          end
          object tsDadosPromocaoPorCliente: TTabSheet
            Caption = 'Dados Promo'#231#227'o por Cliente'
            ImageIndex = 2
            object pnlPromocaoCliente: TPanel
              Left = 0
              Top = 0
              Width = 899
              Height = 635
              Align = alClient
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 732
    Top = 312
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 632
    Top = 312
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 596
    Top = 316
  end
  object imgLista: TImageList
    Left = 664
    Top = 316
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00D6D6D600D6D6D600D6D6D600DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      F700000000000000000000000000000000000000000000000000000000000000
      0000BDBDF7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BE7000000
      CE008484E7000000000000000000000000000000000000000000000000008484
      E7000000CE006B6BE70000000000000000000000000000000000C6E7C60008A5
      390010AD420008AD420063AD7300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDEF000000CE000000
      CE000000CE008484E700000000000000000000000000000000008484E7000000
      CE000000CE000000CE00BDBDEF0000000000000000000000000052B56B004AE7
      9C005AEFAD005AEFAD0021C66B0052A56B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484E7000000
      C6000000C6000000C6008484E70000000000000000008484E7000000C6000000
      C6000000C6008484E7000000000000000000000000000000000018B55A0063FF
      CE006BFFCE0052FFC6004AFFBD0018C66B0052A5630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      DE000000BD000000BD000000BD008484DE008484DE000000BD000000BD000000
      BD008484DE00000000000000000000000000000000009CCEA50010DE840029FF
      B50029FFAD0018FFAD0000FFA50010FF9C0008BD5A00429C5200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484DE000000B5000000B5000000B5000000B5000000B5000000B5008484
      DE00000000000000000000000000000000000000000042AD5A0000FF940000FF
      9C0008FFA50010FF9C0021FFA50031F7A50042EF9C0010B552004AA55A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484DE000000B5000000B5000000B5000000B5008484DE000000
      0000000000000000000000000000000000000000000000AD420000F7940029F7
      A5004AF7AD0063C68C005AE7A50073F7B5006BEFAD0063E79C0018AD4A00399C
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484D6000000AD000000AD000000AD000000AD008484D6000000
      00000000000000000000000000000000000094C6940010CE63004AEFA50063F7
      B50052CE7B0000000000ADD6B50052BD7B0084EFB50084E7AD0084D69C0029AD
      4A0039A54A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484D6000000A5000000A5000000A5000000A5000000A5000000A5008484
      D600000000000000000000000000000000007BC6840052DE940073E7AD006BEF
      AD0094CE9C000000000000000000D6E7D60063B5730094E7B50094DEAD009CDE
      AD0039AD52002994310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      D60000009C0000009C0000009C008484D6008484D6000000A5000000A5000000
      A5008484D600000000000000000000000000000000008CBD8C005AB573004AB5
      6B0000000000000000000000000000000000D6E7D6006BB57300ADE7BD00ADDE
      B500B5DEB50052AD630029943100D6EFD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484CE000000
      9C0000009C0000009C008484CE0000000000000000008484CE0000009C000000
      9C0000009C008484CE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000073B57B00C6E7
      C600BDDEBD00CEE7CE006BBD7B0073B573000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDDE00000094000000
      9400000094008484CE00000000000000000000000000000000008484CE000000
      94000000940000009400BDBDE700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BB5
      7B00DEEFDE00E7F7E700A5D6A500ADCEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BBD000000
      8C008484CE000000000000000000000000000000000000000000000000008484
      CE0000008C006B6BBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073A573008CBD8C00C6D6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      DE00000000000000000000000000000000000000000000000000000000000000
      0000BDBDDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FC1FFFFF00000000EFF7FFFF00000000
      C7E3C1FF0000000083C1C0FF00000000C183C07F00000000E007803F00000000
      F00F801F00000000F81F800F00000000F81F040700000000F00F060300000000
      E0078F0000000000C183FFC00000000083C1FFE000000000C7E3FFF100000000
      EFF7FFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 572
    Top = 393
  end
  object frxExpPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 640
    Top = 392
  end
  object frxRelJato: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    EngineOptions.MaxMemSize = 10000
    EngineOptions.UseFileCache = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.PagesInCache = 6
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.PictureCacheInFile = True
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43130.492521354200000000
    ReportOptions.LastChange = 43850.679751851850000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   pCarregarImagemProduto;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 568
    Top = 444
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 279.400000000000000000
      PaperHeight = 215.900000000000000000
      PaperSize = 1
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      OnAfterPrint = 'Page1OnAfterPrint'
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 130.015748030000000000
        Top = 181.417440000000000000
        Width = 1018.205382000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Columns = 4
        ColumnWidth = 254.362204724409000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object shpBorda: TfrxShapeView
          Width = 254.362204720000000000
          Height = 130.015748030000000000
        end
        object ImgProduto: TfrxPictureView
          Left = 3.000000000000000000
          Top = 3.913385830000010000
          Width = 103.385900000000000000
          Height = 116.409456140000000000
          OnAfterData = 'ImgProdutoOnAfterData'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Left = 110.000000000000000000
          Top = 77.913419999999970000
          Width = 141.732278580000000000
          Height = 15.118112680000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ref: [frxRelatorio."Refer'#234'ncia"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 110.000000000000000000
          Top = 22.677165350000000000
          Width = 141.732278580000000000
          Height = 45.354330710000000000
          DataField = 'Descri'#231#227'o'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."Descri'#231#227'o"]')
          ParentFont = False
        end
        object memPrePromo: TfrxMemoView
          Left = 178.031540000000000000
          Top = 99.173160000000000000
          Width = 73.700738580000010000
          Height = 22.677172680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Pre'#231'o"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 109.984251970000000000
          Top = 99.023619610000030000
          Width = 62.362148580000000000
          Height = 22.677167800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."Marca"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 109.606370000000000000
          Top = 3.779529999999994000
          Width = 141.732278580000000000
          Height = 15.118112680000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd: [frxRelatorio."C'#243'digo"]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 100.913420000000000000
        Top = 18.897650000000000000
        Width = 1018.205382000000000000
        object Memo5: TfrxMemoView
          Align = baCenter
          Left = 292.673237499999900000
          Top = 44.252010000000000000
          Width = 432.858907000000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -40
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMP_FONE01]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baRight
          Left = 736.527674999999900000
          Top = 22.677177560000000000
          Width = 281.677707000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[OPE_NOMOPE]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baRight
          Left = 736.527674999999900000
          Top = 45.354360000000000000
          Width = 281.677707000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[OPE_EMAIL_]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baRight
          Left = 736.870734499999900000
          Top = 68.031540000000010000
          Width = 281.334647500000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[EMP_HOMEPA]')
          ParentFont = False
          VAlign = vaCenter
        end
        object imgLogo: TfrxPictureView
          Align = baLeft
          Top = 3.779530000000001000
          Width = 150.047310000000000000
          Height = 85.795275590000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo8: TfrxMemoView
          Align = baCenter
          Left = 291.779715999999900000
          Top = 3.779530000000001000
          Width = 434.645950000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[TITULO]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 96.488257320000000000
        Top = 370.393940000000000000
        Width = 1018.205382000000000000
        object memObsPromocao: TfrxMemoView
          Align = baRight
          Left = 678.846951149999900000
          Width = 339.358430850000000000
          Height = 49.133875350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Promo'#231#227'o v'#225'lida at'#233' 00/00/0000')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Top = 0.000007320000008804
          Width = 603.453050850000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data e Hora da Emiss'#227'o da Promo'#231#227'o: [REL_EXEC]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Top = 26.456717320000000000
          Width = 603.453050850000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[EMP_ENDERE]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Top = 54.913427319999980000
          Width = 603.453050850000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[EMP_NOMCID]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 873.071430000000000000
          Top = 75.590607320000000000
          Width = 141.656710000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina: [Page]/[TotalPages]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
    end
  end
end
