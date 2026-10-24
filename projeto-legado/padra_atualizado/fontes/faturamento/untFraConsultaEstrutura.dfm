object fraConsultaEstrutura: TfraConsultaEstrutura
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object cxDBTreeEstru: TcxDBTreeList
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    Bands = <
      item
        Caption.AlignHorz = taCenter
        Caption.Text = 'Estrutura Produto'
      end>
    DataController.ParentField = 'CODPAI'
    DataController.KeyField = 'CODITE'
    Navigator.Buttons.CustomButtons = <>
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsView.ScrollBars = ssNone
    OptionsView.Bands = True
    OptionsView.ColumnAutoWidth = True
    RootValue = -1
    TabOrder = 0
    object CODITE: TcxDBTreeListColumn
      Caption.Text = 'C'#243'digo'
      DataBinding.FieldName = 'CODITE'
      Width = 91
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object DESITE: TcxDBTreeListColumn
      BestFitMaxWidth = 185
      Caption.Text = 'Descri'#231#227'o'
      DataBinding.FieldName = 'DESITE'
      Width = 242
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object SALDIS: TcxDBTreeListColumn
      Caption.Text = 'Saldo Dispon'#237'vel'
      DataBinding.FieldName = 'SALDIS'
      Width = 116
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
      OnGetDisplayText = SALDISGetDisplayText
    end
  end
end
