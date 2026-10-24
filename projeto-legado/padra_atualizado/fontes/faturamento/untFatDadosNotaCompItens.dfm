inherited frmFatDadosNotaCompItens: TfrmFatDadosNotaCompItens
  Left = 275
  Top = 145
  Width = 1061
  Height = 500
  VertScrollBar.Range = 45
  BorderStyle = bsSizeable
  Caption = 'Dados da Nota de Complemento / Cr'#233'dito'
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 1061
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 419
    Width = 1045
    ExplicitTop = 419
    ExplicitWidth = 1045
    inherited FlwBotoes: TFlowPanel
      Width = 1041
      ExplicitWidth = 1041
    end
    inherited btnSair: TBitBtnLocked
      Left = 302
      ExplicitLeft = 302
    end
  end
  inherited pnlStatus: TPanel
    Top = 445
    Width = 1045
    TabOrder = 3
    ExplicitTop = 445
    ExplicitWidth = 1045
    inherited pnlNomeForm: TPanel
      Left = 867
      Width = 178
      ExplicitLeft = 867
      ExplicitWidth = 178
    end
    inherited pnlInfo: TPanel
      Width = 867
      ExplicitWidth = 867
    end
  end
  inherited pgcDados: TPageControl
    Width = 1045
    Height = 419
    TabOrder = 1
    Visible = False
    ExplicitWidth = 1045
    ExplicitHeight = 419
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1037
      ExplicitHeight = 387
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 419
    Width = 1045
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 119
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] &Confirma'
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
      OnClick = btnConfirmaDadosClick
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 954
      Top = 2
      Width = 89
      Height = 22
      Align = alRight
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnCancelaClick
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 1045
    Height = 419
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object cxgItens: TcxGridCitel
      Left = 2
      Top = 2
      Width = 1041
      Height = 415
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgItensView: TcxGridDBBandedTableView
        OnKeyDown = cxgItensViewKeyDown
        OnKeyPress = cxgItensViewKeyPress
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsItensNfe
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewbase_icms_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewvalor_icms_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewbase_icms_st_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewvalor_icms_st_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewbase_ipi_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewvalor_ipi_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewbase_icms
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewvalor_icms
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewbase_icms_st
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewvalor_icms_st
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewbase_ipi
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewvalor_ipi
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewbase_fcp_st
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewvalor_fcp_st
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewbase_fcp_icms
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewvalor_fcp_icms
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewValor_Difal
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewBase_Difal
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewbase_icms_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewvalor_icms_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewbase_icms_st_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewvalor_icms_st_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewbase_ipi_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewvalor_ipi_ori
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewbase_icms
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewvalor_icms
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewbase_icms_st
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewvalor_icms_st
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewbase_ipi
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewvalor_ipi
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewbase_fcp_st
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewvalor_fcp_st
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewbase_fcp_icms
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewvalor_fcp_icms
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewValor_Difal
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewBase_Difal
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CellHints = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' registros'
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfAlwaysVisible
        OptionsView.Indicator = True
        Styles.Group = cxsGroupHeader
        Bands = <
          item
            Caption = 'PRODUTOS DO DOCUMENTO '
            Options.Moving = False
            Styles.Header = cxsBands
            Width = 318
          end
          item
            Caption = 'IMPOSTOS EMISS'#195'O DO DOCUMENTO'
            Options.Moving = False
            Styles.Header = cxsBands
            Width = 600
          end
          item
            Caption = 'IMPOSTOS DOCUMENTO COMPLEMENTO / CR'#201'DITO'
            Options.Moving = False
            Styles.Header = cxsBands
            Width = 2000
          end>
        object cxgItensViewdocumento: TcxGridDBBandedColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'documento'
          Visible = False
          GroupIndex = 0
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Sorting = False
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgItensViewcodigo: TcxGridDBBandedColumn
          DataBinding.FieldName = 'codigo'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 55
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewdescricao: TcxGridDBBandedColumn
          DataBinding.FieldName = 'descricao'
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 176
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewunidade: TcxGridDBBandedColumn
          DataBinding.FieldName = 'unidade'
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 32
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewcfop: TcxGridDBBandedColumn
          DataBinding.FieldName = 'cfop'
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 36
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgItensViewcst: TcxGridDBBandedColumn
          DataBinding.FieldName = 'cst'
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 35
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgItensViewbase_icms_ori: TcxGridDBBandedColumn
          DataBinding.FieldName = 'base_icms_ori'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          MinWidth = 65
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIcms
          Width = 65
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewalq_icms_ori: TcxGridDBBandedColumn
          DataBinding.FieldName = 'alq_icms_ori'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          MinWidth = 65
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIcms
          Width = 65
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewvalor_icms_ori: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_icms_ori'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          MinWidth = 65
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIcms
          Width = 65
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewbase_icms_st_ori: TcxGridDBBandedColumn
          DataBinding.FieldName = 'base_icms_st_ori'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          MinWidth = 65
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsRetido
          Width = 65
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgItensViewvalor_icms_st_ori: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_icms_st_ori'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          MinWidth = 65
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsRetido
          Width = 65
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgItensViewbase_ipi_ori: TcxGridDBBandedColumn
          DataBinding.FieldName = 'base_ipi_ori'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIPI
          Width = 48
          Position.BandIndex = 1
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgItensViewalq_ipi_ori: TcxGridDBBandedColumn
          DataBinding.FieldName = 'alq_ipi_ori'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIPI
          Width = 36
          Position.BandIndex = 1
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object cxgItensViewvalor_ipi_ori: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_ipi_ori'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIPI
          Width = 48
          Position.BandIndex = 1
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object cxgItensViewbase_icms: TcxGridDBBandedColumn
          DataBinding.FieldName = 'base_icms'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          MinWidth = 65
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIcms
          Width = 65
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewalq_icms: TcxGridDBBandedColumn
          DataBinding.FieldName = 'alq_icms'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          MinWidth = 65
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIcms
          Width = 65
          Position.BandIndex = 2
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewvalor_icms: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_icms'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          MinWidth = 65
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIcms
          Width = 65
          Position.BandIndex = 2
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgItensViewbase_icms_st: TcxGridDBBandedColumn
          DataBinding.FieldName = 'base_icms_st'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsRetido
          Width = 52
          Position.BandIndex = 2
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object cxgItensViewvalor_icms_st: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_icms_st'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsRetido
          Width = 52
          Position.BandIndex = 2
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object cxgItensViewbase_ipi: TcxGridDBBandedColumn
          DataBinding.FieldName = 'base_ipi'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIPI
          Width = 51
          Position.BandIndex = 2
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object cxgItensViewalq_ipi: TcxGridDBBandedColumn
          DataBinding.FieldName = 'alq_ipi'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIPI
          Width = 40
          Position.BandIndex = 2
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object cxgItensViewvalor_ipi: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_ipi'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIPI
          Width = 53
          Position.BandIndex = 2
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object cxgItensViewbase_fcp_st: TcxGridDBBandedColumn
          DataBinding.FieldName = 'base_fcp_st'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsRetido
          Width = 66
          Position.BandIndex = 2
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
        object cxgItensViewalq_fcp_st: TcxGridDBBandedColumn
          DataBinding.FieldName = 'alq_fcp_st'
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsRetido
          Width = 69
          Position.BandIndex = 2
          Position.ColIndex = 12
          Position.RowIndex = 0
        end
        object cxgItensViewvalor_fcp_st: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_fcp_st'
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsRetido
          Width = 72
          Position.BandIndex = 2
          Position.ColIndex = 13
          Position.RowIndex = 0
        end
        object cxgItensViewbase_fcp_icms: TcxGridDBBandedColumn
          DataBinding.FieldName = 'base_fcp_icms'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsRetido
          Width = 78
          Position.BandIndex = 2
          Position.ColIndex = 14
          Position.RowIndex = 0
        end
        object cxgItensViewalq_fcp_icms: TcxGridDBBandedColumn
          DataBinding.FieldName = 'alq_fcp_icms'
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsRetido
          Width = 68
          Position.BandIndex = 2
          Position.ColIndex = 15
          Position.RowIndex = 0
        end
        object cxgItensViewvalor_fcp_icms: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_fcp_icms'
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsRetido
          Width = 74
          Position.BandIndex = 2
          Position.ColIndex = 16
          Position.RowIndex = 0
        end
        object cxgItensViewBase_Difal: TcxGridDBBandedColumn
          DataBinding.FieldName = 'base_difal'
          Styles.Content = cxsIcms
          Width = 58
          Position.BandIndex = 2
          Position.ColIndex = 17
          Position.RowIndex = 0
        end
        object cxgItensViewValor_Difal: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_difal'
          Styles.Content = cxsIcms
          Width = 58
          Position.BandIndex = 2
          Position.ColIndex = 18
          Position.RowIndex = 0
        end
        object cxgItensViewcst_pis: TcxGridDBBandedColumn
          Caption = 'CST PIS'
          DataBinding.FieldName = 'cst_pis'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.CharCase = ecUpperCase
          Properties.OnValidate = cxgItensViewcst_pisPropertiesValidate
          MinWidth = 45
          Width = 45
          Position.BandIndex = 2
          Position.ColIndex = 19
          Position.RowIndex = 0
        end
        object cxgItensViewbase_pis: TcxGridDBBandedColumn
          Caption = 'Base PIS'
          DataBinding.FieldName = 'base_pis'
          MinWidth = 65
          Width = 65
          Position.BandIndex = 2
          Position.ColIndex = 20
          Position.RowIndex = 0
        end
        object cxgItensViewaliquota_pis: TcxGridDBBandedColumn
          Caption = 'Alq. PIS'
          DataBinding.FieldName = 'aliquota_pis'
          MinWidth = 65
          Width = 65
          Position.BandIndex = 2
          Position.ColIndex = 21
          Position.RowIndex = 0
        end
        object cxgItensViewvalor_pis: TcxGridDBBandedColumn
          Caption = 'Valor PIS'
          DataBinding.FieldName = 'valor_pis'
          MinWidth = 65
          Position.BandIndex = 2
          Position.ColIndex = 22
          Position.RowIndex = 0
        end
        object cxgItensViewcst_cofins: TcxGridDBBandedColumn
          Caption = 'CST COFINS'
          DataBinding.FieldName = 'cst_cofins'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.CharCase = ecUpperCase
          Properties.OnValidate = cxgItensViewcst_cofinsPropertiesValidate
          MinWidth = 65
          Width = 65
          Position.BandIndex = 2
          Position.ColIndex = 23
          Position.RowIndex = 0
        end
        object cxgItensViewbase_cofins: TcxGridDBBandedColumn
          Caption = 'Base COFINS'
          DataBinding.FieldName = 'base_cofins'
          MinWidth = 70
          Position.BandIndex = 2
          Position.ColIndex = 24
          Position.RowIndex = 0
        end
        object cxgItensViewaliquota_cofins: TcxGridDBBandedColumn
          Caption = 'Alq. COFINS'
          DataBinding.FieldName = 'aliquota_cofins'
          MinWidth = 65
          Position.BandIndex = 2
          Position.ColIndex = 25
          Position.RowIndex = 0
        end
        object cxgItensViewvalor_cofins: TcxGridDBBandedColumn
          Caption = 'Valor COFINS'
          DataBinding.FieldName = 'valor_cofins'
          MinWidth = 70
          Position.BandIndex = 2
          Position.ColIndex = 26
          Position.RowIndex = 0
        end
        object cxgItensViewPerDif: TcxGridDBBandedColumn
          Caption = 'Perc.Diferimento'
          DataBinding.FieldName = 'PerDif'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Styles.Content = cxsIcms
          Width = 75
          Position.BandIndex = 2
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewIcmDif: TcxGridDBBandedColumn
          Caption = 'Icms Diferido'
          DataBinding.FieldName = 'IcmDif'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIcms
          Width = 65
          Position.BandIndex = 2
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgItensViewColumn1: TcxGridDBBandedColumn
          Caption = 'Icms Opera'#231#227'o'
          DataBinding.FieldName = 'IcmsOp'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Styles.Content = cxsIcms
          Width = 70
          Position.BandIndex = 2
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
      end
      object cxgItensLevel: TcxGridLevel
        GridView = cxgItensView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 208
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 264
    Top = 208
  end
  object dtsItensNfe: TDataSource
    DataSet = cdsItensNFe
    Left = 392
    Top = 208
  end
  object cdsItensNFe: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsItensNFeBeforePost
    Left = 360
    Top = 208
    object cdsItensNFedocumento: TStringField
      FieldName = 'documento'
    end
    object cdsItensNFeautoincremento: TStringField
      FieldName = 'autoincremento'
    end
    object cdsItensNFecodigo: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
      Size = 5
    end
    object cdsItensNFedescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 100
    end
    object cdsItensNFecfop: TStringField
      Alignment = taCenter
      DisplayLabel = 'CFOP'
      FieldName = 'cfop'
      Size = 4
    end
    object cdsItensNFecst_ori: TStringField
      FieldName = 'cst_ori'
      Size = 3
    end
    object cdsItensNFecst: TStringField
      Alignment = taCenter
      DisplayLabel = 'CST'
      FieldName = 'cst'
      Size = 3
    end
    object cdsItensNFeunidade: TStringField
      Alignment = taCenter
      DisplayLabel = 'UN'
      FieldName = 'unidade'
      Size = 5
    end
    object cdsItensNFebase_icms_ori: TFloatField
      DisplayLabel = 'Base Icms'
      FieldName = 'base_icms_ori'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFealq_icms_ori: TFloatField
      DisplayLabel = 'Alq. Icms'
      FieldName = 'alq_icms_ori'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_icms_ori: TFloatField
      DisplayLabel = 'Valor Icms'
      FieldName = 'valor_icms_ori'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFebase_icms_st_ori: TFloatField
      DisplayLabel = 'Base ST'
      FieldName = 'base_icms_st_ori'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_icms_st_ori: TFloatField
      DisplayLabel = 'Valor ST'
      FieldName = 'valor_icms_st_ori'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFebase_ipi_ori: TFloatField
      DisplayLabel = 'Base IPI'
      FieldName = 'base_ipi_ori'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFealq_ipi_ori: TFloatField
      DisplayLabel = 'Alq. IPI'
      FieldName = 'alq_ipi_ori'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_ipi_ori: TFloatField
      DisplayLabel = 'Valor IPI'
      FieldName = 'valor_ipi_ori'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFebase_icms: TFloatField
      DisplayLabel = 'Base Icms'
      FieldName = 'base_icms'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFealq_icms: TFloatField
      DisplayLabel = 'Alq. Icms'
      FieldName = 'alq_icms'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_icms: TFloatField
      DisplayLabel = 'Valor Icms'
      FieldName = 'valor_icms'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFebase_icms_st: TFloatField
      DisplayLabel = 'Base ST'
      FieldName = 'base_icms_st'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_icms_st: TFloatField
      DisplayLabel = 'Valor ST'
      FieldName = 'valor_icms_st'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFebase_ipi: TFloatField
      DisplayLabel = 'Base IPI'
      FieldName = 'base_ipi'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFealq_ipi: TFloatField
      DisplayLabel = 'Alq. IPI'
      FieldName = 'alq_ipi'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_ipi: TFloatField
      DisplayLabel = 'Valor IPI'
      FieldName = 'valor_ipi'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFebase_fcp_st: TFloatField
      DisplayLabel = 'Base FCP ST'
      FieldName = 'base_fcp_st'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFealq_fcp_st: TFloatField
      DisplayLabel = 'Alq.FCP ST'
      FieldName = 'alq_fcp_st'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_fcp_st: TFloatField
      DisplayLabel = 'Valor FCP ST'
      FieldName = 'valor_fcp_st'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFebase_fcp_icms: TFloatField
      DisplayLabel = 'Base FCP ICMS'
      FieldName = 'base_fcp_icms'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFealq_fcp_icms: TFloatField
      DisplayLabel = 'Alq.FCP ICMS'
      FieldName = 'alq_fcp_icms'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_fcp_icms: TFloatField
      DisplayLabel = 'Valor FCP ICMS'
      FieldName = 'valor_fcp_icms'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFebase_difal: TFloatField
      DisplayLabel = 'Base Difal'
      FieldName = 'base_difal'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_difal: TFloatField
      DisplayLabel = 'Valor Difal'
      FieldName = 'valor_difal'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFecst_pis: TStringField
      FieldName = 'cst_pis'
      Size = 2
    end
    object cdsItensNFecst_cofins: TStringField
      FieldName = 'cst_cofins'
      Size = 2
    end
    object cdsItensNFebase_pis: TFloatField
      FieldName = 'base_pis'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFebase_cofins: TFloatField
      FieldName = 'base_cofins'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFealiquota_pis: TFloatField
      FieldName = 'aliquota_pis'
      OnChange = cdsItensNFealiquota_pisChange
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFealiquota_cofins: TFloatField
      FieldName = 'aliquota_cofins'
      OnChange = cdsItensNFealiquota_cofinsChange
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_pis: TFloatField
      FieldName = 'valor_pis'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_cofins: TFloatField
      FieldName = 'valor_cofins'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeIcmsOp: TFloatField
      FieldName = 'IcmsOp'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFePerDif: TFloatField
      FieldName = 'PerDif'
      OnChange = cdsItensNFePerDifChange
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeIcmDif: TFloatField
      FieldName = 'IcmDif'
      DisplayFormat = '#,##0.00'
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 200
    Top = 208
    PixelsPerInch = 96
    object cxsBands: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxsIcms: TcxStyle
      AssignedValues = [svColor]
      Color = 10944511
    end
    object cxsIPI: TcxStyle
      AssignedValues = [svColor]
      Color = 13434828
    end
    object cxsRetido: TcxStyle
      AssignedValues = [svColor]
      Color = 16768959
    end
    object cxsGroupHeader: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
