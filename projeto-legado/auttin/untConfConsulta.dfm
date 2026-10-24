object frmConfConsulta: TfrmConfConsulta
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  Align = alClient
  TabOrder = 0
  object grpVisiveis: TGroupBox
    Left = 0
    Top = 0
    Width = 297
    Height = 185
    Align = alClient
    Caption = 'Colunas Visiveis'
    Color = 16770261
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 1
    object dbgConsulta: TcxGrid
      Left = 1
      Top = 14
      Width = 295
      Height = 170
      Align = alClient
      DragMode = dmAutomatic
      TabOrder = 0
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgViewConsulta: TcxGridDBTableView
        DragMode = dmAutomatic
        OnDragDrop = dbgViewConsultaDragDrop
        OnDragOver = dbgViewConsultaDragOver
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsPrevia
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Editing = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.CellMultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<N'#227'o h'#225' registros para serem mostrados>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.GroupByBox = False
        OnColumnHeaderClick = dbgViewConsultaColumnHeaderClick
        OnColumnPosChanged = dbgViewConsultaColumnPosChanged
        OnColumnSizeChanged = dbgViewConsultaColumnSizeChanged
        OnCustomDrawColumnHeader = dbgViewConsultaCustomDrawColumnHeader
      end
      object dbgLvlConsulta: TcxGridLevel
        GridView = dbgViewConsulta
      end
    end
  end
  object grpDisponiveis: TGroupBox
    Left = 297
    Top = 0
    Width = 154
    Height = 185
    Align = alRight
    Caption = 'Colunas Disponiveis'
    Color = 16770261
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 2
    object lstDisponiveis: TListBox
      Left = 1
      Top = 14
      Width = 152
      Height = 170
      Align = alClient
      DragMode = dmAutomatic
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
      OnDragDrop = lstDisponiveisDragDrop
      OnDragOver = lstDisponiveisDragOver
    end
  end
  object grpIndices: TGroupBox
    Left = 0
    Top = 219
    Width = 451
    Height = 85
    Align = alBottom
    Caption = 'Indices'
    Color = 16770261
    Ctl3D = False
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 3
    object lstIndices: TListBox
      Left = 1
      Top = 14
      Width = 449
      Height = 70
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      OnDragDrop = lstIndicesDragDrop
      OnDragOver = lstIndicesDragOver
      OnKeyUp = lstIndicesKeyUp
    end
  end
  object grpPreviaTexto: TGroupBox
    Left = 0
    Top = 185
    Width = 451
    Height = 34
    Align = alBottom
    Caption = 'Descri'#231#227'o da Tinta'
    Color = 16770261
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    OnDragDrop = grpPreviaTextoDragDrop
    OnDragOver = grpPreviaTextoDragOver
    object lblPreviaTexto: TLabel
      Left = 1
      Top = 14
      Width = 82
      Height = 19
      Align = alLeft
      Caption = 'lblPreviaTexto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnDragDrop = grpPreviaTextoDragDrop
      OnDragOver = grpPreviaTextoDragOver
      ExplicitHeight = 13
    end
    object btnLimparDescri: TSpeedButton
      Left = 377
      Top = 14
      Width = 73
      Height = 19
      Align = alRight
      Caption = 'Limpar...'
      Flat = True
      OnClick = btnLimparDescriClick
      ExplicitLeft = 208
      ExplicitTop = 8
      ExplicitHeight = 22
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
    Constraints = <>
    Left = 702
    Top = 20
  end
end
