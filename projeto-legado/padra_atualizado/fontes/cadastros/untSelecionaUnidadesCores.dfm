inherited frmSelecionaUnidadesCores: TfrmSelecionaUnidadesCores
  Width = 756
  Height = 554
  Caption = 'Selecionar Unidades e Cores'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 756
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 482
    Width = 750
    ExplicitTop = 482
    ExplicitWidth = 750
    DesignSize = (
      750
      28)
    inherited btnSair: TBitBtnLocked
      Left = 667
      ExplicitLeft = 667
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 4
      Width = 101
      Height = 21
      Caption = '[ F10 ] Confirmar'
      Enabled = False
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
    object btnSelCor: TBitBtnLocked
      Tag = 1
      Left = 107
      Top = 4
      Width = 105
      Height = 21
      Caption = 'Sele'#231#227'o'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000001E1E1E7E1E1E1E7E0000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000001E1E1E813C3C3CFF3C3C3CFF1E1E
        1E7E000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF1E1E1E7E0000000000000000000000000000000000000000000000000000
        000000000000000000001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF1E1E1E7E00000000000000000000000000000000000000000000
        0000000000001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF3C3C3CFF1E1E1E7E000000000000000000000000000000000000
        00001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 2
      OnClick = btnSelUniClick
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 750
    Height = 482
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 1
      Top = 187
      Width = 748
      Height = 2
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 150
      ExplicitWidth = 625
    end
    object pnlUnidades: TPanel
      Left = 1
      Top = 1
      Width = 748
      Height = 186
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object gbUnidades: TGroupBox
        Left = 1
        Top = 1
        Width = 746
        Height = 152
        Align = alClient
        Caption = 'Unidades'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object dbgUnidades: TcxGrid
          Left = 2
          Top = 16
          Width = 742
          Height = 134
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object dbgUnidadesDBTableView1: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = dbgUnidadesDBTableView1CustomDrawCell
            DataController.DataSource = dtsUnidades
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsSelection.UnselectFocusedRecordOnExit = False
            OptionsView.NoDataToDisplayInfoText = '<Nenhum registro para exibi'#231#227'o>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.GroupByBox = False
            object dbgUnidadesDBTableView1UNI_CODUNI: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'UNI_CODUNI'
              Visible = False
              Options.Editing = False
              Width = 70
            end
            object MARDES: TcxGridDBColumn
              Caption = 'Selecione'
              DataBinding.FieldName = 'UNI_MARDES'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 'M'
              Properties.ValueUnchecked = 'D'
              Properties.OnChange = MARDESPropertiesChange
              Options.Sorting = False
              Width = 70
            end
            object dbgUnidadesDBTableView1UNI_DESUNI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'UNI_DESUNI'
              Options.Editing = False
              Width = 150
            end
            object dbgUnidadesDBTableView1UNI_SIGUNI: TcxGridDBColumn
              Caption = 'Sigla'
              DataBinding.FieldName = 'UNI_SIGUNI'
              Options.Editing = False
              Width = 70
            end
            object dbgUnidadesDBTableView1COMPOSICAO: TcxGridDBColumn
              Caption = 'Composi'#231#227'o'
              DataBinding.FieldName = 'UNI_CODCOM'
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.KeyFieldNames = 'GCO_CODCOM'
              Properties.ListColumns = <
                item
                  FieldName = 'GCO_DESCOM'
                end>
              Properties.ListOptions.ColumnSorting = False
              Properties.ListOptions.ShowHeader = False
              Properties.ListSource = dtsGerCom
              Width = 336
            end
            object dbgUnidadesDBTableView1UNI_PESLIT: TcxGridDBColumn
              DataBinding.FieldName = 'UNI_PESLIT'
              Visible = False
            end
          end
          object dbgUnidadesLevel1: TcxGridLevel
            GridView = dbgUnidadesDBTableView1
          end
        end
      end
      object pnlLegUni: TPanel
        Left = 1
        Top = 153
        Width = 746
        Height = 32
        Align = alBottom
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object Label1: TLabel
          Left = 15
          Top = 10
          Width = 105
          Height = 14
          Caption = 'Legenda Unidades:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Shape1: TShape
          Left = 129
          Top = 7
          Width = 29
          Height = 17
          Brush.Color = clRed
          Pen.Color = clWhite
        end
        object Label2: TLabel
          Left = 164
          Top = 10
          Width = 216
          Height = 14
          Caption = 'Unidades sem Peso / Litro cadastrados'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnSelUni: TBitBtnLocked
          Left = 629
          Top = 4
          Width = 105
          Height = 21
          Caption = 'Sele'#231#227'o'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            20000000000000040000C40E0000C40E00000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000001E1E1E7E1E1E1E7E0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000001E1E1E813C3C3CFF3C3C3CFF1E1E
            1E7E000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF1E1E1E7E0000000000000000000000000000000000000000000000000000
            000000000000000000001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF1E1E1E7E00000000000000000000000000000000000000000000
            0000000000001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF3C3C3CFF1E1E1E7E000000000000000000000000000000000000
            00001E1E1E813C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 0
          OnClick = btnSelUniClick
        end
      end
    end
    object pnlCores: TPanel
      Left = 1
      Top = 189
      Width = 748
      Height = 292
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object gbCores: TGroupBox
        Left = 1
        Top = 1
        Width = 746
        Height = 258
        Align = alClient
        Caption = 'Cores'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object dbgCores: TcxGrid
          Left = 2
          Top = 16
          Width = 742
          Height = 240
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object dbgCoresDBTableView1: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = dbgCoresDBTableView1CustomDrawCell
            DataController.DataSource = dtsCores
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Nenhum registro para exibi'#231#227'o>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.GroupByBox = False
            object dbgCoresDBTableView1MARDES: TcxGridDBColumn
              Caption = 'Selecione'
              DataBinding.FieldName = 'COR_MARDES'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 'M'
              Properties.ValueUnchecked = 'D'
              Properties.OnChange = dbgCoresDBTableView1MARDESPropertiesChange
              Options.Sorting = False
              Width = 70
            end
            object dbgCoresDBTableView1COR_CODCOR: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'COR_CODCOR'
              Options.Editing = False
              Width = 70
            end
            object dbgCoresDBTableView1COR_DESCOR: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'COR_DESCOR'
              Options.Editing = False
              Width = 300
            end
            object dbgCoresDBTableView1COR_DESRES: TcxGridDBColumn
              Caption = 'Descri'#231#227'o Reduzida'
              DataBinding.FieldName = 'COR_DESRES'
              Options.Editing = False
              Width = 200
            end
            object dbgCoresDBTableView1FORMULA: TcxGridDBColumn
              DataBinding.FieldName = 'FORMULA'
              Visible = False
            end
          end
          object dbgCoresLevel1: TcxGridLevel
            GridView = dbgCoresDBTableView1
          end
        end
      end
      object pnlLegCor: TPanel
        Left = 1
        Top = 259
        Width = 746
        Height = 32
        Align = alBottom
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object Label3: TLabel
          Left = 15
          Top = 10
          Width = 88
          Height = 14
          Caption = 'Legenda Cores:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Shape2: TShape
          Left = 107
          Top = 7
          Width = 29
          Height = 17
          Brush.Color = clRed
          Pen.Color = clWhite
        end
        object Label4: TLabel
          Left = 142
          Top = 10
          Width = 187
          Height = 14
          Caption = 'Cores sem F'#243'rmulas cadastradas'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rdbComFor: TRadioButton
          Left = 392
          Top = 8
          Width = 138
          Height = 17
          Caption = 'Somente Com F'#243'rmulas'
          TabOrder = 0
          OnClick = rdbComForClick
        end
        object rdbSemFor: TRadioButton
          Left = 536
          Top = 8
          Width = 136
          Height = 17
          Caption = 'Somente Sem F'#243'rmulas'
          TabOrder = 1
          OnClick = rdbComForClick
        end
        object rdbTodos: TRadioButton
          Left = 678
          Top = 8
          Width = 50
          Height = 17
          Caption = 'Todos'
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = rdbComForClick
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 510
    Width = 750
    ExplicitTop = 510
    ExplicitWidth = 750
    inherited pnlNomeForm: TPanel
      Left = 579
      ExplicitLeft = 579
    end
    inherited pnlInfo: TPanel
      Width = 579
      ExplicitWidth = 579
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 32
  end
  object dtsUnidades: TDataSource
    DataSet = cdsUnidades
    Left = 24
    Top = 32
  end
  object cdsUnidades: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUnidades'
    Left = 56
    Top = 32
  end
  object qryUnidades: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 88
    Top = 32
  end
  object dspUnidades: TUniDataSetProvider
    DataSet = qryUnidades
    Options = []
    Left = 120
    Top = 32
  end
  object dtsCores: TDataSource
    DataSet = cdsCores
    Left = 144
    Top = 192
  end
  object cdsCores: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCores'
    Left = 176
    Top = 192
  end
  object qryCores: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 208
    Top = 192
  end
  object dspCores: TUniDataSetProvider
    DataSet = qryCores
    Options = []
    Left = 240
    Top = 192
  end
  object dtsGerCom: TDataSource
    DataSet = qryGerCom
    Left = 288
    Top = 40
  end
  object qryGerCom: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 318
    Top = 38
  end
  object popSelecao: TPopupMenu
    Left = 314
    Top = 374
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = MarcarTodos1Click
    end
    object DesmarcarTodos1: TMenuItem
      Tag = 1
      Caption = 'Desmarcar Todos'
      OnClick = MarcarTodos1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InverterSeleo1: TMenuItem
      Tag = 2
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = MarcarTodos1Click
    end
  end
end
