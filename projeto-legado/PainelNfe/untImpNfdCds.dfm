object frmImpNfdCds: TfrmImpNfdCds
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Datasets (CDS)'
  ClientHeight = 642
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
  object grdCds: TcxGrid
    Left = 8
    Top = 8
    Width = 704
    Height = 200
    TabOrder = 0
    object tbvCds: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsCds
      DataController.KeyFieldNames = 'CDS_CODPRV;CDS_NOMCDS'
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
      object tbvCdsCDS_NOMCDS: TcxGridDBColumn
        Caption = 'Nome CDS'
        DataBinding.FieldName = 'CDS_NOMCDS'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 200
      end
      object tbvCdsCDS_NOMFRX: TcxGridDBColumn
        Caption = 'Nome FRX'
        DataBinding.FieldName = 'CDS_NOMFRX'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 200
      end
      object tbvCdsCDS_ORIGEM: TcxGridDBColumn
        Caption = 'Origem'
        DataBinding.FieldName = 'CDS_ORIGEM'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 60
      end
    end
    object lvlCds: TcxGridLevel
      GridView = tbvCds
    end
  end
  object pnlCampos: TPanel
    Left = 8
    Top = 214
    Width = 704
    Height = 380
    BevelOuter = bvNone
    TabOrder = 1
    object lblNomCds: TLabel
      Left = 0
      Top = 4
      Width = 60
      Height = 13
      Caption = 'Nome do cds'
    end
    object lblNomFrx: TLabel
      Left = 232
      Top = 4
      Width = 84
      Height = 13
      Caption = 'Nome no fr3 (frx)'
    end
    object lblSelect: TLabel
      Left = 0
      Top = 52
      Width = 164
      Height = 13
      Caption = 'SELECT (origem Banco) / SELECT de apoio ou @DOC (origem Ambos)'
    end
    object dbeNomCds: TDBEdit
      Left = 0
      Top = 20
      Width = 220
      Height = 21
      DataField = 'CDS_NOMCDS'
      DataSource = dtsCds
      TabOrder = 0
    end
    object dbeNomFrx: TDBEdit
      Left = 232
      Top = 20
      Width = 220
      Height = 21
      DataField = 'CDS_NOMFRX'
      DataSource = dtsCds
      TabOrder = 1
    end
    object dbrOrigem: TDBRadioGroup
      Left = 464
      Top = 0
      Width = 240
      Height = 44
      Caption = 'Origem'
      Columns = 3
      DataField = 'CDS_ORIGEM'
      DataSource = dtsCds
      Items.Strings = (
        'XML'
        'Banco'
        'Ambos')
      TabOrder = 2
      Values.Strings = (
        'X'
        'B'
        'A')
    end
    object dbmSelect: TDBMemo
      Left = 0
      Top = 68
      Width = 704
      Height = 106
      DataField = 'CDS_SELECT'
      DataSource = dtsCds
      ScrollBars = ssBoth
      TabOrder = 3
      WordWrap = False
    end
    object lblCamBas: TLabel
      Left = 0
      Top = 180
      Width = 230
      Height = 13
      Caption = 'Caminho base (um registro por no) - CAMBAS'
    end
    object dbeCamBas: TDBEdit
      Left = 0
      Top = 196
      Width = 340
      Height = 21
      DataSource = dtsCds
      TabOrder = 4
    end
    object lblChvSel: TLabel
      Left = 352
      Top = 180
      Width = 230
      Height = 13
      Caption = 'Ligacao com o SELECT de apoio - CHVSEL'
    end
    object dbeChvSel: TDBEdit
      Left = 352
      Top = 196
      Width = 352
      Height = 21
      DataSource = dtsCds
      TabOrder = 5
    end
    object lblPosPrc: TLabel
      Left = 0
      Top = 224
      Width = 94
      Height = 13
      Caption = 'Pos-processamento'
    end
    object dbePosPrc: TDBEdit
      Left = 0
      Top = 240
      Width = 130
      Height = 21
      DataSource = dtsCds
      TabOrder = 6
    end
    object lblOrdem: TLabel
      Left = 142
      Top = 224
      Width = 33
      Height = 13
      Caption = 'Ordem'
    end
    object dbeOrdem: TDBEdit
      Left = 142
      Top = 240
      Width = 70
      Height = 21
      DataSource = dtsCds
      TabOrder = 7
    end
    object dbcRegVaz: TDBCheckBox
      Left = 224
      Top = 242
      Width = 128
      Height = 17
      Caption = 'Registro vazio (S)'
      DataSource = dtsCds
      TabOrder = 8
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object lblCondic: TLabel
      Left = 0
      Top = 268
      Width = 330
      Height = 13
      Caption = 'Condicao do registro (expressao SQL; 0/nulo descarta) - CONDIC'
    end
    object dbmCondic: TDBMemo
      Left = 0
      Top = 284
      Width = 704
      Height = 96
      DataSource = dtsCds
      ScrollBars = ssBoth
      TabOrder = 9
      WordWrap = False
    end
  end
  object btnSalvar: TButton
    Left = 8
    Top = 602
    Width = 90
    Height = 28
    Caption = 'Salvar'
    Enabled = False
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object btnNovo: TButton
    Left = 104
    Top = 602
    Width = 90
    Height = 28
    Caption = 'Novo'
    TabOrder = 3
    OnClick = btnNovoClick
  end
  object btnEditar: TButton
    Left = 200
    Top = 602
    Width = 90
    Height = 28
    Caption = 'Editar'
    TabOrder = 4
    OnClick = btnEditarClick
  end
  object btnExcluir: TButton
    Left = 296
    Top = 602
    Width = 90
    Height = 28
    Caption = 'Excluir'
    TabOrder = 5
    OnClick = btnExcluirClick
  end
  object btnCancelar: TButton
    Left = 392
    Top = 602
    Width = 90
    Height = 28
    Caption = 'Cancelar'
    Enabled = False
    TabOrder = 6
    OnClick = btnCancelarClick
  end
  object btnFields: TButton
    Left = 496
    Top = 602
    Width = 108
    Height = 28
    Caption = 'Fields (campos)'
    TabOrder = 7
    OnClick = btnFieldsClick
  end
  object btnFechar: TButton
    Left = 612
    Top = 602
    Width = 100
    Height = 28
    Caption = 'Fechar'
    TabOrder = 8
    OnClick = btnFecharClick
  end
  object dtsCds: TDataSource
    AutoEdit = False
    OnStateChange = dtsCdsStateChange
    Left = 640
    Top = 16
  end
end
