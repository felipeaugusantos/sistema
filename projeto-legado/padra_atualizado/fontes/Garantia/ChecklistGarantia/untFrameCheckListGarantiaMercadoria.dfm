object frameCheckListGarantiaMercadoria: TframeCheckListGarantiaMercadoria
  Left = 0
  Top = 0
  Width = 837
  Height = 240
  TabOrder = 0
  object pnlFraChkGar: TPanel
    AlignWithMargins = True
    Left = 1
    Top = 1
    Width = 835
    Height = 238
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlFraChkGar'
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 3
      Width = 224
      Height = 15
      Margins.Left = 4
      Align = alTop
      Caption = 'Checklist de Valida'#231#227'o de Mercadoria'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDelete: TLabel
      Left = 0
      Top = 194
      Width = 171
      Height = 13
      Align = alBottom
      Caption = '  Para Excluir pressione CTRL + DEL'
    end
    object pnlFraChkGarBtn: TPanel
      Left = 0
      Top = 207
      Width = 835
      Height = 31
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlFraChkGarBtn'
      ShowCaption = False
      TabOrder = 0
      object btnMarcarTodos: TBitBtnLocked
        Tag = 1
        Left = 3
        Top = 3
        Width = 182
        Height = 25
        Caption = 'Marcar todos'
        Enabled = False
        TabOrder = 0
        Visible = False
        OnClick = btnMarcarTodosClick
      end
      object btnEditar: TBitBtnLocked
        Left = 191
        Top = 3
        Width = 146
        Height = 25
        Caption = 'Editar Conte'#250'do'
        Enabled = False
        TabOrder = 1
        Visible = False
        OnClick = btnEditarClick
      end
      object btnExtrairJson: TBitBtnLocked
        Left = 343
        Top = 3
        Width = 140
        Height = 25
        Caption = 'Extrair p/Transf.'
        Enabled = False
        TabOrder = 2
        OnClick = btnExtrairJsonClick
      end
    end
    object cxGrid1: TcxGrid
      Left = 0
      Top = 18
      Width = 835
      Height = 176
      Align = alClient
      TabOrder = 1
      ExplicitTop = 12
      object cxGrid1DBTableView1: TcxGridDBTableView
        OnDblClick = cxGrid1DBTableView1DblClick
        OnKeyDown = cxGrid1DBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = cxGrid1DBTableView1CellClick
        DataController.DataSource = dtsDados
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.Visible = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxGrid1DBTableView1CVG_DESCRI: TcxGridDBColumn
          DataBinding.FieldName = 'CVG_DESCRI'
          Options.Editing = False
          Width = 200
        end
        object cxGrid1DBTableView1CVG_CODIGO: TcxGridDBColumn
          DataBinding.FieldName = 'CVG_CODIGO'
          Options.Editing = False
          Width = 80
        end
        object cxGrid1DBTableView1ITE_CONTEU: TcxGridDBColumn
          DataBinding.FieldName = 'ITE_CONTEU'
          Options.Editing = False
          Width = 600
        end
        object cxGrid1DBTableView1CVG_TIPOVG: TcxGridDBColumn
          DataBinding.FieldName = 'CVG_TIPOVG'
          Visible = False
          Options.Editing = False
          Width = 80
        end
        object cxGrid1DBTableView1CVG_TIPORE: TcxGridDBColumn
          DataBinding.FieldName = 'CVG_TIPORE'
          Visible = False
          Options.Editing = False
          Width = 80
        end
        object cxGrid1DBTableView1ITE_AUTINC: TcxGridDBColumn
          DataBinding.FieldName = 'ITE_AUTINC'
          Visible = False
          Options.Editing = False
        end
        object cxGrid1DBTableView1AUTOINCREM: TcxGridDBColumn
          DataBinding.FieldName = 'AUTOINCREM'
          Visible = False
          Options.Editing = False
        end
        object cxGrid1DBTableView1ASSOCIADO: TcxGridDBColumn
          DataBinding.FieldName = 'ASSOCIADO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayChecked = '1'
          Properties.DisplayUnchecked = '0'
          Properties.FullFocusRect = True
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Properties.OnValidate = cxGrid1DBTableView1ASSOCIADOPropertiesValidate
          Visible = False
          Width = 80
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object dtsDados: TDataSource
    AutoEdit = False
    DataSet = cdsDados
    Left = 761
    Top = 81
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CVG_TIPORE;CVG_DESCRI;CVG_CODIGO'
    Params = <>
    Left = 729
    Top = 49
    object cdsDadosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsDadosCVG_CODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CVG_CODIGO'
      Size = 5
    end
    object cdsDadosCVG_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'CVG_DESCRI'
      Size = 60
    end
    object cdsDadosCVG_TIPORE: TStringField
      FieldName = 'CVG_TIPORE'
      Size = 1
    end
    object cdsDadosCVG_TIPOVG: TStringField
      FieldName = 'CVG_TIPOVG'
      Size = 1
    end
    object cdsDadosASSOCIADO: TStringField
      DisplayLabel = 'Associado'
      FieldName = 'ASSOCIADO'
      Size = 1
    end
    object cdsDadosSITUACAO: TStringField
      FieldName = 'SITUACAO'
      Size = 1
    end
    object cdsDadosITE_CONTEU: TStringField
      DisplayLabel = 'Conte'#250'do'
      FieldName = 'ITE_CONTEU'
      Size = 256
    end
    object cdsDadosITE_AUTINC: TStringField
      FieldName = 'ITE_AUTINC'
    end
    object cdsDadosITE_CODITE: TStringField
      FieldName = 'ITE_CODITE'
      Size = 5
    end
  end
end
