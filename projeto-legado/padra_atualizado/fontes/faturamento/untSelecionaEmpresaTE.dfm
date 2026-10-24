inherited frmSelecionaEmpresaTE: TfrmSelecionaEmpresaTE
  Width = 593
  Height = 425
  BorderIcons = [biSystemMenu]
  Caption = 
    'Informe a Empresa que atender'#225' este documento atrav'#233's de Transfe' +
    'r'#234'ncia de Estoque'
  Position = poMainFormCenter
  ExplicitWidth = 593
  ExplicitHeight = 425
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 353
    Width = 587
    ExplicitTop = 353
    ExplicitWidth = 587
    inherited btnSair: TBitBtnLocked
      Left = 504
      ExplicitLeft = 504
    end
  end
  object gridEmpresas: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 587
    Height = 353
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object gridEmpresasDBTableView1: TcxGridDBTableView
      OnKeyDown = gridEmpresasDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = dtsCadEmp
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object gridEmpresasCODEMP: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODEMP'
        Options.Editing = False
        Width = 50
      end
      object gridEmpresasNOMEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'NOMEMP'
        Options.Editing = False
        Width = 500
      end
    end
    object gridEmpresasLevel1: TcxGridLevel
      GridView = gridEmpresasDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 381
    Width = 587
    ExplicitTop = 381
    ExplicitWidth = 587
    inherited pnlNomeForm: TPanel
      Left = 416
      ExplicitLeft = 416
    end
    inherited pnlInfo: TPanel
      Width = 416
      ExplicitWidth = 416
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 32
  end
  object qryCadEmp: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 360
    Top = 32
  end
  object dspCadEmp: TUniDataSetProvider
    DataSet = qryCadEmp
    Options = []
    Left = 392
    Top = 32
  end
  object cdsCadEmp: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCadEmp'
    Left = 424
    Top = 32
  end
  object dtsCadEmp: TDataSource
    DataSet = cdsCadEmp
    Left = 456
    Top = 32
  end
end
