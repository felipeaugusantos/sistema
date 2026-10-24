object fraImendesResultado: TfraImendesResultado
  Left = 0
  Top = 0
  Width = 986
  Height = 305
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  object cxgDados: TcxGrid
    Left = 0
    Top = 17
    Width = 986
    Height = 288
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitTop = 19
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
          Width = 363
        end>
      object IME_CODITE: TcxGridDBBandedColumn
        Caption = 'Item'
        DataBinding.FieldName = 'ITEM'
        OnGetDisplayText = IME_CODITEGetDisplayText
        GroupIndex = 0
        Options.Editing = False
        Width = 230
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object LOCAL: TcxGridDBBandedColumn
        Caption = 'Local'
        DataBinding.FieldName = 'LOCAL'
        Options.Editing = False
        Options.Sorting = False
        Width = 98
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
        Width = 20
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object IME_GERABF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'IME_GERABF'
        Visible = False
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object IME_SEMIME: TcxGridDBBandedColumn
        DataBinding.FieldName = 'IME_SEMIME'
        Visible = False
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object IME_RETPAR: TcxGridDBBandedColumn
        DataBinding.FieldName = 'IME_RETPAR'
        Visible = False
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_PISCOF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_PISCOF'
        Visible = False
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_IPI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_IPI'
        Visible = False
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_INF_GERAIS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_INF_GERAIS'
        Visible = False
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object IME_DIFICM: TcxGridDBBandedColumn
        DataBinding.FieldName = 'IME_DIFICM'
        Visible = False
        Options.Editing = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ITE_CLAIPI_: TcxGridDBBandedColumn
        Caption = 'NCM'
        DataBinding.FieldName = 'ITE_CLAIPI_'
        Options.Editing = False
        Width = 66
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ITE_CDCEST_: TcxGridDBBandedColumn
        Caption = 'CEST'
        DataBinding.FieldName = 'ITE_CDCEST_'
        Options.Editing = False
        Width = 66
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object IME_EXCIPI_: TcxGridDBBandedColumn
        Caption = 'EX IPI'
        DataBinding.FieldName = 'IME_EXCIPI_'
        Options.Editing = False
        Width = 33
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object ITE_CODLUB_: TcxGridDBBandedColumn
        Caption = 'C'#243'd. ANP'
        DataBinding.FieldName = 'ITE_CODLUB_'
        Options.Editing = False
        Width = 98
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ITE_CLAIPI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ITE_CLAIPI'
        Visible = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ITE_CDCEST: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ITE_CDCEST'
        Visible = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ITE_EXCIPI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_EXCIPI'
        Visible = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object DIF_ITE_CODLUB: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DIF_ITE_CODLUB'
        Visible = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object cxbDadosPAGINA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'PAGINA'
        Visible = False
        Options.Editing = False
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object ITE_CODBAR: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_CODBAR'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object TEM_MENSAGEM_PEF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_PEF'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_PEFPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_PEJ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_PEJ'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_PEJPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_PER: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_PER'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_PERPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_PES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_PES'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_PESPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_PSI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_PSI'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_PSIPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_PII: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_PII'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_PIIPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_NCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_NCO'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_NCOPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_CCO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_CCO'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_CCOPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_CNC: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_CNC'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_CNCPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_SNA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_SNA'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_SNAPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_CTA: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_CTA'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_CTAPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_PRU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_PRU'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_PRUPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_IND: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_IND'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_INDPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object TEM_MENSAGEM_TRS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_MENSAGEM_TRS'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = TEM_MENSAGEM_TRSPropertiesButtonClick
        OnGetDisplayText = TEM_MENSAGEM_PEFGetDisplayText
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object IME_SEMEAN: TcxGridDBBandedColumn
        DataBinding.FieldName = 'IME_SEMEAN'
        Visible = False
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxbDados
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 986
    Height = 17
    Align = alTop
    BevelOuter = bvNone
    Color = clInactiveBorder
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = -6
    object Label4: TLabel
      Left = 132
      Top = 2
      Width = 156
      Height = 14
      Caption = 'Item n'#227'o encontrado na iMendes'
      Font.Charset = ANSI_CHARSET
      Font.Color = 25600
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object Shape5: TShape
      Left = 116
      Top = 2
      Width = 14
      Height = 14
      Brush.Color = 25600
    end
    object Label7: TLabel
      Left = 457
      Top = 2
      Width = 107
      Height = 14
      Caption = 'Item com diverg'#234'ncias'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object Shape6: TShape
      Left = 437
      Top = 2
      Width = 14
      Height = 14
      Brush.Color = clRed
    end
    object Shape1: TShape
      Left = 298
      Top = 2
      Width = 14
      Height = 14
      Brush.Color = clTeal
    end
    object Label1: TLabel
      Left = 316
      Top = 2
      Width = 115
      Height = 14
      Caption = 'Item com retorno Parcial'
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object Shape2: TShape
      Left = 4
      Top = 2
      Width = 14
      Height = 14
      Brush.Color = clBlack
    end
    object Label2: TLabel
      Left = 23
      Top = 2
      Width = 87
      Height = 14
      Caption = 'Sem Diverg'#234'ncias'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object Label5: TLabel
      Left = 588
      Top = 2
      Width = 123
      Height = 14
      Caption = 'C'#243'digo de Barras Inv'#225'lido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clPurple
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object Shape3: TShape
      Left = 570
      Top = 2
      Width = 14
      Height = 14
      Brush.Color = clPurple
    end
    object Shape4: TShape
      Left = 719
      Top = 2
      Width = 14
      Height = 14
      Brush.Color = clBlue
    end
    object Label3: TLabel
      Left = 737
      Top = 2
      Width = 123
      Height = 14
      Caption = 'C'#243'digo de Barras Inv'#225'lido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
  end
  object dtsDados: TDataSource
    Left = 96
    Top = 24
  end
end
