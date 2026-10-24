inherited frmImportacaoSimilaridadeConfirma: TfrmImportacaoSimilaridadeConfirma
  Width = 1071
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Importa'#231#227'o de Similaridade - Confirma'#231#227'o'
  WindowState = wsMaximized
  ExplicitWidth = 1071
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 1055
    ExplicitTop = 519
    ExplicitWidth = 1055
    inherited FlwBotoes: TFlowPanel
      Width = 1051
      ExplicitWidth = 1051
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 968
      Top = 2
      ExplicitLeft = 968
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1055
    ExplicitTop = 545
    ExplicitWidth = 1055
    inherited pnlNomeForm: TPanel
      Left = 884
      ExplicitLeft = 884
    end
    inherited pnlInfo: TPanel
      Width = 884
      ExplicitWidth = 884
    end
  end
  object grpLegenda: TGroupBox [2]
    Left = 0
    Top = 479
    Width = 1055
    Height = 40
    Align = alBottom
    Caption = 'Legenda'
    TabOrder = 2
    object shpNaoImportados: TShape
      Left = 23
      Top = 19
      Width = 17
      Height = 15
      Brush.Color = clRed
    end
    object lblNaoImportados: TLabel
      Left = 46
      Top = 20
      Width = 169
      Height = 14
      Caption = 'Registro que n'#227'o ser'#227'o importados'
    end
  end
  object cxDados: TcxGridCitel [3]
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 1055
    Height = 479
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.DataSource = dtsItens
      DataController.DetailKeyFieldNames = 'LINHA'
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'ITE_CODITE'
      DataController.MasterKeyFieldNames = 'LINHA'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensViewLinha: TcxGridDBColumn
        Caption = 'Similares'
        DataBinding.FieldName = 'LINHA'
        Visible = False
        GroupIndex = 0
        Width = 64
      end
      object cxgItensViewCodIte: TcxGridDBColumn
        Caption = 'Codigo'
        DataBinding.FieldName = 'ITE_CODITE'
        Width = 80
      end
      object cxgItensViewDesIte: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
      end
      object cxgItensViewPRISIM: TcxGridDBColumn
        Caption = 'Principal'
        DataBinding.FieldName = 'ITE_PRISIM'
        Width = 80
      end
      object cxgItensViewCODSIM: TcxGridDBColumn
        Caption = 'Similaridade'
        DataBinding.FieldName = 'ITE_CODSIM'
        Width = 80
      end
      object cxgItensViewIMPORT: TcxGridDBColumn
        DataBinding.FieldName = 'IMPORT'
        Visible = False
        VisibleForEditForm = bTrue
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 152
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    Left = 96
    Top = 44
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 304
    Top = 244
  end
  object dtsItens: TDataSource
    Left = 392
    Top = 96
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 184
    Top = 216
    PixelsPerInch = 96
    object styDentro: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object styFora: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 8421631
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object styEditavel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 8454143
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clDefault
    end
  end
end
