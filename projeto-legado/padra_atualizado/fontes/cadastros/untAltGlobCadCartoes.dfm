inherited frmAltGlobCadCartoes: TfrmAltGlobCadCartoes
  Width = 1092
  Height = 598
  Caption = 'Altera'#231#227'o Global Cadastro de Cart'#245'es'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 1092
  ExplicitHeight = 598
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 525
    Width = 1086
    ExplicitTop = 525
    ExplicitWidth = 1086
    inherited FlwBotoes: TFlowPanel
      Width = 1082
      ExplicitWidth = 1082
      object btnConfirmaAlt: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 98
        Height = 24
        Align = alLeft
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaAltClick
      end
      object btnSair2: TBitBtnLocked
        Left = 98
        Top = 0
        Width = 98
        Height = 24
        Align = alLeft
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
        OnClick = btnSairClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 999
      Top = 6
      Visible = False
      ExplicitLeft = 999
      ExplicitTop = 6
    end
  end
  inherited pnlStatus: TPanel
    Top = 553
    Width = 1086
    ExplicitTop = 553
    ExplicitWidth = 1086
    inherited pnlNomeForm: TPanel
      Left = 915
      ExplicitLeft = 915
    end
    inherited pnlInfo: TPanel
      Width = 915
      ExplicitWidth = 915
    end
  end
  object pnFiltro: TPanel [2]
    Left = 0
    Top = 0
    Width = 1086
    Height = 33
    Align = alTop
    TabOrder = 2
    object btnDesmarcar: TBitBtnLocked
      Left = 102
      Top = 1
      Width = 120
      Height = 31
      Align = alLeft
      Caption = ' [F3] Desmarcar Todos'
      TabOrder = 0
      TabStop = False
      OnClick = btnDesmarcarClick
    end
    object btnMarcar: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 101
      Height = 31
      Align = alLeft
      Caption = '[F2] Marcar Todos'
      TabOrder = 1
      TabStop = False
      OnClick = btnMarcarClick
    end
    object btnLimpaFiltros: TBitBtnLocked
      Left = 222
      Top = 1
      Width = 108
      Height = 31
      Align = alLeft
      BiDiMode = bdLeftToRight
      Caption = '[F8] Limpa Filtros'
      ParentBiDiMode = False
      TabOrder = 2
      OnClick = btnLimpaFiltrosClick
    end
  end
  object GridCartoes: TcxGridCitel [3]
    Left = 0
    Top = 33
    Width = 1086
    Height = 492
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object GridTabCartoes: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.InfoText = 'Digite para pesquisar'
      FindPanel.ShowClearButton = False
      FindPanel.ShowFindButton = False
      DataController.DataSource = dsCartoes
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.BandMoving = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Bands = <
        item
          Caption = 'Dados Gerais'
          FixedKind = fkLeft
          HeaderAlignmentHorz = taLeftJustify
          Width = 532
        end
        item
          Caption = 'Configura'#231#227'o TEF'
          Width = 839
        end
        item
          Caption = 'Fiserv-CliSiTef'
          Position.BandIndex = 1
          Position.ColIndex = 0
          Width = 414
        end
        item
          Caption = 'Conex'#227'oTech-Scope'
          Position.BandIndex = 1
          Position.ColIndex = 1
          Width = 425
        end>
      object GridTabCartoesCAR_CODCAR: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CAR_CODCAR'
        Options.Editing = False
        Width = 53
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object GridTabCartoesCAR_DESCAR: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'CAR_DESCAR'
        Options.Editing = False
        Width = 155
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object GridTabCartoesCAR_STATUS: TcxGridDBBandedColumn
        Caption = 'Status'
        DataBinding.FieldName = 'CAR_STATUS'
        PropertiesClassName = 'TcxRadioGroupProperties'
        Properties.Columns = 2
        Properties.Items = <
          item
            Caption = 'N'#227'o'
            Value = 'N'
          end
          item
            Caption = 'Sim'
            Value = 'S'
          end>
        Width = 85
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object GridTabCartoesCAR_CODEMP: TcxGridDBBandedColumn
        Caption = 'C'#243'digo Empresa'
        DataBinding.FieldName = 'CAR_CODEMP'
        Options.Editing = False
        Width = 37
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object GridTabCartoesEMP_NOMFAN: TcxGridDBBandedColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMP_NOMFAN'
        Options.Editing = False
        Width = 202
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object GridTabCartoesCAR_TFTRED: TcxGridDBBandedColumn
        Caption = 'C'#243'digo Operadora'
        DataBinding.FieldName = 'CAR_TFTRED'
        PropertiesClassName = 'TcxTextEditProperties'
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object GridTabCartoesCAR_TFTBAN: TcxGridDBBandedColumn
        Caption = 'C'#243'digo Bandeira'
        DataBinding.FieldName = 'CAR_TFTBAN'
        PropertiesClassName = 'TcxTextEditProperties'
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object GridTabCartoesCAR_TFRED2: TcxGridDBBandedColumn
        Caption = 'C'#243'digo Operadora'
        DataBinding.FieldName = 'CAR_TFRED2'
        PropertiesClassName = 'TcxTextEditProperties'
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object GridTabCartoesCAR_TFBAN2: TcxGridDBBandedColumn
        Caption = 'C'#243'digo Bandeira'
        DataBinding.FieldName = 'CAR_TFBAN2'
        PropertiesClassName = 'TcxTextEditProperties'
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
    end
    object GridCartoesLevel: TcxGridLevel
      GridView = GridTabCartoes
    end
  end
  object dsCartoes: TDataSource
    AutoEdit = False
    Left = 888
    Top = 40
  end
  object GridPopupMenu: TcxGridPopupMenu
    Grid = GridCartoes
    PopupMenus = <>
    Left = 888
    Top = 88
  end
  object GuardaConfColGridAltGlobCadCartoes: TcxPropertiesStore
    Active = False
    Components = <
      item
        Component = GridTabCartoes
        Properties.Strings = (
          'Bands')
      end
      item
        Component = GridTabCartoesCAR_CODCAR
        Properties.Strings = (
          'Width')
      end
      item
        Component = GridTabCartoesCAR_CODEMP
        Properties.Strings = (
          'Width')
      end
      item
        Component = GridTabCartoesCAR_DESCAR
        Properties.Strings = (
          'Width')
      end
      item
        Component = GridTabCartoesCAR_STATUS
        Properties.Strings = (
          'Width')
      end
      item
        Component = GridTabCartoesCAR_TFBAN2
        Properties.Strings = (
          'Width')
      end
      item
        Component = GridTabCartoesCAR_TFRED2
        Properties.Strings = (
          'Width')
      end
      item
        Component = GridTabCartoesCAR_TFTBAN
        Properties.Strings = (
          'Width')
      end
      item
        Component = GridTabCartoesCAR_TFTRED
        Properties.Strings = (
          'Width')
      end
      item
        Component = GridTabCartoesEMP_NOMFAN
        Properties.Strings = (
          'Width')
      end>
    StorageName = 'GuardaConfColGridAltGlobCadCartoes'
    Left = 728
    Top = 248
  end
end
