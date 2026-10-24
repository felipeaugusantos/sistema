object fraClienteResumo: TfraClienteResumo
  Left = 0
  Top = 0
  Width = 570
  Height = 185
  TabOrder = 0
  object cxDBVerticalGrid: TcxDBVerticalGrid
    Left = 0
    Top = 0
    Width = 570
    Height = 185
    Align = alClient
    OptionsView.ScrollBars = ssNone
    OptionsView.RowHeaderWidth = 283
    OptionsData.CancelOnExit = False
    OptionsData.Editing = False
    OptionsData.Appending = False
    OptionsData.Deleting = False
    OptionsData.DeletingConfirmation = False
    OptionsData.Inserting = False
    Navigator.Buttons.CustomButtons = <>
    TabOrder = 0
    TabStop = False
    DataController.DataSource = DataSource
    Version = 1
    object cxDBVerticalGridTipodeAbrevFiscaldeICMS: TcxDBEditorRow
      Options.Focusing = False
      Options.TabStop = False
      Properties.DataBinding.FieldName = 'Tipo de Abrev.Fiscal de ICMS'
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
    object cxDBVerticalGridZonaFranca: TcxDBEditorRow
      Options.Focusing = False
      Options.TabStop = False
      Properties.DataBinding.FieldName = 'Zona Franca?'
      ID = 1
      ParentID = -1
      Index = 1
      Version = 1
    end
    object cxDBVerticalGridSuframa: TcxDBEditorRow
      Options.Focusing = False
      Options.TabStop = False
      Properties.DataBinding.FieldName = 'Suframa:'
      ID = 2
      ParentID = -1
      Index = 2
      Version = 1
    end
    object cxDBVerticalGridValidadeSuframa: TcxDBEditorRow
      Options.Focusing = False
      Options.TabStop = False
      Properties.DataBinding.FieldName = 'Validade Suframa:'
      ID = 3
      ParentID = -1
      Index = 3
      Version = 1
    end
    object cxDBVerticalGridIndstria: TcxDBEditorRow
      Options.Focusing = False
      Options.TabStop = False
      Properties.DataBinding.FieldName = 'Ind'#250'stria?'
      ID = 4
      ParentID = -1
      Index = 4
      Version = 1
    end
    object cxDBVerticalGridrgoPblico: TcxDBEditorRow
      Options.Focusing = False
      Options.TabStop = False
      Properties.DataBinding.FieldName = #211'rg'#227'o P'#250'blico?'
      ID = 5
      ParentID = -1
      Index = 5
      Version = 1
    end
    object cxDBVerticalGridUtilizardiferimentodeICMS: TcxDBEditorRow
      Options.Focusing = False
      Options.TabStop = False
      Properties.DataBinding.FieldName = 'Utilizar diferimento de ICMS?'
      ID = 6
      ParentID = -1
      Index = 6
      Version = 1
    end
    object cxDBVerticalGridSujeitopassivoporSTatribuidaporregimeespecial: TcxDBEditorRow
      Options.Focusing = False
      Options.TabStop = False
      Properties.DataBinding.FieldName = 'Sujeito passivo por ST atribuida por regime especial?'
      ID = 7
      ParentID = -1
      Index = 7
      Version = 1
    end
    object cxDBVerticalGridIsenodeIPI: TcxDBEditorRow
      Options.Focusing = False
      Options.TabStop = False
      Properties.DataBinding.FieldName = 'Isen'#231#227'o de IPI?'
      ID = 8
      ParentID = -1
      Index = 8
      Version = 1
    end
    object cxDBVerticalGridBenefcioREIDI: TcxDBEditorRow
      Options.Focusing = False
      Options.TabStop = False
      Properties.DataBinding.FieldName = 'Benef'#237'cio REIDI?'
      ID = 9
      ParentID = -1
      Index = 9
      Version = 1
    end
  end
  object DataSource: TDataSource
    Left = 200
    Top = 32
  end
end
