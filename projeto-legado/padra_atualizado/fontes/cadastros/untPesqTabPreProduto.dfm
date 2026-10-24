inherited frmPesqTabPreProduto: TfrmPesqTabPreProduto
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Pesquisa de Tabela de Pre'#231'o por Produto'
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 1008
    ExplicitTop = 517
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
    end
    inherited btnSair: TBitBtnLocked
      Left = 927
      TabOrder = 2
      ExplicitLeft = 927
    end
    object btnConfirma: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 120
      Height = 22
      Caption = '[ F10 ] Confirma'
      ModalResult = 1
      TabOrder = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    ExplicitTop = 545
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
  object pnl1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 101
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lbl1: TLabel
      Left = 14
      Top = 18
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDesIte: TEditFocus
      Left = 129
      Top = 14
      Width = 395
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 57
      Top = 14
      Width = 71
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 1
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object rdgStatus: TRadioGroup
      Tag = 99
      Left = 57
      Top = 42
      Width = 467
      Height = 48
      Caption = 'Status da Tabela'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Ativa'
        'Inativa'
        'Todas')
      TabOrder = 2
      OnClick = rdgStatusClick
    end
  end
  object cxgDados: TcxGridCitel [3]
    Left = 0
    Top = 101
    Width = 1008
    Height = 416
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxbDadosView: TcxGridDBTableViewCitel
      OnKeyDown = cxbDadosViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum registro econtrado>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxcDadosViewColumn1: TcxGridDBColumn
        Caption = 'Tabela'
        DataBinding.FieldName = 'CODTAB'
        HeaderAlignmentHorz = taCenter
        Width = 56
      end
      object cxcDadosViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'NOMTAB'
        Width = 122
      end
      object cxcDadosViewColumn4: TcxGridDBColumn
        Caption = 'C'#243'd. Fornec.'
        DataBinding.FieldName = 'CODFOR'
        HeaderAlignmentHorz = taCenter
        Width = 87
      end
      object cxcDadosViewColumn3: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Width = 101
      end
      object cxcDadosViewColumn7: TcxGridDBColumn
        Caption = 'C'#243'd. Fabrica'
        DataBinding.FieldName = 'CODFAB'
        Width = 75
      end
      object cxcDadosViewColumn5: TcxGridDBColumn
        Caption = 'Ativa'
        DataBinding.FieldName = 'ATICMP'
        HeaderAlignmentHorz = taCenter
        Width = 69
      end
      object cxcDadosViewColumn6: TcxGridDBColumn
        Caption = 'Cadastro'
        DataBinding.FieldName = 'DTACAD'
        HeaderAlignmentHorz = taCenter
        SortIndex = 0
        SortOrder = soDescending
        Width = 100
      end
      object cxbDadosViewColumn1: TcxGridDBColumn
        Caption = 'P. Compra'
        DataBinding.FieldName = 'PRECOM'
        Width = 108
      end
      object cxbDadosViewColumn2: TcxGridDBColumn
        Caption = 'P. Custo'
        DataBinding.FieldName = 'PRECUS'
        Width = 108
      end
      object cxbDadosViewColumn3: TcxGridDBColumn
        Caption = 'Unid. Compra'
        DataBinding.FieldName = 'UNICOM'
        Width = 73
      end
      object cxbDadosViewColumn4: TcxGridDBColumn
        Caption = 'Embalagem'
        DataBinding.FieldName = 'EMBALA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000;'
        Width = 66
      end
      object cxbDadosViewColumn6: TcxGridDBColumn
        Caption = 'P. Compra Em Quilos'
        DataBinding.FieldName = 'PREKIL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        Width = 116
      end
    end
    object cxlGrid1Level1: TcxGridLevel
      GridView = cxbDadosView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 590
    Top = 30
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 664
    Top = 36
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 738
    Top = 22
  end
end
