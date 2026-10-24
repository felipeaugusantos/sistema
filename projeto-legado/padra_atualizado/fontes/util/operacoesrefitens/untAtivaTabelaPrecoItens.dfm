inherited frmAtivaTabelaPrecoItens: TfrmAtivaTabelaPrecoItens
  Width = 1030
  Height = 682
  BorderStyle = bsSingle
  Caption = 'Ativa'#231#227'o de Tabela de Pre'#231'o - Produtos'
  WindowState = wsMaximized
  ExplicitWidth = 1030
  ExplicitHeight = 682
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 611
    Width = 1024
    ExplicitTop = 611
    ExplicitWidth = 1431
    inherited FlwBotoes: TFlowPanel
      Width = 1020
      ExplicitWidth = 1427
      inherited btnConfirma: TBitBtnLocked
        Width = 105
        Height = 20
        Caption = '[F10] Confirma'
        ExplicitWidth = 105
        ExplicitHeight = 20
      end
      object btnMarTod: TBitBtnLocked
        Left = 105
        Top = 0
        Width = 114
        Height = 20
        Align = alLeft
        Caption = '[ F3 ] Marca Todos'
        TabOrder = 1
        OnClick = btnMarTodClick
      end
      object btnDesTod: TBitBtnLocked
        Left = 219
        Top = 0
        Width = 114
        Height = 20
        Align = alLeft
        Caption = '[ F4] Desmarca Todos'
        TabOrder = 2
        OnClick = btnDesTodClick
      end
      object btnMarcaDesmarca: TBitBtnLocked
        Left = 333
        Top = 0
        Width = 140
        Height = 20
        Align = alLeft
        Caption = '[ ENTER] Marca/Desmarca'
        TabOrder = 3
        OnClick = btnMarcaDesmarcaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 944
      ExplicitLeft = 1351
    end
  end
  inherited pnlStatus: TPanel
    Top = 637
    Width = 1024
    ExplicitTop = 637
    ExplicitWidth = 1431
    inherited pnlNomeForm: TPanel
      Left = 853
      ExplicitLeft = 1260
    end
    inherited pnlInfo: TPanel
      Width = 853
      ExplicitWidth = 1260
    end
  end
  object cxgProdutos: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1024
    Height = 560
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitWidth = 1431
    ExplicitHeight = 464
    object cxvProdutos: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvProdutosCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.ContentEven = cxStyle1
      Bands = <
        item
          Caption = 'Produto'
          FixedKind = fkLeft
          Width = 461
        end
        item
          Caption = 'Tabela do Fornecedor'
          FixedKind = fkLeft
        end
        item
          Caption = 'Pre'#231'os'
          FixedKind = fkLeft
          Width = 282
        end
        item
          Caption = 'Custos'
        end
        item
          Caption = 'Dados Cadastrais'
        end>
      object cxvProdutosCODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        HeaderAlignmentHorz = taCenter
        SortIndex = 0
        SortOrder = soAscending
        Width = 68
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvProdutosDESITE: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        HeaderAlignmentHorz = taCenter
        Width = 245
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvProdutosCODEMP: TcxGridDBBandedColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'ITE_CODEMP'
        HeaderAlignmentHorz = taCenter
        MinWidth = 68
        SortIndex = 1
        SortOrder = soAscending
        Width = 68
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvProdutosMARGEM: TcxGridDBBandedColumn
        Caption = 'Margem (Atual)'
        DataBinding.FieldName = 'ITE_MARBRU_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvProdutosPREVEN: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda (Atual)'
        DataBinding.FieldName = 'ITE_PREVEN_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvProdutosPRENOV: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o de Venda (Novo)'
        DataBinding.FieldName = 'ITE_PREVEN_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvProdutosDESADB: TcxGridDBBandedColumn
        Caption = 'Descontos Adicionais (Boleto) (+) (Atual)'
        DataBinding.FieldName = 'ITE_DESADB_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 3
        Position.ColIndex = 30
        Position.RowIndex = 0
      end
      object cxvProdutosCLAIPI: TcxGridDBBandedColumn
        Caption = 'NCM / Classifica'#231#227'o de IPI (Atual)'
        DataBinding.FieldName = 'ITE_CLAIPI_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 77
        Position.BandIndex = 4
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxvProdutosDIAFOR: TcxGridDBBandedColumn
        Caption = 'Dias para entrega do Fornecedor (Atual)'
        DataBinding.FieldName = 'ITE_DIAFOR_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxvProdutosPRECOM: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Compra (Atual)'
        DataBinding.FieldName = 'ITE_PRECOM_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 78
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvProdutosDESF01: TcxGridDBBandedColumn
        Caption = 'Desconto 1 (Atual)'
        DataBinding.FieldName = 'ITE_DESF01_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvProdutosDESF02: TcxGridDBBandedColumn
        Caption = 'Desconto 2 (Atual)'
        DataBinding.FieldName = 'ITE_DESF02_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvProdutosDESF03: TcxGridDBBandedColumn
        Caption = 'Desconto 3 (Atual)'
        DataBinding.FieldName = 'ITE_DESF03_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxvProdutosDESF04: TcxGridDBBandedColumn
        Caption = 'Desconto 4 (Atual)'
        DataBinding.FieldName = 'ITE_DESF04_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxvProdutosDESF05: TcxGridDBBandedColumn
        Caption = 'Desconto 5 (Atual)'
        DataBinding.FieldName = 'ITE_DESF05_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxvProdutosDESF06: TcxGridDBBandedColumn
        Caption = 'Desconto 6 (Atual)'
        DataBinding.FieldName = 'ITE_DESF06_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxvProdutosICMENT: TcxGridDBBandedColumn
        Caption = 'ICMS Entrada (-) (Atual)'
        DataBinding.FieldName = 'ITE_ICMENT_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 62
        Position.BandIndex = 3
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxvProdutosSUBFED: TcxGridDBBandedColumn
        Caption = 'Impostos Federais (-) (Atual)'
        DataBinding.FieldName = 'ITE_SUBFED_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 18
        Position.RowIndex = 0
      end
      object cxvProdutosIPIENT: TcxGridDBBandedColumn
        Caption = 'IPI Entrada (+) (Atual)'
        DataBinding.FieldName = 'ITE_IPIENT_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 20
        Position.RowIndex = 0
      end
      object cxvProdutosFREENT: TcxGridDBBandedColumn
        Caption = 'Frete (+) (Atual)'
        DataBinding.FieldName = 'ITE_FREENT_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 22
        Position.RowIndex = 0
      end
      object cxvProdutosVALFRE: TcxGridDBBandedColumn
        Caption = 'Valor Frete (+) (Atual)'
        DataBinding.FieldName = 'ITE_VALFRE_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 24
        Position.RowIndex = 0
      end
      object cxvProdutosACRFIN: TcxGridDBBandedColumn
        Caption = 'Acr'#233'scimo Finan. (+) (Atual)'
        DataBinding.FieldName = 'ITE_ACRFIN_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 26
        Position.RowIndex = 0
      end
      object cxvProdutosSUBSTI: TcxGridDBBandedColumn
        Caption = 'Sub. Tribut'#225'ria (+) (Atual)'
        DataBinding.FieldName = 'ITE_SUBSTI_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 28
        Position.RowIndex = 0
      end
      object cxvProdutosTCIFCU: TcxGridDBBandedColumn
        Caption = 'TCIF (+) (Atual)'
        DataBinding.FieldName = 'ITE_TCIFCU_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 3
        Position.ColIndex = 32
        Position.RowIndex = 0
      end
      object cxvProdutosTSCUST: TcxGridDBBandedColumn
        Caption = 'TS (+) (Atual)'
        DataBinding.FieldName = 'ITE_TSCUST_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 3
        Position.ColIndex = 34
        Position.RowIndex = 0
      end
      object cxvProdutosDEPICO: TcxGridDBBandedColumn
        Caption = 'Desconto PIS/COFINS (-) (Atual)'
        DataBinding.FieldName = 'ITE_DEPICO_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 36
        Position.RowIndex = 0
      end
      object cxvProdutosDEICMS: TcxGridDBBandedColumn
        Caption = 'Desconto ICMS (-) (Atual)'
        DataBinding.FieldName = 'ITE_DEICMS_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 3
        Position.ColIndex = 38
        Position.RowIndex = 0
      end
      object cxvProdutosFATREG: TcxGridDBBandedColumn
        Caption = 'Fator Regional (+) (Atual)'
        DataBinding.FieldName = 'ITE_FATREG_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 40
        Position.RowIndex = 0
      end
      object cxvProdutosPRECUS: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o de Custo (Atual)'
        DataBinding.FieldName = 'ITE_PRECUS_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 66
        Position.BandIndex = 3
        Position.ColIndex = 42
        Position.RowIndex = 0
      end
      object cxvProdutosOUTVAL: TcxGridDBBandedColumn
        Caption = 'Outros Valores (+) (Atual)'
        DataBinding.FieldName = 'ITE_OUTVAL_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 44
        Position.RowIndex = 0
      end
      object cxvProdutosICMSAI: TcxGridDBBandedColumn
        Caption = 'ICMS Sa'#237'da (+) (Atual)'
        DataBinding.FieldName = 'ITE_ICMSAI_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 46
        Position.RowIndex = 0
      end
      object cxvProdutosIMPFED: TcxGridDBBandedColumn
        Caption = 'Impostos Federais (+) (Atual)'
        DataBinding.FieldName = 'ITE_IMPFED_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 63
        Position.BandIndex = 3
        Position.ColIndex = 48
        Position.RowIndex = 0
      end
      object cxvProdutosDESOPE: TcxGridDBBandedColumn
        Caption = 'Despesas Operacionais (+) (Atual)'
        DataBinding.FieldName = 'ITE_DESOPE_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 3
        Position.ColIndex = 50
        Position.RowIndex = 0
      end
      object cxvProdutosBAREMB: TcxGridDBBandedColumn
        Caption = 'C'#243'digo  Barras Embalagem (Atual)'
        DataBinding.FieldName = 'TFO_BAREMB_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 96
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvProdutosCODBAR: TcxGridDBBandedColumn
        Caption = 'C'#243'digo de Barras (Atual)'
        DataBinding.FieldName = 'TFO_CODBAR_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 96
        Position.BandIndex = 4
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvProdutosCODFAB: TcxGridDBBandedColumn
        Caption = 'C'#243'digo de F'#225'brica (Atual)'
        DataBinding.FieldName = 'ITE_CODFAB_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 95
        Position.BandIndex = 4
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvProdutosREFERE: TcxGridDBBandedColumn
        Caption = 'Refer'#234'ncia (Atual)'
        DataBinding.FieldName = 'TFO_REFERE_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 90
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvProdutosDESFAB: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o do Fabricante (Atual)'
        DataBinding.FieldName = 'ITE_DESFAB_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 123
        Position.BandIndex = 4
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxvProdutosMLTCOM: TcxGridDBBandedColumn
        Caption = 'M'#250'ltiplo Compra (Atual)'
        DataBinding.FieldName = 'ITE_MLTCOM_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 4
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxvProdutosEMBALA: TcxGridDBBandedColumn
        Caption = 'Quantidade Embalagem (Atual)'
        DataBinding.FieldName = 'TFO_EMBALA_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 18
        Position.RowIndex = 0
      end
      object cxvProdutosPESOIT: TcxGridDBBandedColumn
        Caption = 'Peso (Atual)'
        DataBinding.FieldName = 'TFO_PESOIT_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 20
        Position.RowIndex = 0
      end
      object cxvProdutosNOTESP: TcxGridDBBandedColumn
        Caption = 'Divis'#237'vel (Atual)'
        DataBinding.FieldName = 'TFO_NOTESP_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 50
        Position.BandIndex = 4
        Position.ColIndex = 22
        Position.RowIndex = 0
      end
      object cxvProdutosEXCIPI: TcxGridDBBandedColumn
        Caption = 'C'#243'digo EX IPI (Atual)'
        DataBinding.FieldName = 'ITE_EXCIPI_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxvProdutosSIGUNI: TcxGridDBBandedColumn
        Caption = 'Unidade Compra (Sigla) (Atual)'
        DataBinding.FieldName = 'SIGUNI_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 4
        Position.ColIndex = 24
        Position.RowIndex = 0
      end
      object cxvProdutosCODABF: TcxGridDBBandedColumn
        Caption = 'Abrevia'#231#227'o Fiscal (Atual)'
        DataBinding.FieldName = 'ITE_CODABF_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 26
        Position.RowIndex = 0
      end
      object cxvProdutosABFPIS: TcxGridDBBandedColumn
        Caption = 'Abrevia'#231#227'o de PIS (Atual)'
        DataBinding.FieldName = 'ITE_ABFPIS_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 28
        Position.RowIndex = 0
      end
      object cxvProdutosABFIPI: TcxGridDBBandedColumn
        Caption = 'Abrevia'#231#227'o de IPI (Atual)'
        DataBinding.FieldName = 'ITE_ABFIPI_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 30
        Position.RowIndex = 0
      end
      object cxvProdutosABFCOF: TcxGridDBBandedColumn
        Caption = 'Abrevia'#231#227'o de COFINS (Atual)'
        DataBinding.FieldName = 'ITE_ABFCOF_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 32
        Position.RowIndex = 0
      end
      object cxvProdutosSITPRO: TcxGridDBBandedColumn
        Caption = 'Situa'#231#227'o do Produto (Atual)'
        DataBinding.FieldName = 'TFO_SITPRO_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 34
        Position.RowIndex = 0
      end
      object cxvProdutosPRDGRU: TcxGridDBBandedColumn
        Caption = 'Grupo de Produtos (Atual)'
        DataBinding.FieldName = 'TFO_PRDGRU_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 36
        Position.RowIndex = 0
      end
      object cxvProdutosPRECOMNOV: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Compra (Novo)'
        DataBinding.FieldName = 'ITE_PRECOM_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 71
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvProdutosDESF01NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 1 (Novo)'
        DataBinding.FieldName = 'ITE_DESF01_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvProdutosDESF02NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 2 (Novo)'
        DataBinding.FieldName = 'ITE_DESF02_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvProdutosDESF03NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 3 (Novo)'
        DataBinding.FieldName = 'ITE_DESF03_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxvProdutosDESF04NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 4 (Novo)'
        DataBinding.FieldName = 'ITE_DESF04_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxvProdutosDESF05NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 5 (Novo)'
        DataBinding.FieldName = 'ITE_DESF05_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxvProdutosDESF06NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 6 (Novo)'
        DataBinding.FieldName = 'ITE_DESF06_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxvProdutosICMENTNOV: TcxGridDBBandedColumn
        Caption = 'ICMS Entrada (-) (Novo)'
        DataBinding.FieldName = 'ITE_ICMENT_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 62
        Position.BandIndex = 3
        Position.ColIndex = 17
        Position.RowIndex = 0
      end
      object cxvProdutosSUBFEDNOV: TcxGridDBBandedColumn
        Caption = 'Impostos Federais (-) (Novo)'
        DataBinding.FieldName = 'ITE_SUBFED_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 19
        Position.RowIndex = 0
      end
      object cxvProdutosIPIENTNOV: TcxGridDBBandedColumn
        Caption = 'IPI Entrada (+) (Novo)'
        DataBinding.FieldName = 'ITE_IPIENT_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 21
        Position.RowIndex = 0
      end
      object cxvProdutosFREENTNOV: TcxGridDBBandedColumn
        Caption = 'Frete (+) (Novo)'
        DataBinding.FieldName = 'ITE_FREENT_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 23
        Position.RowIndex = 0
      end
      object cxvProdutosVALFRENOV: TcxGridDBBandedColumn
        Caption = 'Valor Frete (+) (Novo)'
        DataBinding.FieldName = 'ITE_VALFRE_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 25
        Position.RowIndex = 0
      end
      object cxvProdutosACRFINNOV: TcxGridDBBandedColumn
        Caption = 'Acr'#233'scimo Finan. (+) (Novo)'
        DataBinding.FieldName = 'ITE_ACRFIN_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 27
        Position.RowIndex = 0
      end
      object cxvProdutosSUBSTINOV: TcxGridDBBandedColumn
        Caption = 'Sub. Tribut'#225'ria (+) (Novo)'
        DataBinding.FieldName = 'ITE_SUBSTI_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 29
        Position.RowIndex = 0
      end
      object cxvProdutosDESADBNOV: TcxGridDBBandedColumn
        Caption = 'Descontos Adicionais (Boleto) (+) (Novo)'
        DataBinding.FieldName = 'ITE_DESADB_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 3
        Position.ColIndex = 31
        Position.RowIndex = 0
      end
      object cxvProdutosTCIFCUNOV: TcxGridDBBandedColumn
        Caption = 'TCIF (+) (Novo)'
        DataBinding.FieldName = 'ITE_TCIFCU_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 3
        Position.ColIndex = 33
        Position.RowIndex = 0
      end
      object cxvProdutosTSCUSTNOV: TcxGridDBBandedColumn
        Caption = 'TS (+) (Novo)'
        DataBinding.FieldName = 'ITE_TSCUST_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 3
        Position.ColIndex = 35
        Position.RowIndex = 0
      end
      object cxvProdutosDEPICONOV: TcxGridDBBandedColumn
        Caption = 'Desconto PIS/COFINS (-) (Novo)'
        DataBinding.FieldName = 'ITE_DEPICO_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 37
        Position.RowIndex = 0
      end
      object cxvProdutosDEICMSNOV: TcxGridDBBandedColumn
        Caption = 'Desconto ICMS (-) (Novo)'
        DataBinding.FieldName = 'ITE_DEICMS_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 3
        Position.ColIndex = 39
        Position.RowIndex = 0
      end
      object cxvProdutosFATREGNOV: TcxGridDBBandedColumn
        Caption = 'Fator Regional (+) (Novo)'
        DataBinding.FieldName = 'ITE_FATREG_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 41
        Position.RowIndex = 0
      end
      object cxvProdutosPRECUSNOV: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o de Custo (Novo)'
        DataBinding.FieldName = 'ITE_PRECUS_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 66
        Position.BandIndex = 3
        Position.ColIndex = 43
        Position.RowIndex = 0
      end
      object cxvProdutosOUTVALNOV: TcxGridDBBandedColumn
        Caption = 'Outros Valores (+) (Novo)'
        DataBinding.FieldName = 'ITE_OUTVAL_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 45
        Position.RowIndex = 0
      end
      object cxvProdutosICMSAINOV: TcxGridDBBandedColumn
        Caption = 'ICMS Sa'#237'da (+) (Novo)'
        DataBinding.FieldName = 'ITE_ICMSAI_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 47
        Position.RowIndex = 0
      end
      object cxvProdutosIMPFEDNOV: TcxGridDBBandedColumn
        Caption = 'Impostos Federais (+) (Novo)'
        DataBinding.FieldName = 'ITE_IMPFED_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 63
        Position.BandIndex = 3
        Position.ColIndex = 49
        Position.RowIndex = 0
      end
      object cxvProdutosDESOPENOV: TcxGridDBBandedColumn
        Caption = 'Despesas Operacionais (+) (Novo)'
        DataBinding.FieldName = 'ITE_DESOPE_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 3
        Position.ColIndex = 51
        Position.RowIndex = 0
      end
      object cxvProdutosDIAFORNOV: TcxGridDBBandedColumn
        Caption = 'Dias para entrega do Fornecedor (Novo)'
        DataBinding.FieldName = 'ITE_DIAFOR_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxvProdutosCLAIPINOV: TcxGridDBBandedColumn
        Caption = 'NCM / Classifica'#231#227'o de IPI (Novo)'
        DataBinding.FieldName = 'ITE_CLAIPI_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 77
        Position.BandIndex = 4
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxvProdutosDESFABNOV: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o do Fabricante (Novo)'
        DataBinding.FieldName = 'ITE_DESFAB_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 123
        Position.BandIndex = 4
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxvProdutosCODFABNOV: TcxGridDBBandedColumn
        Caption = 'C'#243'digo de F'#225'brica (Novo)'
        DataBinding.FieldName = 'ITE_CODFAB_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 95
        Position.BandIndex = 4
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvProdutosBAREMBNOV: TcxGridDBBandedColumn
        Caption = 'C'#243'digo  Barras Embalagem (Novo)'
        DataBinding.FieldName = 'TFO_BAREMB_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 96
        Position.BandIndex = 4
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvProdutosREFERENOV: TcxGridDBBandedColumn
        Caption = 'Refer'#234'ncia (Novo)'
        DataBinding.FieldName = 'TFO_REFERE_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 90
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvProdutosCODBARNOV: TcxGridDBBandedColumn
        Caption = 'C'#243'digo de Barras (Novo)'
        DataBinding.FieldName = 'TFO_CODBAR_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 96
        Position.BandIndex = 4
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvProdutosEXCIPINOV: TcxGridDBBandedColumn
        Caption = 'C'#243'digo EX IPI (Novo)'
        DataBinding.FieldName = 'ITE_EXCIPI_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxvProdutosMLTCOMNOV: TcxGridDBBandedColumn
        Caption = 'M'#250'ltiplo Compra (Novo)'
        DataBinding.FieldName = 'ITE_MLTCOM_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 4
        Position.ColIndex = 17
        Position.RowIndex = 0
      end
      object cxvProdutosEMBALANOV: TcxGridDBBandedColumn
        Caption = 'Quantidade Embalagem (Novo)'
        DataBinding.FieldName = 'TFO_EMBALA_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 19
        Position.RowIndex = 0
      end
      object cxvProdutosNOTESPNOV: TcxGridDBBandedColumn
        Caption = 'Divis'#237'vel (Novo)'
        DataBinding.FieldName = 'TFO_NOTESP_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 50
        Position.BandIndex = 4
        Position.ColIndex = 23
        Position.RowIndex = 0
      end
      object cxvProdutosPESOITNOV: TcxGridDBBandedColumn
        Caption = 'Peso (Novo)'
        DataBinding.FieldName = 'TFO_PESOIT_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 21
        Position.RowIndex = 0
      end
      object cxvProdutosSIGUNINOV: TcxGridDBBandedColumn
        Caption = 'Unidade Compra (Sigla) (Novo)'
        DataBinding.FieldName = 'SIGUNI_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 4
        Position.ColIndex = 25
        Position.RowIndex = 0
      end
      object cxvProdutosCODABFNOV: TcxGridDBBandedColumn
        Caption = 'Abrevia'#231#227'o Fiscal (Novo)'
        DataBinding.FieldName = 'ITE_CODABF_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 27
        Position.RowIndex = 0
      end
      object cxvProdutosABFPISNOV: TcxGridDBBandedColumn
        Caption = 'Abrevia'#231#227'o de PIS (Novo)'
        DataBinding.FieldName = 'ITE_ABFPIS_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 29
        Position.RowIndex = 0
      end
      object cxvProdutosABFIPINOV: TcxGridDBBandedColumn
        Caption = 'Abrevia'#231#227'o de IPI (Novo)'
        DataBinding.FieldName = 'ITE_ABFIPI_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 31
        Position.RowIndex = 0
      end
      object cxvProdutosABFCOFNOV: TcxGridDBBandedColumn
        Caption = 'Abrevia'#231#227'o de COFINS (Novo)'
        DataBinding.FieldName = 'ITE_ABFCOF_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 33
        Position.RowIndex = 0
      end
      object cxvProdutosSITPRONOV: TcxGridDBBandedColumn
        Caption = 'Situa'#231#227'o do Produto (Novo)'
        DataBinding.FieldName = 'TFO_SITPRO_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 35
        Position.RowIndex = 0
      end
      object cxvProdutosPRDGRUNOV: TcxGridDBBandedColumn
        Caption = 'Grupo de Produtos (Novo)'
        DataBinding.FieldName = 'TFO_PRDGRU_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 4
        Position.ColIndex = 37
        Position.RowIndex = 0
      end
      object cxvProdutosMARCADO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'MARCADO'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvProdutosCODFOR: TcxGridDBBandedColumn
        Caption = 'Fornecedor (Atual)'
        DataBinding.FieldName = 'ITE_CODFOR_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvProdutosCODFORNOV: TcxGridDBBandedColumn
        Caption = 'Fornecedor (Novo)'
        DataBinding.FieldName = 'ITE_CODFOR_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvProdutosCODTAB: TcxGridDBBandedColumn
        Caption = 'Tabela (Atual)'
        DataBinding.FieldName = 'ITE_CODTAB_ATU'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvProdutosCODTABNOV: TcxGridDBBandedColumn
        Caption = 'Tabela (Nova)'
        DataBinding.FieldName = 'ITE_CODTAB_NOV'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvProdutosCOMLIQ: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o de Compra L'#237'q. (Atual)'
        DataBinding.FieldName = 'ITE_PRCLIQ_ATU'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvProdutosColumn1: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o de Compra L'#237'q. (Novo)'
        DataBinding.FieldName = 'ITE_PRCLIQ_NOV'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 3
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvProdutosMARNOV: TcxGridDBBandedColumn
        Caption = 'Margem (Nova)'
        DataBinding.FieldName = 'ITE_MARBRU_NOV'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvProdutosColumn2: TcxGridDBBandedColumn
        Caption = 'Fornecedor Principal'
        DataBinding.FieldName = 'PRINC'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = cxvProdutosColumn2GetDisplayText
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        MinWidth = 64
        Width = 84
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvProdutosTabPre: TcxGridDBBandedColumn
        Caption = 'Tabela de Pre'#231'o de Venda'
        DataBinding.FieldName = 'TABELA'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 57
        Width = 57
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
    end
    object cxgProdutosLevel1: TcxGridLevel
      GridView = cxvProdutos
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 560
    Width = 1024
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object lblLegendaAzul: TLabel
      Left = 2
      Top = 6
      Width = 339
      Height = 18
      AutoSize = False
      Caption = 'Os itens com a cor da fonte azul ser'#227'o atualizados.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAvisoAtivo: TLabel
      Left = 291
      Top = 6
      Width = 381
      Height = 14
      Caption = 
        'As colunas com fundo amarelo possuem valores diferentes do atual' +
        '.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object flpLegenda: TFlowPanel
      Left = 0
      Top = 24
      Width = 1024
      Height = 27
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 120
      ExplicitWidth = 1431
      object pnlPreco1: TPanel
        Left = 0
        Top = 0
        Width = 128
        Height = 25
        BevelOuter = bvNone
        TabOrder = 0
        object Shape1: TShape
          Left = 1
          Top = 4
          Width = 22
          Height = 17
        end
        object lblPreco1: TLabel
          Left = 32
          Top = 5
          Width = 85
          Height = 14
          Caption = 'Tab. Pre'#231'o Ven. 1'
        end
      end
      object pnlPreco2: TPanel
        Left = 128
        Top = 0
        Width = 128
        Height = 25
        BevelOuter = bvNone
        TabOrder = 1
        object Shape2: TShape
          Left = 1
          Top = 4
          Width = 22
          Height = 17
          Brush.Color = 8894686
        end
        object Label2: TLabel
          Left = 32
          Top = 5
          Width = 85
          Height = 14
          Caption = 'Tab. Pre'#231'o Ven. 2'
        end
      end
      object pnlPreco3: TPanel
        Left = 256
        Top = 0
        Width = 128
        Height = 25
        BevelOuter = bvNone
        TabOrder = 2
        object Shape3: TShape
          Left = 1
          Top = 4
          Width = 22
          Height = 17
          Brush.Color = clSkyBlue
        end
        object Label3: TLabel
          Left = 32
          Top = 5
          Width = 85
          Height = 14
          Caption = 'Tab. Pre'#231'o Ven. 3'
        end
      end
      object pnlPreco4: TPanel
        Left = 384
        Top = 0
        Width = 128
        Height = 25
        BevelOuter = bvNone
        TabOrder = 3
        object Shape4: TShape
          Left = 1
          Top = 4
          Width = 22
          Height = 17
          Brush.Color = clActiveCaption
        end
        object Label4: TLabel
          Left = 32
          Top = 5
          Width = 85
          Height = 14
          Caption = 'Tab. Pre'#231'o Ven. 4'
        end
      end
      object pnlPreco5: TPanel
        Left = 512
        Top = 0
        Width = 128
        Height = 25
        BevelOuter = bvNone
        TabOrder = 4
        object Shape5: TShape
          Left = 1
          Top = 4
          Width = 22
          Height = 17
          Brush.Color = clMoneyGreen
        end
        object Label5: TLabel
          Left = 32
          Top = 5
          Width = 85
          Height = 14
          Caption = 'Tab. Pre'#231'o Ven. 5'
        end
      end
      object Panel7: TPanel
        Left = 640
        Top = 0
        Width = 128
        Height = 25
        BevelOuter = bvNone
        TabOrder = 5
        object pnlPreco6: TLabel
          Left = 32
          Top = 5
          Width = 85
          Height = 14
          Caption = 'Tab. Pre'#231'o Ven. 6'
        end
        object Shape6: TShape
          Left = 7
          Top = 4
          Width = 22
          Height = 17
          Brush.Color = 15134970
        end
      end
      object pnlPreco7: TPanel
        Left = 768
        Top = 0
        Width = 128
        Height = 25
        BevelOuter = bvNone
        TabOrder = 6
        object Shape7: TShape
          Left = 1
          Top = 4
          Width = 22
          Height = 17
          Brush.Color = clSilver
        end
        object Label7: TLabel
          Left = 32
          Top = 5
          Width = 85
          Height = 14
          Caption = 'Tab. Pre'#231'o Ven. 7'
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 192
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 312
    Top = 192
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 144
    Top = 360
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 15461355
    end
  end
end
