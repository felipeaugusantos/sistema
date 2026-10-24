object frmImpNfdProvedores: TfrmImpNfdProvedores
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Layout dinamico NFS-e - Provedores'
  ClientHeight = 444
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object grdPrv: TcxGrid
    Left = 8
    Top = 8
    Width = 704
    Height = 300
    TabOrder = 0
    object tbvPrv: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsPrv
      DataController.KeyFieldNames = 'PRV_NOME'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      OptionsView.IndicatorWidth = 20
      object tbvPrvPRV_NOME: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'PRV_NOME'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 240
      end
      object tbvPrvPRV_DESCRI: TcxGridDBColumn
        Caption = 'Descricao'
        DataBinding.FieldName = 'PRV_DESCRI'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 360
      end
    end
    object lvlPrv: TcxGridLevel
      GridView = tbvPrv
    end
  end
  object pnlCampos: TPanel
    Left = 8
    Top = 314
    Width = 704
    Height = 44
    BevelOuter = bvNone
    TabOrder = 1
    object lblNome: TLabel
      Left = 0
      Top = 2
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object lblDescri: TLabel
      Left = 328
      Top = 2
      Width = 48
      Height = 13
      Caption = 'Descricao'
    end
    object dbeNome: TDBEdit
      Left = 0
      Top = 18
      Width = 320
      Height = 21
      DataField = 'PRV_NOME'
      DataSource = dtsPrv
      TabOrder = 0
    end
    object dbeDescri: TDBEdit
      Left = 328
      Top = 18
      Width = 376
      Height = 21
      DataField = 'PRV_DESCRI'
      DataSource = dtsPrv
      TabOrder = 1
    end
  end
  object btnSalvar: TButton
    Left = 8
    Top = 366
    Width = 90
    Height = 28
    Caption = 'Salvar'
    Enabled = False
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object btnNovo: TButton
    Left = 104
    Top = 366
    Width = 90
    Height = 28
    Caption = 'Novo'
    TabOrder = 3
    OnClick = btnNovoClick
  end
  object btnEditar: TButton
    Left = 200
    Top = 366
    Width = 90
    Height = 28
    Caption = 'Editar'
    TabOrder = 4
    OnClick = btnEditarClick
  end
  object btnExcluir: TButton
    Left = 296
    Top = 366
    Width = 90
    Height = 28
    Caption = 'Excluir'
    TabOrder = 5
    OnClick = btnExcluirClick
  end
  object btnCancelar: TButton
    Left = 392
    Top = 366
    Width = 90
    Height = 28
    Caption = 'Cancelar'
    Enabled = False
    TabOrder = 6
    OnClick = btnCancelarClick
  end
  object btnCds: TButton
    Left = 8
    Top = 404
    Width = 124
    Height = 28
    Caption = 'Datasets (CDS)'
    TabOrder = 7
    OnClick = btnCdsClick
  end
  object btnVars: TButton
    Left = 140
    Top = 404
    Width = 124
    Height = 28
    Caption = 'Variaveis'
    TabOrder = 8
    OnClick = btnVarsClick
  end
  object btnTestar: TButton
    Left = 272
    Top = 404
    Width = 124
    Height = 28
    Caption = 'Testar...'
    TabOrder = 9
    OnClick = btnTestarClick
  end
  object btnExportar: TButton
    Left = 404
    Top = 404
    Width = 124
    Height = 28
    Caption = 'Exportar...'
    TabOrder = 10
    OnClick = btnExportarClick
  end
  object btnComparar: TButton
    Left = 488
    Top = 366
    Width = 124
    Height = 28
    Hint = 'Compara os datasets da rotina antiga (ACBr) com os do provedor NOTA_FISCAL'
    Caption = 'Comparar...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = btnCompararClick
  end
  object btnFechar: TButton
    Left = 612
    Top = 404
    Width = 100
    Height = 28
    Caption = 'Fechar'
    TabOrder = 11
    OnClick = btnFecharClick
  end
  object dtsPrv: TDataSource
    AutoEdit = False
    OnStateChange = dtsPrvStateChange
    Left = 640
    Top = 360
  end
  object dlgExportar: TSaveDialog
    DefaultExt = 'sql'
    Filter = 'Script SQL (*.sql)|*.sql|Todos (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Exportar provedor'
    Left = 680
    Top = 360
  end
end
