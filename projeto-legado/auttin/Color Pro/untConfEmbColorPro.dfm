object frmConfEmbColorPro: TfrmConfEmbColorPro
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  Align = alClient
  TabOrder = 0
  object grpVisiveis: TGroupBox
    Left = 0
    Top = 0
    Width = 451
    Height = 304
    Align = alClient
    Caption = 'Embalagens'
    Color = 16770261
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 0
    object dbgConsulta: TcxGrid
      Left = 1
      Top = 14
      Width = 449
      Height = 289
      Align = alClient
      DragMode = dmAutomatic
      TabOrder = 0
      DragOpening = False
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      object dbgViewConsulta: TcxGridDBTableView
        DragMode = dmAutomatic
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsEmb
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.CellMultiSelect = True
        OptionsView.NoDataToDisplayInfoText = '<N'#227'o h'#225' registros para serem mostrados>'
        OptionsView.ScrollBars = ssVertical
        object dbgViewConsultaDESLIN: TcxGridDBColumn
          Caption = 'Linha'
          DataBinding.FieldName = 'DESLIN'
          Visible = False
          GroupIndex = 0
          Width = 200
        end
        object dbgViewConsultaEMBALA: TcxGridDBColumn
          Caption = 'Embalagem'
          DataBinding.FieldName = 'EMBALA'
          Options.Editing = False
        end
        object dbgViewConsultaCODCFG: TcxGridDBColumn
          DataBinding.FieldName = 'CODCFG'
          Visible = False
          Options.Editing = False
        end
        object dbgViewConsultaVALCFG: TcxGridDBColumn
          Caption = 'Item'
          DataBinding.FieldName = 'VALCFG'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = '...'
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = dbgViewConsultaVALCFGPropertiesButtonClick
          Properties.OnValidate = dbgViewConsultaVALCFGPropertiesValidate
          VisibleForEditForm = bTrue
          Width = 70
        end
        object dbgViewConsultaDESCFG: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCFG'
          Options.Editing = False
          Width = 300
        end
      end
      object dbgLvlConsulta: TcxGridLevel
        GridView = dbgViewConsulta
      end
    end
  end
  object dtsPrevia: TDataSource
    DataSet = qryPrevia
    Left = 637
    Top = 20
  end
  object qryPrevia: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 702
    Top = 20
  end
  object cdsEmb: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 96
    object cdsEmbDESLIN: TStringField
      FieldName = 'DESLIN'
      Size = 70
    end
    object cdsEmbCODCFG: TStringField
      FieldName = 'CODCFG'
    end
    object cdsEmbVALCFG: TStringField
      FieldName = 'VALCFG'
      Size = 5
    end
    object cdsEmbDESCFG: TStringField
      FieldName = 'DESCFG'
      Size = 70
    end
    object cdsEmbEMBALA: TStringField
      FieldName = 'EMBALA'
      Size = 10
    end
  end
  object dtsEmb: TDataSource
    DataSet = cdsEmb
    Left = 208
    Top = 96
  end
end
