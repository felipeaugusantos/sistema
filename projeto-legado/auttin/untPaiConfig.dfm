inherited frmPaiConfig: TfrmPaiConfig
  Left = 202
  Top = 130
  Caption = 'frmPaiConfig'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl
    inherited tbsGeral: TTabSheet
      Caption = '&1 - Geral'
      object dbgConfTinta: TcxGrid
        Left = 0
        Top = 0
        Width = 758
        Height = 437
        Align = alClient
        TabOrder = 0
        object dbgViewConfTinta: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = dtsConf
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsCustomize.GroupBySorting = True
          OptionsView.GroupByBox = False
          object dbgViewConfTintaCFG_CODCFG: TcxGridDBColumn
            DataBinding.FieldName = 'CFG_CODCFG'
            Visible = False
          end
          object dbgViewConfTintaCFG_DESCRI: TcxGridDBColumn
            Caption = 'Configura'#231#227'o'
            DataBinding.FieldName = 'CFG_DESCRI'
            Width = 218
          end
          object dbgViewConfTintaCFG_VALCFG: TcxGridDBColumn
            Caption = 'Valor'
            DataBinding.FieldName = 'CFG_VALCFG'
            Width = 112
          end
        end
        object dbgLvlConfTinta: TcxGridLevel
          GridView = dbgViewConfTinta
        end
      end
    end
    object tsConfConsulta: TTabSheet
      Caption = '&2 - Consulta'
      ImageIndex = 1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 685
    Top = 20
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 619
    Top = 20
  end
  object qryConf: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    Active = True
    RequestLive = False
    SQL.Strings = (
      'SELECT  '
      '  CFG_CODCFG,'
      '  CFG_VALCFG,'
      '  CFG_DESCRI,'
      '  CFG_GRUCFG'
      'FROM CFGTIN'
      'WHERE CFG_CODEMP = "001"'
      '    AND CFG_IDEPRO = "SUV"'
      '    AND CFG_GRUCFG = "CONFIGURACOES"')
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 718
    Top = 20
    object qryConfCFG_CODCFG: TStringField
      FieldName = 'CFG_CODCFG'
      Required = True
    end
    object qryConfCFG_VALCFG: TStringField
      FieldName = 'CFG_VALCFG'
      Size = 255
    end
    object qryConfCFG_DESCRI: TStringField
      FieldName = 'CFG_DESCRI'
      Size = 255
    end
    object qryConfCFG_GRUCFG: TStringField
      FieldName = 'CFG_GRUCFG'
      Required = True
      Size = 50
    end
  end
  object dtsConf: TDataSource
    DataSet = qryConf
    Left = 652
    Top = 20
  end
  object cxdtrpstryRepositorio: TcxEditRepository
    Left = 548
    Top = 20
    object rgbSimNao: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Sim'
          Value = 'S'
        end
        item
          Caption = 'Nao'
          Value = 'N'
        end>
    end
  end
end
