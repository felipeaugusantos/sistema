inherited frmFatMostraItensFechamento: TfrmFatMostraItensFechamento
  Left = 482
  Top = 194
  Width = 1024
  Height = 538
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Informa'#231#245'es dos Produtos para Emiss'#227'o da Venda'
  Position = poDesigned
  WindowState = wsMaximized
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlStatus: TPanel [0]
    Top = 493
    Width = 1018
    TabOrder = 2
    ExplicitTop = 493
    ExplicitWidth = 1018
    inherited pnlInfo: TPanel [0]
      Width = 847
      ExplicitWidth = 847
    end
    inherited pnlNomeForm: TPanel [1]
      Left = 847
      ExplicitLeft = 847
    end
  end
  object pnlDados: TPanel [1]
    Left = 0
    Top = 0
    Width = 1018
    Height = 465
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object cxgItens: TcxGrid
      Left = 0
      Top = 0
      Width = 1018
      Height = 465
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgItensView: TcxGridDBBandedTableView
        OnKeyDown = cxgItensViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgItensViewCustomDrawCell
        DataController.DataSource = dtsItens
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewTOTITE
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewDESESP
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewVALFRE
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewDESACE
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewBASICM
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewVALICM
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewBASIPI
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewVALIPI
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewBASRET
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewVALRET
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewVLRCON
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewTOTITE
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewDESESP
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALFRE
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewDESACE
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewBASICM
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALICM
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewBASIPI
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALIPI
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewBASRET
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALRET
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVLRCON
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewDIFORI
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewDIFORI
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewDIFDES
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewDIFDES
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewTOTDIF
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewTOTDIF
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewVALFCP
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALFCP
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewVALFCPST
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALFCPST
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewBASPIS
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewBASPIS
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewVALPIS
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALPIS
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewBASCOF
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewBASCOF
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewVALCOF
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALCOF
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgItensViewICMORG
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewICMORG
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'TOTITE'
            Column = cxgItensViewTOTITE
            DisplayText = 'Total Item:'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'DESESP'
            Column = cxgItensViewDESESP
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'VALFRE'
            Column = cxgItensViewVALFRE
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'DESACE'
            Column = cxgItensViewDESACE
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'BASICM'
            Column = cxgItensViewBASICM
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'VALICM'
            Column = cxgItensViewVALICM
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'BASIPI'
            Column = cxgItensViewBASIPI
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'VALIPI'
            Column = cxgItensViewVALIPI
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'BASRET'
            Column = cxgItensViewBASRET
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'VALRET'
            Column = cxgItensViewVALRET
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'VLRCON'
            Column = cxgItensViewVLRCON
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewDIFDES
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewDIFORI
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewTOTDIF
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALFCP
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALFCPST
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewBASPIS
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALPIS
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewBASCOF
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewVALCOF
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgItensViewICMORG
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        OptionsView.FooterMultiSummaries = True
        OptionsView.GroupByHeaderLayout = ghlHorizontal
        OptionsView.GroupFooters = gfAlwaysVisible
        OptionsView.GroupSummaryLayout = gslAlignWithColumnsAndDistribute
        Styles.Footer = cxsFooter
        Styles.Group = cxsGroup
        Styles.GroupByBox = cxsGroup
        Styles.GroupFooterSortedSummary = cxsSummary
        Styles.GroupSortedSummary = cxsSummary
        Styles.GroupSummary = cxsSummary
        Bands = <
          item
            Caption = 'DADOS DO PRODUTO'
            Styles.Header = cxsBandHeader
            Width = 543
          end
          item
            Caption = 'DADOS FISCAIS'
            Styles.Header = cxsBandHeader
            Width = 93
          end
          item
            Caption = 'TOTAL PRODUTO'
            Styles.Header = cxsBandHeader
            Width = 173
          end
          item
            Caption = 'DESCONTOS / ACR'#201'SCIMOS'
            Styles.Header = cxsBandHeader
            Width = 211
          end
          item
            Caption = 'ICMS'
            Styles.Header = cxsBandHeader
            Width = 189
          end
          item
            Caption = 'IPI'
            Styles.Header = cxsBandHeader
            Width = 122
          end
          item
            Caption = 'ST'
            Styles.Header = cxsBandHeader
            Width = 224
          end
          item
            Caption = 'FCP ST'
            Styles.Header = cxsBandHeader
            Width = 227
          end
          item
            Caption = 'DIFAL'
            Styles.Header = cxsBandHeader
          end
          item
            Caption = 'FCP'
            Styles.Header = cxsBandHeader
            Width = 174
          end
          item
            Caption = 'PIS'
            Styles.Header = cxsBandHeader
          end
          item
            Caption = 'COFINS'
            Styles.Header = cxsBandHeader
          end
          item
            Caption = 'CBS'
            Styles.Header = cxsBandHeader
          end
          item
            Caption = 'IBS'
            Styles.Header = cxsBandHeader
          end
          item
            Caption = 'IS'
            Styles.Header = cxsBandHeader
          end
          item
            Caption = 'TOTAL GERAL'
            Styles.Header = cxsBandHeader
            Width = 86
          end>
        object cxgItensViewESPDOC: TcxGridDBBandedColumn
          Caption = 'Esp'#233'cie '
          DataBinding.FieldName = 'ESPDOC'
          Visible = False
          GroupIndex = 0
          Options.Editing = False
          Options.GroupFooters = False
          Options.Moving = False
          VisibleForCustomization = False
          Position.BandIndex = -1
          Position.ColIndex = -1
          Position.RowIndex = -1
        end
        object cxgItensViewCODITE: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CODITE'
          BestFitMaxWidth = 50
          Options.Editing = False
          Options.Moving = False
          Width = 53
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewDESITE: TcxGridDBBandedColumn
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Options.Moving = False
          Width = 68
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewREFERE: TcxGridDBBandedColumn
          DataBinding.FieldName = 'REFERE'
          Options.Editing = False
          Width = 74
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewCODFAB: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CODFAB'
          Options.Editing = False
          Width = 83
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgItensViewSIGUNI: TcxGridDBBandedColumn
          DataBinding.FieldName = 'SIGUNI'
          BestFitMaxWidth = 50
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Moving = False
          Width = 25
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgItensViewClaIPI: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CLAIPI'
          Width = 78
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgItensViewDesmar: TcxGridDBBandedColumn
          DataBinding.FieldName = 'DESMAR'
          Width = 45
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object cxgItensViewCodAbf: TcxGridDBBandedColumn
          Caption = 'Abrevia'#231#227'o Fiscal'
          DataBinding.FieldName = 'CODABF'
          Width = 102
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object cxgItensViewCODFIS: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CODFIS'
          BestFitMaxWidth = 50
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Moving = False
          Width = 26
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewCLAFIS: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CLAFIS'
          BestFitMaxWidth = 50
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Moving = False
          Width = 32
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewQTDITE: TcxGridDBBandedColumn
          DataBinding.FieldName = 'QTDITE'
          BestFitMaxWidth = 100
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 61
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewUNITAR: TcxGridDBBandedColumn
          DataBinding.FieldName = 'UNITAR'
          BestFitMaxWidth = 100
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 58
          Position.BandIndex = 2
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewTOTITE: TcxGridDBBandedColumn
          DataBinding.FieldName = 'TOTITE'
          BestFitMaxWidth = 200
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 49
          Position.BandIndex = 2
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewDESESP: TcxGridDBBandedColumn
          Caption = 'Desc. Espec.'
          DataBinding.FieldName = 'DESESP'
          BestFitMaxWidth = 100
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 70
          Position.BandIndex = 3
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewVALFRE: TcxGridDBBandedColumn
          DataBinding.FieldName = 'VALFRE'
          BestFitMaxWidth = 100
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 58
          Position.BandIndex = 3
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewDESACE: TcxGridDBBandedColumn
          DataBinding.FieldName = 'DESACE'
          BestFitMaxWidth = 100
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 70
          Position.BandIndex = 3
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewICMORG: TcxGridDBBandedColumn
          Caption = 'Desonerado'
          DataBinding.FieldName = 'ICMORG'
          BestFitMaxWidth = 100
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 70
          Position.BandIndex = 3
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgItensViewPERBAS: TcxGridDBBandedColumn
          Caption = '%BC'
          DataBinding.FieldName = 'PERBAS'
          Position.BandIndex = 4
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewBASICM: TcxGridDBBandedColumn
          Caption = 'Base'
          DataBinding.FieldName = 'BASICM'
          BestFitMaxWidth = 200
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 31
          Position.BandIndex = 4
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewALQICM: TcxGridDBBandedColumn
          Caption = 'Alq.'
          DataBinding.FieldName = 'ALQICM'
          BestFitMaxWidth = 40
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 24
          Position.BandIndex = 4
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewVALICM: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALICM'
          BestFitMaxWidth = 100
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 30
          Position.BandIndex = 4
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgItensViewBASIPI: TcxGridDBBandedColumn
          Caption = 'Base'
          DataBinding.FieldName = 'BASIPI'
          BestFitMaxWidth = 200
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 31
          Position.BandIndex = 5
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewALQIPI: TcxGridDBBandedColumn
          Caption = 'Alq.'
          DataBinding.FieldName = 'ALQIPI'
          BestFitMaxWidth = 40
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 24
          Position.BandIndex = 5
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewVALIPI: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALIPI'
          BestFitMaxWidth = 100
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 30
          Position.BandIndex = 5
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewIVA_ST: TcxGridDBBandedColumn
          DataBinding.FieldName = 'IVA_ST'
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Width = 52
          Position.BandIndex = 6
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewPEBAST: TcxGridDBBandedColumn
          Caption = '%BC'
          DataBinding.FieldName = 'PEBAST'
          Width = 38
          Position.BandIndex = 6
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewBASRET: TcxGridDBBandedColumn
          Caption = 'Base'
          DataBinding.FieldName = 'BASRET'
          BestFitMaxWidth = 200
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 59
          Position.BandIndex = 6
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewVALRET: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALRET'
          BestFitMaxWidth = 100
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 75
          Position.BandIndex = 6
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgItensViewVLRCON: TcxGridDBBandedColumn
          DataBinding.FieldName = 'VLRCON'
          BestFitMaxWidth = 200
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Moving = False
          Width = 72
          Position.BandIndex = 15
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewDIFORI: TcxGridDBBandedColumn
          Caption = 'Vlr. Difal Origem'
          DataBinding.FieldName = 'DIFORI'
          Width = 87
          Position.BandIndex = 8
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewDIFDES: TcxGridDBBandedColumn
          Caption = 'Vlr. Difal Destino'
          DataBinding.FieldName = 'DIFDES'
          Width = 87
          Position.BandIndex = 8
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewTOTDIF: TcxGridDBBandedColumn
          Caption = 'Total Difal'
          DataBinding.FieldName = 'TOTDIF'
          Width = 78
          Position.BandIndex = 8
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewALDIFAL: TcxGridDBBandedColumn
          Caption = 'Alq. Final Difal'
          DataBinding.FieldName = 'ALDIFA'
          Width = 76
          Position.BandIndex = 8
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgItensViewBASFCP: TcxGridDBBandedColumn
          Caption = 'Base FCP'
          DataBinding.FieldName = 'BASFCP'
          Position.BandIndex = 9
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewPERFCP: TcxGridDBBandedColumn
          Caption = '% FCP'
          DataBinding.FieldName = 'PERFCP'
          Width = 43
          Position.BandIndex = 9
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewVALFCP: TcxGridDBBandedColumn
          Caption = 'Valor FCP'
          DataBinding.FieldName = 'VALFCP'
          Width = 54
          Position.BandIndex = 9
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewBASFCPST: TcxGridDBBandedColumn
          Caption = 'Base FCP ST'
          DataBinding.FieldName = 'BASFCPST'
          Position.BandIndex = 7
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewPERFCPST: TcxGridDBBandedColumn
          Caption = '% FCP ST'
          DataBinding.FieldName = 'PERFCPST'
          Width = 39
          Position.BandIndex = 7
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewVALFCPST: TcxGridDBBandedColumn
          Caption = 'Valor FCP ST'
          DataBinding.FieldName = 'VALFCPST'
          Position.BandIndex = 7
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewBASPIS: TcxGridDBBandedColumn
          Caption = 'Base'
          DataBinding.FieldName = 'BASPIS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 10
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewALQPIS: TcxGridDBBandedColumn
          Caption = 'Al'#237'quota'
          DataBinding.FieldName = 'ALQPIS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 10
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewVALPIS: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALPIS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 10
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewBASCOF: TcxGridDBBandedColumn
          Caption = 'Base'
          DataBinding.FieldName = 'BASCOF'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 11
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewALQCOF: TcxGridDBBandedColumn
          Caption = 'Al'#237'quota'
          DataBinding.FieldName = 'ALQCOF'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 11
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewVALCOF: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALCOF'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 11
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewBASCBS: TcxGridDBBandedColumn
          Caption = 'Base'
          DataBinding.FieldName = 'BASCBS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 12
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewALQCBS: TcxGridDBBandedColumn
          Caption = 'Al'#237'quota'
          DataBinding.FieldName = 'ALQCBS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 12
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewVALCBS: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALCBS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 12
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewBASIBS: TcxGridDBBandedColumn
          Caption = 'Base'
          DataBinding.FieldName = 'BASIBS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 13
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewALQIBS: TcxGridDBBandedColumn
          Caption = 'Al'#237'quota'
          DataBinding.FieldName = 'ALQIBS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 13
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewVALIBS: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALIBS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 13
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensViewBAS_IS: TcxGridDBBandedColumn
          Caption = 'Base'
          DataBinding.FieldName = 'BAS_IS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 14
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensViewALQ_IS: TcxGridDBBandedColumn
          Caption = 'Al'#237'quota'
          DataBinding.FieldName = 'ALQ_IS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 14
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensViewVAL_IS: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VAL_IS'
          HeaderAlignmentHorz = taRightJustify
          Position.BandIndex = 14
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
      end
      object cxgItensLevel: TcxGridLevel
        GridView = cxgItensView
      end
    end
  end
  inherited pnlBotoes: TPanel [2]
    Top = 465
    Width = 1018
    TabOrder = 1
    ExplicitTop = 465
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 937
      ExplicitWidth = 937
      object btnExportaCSV: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 112
        Height = 22
        Caption = '[F8] Exportar CSV'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          001200000012000000110000000C000000030000000000000000000000087B50
          43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
          59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
          5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
          ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
          62FFFDFBFAFFCEAF69FFBA8D2CFFB68B2AFFB3892AFFB18728FFAF8526FFAD82
          25FFAA7F24FFA77D22FFA67C21FFA57A20FFA2761FFF6C4F14AD0000000BB079
          66FFFDFBFBFFBD932FFFDBC292FFFAF5F4FFF9F5F3FFB3892AFFF8F2F1FFF7F2
          EFFFD2B98AFFAA7E23FFC4A86EFFF5EEEAFFC2A66CFFA1791FFF0000000AB37C
          69FFFEFCFBFFC09430FFFBF7F6FFBB8E2DFFB88D2BFFB58B2AFFB3872AFFAF85
          27FFF7F2EFFFAC8124FFE4D5BCFFCEB686FFE2D3BAFFA37A20FF00000009B67F
          6CFFFEFDFCFFC19531FFFBF8F7FFBC922EFFBA8D2CFFB68C2BFFD7C08EFFF9F4
          F1FFD4BC8CFFAD8225FFF6F1EEFFA97E22FFF6EEEAFFA37B21FF00000009B983
          71FFFEFDFCFFC29732FFFCF8F8FFC0932FFFBB912FFFBA8D2DFFFAF5F3FFB489
          2AFFB18728FFAF8526FFF7F1EFFFAA7F24FFF6F0ECFFA67C21FF00000008BC88
          77FFFEFEFDFFC69933FFDFC996FFFCF8F8FFFAF8F7FFBB912EFFDAC291FFFAF5
          F4FFF8F3F0FFB18728FFF8F2F0FFAC8225FFF6F0EDFFA77D22FF00000007BF8C
          7AFFFEFEFDFFD7B871FFC39932FFC29532FFC09431FFBC922FFFBB8E2DFFB88D
          2CFFB58B2AFFB38729FFB18628FFAE8325FFAC8124FF735618AD00000006C18F
          7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
          82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
          85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
          89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
          67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
          87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
          0002000000030000000400000004000000050000000500000005000000060000
          0006000000060000000600000005000000010000000000000000}
        TabOrder = 0
        OnClick = btnExportaCSVClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 939
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 536
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 336
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 200
    object cdsItensESPDOC: TStringField
      DisplayLabel = 'Esp'#233'cie: '
      FieldName = 'ESPDOC'
      Size = 150
    end
    object cdsItensCODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsItensDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESITE'
      Size = 100
    end
    object cdsItensREFERE: TStringField
      DisplayLabel = 'Refer'#234'ncia'
      FieldName = 'REFERE'
      Size = 30
    end
    object cdsItensCODFAB: TStringField
      DisplayLabel = 'C'#243'd. F'#225'brica'
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsItensSIGUNI: TStringField
      DisplayLabel = 'UN'
      FieldName = 'SIGUNI'
      Size = 7
    end
    object cdsItensCODFIS: TStringField
      DisplayLabel = 'CST'
      FieldName = 'CODFIS'
      Size = 3
    end
    object cdsItensCLAFIS: TStringField
      DisplayLabel = 'CFOP'
      FieldName = 'CLAFIS'
      Size = 4
    end
    object cdsItensQTDITE: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QTDITE'
    end
    object cdsItensUNITAR: TFloatField
      DisplayLabel = 'Vlr Unit'#225'rio'
      FieldName = 'UNITAR'
    end
    object cdsItensTOTITE: TFloatField
      DisplayLabel = 'Total Item'
      FieldName = 'TOTITE'
    end
    object cdsItensDESESP: TFloatField
      DisplayLabel = 'Desc. Especial'
      FieldName = 'DESESP'
    end
    object cdsItensVALFRE: TFloatField
      DisplayLabel = 'Valor Frete'
      FieldName = 'VALFRE'
    end
    object cdsItensDESACE: TFloatField
      DisplayLabel = 'Desp. Acess.'
      FieldName = 'DESACE'
    end
    object cdsItensBASICM: TFloatField
      DisplayLabel = 'Base ICMS'
      FieldName = 'BASICM'
    end
    object cdsItensALQICM: TFloatField
      DisplayLabel = 'Alq. ICMS'
      FieldName = 'ALQICM'
    end
    object cdsItensVALICM: TFloatField
      DisplayLabel = 'Valor ICMS'
      FieldName = 'VALICM'
    end
    object cdsItensBASIPI: TFloatField
      DisplayLabel = 'Base IPI'
      FieldName = 'BASIPI'
    end
    object cdsItensALQIPI: TFloatField
      DisplayLabel = 'Alq. IPI'
      FieldName = 'ALQIPI'
    end
    object cdsItensVALIPI: TFloatField
      DisplayLabel = 'Valor IPI'
      FieldName = 'VALIPI'
    end
    object cdsItensBASRET: TFloatField
      DisplayLabel = 'Base Retido'
      FieldName = 'BASRET'
    end
    object cdsItensVALRET: TFloatField
      DisplayLabel = 'Valor Retido'
      FieldName = 'VALRET'
    end
    object cdsItensVLRCON: TFloatField
      DisplayLabel = 'Valor Cont'#225'bil'
      FieldName = 'VLRCON'
    end
    object cdsItensIVA_ST: TFloatField
      Alignment = taCenter
      DisplayLabel = 'IVA'
      FieldName = 'IVA_ST'
    end
    object cdsItensCLAIPI: TStringField
      DisplayLabel = 'NCM/Cla. IPI'
      FieldName = 'CLAIPI'
      Size = 10
    end
    object cdsItensDESMAR: TStringField
      DisplayLabel = 'Marca'
      FieldName = 'DESMAR'
      Size = 30
    end
    object cdsItensALDIFA: TFloatField
      FieldName = 'ALDIFA'
    end
    object cdsItensDIFDES: TFloatField
      FieldName = 'DIFDES'
    end
    object cdsItensDIFORI: TFloatField
      FieldName = 'DIFORI'
    end
    object cdsItensTOTDIF: TFloatField
      FieldName = 'TOTDIF'
    end
    object cdsItensBASFCP: TFloatField
      FieldName = 'BASFCP'
    end
    object cdsItensPERFCP: TFloatField
      FieldName = 'PERFCP'
    end
    object cdsItensVALFCP: TFloatField
      FieldName = 'VALFCP'
    end
    object cdsItensBASFCPST: TFloatField
      FieldName = 'BASFCPST'
    end
    object cdsItensPERFCPST: TFloatField
      FieldName = 'PERFCPST'
    end
    object cdsItensVALFCPST: TFloatField
      FieldName = 'VALFCPST'
    end
    object cdsItensCODABF: TStringField
      FieldName = 'CODABF'
      Size = 3
    end
    object cdsItensPERBAS: TFloatField
      FieldName = 'PERBAS'
    end
    object cdsItensPERBASST: TFloatField
      FieldName = 'PEBAST'
    end
    object cdsItensBASPIS: TFloatField
      FieldName = 'BASPIS'
    end
    object cdsItensALQPIS: TFloatField
      FieldName = 'ALQPIS'
    end
    object cdsItensVALPIS: TFloatField
      FieldName = 'VALPIS'
    end
    object cdsItensBASCOF: TFloatField
      FieldName = 'BASCOF'
    end
    object cdsItensALQCOF: TFloatField
      FieldName = 'ALQCOF'
    end
    object cdsItensVALCOF: TFloatField
      FieldName = 'VALCOF'
    end
    object cdsItensICMORG: TFloatField
      FieldName = 'ICMORG'
    end
    object cdsItensBASCBS: TFloatField
      FieldName = 'BASCBS'
    end
    object cdsItensALQCBS: TFloatField
      FieldName = 'ALQCBS'
    end
    object cdsItensVALCBS: TFloatField
      FieldName = 'VALCBS'
    end
    object cdsItensBASIBS: TFloatField
      FieldName = 'BASIBS'
    end
    object cdsItensALQIBS: TFloatField
      FieldName = 'ALQIBS'
    end
    object cdsItensVALIBS: TFloatField
      FieldName = 'VALIBS'
    end
    object cdsItensBAS_IS: TFloatField
      FieldName = 'BAS_IS'
    end
    object cdsItensALQ_IS: TFloatField
      FieldName = 'ALQ_IS'
    end
    object cdsItensVAL_IS: TFloatField
      FieldName = 'VAL_IS'
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 320
    Top = 200
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 696
    Top = 424
    PixelsPerInch = 96
    object cxsBandHeader: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxsFooter: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsSummary: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxsGroup: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
