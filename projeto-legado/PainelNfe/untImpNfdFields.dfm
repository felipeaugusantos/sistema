object frmImpNfdFields: TfrmImpNfdFields
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Fields'
  ClientHeight = 560
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
  object pnlXml: TPanel
    Left = 8
    Top = 8
    Width = 884
    Height = 506
    BevelOuter = bvNone
    TabOrder = 0
    object lblDica: TLabel
      Left = 444
      Top = 440
      Width = 420
      Height = 13
      Caption = 'Duplo clique num no da arvore preenche o destino abaixo (em Novo/Editar).'
    end
    object grdFld: TcxGrid
      Left = 0
      Top = 0
      Width = 884
      Height = 180
      TabOrder = 0
      object tbvFld: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsFld
        DataController.KeyFieldNames = 'FLD_CODPRV;FLD_CODCDS;FLD_NOME'
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
        object tbvFldFLD_NOME: TcxGridDBColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'FLD_NOME'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 130
        end
        object tbvFldFLD_TIPO: TcxGridDBColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'FLD_TIPO'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 100
        end
        object tbvFldFLD_CAMINH: TcxGridDBColumn
          Caption = 'Caminho'
          DataBinding.FieldName = 'FLD_CAMINH'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 220
        end
        object tbvFldFLD_CAMAUX: TcxGridDBColumn
          Caption = 'Caminho auxiliar'
          DataBinding.FieldName = 'FLD_CAMAUX'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 180
        end
        object tbvFldFLD_AJUSTE: TcxGridDBColumn
          Caption = 'Ajuste'
          DataBinding.FieldName = 'FLD_AJUSTE'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 140
        end
        object tbvFldFLD_DEFAUL: TcxGridDBColumn
          Caption = 'Default'
          DataBinding.FieldName = 'FLD_DEFAUL'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 80
        end
      end
      object lvlFld: TcxGridLevel
        GridView = tbvFld
      end
    end
    object btnCarregarXml: TButton
      Left = 0
      Top = 188
      Width = 130
      Height = 28
      Caption = 'Carregar XML...'
      TabOrder = 1
      OnClick = btnCarregarXmlClick
    end
    object tvXml: TTreeView
      Left = 0
      Top = 222
      Width = 430
      Height = 284
      Indent = 19
      ReadOnly = True
      TabOrder = 2
      OnDblClick = tvXmlDblClick
    end
    object pnlCamposFld: TPanel
      Left = 444
      Top = 188
      Width = 440
      Height = 244
      BevelOuter = bvNone
      TabOrder = 3
      object lblNome: TLabel
        Left = 0
        Top = 4
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object lblTipo: TLabel
        Left = 216
        Top = 4
        Width = 20
        Height = 13
        Caption = 'Tipo'
      end
      object lblCaminho: TLabel
        Left = 0
        Top = 52
        Width = 42
        Height = 13
        Caption = 'Caminho'
      end
      object lblCamAux: TLabel
        Left = 0
        Top = 100
        Width = 280
        Height = 13
        Caption = 'Caminho auxiliar (lido se o Caminho nao existir ou vier vazio)'
      end
      object lblAjuste: TLabel
        Left = 0
        Top = 148
        Width = 32
        Height = 13
        Caption = 'Ajuste'
      end
      object lblDefault: TLabel
        Left = 0
        Top = 196
        Width = 36
        Height = 13
        Caption = 'Default'
      end
      object dbeNome: TDBEdit
        Left = 0
        Top = 20
        Width = 200
        Height = 21
        DataField = 'FLD_NOME'
        DataSource = dtsFld
        TabOrder = 0
      end
      object dbeTipo: TDBEdit
        Left = 216
        Top = 20
        Width = 100
        Height = 21
        DataField = 'FLD_TIPO'
        DataSource = dtsFld
        TabOrder = 1
      end
      object dbeCaminho: TDBEdit
        Left = 0
        Top = 68
        Width = 426
        Height = 21
        DataField = 'FLD_CAMINH'
        DataSource = dtsFld
        TabOrder = 2
      end
      object dbeCamAux: TDBEdit
        Left = 0
        Top = 116
        Width = 426
        Height = 21
        DataField = 'FLD_CAMAUX'
        DataSource = dtsFld
        TabOrder = 3
      end
      object dbeAjuste: TDBEdit
        Left = 0
        Top = 164
        Width = 200
        Height = 21
        DataField = 'FLD_AJUSTE'
        DataSource = dtsFld
        TabOrder = 4
      end
      object dbeDefault: TDBEdit
        Left = 0
        Top = 212
        Width = 200
        Height = 21
        DataField = 'FLD_DEFAUL'
        DataSource = dtsFld
        TabOrder = 5
      end
      object lblOrdem: TLabel
        Left = 326
        Top = 4
        Width = 33
        Height = 13
        Caption = 'Ordem'
      end
      object dbeOrdem: TDBEdit
        Left = 326
        Top = 20
        Width = 100
        Height = 21
        DataSource = dtsFld
        TabOrder = 6
      end
      object lblFunc: TLabel
        Left = 216
        Top = 148
        Width = 90
        Height = 13
        Caption = 'Funcao (FLD_FUNC)'
      end
      object dbcFunc: TDBComboBox
        Left = 216
        Top = 164
        Width = 210
        Height = 21
        DataSource = dtsFld
        ItemHeight = 13
        Items.Strings = (
          ''
          'VALOR'
          'CURR'
          'DBL'
          'INT'
          'INTNUM'
          'MILHAR'
          'DATA'
          'CNPJ'
          'CNPJCPF'
          'CEP'
          'FONE'
          'COLLATE'
          'TRIM'
          'UPPER'
          'NRO'
          'CHAVE'
          'ONLYNUMBER'
          'DANFE(RazSoc)'
          'DANFETRIM(RazSoc)'
          'DANFEFONE(Fone2)')
        TabOrder = 7
      end
      object lblColSel: TLabel
        Left = 216
        Top = 196
        Width = 150
        Height = 13
        Caption = 'Coluna do SELECT de apoio'
      end
      object dbeColSel: TDBEdit
        Left = 216
        Top = 212
        Width = 210
        Height = 21
        DataSource = dtsFld
        TabOrder = 8
      end
    end
    object rgDestino: TRadioGroup
      Left = 444
      Top = 458
      Width = 426
      Height = 42
      Caption = 'Duplo clique na arvore preenche'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Caminho'
        'Caminho auxiliar')
      TabOrder = 4
    end
  end
  object pnlBanco: TPanel
    Left = 8
    Top = 8
    Width = 884
    Height = 506
    BevelOuter = bvNone
    TabOrder = 1
    object lblSelect: TLabel
      Left = 0
      Top = 0
      Width = 430
      Height = 13
      Caption = 'SELECT (VS_ACESSO, VS_CODEMP, VS_VALOR, VS_NUMDOC, VS_ESPDOC, VS_<campo>)'
    end
    object pnlCamposSel: TPanel
      Left = 0
      Top = 18
      Width = 884
      Height = 250
      BevelOuter = bvNone
      TabOrder = 0
      object dbmSelect: TDBMemo
        Left = 0
        Top = 0
        Width = 884
        Height = 250
        DataField = 'CDS_SELECT'
        DataSource = dtsSel
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
    object btnCarregarCampos: TButton
      Left = 0
      Top = 276
      Width = 160
      Height = 28
      Caption = 'Carregar campos'
      TabOrder = 1
      OnClick = btnCarregarCamposClick
    end
    object lvPreview: TListView
      Left = 0
      Top = 312
      Width = 884
      Height = 194
      Columns = <
        item
          Caption = 'Coluna (campo do dataset)'
          Width = 300
        end
        item
          Caption = 'Tipo'
          Width = 200
        end>
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 2
      ViewStyle = vsReport
    end
  end
  object btnSalvar: TButton
    Left = 8
    Top = 524
    Width = 90
    Height = 28
    Caption = 'Salvar'
    Enabled = False
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object btnNovo: TButton
    Left = 104
    Top = 524
    Width = 90
    Height = 28
    Caption = 'Novo'
    TabOrder = 3
    OnClick = btnNovoClick
  end
  object btnEditar: TButton
    Left = 200
    Top = 524
    Width = 90
    Height = 28
    Caption = 'Editar'
    TabOrder = 4
    OnClick = btnEditarClick
  end
  object btnExcluir: TButton
    Left = 296
    Top = 524
    Width = 90
    Height = 28
    Caption = 'Excluir'
    TabOrder = 5
    OnClick = btnExcluirClick
  end
  object btnCancelar: TButton
    Left = 392
    Top = 524
    Width = 90
    Height = 28
    Caption = 'Cancelar'
    Enabled = False
    TabOrder = 6
    OnClick = btnCancelarClick
  end
  object btnFechar: TButton
    Left = 792
    Top = 524
    Width = 100
    Height = 28
    Caption = 'Fechar'
    TabOrder = 7
    OnClick = btnFecharClick
  end
  object dtsFld: TDataSource
    AutoEdit = False
    OnStateChange = dtsStateChange
    Left = 600
    Top = 40
  end
  object dtsSel: TDataSource
    AutoEdit = False
    OnStateChange = dtsStateChange
    Left = 640
    Top = 40
  end
  object dlgXml: TOpenDialog
    Filter = 'XML|*.xml|Todos|*.*'
    Left = 680
    Top = 40
  end
end
