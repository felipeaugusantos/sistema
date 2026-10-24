inherited frmConsultaServicosAutocenterTempoTot: TfrmConsultaServicosAutocenterTempoTot
  Width = 600
  Height = 550
  BorderIcons = [biSystemMenu]
  Caption = 'Tempo Total dos Servi'#231'os por Tipo de Servi'#231'o'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 600
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 479
    Width = 594
    Height = 26
    ExplicitTop = 479
    ExplicitWidth = 594
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 513
      Height = 22
      TabOrder = 1
      ExplicitWidth = 513
      ExplicitHeight = 22
      object btnExpand: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Caption = 'Expandir'
        Glyph.Data = {
          46030000424D460300000000000036000000280000000E0000000E0000000100
          2000000000001003000000000000000000000000000000000000767676FF8484
          85FF838383FF838383FF838383FF838383FF838383FF838383FF838383FF8383
          83FF838383FF838383FF848485FF767676FF848485FFC7C3C1FFC0BDBAFFC0BC
          BAFFC0BCBAFFC0BCBAFFC0BCBAFFC0BCBAFFC0BCBAFFC0BCBAFFC0BCBAFFC0BD
          BAFFC7C3C1FF848485FF838383FFC4C2BFFFB7B4B1FFB7B4B2FFB7B4B2FFB7B4
          B2FFB7B4B2FFB7B4B2FFB7B4B2FFB7B4B2FFB7B4B2FFB7B4B1FFC4C2BFFF8383
          83FF828383FFC7C4C3FFB3B0AEFFB3B0AEFFB3B0AEFFB3B0AEFFFFFFFFFFFFFF
          FFFFB3B0AEFFB3B0AEFFB3B0AEFFB3B0AEFFC7C4C3FF828383FF828383FFCAC7
          C5FFADAAA8FFADAAA8FFADAAA8FFADAAA8FFFFFFFFFFFFFFFFFFADAAA8FFADAA
          A8FFADAAA8FFADAAA8FFCAC7C5FF828383FF828283FFCCCAC8FFA7A3A1FFA4A1
          9EFFA29F9DFFA29F9CFFFFFFFFFFFFFFFFFFA29F9CFFA29F9DFFA4A19EFFA7A3
          A1FFCCCAC8FF828283FF828282FFD0CECDFFA09C9AFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA09C9AFFD0CECDFF8282
          82FF828282FFD4D2D1FF9B9895FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9895FFD4D2D1FF828282FF828282FFDAD9
          D6FF9A9794FF989593FF979491FF979391FFFFFFFFFFFFFFFFFF979391FF9794
          91FF989593FF9A9794FFDAD9D6FF828282FF818181FFE1DEDDFF989593FF9B98
          96FF9C9896FF9B9896FFFFFFFFFFFFFFFFFF9B9896FF9C9896FF9B9896FF9895
          93FFE1DEDDFF818181FF818181FFE6E5E4FF93908EFF979492FF989593FF9895
          93FFFFFFFFFFFFFFFFFF989593FF989593FF979492FF93908EFFE6E5E4FF8181
          81FF818181FFEEEDECFF8D8987FF908D8BFF918D8BFF918D8BFF918D8BFF918D
          8BFF918D8BFF918D8BFF908D8BFF8D8987FFEEEDECFF818181FF838383FFEEED
          ECFFEEEDECFFEEEDECFFEEEDECFFEEEDECFFEEEDECFFEEEDECFFEEEDECFFEEED
          ECFFEEEDECFFEEEDECFFEEEDECFF838383FF808080FF838484FF838383FF8383
          83FF838383FF838383FF838383FF838383FF838383FF838383FF838383FF8383
          83FF838484FF808080FF}
        TabOrder = 0
        OnClick = btnExpandClick
      end
      object btnCollapse: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 75
        Height = 22
        Caption = 'Agrupar'
        Glyph.Data = {
          46030000424D460300000000000036000000280000000E0000000E0000000100
          2000000000001003000000000000000000000000000000000000767676FF8484
          85FF838383FF838383FF838383FF838383FF838383FF838383FF838383FF8383
          83FF838383FF838383FF848485FF767676FF848485FFC7C3C1FFC0BDBAFFC0BC
          BAFFC0BCBAFFC0BCBAFFC0BCBAFFC0BCBAFFC0BCBAFFC0BCBAFFC0BCBAFFC0BD
          BAFFC7C3C1FF848485FF838383FFC4C2BFFFB7B4B1FFB7B4B2FFB7B4B2FFB7B4
          B2FFB7B4B2FFB7B4B2FFB7B4B2FFB7B4B2FFB7B4B2FFB7B4B1FFC4C2BFFF8383
          83FF828383FFC7C4C3FFB3B0AEFFB3B0AEFFB3B0AEFFB3B0AEFFB3B0AEFFB3B0
          AEFFB3B0AEFFB3B0AEFFB3B0AEFFB3B0AEFFC7C4C3FF828383FF828383FFCAC7
          C5FFADAAA8FFADAAA8FFADAAA8FFADAAA8FFADAAA8FFADAAA8FFADAAA8FFADAA
          A8FFADAAA8FFADAAA8FFCAC7C5FF828383FF828283FFCCCAC8FFA7A3A1FFA4A1
          9EFFA29F9DFFA29F9CFFA29F9CFFA29F9CFFA29F9CFFA29F9DFFA4A19EFFA7A3
          A1FFCCCAC8FF828283FF828282FFD0CECDFFA09C9AFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA09C9AFFD0CECDFF8282
          82FF828282FFD4D2D1FF9B9895FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9895FFD4D2D1FF828282FF828282FFDAD9
          D6FF9A9794FF989593FF979491FF979391FF979391FF979391FF979391FF9794
          91FF989593FF9A9794FFDAD9D6FF828282FF818181FFE1DEDDFF989593FF9B98
          96FF9C9896FF9B9896FF9B9896FF9B9896FF9B9896FF9C9896FF9B9896FF9895
          93FFE1DEDDFF818181FF818181FFE6E5E4FF93908EFF979492FF989593FF9895
          93FF989593FF989593FF989593FF989593FF979492FF93908EFFE6E5E4FF8181
          81FF818181FFEEEDECFF8D8987FF908D8BFF918D8BFF918D8BFF918D8BFF918D
          8BFF918D8BFF918D8BFF908D8BFF8D8987FFEEEDECFF818181FF838383FFEEED
          ECFFEEEDECFFEEEDECFFEEEDECFFEEEDECFFEEEDECFFEEEDECFFEEEDECFFEEED
          ECFFEEEDECFFEEEDECFFEEEDECFF838383FF808080FF838484FF838383FF8383
          83FF838383FF838383FF838383FF838383FF838383FF838383FF838383FF8383
          83FF838484FF808080FF}
        TabOrder = 1
        OnClick = btnCollapseClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 515
      Top = 2
      Align = alRight
      TabOrder = 0
      ExplicitLeft = 515
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 505
    Width = 594
    ExplicitTop = 505
    ExplicitWidth = 594
    inherited pnlNomeForm: TPanel
      Left = 374
      Width = 220
      ExplicitLeft = 374
      ExplicitWidth = 220
    end
    inherited pnlInfo: TPanel
      Width = 374
      ExplicitWidth = 374
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 594
    Height = 479
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object cxgTipSer: TcxGridCitel
      Left = 0
      Top = 0
      Width = 594
      Height = 479
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgTipSerTableView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawPartBackground = cxgTipSerTableViewCustomDrawPartBackground
        DataController.DataSource = dtsServ
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            Position = spFooter
            Column = cxgTipSerTableViewQTDSER
          end
          item
            Kind = skSum
            Position = spFooter
            OnGetText = FooterItemGetText
            Column = cxgTipSerTableViewTOTSER
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            Column = cxgTipSerTableViewQTDSER
          end
          item
            Kind = skSum
            OnGetText = FooterItemGetText
            Column = cxgTipSerTableViewTOTSER
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        Styles.Content = cxStyleBold
        Styles.Footer = cxStyleBold
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxgTipSerTableViewDESSER: TcxGridDBColumn
          Caption = 'Descri'#231#227'o do Servi'#231'o'
          DataBinding.FieldName = 'DESSER'
          SortIndex = 0
          SortOrder = soAscending
          Width = 310
        end
        object cxgTipSerTableViewTIPSER: TcxGridDBColumn
          Caption = 'Tipo de Servi'#231'o'
          DataBinding.FieldName = 'TIPSER'
          Visible = False
          GroupIndex = 0
          Width = 220
        end
        object cxgTipSerTableViewQTDSER: TcxGridDBColumn
          Caption = 'Qtde. Servi'#231'os'
          DataBinding.FieldName = 'QTDSER'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          FooterAlignmentHorz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 80
        end
        object cxgTipSerTableViewTMPSER: TcxGridDBColumn
          Caption = 'Tempo M'#233'dio'
          DataBinding.FieldName = 'TMPSER'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          FooterAlignmentHorz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 80
        end
        object cxgTipSerTableViewTOTSER: TcxGridDBColumn
          Caption = 'Tempo Total'
          DataBinding.FieldName = 'TOTSER'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          FooterAlignmentHorz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 80
        end
      end
      object cxgTipSerLevel: TcxGridLevel
        GridView = cxgTipSerTableView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 732
    Top = 130
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 684
    Top = 66
  end
  object dtsServ: TDataSource
    Left = 440
    Top = 80
  end
  object cxStyleRepo: TcxStyleRepository
    Left = 80
    Top = 200
    PixelsPerInch = 96
    object cxStyleBold: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
  end
end
