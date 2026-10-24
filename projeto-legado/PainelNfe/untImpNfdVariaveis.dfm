object frmImpNfdVariaveis: TfrmImpNfdVariaveis
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Variaveis'
  ClientHeight = 528
  ClientWidth = 900
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
  object grdVar: TcxGrid
    Left = 8
    Top = 8
    Width = 884
    Height = 220
    TabOrder = 0
    object tbvVar: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsVar
      DataController.KeyFieldNames = 'VAR_CODPRV;VAR_NOME'
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
      object tbvVarVAR_NOME: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'VAR_NOME'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 170
      end
      object tbvVarVAR_ORIGEM: TcxGridDBColumn
        Caption = 'Origem'
        DataBinding.FieldName = 'VAR_ORIGEM'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 50
      end
      object tbvVarVAR_CAMPO: TcxGridDBColumn
        Caption = 'Campo'
        DataBinding.FieldName = 'VAR_CAMPO'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 160
      end
      object tbvVarVAR_TIPO: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'VAR_TIPO'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 45
      end
      object tbvVarVAR_FUNC: TcxGridDBColumn
        Caption = 'Funcao'
        DataBinding.FieldName = 'VAR_FUNC'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 70
      end
      object tbvVarVAR_DEFAUL: TcxGridDBColumn
        Caption = 'Default'
        DataBinding.FieldName = 'VAR_DEFAUL'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 190
      end
      object tbvVarVAR_ORDEM: TcxGridDBColumn
        Caption = 'Ordem'
        DataBinding.FieldName = 'VAR_ORDEM'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 50
      end
    end
    object lvlVar: TcxGridLevel
      GridView = tbvVar
    end
  end
  object pnlCampos: TPanel
    Left = 8
    Top = 234
    Width = 884
    Height = 248
    BevelOuter = bvNone
    TabOrder = 1
    object lblNome: TLabel
      Left = 0
      Top = 4
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object lblCampo: TLabel
      Left = 532
      Top = 4
      Width = 33
      Height = 13
      Caption = 'Campo'
    end
    object lblFormat: TLabel
      Left = 720
      Top = 4
      Width = 39
      Height = 13
      Caption = 'Formato'
    end
    object lblFunc: TLabel
      Left = 0
      Top = 48
      Width = 36
      Height = 13
      Caption = 'Funcao'
    end
    object lblOrdem: TLabel
      Left = 188
      Top = 48
      Width = 33
      Height = 13
      Caption = 'Ordem'
    end
    object lblDefault: TLabel
      Left = 276
      Top = 48
      Width = 36
      Height = 13
      Caption = 'Default'
    end
    object lblSelect: TLabel
      Left = 0
      Top = 96
      Width = 380
      Height = 13
      Caption = 'SELECT (origem Select) - VS_ACESSO/VS_CODEMP/VS_NUMDOC/VS_ESPDOC/VS_<campo>'
    end
    object dbeNome: TDBEdit
      Left = 0
      Top = 20
      Width = 180
      Height = 21
      DataField = 'VAR_NOME'
      DataSource = dtsVar
      TabOrder = 0
    end
    object dbrOrigem: TDBRadioGroup
      Left = 188
      Top = 0
      Width = 212
      Height = 42
      Caption = 'Origem'
      Columns = 3
      DataField = 'VAR_ORIGEM'
      DataSource = dtsVar
      Items.Strings = (
        'Campo'
        'Select'
        'Fixo')
      TabOrder = 1
      Values.Strings = (
        'C'
        'S'
        'F')
    end
    object dbrTipo: TDBRadioGroup
      Left = 406
      Top = 0
      Width = 118
      Height = 42
      Caption = 'Tipo'
      Columns = 2
      DataField = 'VAR_TIPO'
      DataSource = dtsVar
      Items.Strings = (
        'STR'
        'NUM')
      TabOrder = 2
      Values.Strings = (
        'STR'
        'NUM')
    end
    object dbeCampo: TDBEdit
      Left = 532
      Top = 20
      Width = 180
      Height = 21
      DataField = 'VAR_CAMPO'
      DataSource = dtsVar
      TabOrder = 3
    end
    object dbeFormat: TDBEdit
      Left = 720
      Top = 20
      Width = 164
      Height = 21
      DataField = 'VAR_FORMAT'
      DataSource = dtsVar
      TabOrder = 4
    end
    object dbcFunc: TDBComboBox
      Left = 0
      Top = 64
      Width = 180
      Height = 21
      Style = csDropDownList
      DataField = 'VAR_FUNC'
      DataSource = dtsVar
      ItemHeight = 13
      Items.Strings = (
        ''
        'CPFCNPJ'
        'CEP'
        'FONE'
        'UPPER')
      TabOrder = 5
    end
    object dbeOrdem: TDBEdit
      Left = 188
      Top = 64
      Width = 80
      Height = 21
      DataField = 'VAR_ORDEM'
      DataSource = dtsVar
      TabOrder = 6
    end
    object dbeDefault: TDBEdit
      Left = 276
      Top = 64
      Width = 400
      Height = 21
      DataField = 'VAR_DEFAUL'
      DataSource = dtsVar
      TabOrder = 7
    end
    object lblCdsVar: TLabel
      Left = 688
      Top = 48
      Width = 150
      Height = 13
      Caption = 'Dataset (VAR_CDS, vazio = 1o)'
    end
    object dbeCdsVar: TDBEdit
      Left = 688
      Top = 64
      Width = 196
      Height = 21
      DataSource = dtsVar
      TabOrder = 9
    end
    object dbmSelect: TDBMemo
      Left = 0
      Top = 112
      Width = 884
      Height = 136
      DataField = 'VAR_SELECT'
      DataSource = dtsVar
      ScrollBars = ssBoth
      TabOrder = 8
      WordWrap = False
    end
  end
  object btnSalvar: TButton
    Left = 8
    Top = 490
    Width = 90
    Height = 28
    Caption = 'Salvar'
    Enabled = False
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object btnNovo: TButton
    Left = 104
    Top = 490
    Width = 90
    Height = 28
    Caption = 'Novo'
    TabOrder = 3
    OnClick = btnNovoClick
  end
  object btnEditar: TButton
    Left = 200
    Top = 490
    Width = 90
    Height = 28
    Caption = 'Editar'
    TabOrder = 4
    OnClick = btnEditarClick
  end
  object btnExcluir: TButton
    Left = 296
    Top = 490
    Width = 90
    Height = 28
    Caption = 'Excluir'
    TabOrder = 5
    OnClick = btnExcluirClick
  end
  object btnCancelar: TButton
    Left = 392
    Top = 490
    Width = 90
    Height = 28
    Caption = 'Cancelar'
    Enabled = False
    TabOrder = 6
    OnClick = btnCancelarClick
  end
  object btnFechar: TButton
    Left = 792
    Top = 490
    Width = 100
    Height = 28
    Caption = 'Fechar'
    TabOrder = 7
    OnClick = btnFecharClick
  end
  object dtsVar: TDataSource
    AutoEdit = False
    OnStateChange = dtsVarStateChange
    Left = 840
    Top = 16
  end
end
