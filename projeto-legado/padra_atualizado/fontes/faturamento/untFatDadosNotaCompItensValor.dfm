inherited frmFatDadosNotaCompItensValor: TfrmFatDadosNotaCompItensValor
  Left = 275
  Top = 145
  Width = 1099
  Height = 600
  VertScrollBar.Range = 45
  BorderStyle = bsSizeable
  Caption = 'Dados da Nota de Complemento / Cr'#233'dito'
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitLeft = -124
  ExplicitWidth = 1099
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 1083
    ExplicitTop = 519
    ExplicitWidth = 1083
    inherited btnSair: TBitBtnLocked
      Left = 302
      ExplicitLeft = 302
    end
  end
  inherited pgcDados: TPageControl
    Width = 1083
    Height = 519
    TabOrder = 1
    Visible = False
    ExplicitWidth = 1083
    ExplicitHeight = 519
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1075
      ExplicitHeight = 487
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 519
    Width = 1083
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
      Left = 992
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
    Width = 1083
    Height = 519
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object cxgItens: TcxGridCitel
      Left = 2
      Top = 2
      Width = 1079
      Height = 515
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgItensView: TcxGridDBBandedTableView
        OnKeyDown = cxgItensViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsItensNfe
        DataController.Options = [dcoAssignGroupingValues, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewvalortotal
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewvalortotalcomp
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewvalortotal
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewvalortotalcomp
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CellHints = True
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
            Width = 404
          end
          item
            Caption = 'VALOR COMPLEMENTAR'
            Options.Moving = False
            Styles.Header = cxsBands
            Width = 160
          end
          item
            Caption = 'IMPOSTOS'
            Options.Moving = False
            Styles.Header = cxsBands
            Width = 700
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
          Position.ColIndex = 3
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
          Width = 50
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
          Width = 133
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
          Width = 28
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewquantidade: TcxGridDBBandedColumn
          DataBinding.FieldName = 'quantidade'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 46
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgItensViewvalorunitario: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_unitario'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 53
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgItensViewdescesp: TcxGridDBBandedColumn
          Caption = 'Desc.Esp.'
          DataBinding.FieldName = 'des_esp'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 62
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object cxgItensViewvalortotal: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_total'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 71
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object cxgItensViewvalorunitcomp: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_unit_comp'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 75
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewvalortotalcomp: TcxGridDBBandedColumn
          DataBinding.FieldName = 'valor_total_comp'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewClaFis: TcxGridDBBandedColumn
          Caption = 'CFOP'
          DataBinding.FieldName = 'CLAFIS'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Sorting = False
          Width = 39
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewCodFis: TcxGridDBBandedColumn
          Caption = 'CST'
          DataBinding.FieldName = 'CODFIS'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Sorting = False
          Width = 26
          Position.BandIndex = 2
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewBasIcm: TcxGridDBBandedColumn
          Caption = 'Base ICMS'
          DataBinding.FieldName = 'BASICM'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 59
          Position.BandIndex = 2
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewAlqIcm: TcxGridDBBandedColumn
          Caption = 'Alq. ICMS'
          DataBinding.FieldName = 'ALQICM'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 53
          Position.BandIndex = 2
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgItensViewValIcm: TcxGridDBBandedColumn
          Caption = 'Val. ICMS'
          DataBinding.FieldName = 'VALICM'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 53
          Position.BandIndex = 2
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgItensViewBasIpi: TcxGridDBBandedColumn
          Caption = 'Base IPI'
          DataBinding.FieldName = 'BASIPI'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 45
          Position.BandIndex = 2
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgItensViewAlqIpi: TcxGridDBBandedColumn
          Caption = 'Alq. IPI'
          DataBinding.FieldName = 'ALQIPI'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 38
          Position.BandIndex = 2
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object cxgItensViewValIpi: TcxGridDBBandedColumn
          Caption = 'Val. IPI'
          DataBinding.FieldName = 'VALIPI'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 40
          Position.BandIndex = 2
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object cxgItensViewBasRet: TcxGridDBBandedColumn
          Caption = 'Base ICMS ST'
          DataBinding.FieldName = 'BASRET'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 79
          Position.BandIndex = 2
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object cxgItensViewValRet: TcxGridDBBandedColumn
          Caption = 'Val. ICMS ST'
          DataBinding.FieldName = 'VALRET'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Width = 71
          Position.BandIndex = 2
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object cxgItensViewBFCPST: TcxGridDBBandedColumn
          DataBinding.FieldName = 'BFCPST'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Position.BandIndex = 2
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object cxgItensViewVFCPST: TcxGridDBBandedColumn
          DataBinding.FieldName = 'VFCPST'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Options.Sorting = False
          Position.BandIndex = 2
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
      end
      object cxgItensLevel: TcxGridLevel
        GridView = cxgItensView
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1083
    TabOrder = 3
    ExplicitTop = 545
    ExplicitWidth = 1083
    inherited pnlNomeForm: TPanel
      Left = 905
      Width = 178
      ExplicitLeft = 905
      ExplicitWidth = 178
    end
    inherited pnlInfo: TPanel
      Width = 905
      ExplicitWidth = 905
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
    AfterPost = cdsItensNFeAfterPost
    Left = 360
    Top = 208
    object cdsItensNFeindex: TIntegerField
      FieldName = 'index'
      Visible = False
    end
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
    object cdsItensNFeunidade: TStringField
      Alignment = taCenter
      DisplayLabel = 'UN'
      FieldName = 'unidade'
      Size = 5
    end
    object cdsItensNFequantidade: TFloatField
      DisplayLabel = 'Qtd.'
      FieldName = 'quantidade'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_unitario: TFloatField
      DisplayLabel = 'Vr. Unit.'
      FieldName = 'valor_unitario'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFedes_esp: TFloatField
      DisplayLabel = 'Desc. Esp.'
      FieldName = 'des_esp'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_total: TFloatField
      DisplayLabel = 'Vr. Total'
      FieldName = 'valor_total'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_unit_comp: TFloatField
      DisplayLabel = 'Vr. Unit. Comp.'
      FieldName = 'valor_unit_comp'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFevalor_total_comp: TFloatField
      DisplayLabel = 'Vr. Total Comp.'
      FieldName = 'valor_total_comp'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeBASICM: TFloatField
      FieldName = 'BASICM'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeALQICM: TFloatField
      FieldName = 'ALQICM'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeVALICM: TFloatField
      FieldName = 'VALICM'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeBASIPI: TFloatField
      FieldName = 'BASIPI'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeALQIPI: TFloatField
      FieldName = 'ALQIPI'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeVALIPI: TFloatField
      FieldName = 'VALIPI'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeBASRET: TFloatField
      FieldName = 'BASRET'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeVALRET: TFloatField
      FieldName = 'VALRET'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeCLAFIS: TStringField
      FieldName = 'CLAFIS'
      Size = 4
    end
    object cdsItensNFeCODFIS: TStringField
      FieldName = 'CODFIS'
      Size = 3
    end
    object cdsItensNFeALQINE: TFloatField
      FieldName = 'ALQINE'
    end
    object cdsItensNFeALQUFD: TFloatField
      FieldName = 'ALQUFD'
    end
    object cdsItensNFeBCUFDE: TFloatField
      FieldName = 'BCUFDE'
    end
    object cdsItensNFePERFCP: TFloatField
      FieldName = 'PERFCP'
    end
    object cdsItensNFePERPAR: TFloatField
      FieldName = 'PERPAR'
    end
    object cdsItensNFeVALDES: TFloatField
      FieldName = 'VALDES'
    end
    object cdsItensNFeVALFCP: TFloatField
      FieldName = 'VALFCP'
    end
    object cdsItensNFeVALORI: TFloatField
      FieldName = 'VALORI'
    end
    object cdsItensNFeBASFCP: TFloatField
      FieldName = 'BASFCP'
    end
    object cdsItensNFeGRVINF: TBooleanField
      FieldName = 'GRVINF'
    end
    object cdsItensNFeBFCPST: TFloatField
      DisplayLabel = 'Base FCP ST'
      FieldName = 'BFCPST'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFeVFCPST: TFloatField
      DisplayLabel = 'Val. FCP ST'
      FieldName = 'VFCPST'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensNFePFCPST: TFloatField
      FieldName = 'PFCPST'
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
