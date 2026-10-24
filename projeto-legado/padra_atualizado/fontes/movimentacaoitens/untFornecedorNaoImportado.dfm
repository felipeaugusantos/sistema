inherited frmFornecedorNaoImportado: TfrmFornecedorNaoImportado
  Width = 1024
  Height = 418
  BorderStyle = bsSizeable
  Caption = 'Fornecedores encontrados na nota mas n'#227'o no cadastro.'
  ExplicitWidth = 1024
  ExplicitHeight = 418
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 336
    Width = 1008
    ExplicitTop = 336
    ExplicitWidth = 1008
    inherited btnSair: TBitBtnLocked
      Left = 925
      ExplicitLeft = 925
    end
  end
  inherited pnlStatus: TPanel
    Top = 364
    Width = 1008
    ExplicitTop = 364
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object cxItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 1008
    Height = 326
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxItensDBTableView1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = dsForn
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxItensDBTableView1Column1: TcxGridDBColumn
        Caption = 'C.N.P.J'
        DataBinding.FieldName = 'CNPJ'
      end
      object cxItensDBTableView1Column2: TcxGridDBColumn
        Caption = 'C.P.F.'
        DataBinding.FieldName = 'CPF'
      end
      object cxItensDBTableView1Column3: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'xNome'
        Width = 73
      end
      object cxItensDBTableView1Column4: TcxGridDBColumn
        Caption = 'Nome Fantasia'
        DataBinding.FieldName = 'xFant'
      end
      object cxItensDBTableView1Column5: TcxGridDBColumn
        Caption = 'Logradouro'
        DataBinding.FieldName = 'xLgr'
      end
      object cxItensDBTableView1Column6: TcxGridDBColumn
        Caption = 'N'#250'mero'
        DataBinding.FieldName = 'nro'
      end
      object cxItensDBTableView1Column7: TcxGridDBColumn
        Caption = 'Complemento'
        DataBinding.FieldName = 'xCpl'
      end
      object cxItensDBTableView1Column9: TcxGridDBColumn
        Caption = 'Bairro'
        DataBinding.FieldName = 'xBairro'
      end
      object cxItensDBTableView1Column10: TcxGridDBColumn
        Caption = 'C'#243'digo Municipio'
        DataBinding.FieldName = 'cMun'
      end
      object cxItensDBTableView1Column11: TcxGridDBColumn
        Caption = 'Municipio'
        DataBinding.FieldName = 'xMun'
      end
      object cxItensDBTableView1Column12: TcxGridDBColumn
        DataBinding.FieldName = 'UF'
      end
      object cxItensDBTableView1Column13: TcxGridDBColumn
        Caption = 'CEP'
        DataBinding.FieldName = 'C.E.P.'
      end
      object cxItensDBTableView1Column14: TcxGridDBColumn
        Caption = 'C'#243'digo do Pa'#237's'
        DataBinding.FieldName = 'cPais'
      end
      object cxItensDBTableView1Column15: TcxGridDBColumn
        Caption = 'Pa'#237's'
        DataBinding.FieldName = 'xPais'
      end
      object cxItensDBTableView1Column16: TcxGridDBColumn
        Caption = 'Telefone'
        DataBinding.FieldName = 'fone'
      end
      object cxItensDBTableView1Column17: TcxGridDBColumn
        Caption = 'Inscri'#231#227'o Estadual'
        DataBinding.FieldName = 'IE'
      end
      object cxItensDBTableView1Column18: TcxGridDBColumn
        Caption = 'IE do Substituto Tribut'#225'rio'
        DataBinding.FieldName = 'IEST'
      end
      object cxItensDBTableView1Column19: TcxGridDBColumn
        Caption = 'Incri'#231#227'o Municipal'
        DataBinding.FieldName = 'IM'
      end
      object cxItensDBTableView1Column20: TcxGridDBColumn
        Caption = 'C'#243'digo C.N.A.E.'
        DataBinding.FieldName = 'CNAE'
      end
    end
    object cxItensLevel1: TcxGridLevel
      GridView = cxItensDBTableView1
    end
  end
  object ProgressBar1: TProgressBar [4]
    Left = 0
    Top = 326
    Width = 1008
    Height = 10
    Align = alBottom
    TabOrder = 4
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 16
  end
  object dsForn: TDataSource
    Left = 336
    Top = 192
  end
end
