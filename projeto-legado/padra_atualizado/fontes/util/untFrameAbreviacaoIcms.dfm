object frameAbreviacoesIcms: TframeAbreviacoesIcms
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object cxgDados: TcxGrid
    Left = 0
    Top = 17
    Width = 451
    Height = 288
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxbDados: TcxGridDBBandedTableView
      OnKeyDown = cxbDadosKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxbDadosCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      OnCustomDrawGroupCell = cxbDadosCustomDrawGroupCell
      Bands = <
        item
          FixedKind = fkLeft
          Width = 187
        end>
      object bABF_CODABF: TcxGridDBBandedColumn
        Caption = 'Abrevia'#231#227'o'
        DataBinding.FieldName = 'ABF_CODABF'
        GroupIndex = 0
        Options.Editing = False
        Width = 63
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object LOCAL: TcxGridDBBandedColumn
        Caption = 'Local'
        DataBinding.FieldName = 'LOCAL'
        Options.Editing = False
        Options.Sorting = False
        Width = 95
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object ABF_ESTADO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ESTADO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_ENT_PEF'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_ENT_PEJ'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_ENT_PER'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_ENT_PES'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_ENT_PSI'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_ENT_PII'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_SAI_NCO'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_SAI_CCO'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_SAI_CNC'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_SAI_SNA'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_SAI_CTA'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_SAI_PRU'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_SAI_IND'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODSIT_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODSIT_SAI_TRS'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASICM_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASICM_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQICM_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQICM_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASRET_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASRET_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRET_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRET_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_IVA_ST_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_IVA_ST_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQFCP_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQFCP_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQEFO_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQEFO_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQRED_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQRED_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_BASDDS_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_BASDDS_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODSIT_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODSIT_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASICM_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASICM_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQICM_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQICM_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASRET_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASRET_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRET_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRET_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IVA_ST_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IVA_ST_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQFCP_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQFCP_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQEFO_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQEFO_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQRED_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQRED_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_BASDDS_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_BASDDS_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_ALQIED_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_ALQIED_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ALQIED_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ALQIED_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ESTADO: TcxGridDBBandedColumn
        Caption = 'UF'
        DataBinding.FieldName = 'ABF_ESTADO'
        Options.Editing = False
        Options.CellMerging = True
        Options.Sorting = False
        Width = 29
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxbDadosPAGINA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'PAGINA'
        Visible = False
        Options.Editing = False
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object ABF_CODABF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODABF'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object ABF_MENS01_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS01_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS02_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS02_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS01_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS01_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS02_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS02_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS01_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS01_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS02_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS02_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS01_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS01_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS02_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS02_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS01_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS01_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS02_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS02_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS01_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS01_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS02_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS02_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS01_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS01_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS02_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS02_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS01_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS01_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS02_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS02_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS01_SAI_ORG: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS01_SAI_ORG'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_MENS02_SAI_ORG: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_MENS02_SAI_ORG'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS01_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS01_SAI_NCO'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS02_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS02_SAI_NCO'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS01_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS01_SAI_CCO'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS02_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS02_SAI_CCO'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS01_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS01_SAI_CNC'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS02_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS02_SAI_CNC'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS01_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS01_SAI_CTA'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS02_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS02_SAI_CTA'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS01_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS01_SAI_PRU'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS02_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS02_SAI_PRU'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS01_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS01_SAI_SNA'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS02_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS02_SAI_SNA'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS01_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS01_SAI_IND'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS02_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS02_SAI_IND'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS01_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS01_SAI_TRS'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS02_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS02_SAI_TRS'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS01_SAI_ORG: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS01_SAI_ORG'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_MENS02_SAI_ORG: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_MENS02_SAI_ORG'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_ENT_PEF'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_ENT_PEJ'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_ENT_PER'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_SAI_NCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_SAI_CCO'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_SAI_CNC'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_SAI_SNA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_SAI_CTA'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_SAI_PRU'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_SAI_IND'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_SAI_TRS'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_ENT_PII'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_ENT_PSI'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ABF_CODBEN_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ABF_CODBEN_ENT_PES'
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_ENT_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_ENT_PEF'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_ENT_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_ENT_PEJ'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_ENT_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_ENT_PER'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_SAI_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_SAI_NCO'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_SAI_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_SAI_CCO'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_SAI_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_SAI_CNC'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_SAI_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_SAI_SNA'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_SAI_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_SAI_CTA'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_SAI_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_SAI_PRU'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_SAI_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_SAI_IND'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_SAI_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_SAI_TRS'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_ENT_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_ENT_PII'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_ENT_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_ENT_PSI'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_CODBEN_ENT_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_CODBEN_ENT_PES'
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxbDados
    end
  end
  object pnlLegendas: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 17
    Align = alTop
    BevelOuter = bvNone
    Color = clInactiveBorder
    ParentBackground = False
    TabOrder = 1
    object lblDivergencias: TLabel
      Left = 14
      Top = 0
      Width = 110
      Height = 14
      Align = alLeft
      Caption = ' Item com diverg'#234'ncias'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object shpDivergencias: TShape
      Left = 0
      Top = 0
      Width = 14
      Height = 17
      Align = alLeft
      Brush.Color = clRed
      ExplicitLeft = 437
      ExplicitTop = 2
      ExplicitHeight = 14
    end
  end
  object dtsDados: TDataSource
    Left = 96
    Top = 24
  end
end
