inherited frmConfirmaImportacaoProdutosAjuste: TfrmConfirmaImportacaoProdutosAjuste
  Width = 1024
  Height = 581
  BorderStyle = bsSingle
  Caption = 'Importa'#231#227'o de Produtos para Ajuste - Confirma'#231#227'o '
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 510
    Width = 1018
    ExplicitTop = 510
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      inherited btnConfirma: TBitBtnLocked
        Width = 86
        Caption = '[F10] &Confirma'
        Glyph.Data = {00000000}
        ModalResult = 0
        ExplicitWidth = 86
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Width = 86
      ExplicitLeft = 929
      ExplicitWidth = 86
    end
  end
  inherited pnlStatus: TPanel
    Top = 536
    Width = 1018
    ExplicitTop = 536
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object grpLegenda: TGroupBox [2]
    Left = 0
    Top = 459
    Width = 1018
    Height = 51
    Align = alBottom
    Caption = 'Legenda'
    TabOrder = 2
    object shpProdutoComInconsistencia: TShape
      Left = 16
      Top = 24
      Width = 17
      Height = 15
      Brush.Color = 7124735
    end
    object lblProdutoComInconsistencia: TLabel
      Left = 39
      Top = 24
      Width = 132
      Height = 14
      Caption = 'Produto com inconsist'#234'ncia'
    end
    object shpProdutoOk: TShape
      Left = 208
      Top = 24
      Width = 17
      Height = 15
    end
    object lblProdutoOk: TLabel
      Left = 231
      Top = 26
      Width = 132
      Height = 14
      Caption = 'Produto sem inconsist'#234'ncia'
    end
  end
  object cxgProdutosImportados: TcxGrid [3]
    Left = 0
    Top = 33
    Width = 1018
    Height = 426
    Align = alClient
    TabOrder = 3
    object cxgProdutosImportadosDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgProdutosImportadosDBTableView1CustomDrawCell
      OnEditValueChanged = cxgProdutosImportadosDBTableView1EditValueChanged
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxgProAjuDBCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 73
      end
      object cxgProAjuDBDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 220
      end
      object cxgProAjuDBUNIITE: TcxGridDBColumn
        Caption = 'Un'
        DataBinding.FieldName = 'UNIITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 100
      end
      object cxgProAjuDBCODREF: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'CODREF'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 125
      end
      object cxgProAjuDBSALDIS: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'SALDIS'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 105
      end
      object cxgProAjuDBSALEXT: TcxGridDBColumn
        Caption = 'Saldo Externo Atual'
        DataBinding.FieldName = 'SALEXT'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 105
      end
      object cxgProAjuDBQTDITE: TcxGridDBColumn
        Caption = 'Qtde Planilha'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taCenter
        Options.AutoWidthSizable = False
        Width = 95
      end
      object cxgProAjuDBVALIDACAO: TcxGridDBColumn
        Caption = 'Valida'#231#227'o'
        DataBinding.FieldName = 'VALIDACAO'
        Options.Editing = False
        Width = 191
      end
    end
    object cxgProdutosImportadosLevel1: TcxGridLevel
      GridView = cxgProdutosImportadosDBTableView1
    end
  end
  object pnlTopo: TPanel [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 33
    Align = alTop
    TabOrder = 4
    DesignSize = (
      1018
      33)
    object rdgOpcoesPesquisa: TRadioGroup
      Left = 0
      Top = -8
      Width = 1018
      Height = 40
      Anchors = [akLeft, akTop, akRight]
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Exibir todos os itens'
        'Exibir apenas itens com inconsist'#234'ncia')
      TabOrder = 0
      OnClick = rdgOpcoesPesquisaClick
    end
  end
  object dtsItens: TDataSource
    Left = 56
    Top = 32
  end
end
