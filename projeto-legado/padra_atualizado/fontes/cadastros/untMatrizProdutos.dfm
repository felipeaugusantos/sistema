inherited frmMatrizProdutos: TfrmMatrizProdutos
  Width = 1058
  Height = 587
  Caption = 'Matriz para cadastramento de novos produtos'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1058
  ExplicitHeight = 587
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 514
    Width = 1052
    ExplicitTop = 514
    ExplicitWidth = 1052
    inherited FlwBotoes: TFlowPanel
      Width = 1048
      ExplicitWidth = 1048
      object btnCopiar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 289
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[F2] Copiar valor da coluna atual para todos os registros'
        TabOrder = 0
        OnClick = btnCopiarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 969
      ExplicitLeft = 969
    end
  end
  inherited pnlStatus: TPanel
    Top = 542
    Width = 1052
    ExplicitTop = 542
    ExplicitWidth = 1052
    inherited pnlNomeForm: TPanel
      Left = 881
      ExplicitLeft = 881
    end
    inherited pnlInfo: TPanel
      Width = 881
      ExplicitWidth = 881
    end
  end
  object grdMatriz: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1052
    Height = 514
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdMatrizTv: TcxGridDBBandedTableViewCitel
      OnKeyDown = grdMatrizTvKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnEditValueChanged = grdMatrizTvEditValueChanged
      DataController.DataSource = dsMatriz
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Bands = <
        item
          Caption = 'Linha/Grupo'
          FixedKind = fkLeft
        end
        item
          Caption = 'Desconto'
        end
        item
          Caption = 'Margem'
        end
        item
          Caption = 'Comiss'#227'o'
        end
        item
          Caption = 'Comiss'#227'o Tabela de Pre'#231'o 1'
        end
        item
          Caption = 'Comiss'#227'o Tabela de Pre'#231'o 2'
        end
        item
          Caption = 'Comiss'#227'o Tabela de Pre'#231'o 3'
        end
        item
          Caption = 'Comiss'#227'o Tabela de Pre'#231'o 4'
        end
        item
          Caption = 'Comiss'#227'o Tabela de Pre'#231'o 5'
        end
        item
          Caption = 'Comiss'#227'o Tabela de Pre'#231'o 6'
        end
        item
          Caption = 'Comiss'#227'o Tabela de Pre'#231'o 7'
        end
        item
          Caption = 'Desc./Marg. Gerentes e SubGerentes'
        end>
      Zebra = True
      Destaque = False
      DestacarRegistro = False
      CorZebra = clMoneyGreen
      object MAT_CODGRU: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'GRU_CODGRU'
        Options.Editing = False
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_DESGRU: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        Options.Editing = False
        Width = 100
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_DESF01: TcxGridDBBandedColumn
        Caption = 'Desconto 1'
        DataBinding.FieldName = 'MAT_DESF01'
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_DESF02: TcxGridDBBandedColumn
        Caption = 'Desconto 2'
        DataBinding.FieldName = 'MAT_DESF02'
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_DESF03: TcxGridDBBandedColumn
        Caption = 'Desconto 3'
        DataBinding.FieldName = 'MAT_DESF03'
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_DESF04: TcxGridDBBandedColumn
        Caption = 'Desconto 4'
        DataBinding.FieldName = 'MAT_DESF04'
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object MAT_DESF05: TcxGridDBBandedColumn
        Caption = 'Desconto 5'
        DataBinding.FieldName = 'MAT_DESF05'
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object MAT_DESF06: TcxGridDBBandedColumn
        Caption = 'Desconto 6'
        DataBinding.FieldName = 'MAT_DESF06'
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object MAT_DESF07: TcxGridDBBandedColumn
        Caption = 'Desconto 7'
        DataBinding.FieldName = 'MAT_DESF07'
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object MAT_MARBR1: TcxGridDBBandedColumn
        Caption = 'Margem 1'
        DataBinding.FieldName = 'MAT_MARBR1'
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_MARBR2: TcxGridDBBandedColumn
        Caption = 'Margem 2'
        DataBinding.FieldName = 'MAT_MARBR2'
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_MARBR3: TcxGridDBBandedColumn
        Caption = 'Margem 3'
        DataBinding.FieldName = 'MAT_MARBR3'
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_MARBR4: TcxGridDBBandedColumn
        Caption = 'Margem 4'
        DataBinding.FieldName = 'MAT_MARBR4'
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object MAT_MARBR5: TcxGridDBBandedColumn
        Caption = 'Margem 5'
        DataBinding.FieldName = 'MAT_MARBR5'
        Position.BandIndex = 2
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object MAT_MARBR6: TcxGridDBBandedColumn
        Caption = 'Margem 6'
        DataBinding.FieldName = 'MAT_MARBR6'
        Position.BandIndex = 2
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object MAT_MARBR7: TcxGridDBBandedColumn
        Caption = 'Margem 7'
        DataBinding.FieldName = 'MAT_MARBR7'
        Position.BandIndex = 2
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object MAT_COMTB1: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 1'
        DataBinding.FieldName = 'MAT_COMTB1'
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_COMTB2: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 2'
        DataBinding.FieldName = 'MAT_COMTB2'
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_COMTB3: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 3'
        DataBinding.FieldName = 'MAT_COMTB3'
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_COMTB4: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 4'
        DataBinding.FieldName = 'MAT_COMTB4'
        Position.BandIndex = 3
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object MAT_COMTB5: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 5'
        DataBinding.FieldName = 'MAT_COMTB5'
        Position.BandIndex = 3
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object MAT_COMTB6: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 6'
        DataBinding.FieldName = 'MAT_COMTB6'
        Position.BandIndex = 3
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object MAT_COMTB7: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 7'
        DataBinding.FieldName = 'MAT_COMTB7'
        Position.BandIndex = 3
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object MAT_COMVAR: TcxGridDBBandedColumn
        Caption = 'Com. Vend. Int.'
        DataBinding.FieldName = 'MAT_COMVAR'
        Position.BandIndex = 3
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object MAT_COMATA: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext Loja'
        DataBinding.FieldName = 'MAT_COMATA'
        Position.BandIndex = 3
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object MAT_COMDIS: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext. Dis.'
        DataBinding.FieldName = 'MAT_COMDIS'
        Position.BandIndex = 3
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object MAT_COMDIG: TcxGridDBBandedColumn
        Caption = 'Com. Dig.'
        DataBinding.FieldName = 'MAT_COMDIG'
        Position.BandIndex = 3
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object MAT_DESMAX: TcxGridDBBandedColumn
        Caption = 'Desc. M'#225'x. Vend.'
        DataBinding.FieldName = 'MAT_DESMAX'
        Position.BandIndex = 11
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_DESMSU: TcxGridDBBandedColumn
        Caption = 'Desc. M'#225'x. Sub Gerente'
        DataBinding.FieldName = 'MAT_DESMSU'
        Position.BandIndex = 11
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_DESMGE: TcxGridDBBandedColumn
        Caption = 'Desc. M'#225'x. Gerente'
        DataBinding.FieldName = 'MAT_DESMGE'
        Position.BandIndex = 11
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_MARMIN: TcxGridDBBandedColumn
        Caption = 'Marg. M'#237'm. Vend.'
        DataBinding.FieldName = 'MAT_MARMIN'
        Position.BandIndex = 11
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object MAT_MARMSG: TcxGridDBBandedColumn
        Caption = 'Marg. M'#237'n. Sub Gerente'
        DataBinding.FieldName = 'MAT_MARMSG'
        Position.BandIndex = 11
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object MAT_MARMGE: TcxGridDBBandedColumn
        Caption = 'Marg. M'#237'n. Gerente'
        DataBinding.FieldName = 'MAT_MARMGE'
        Position.BandIndex = 11
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object MAT_COMVAR1: TcxGridDBBandedColumn
        Caption = 'Com. Vend. Int.'
        DataBinding.FieldName = 'MAT_COMVAR'
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_COMVAR2: TcxGridDBBandedColumn
        Caption = 'Com. Vend. Int.'
        DataBinding.FieldName = 'MAT_COMVAR2'
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_COMVAR3: TcxGridDBBandedColumn
        Caption = 'Com. Vend. Int.'
        DataBinding.FieldName = 'MAT_COMVAR3'
        Position.BandIndex = 6
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_COMVAR4: TcxGridDBBandedColumn
        Caption = 'Com. Vend. Int.'
        DataBinding.FieldName = 'MAT_COMVAR4'
        Position.BandIndex = 7
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_COMVAR5: TcxGridDBBandedColumn
        Caption = 'Com. Vend. Int.'
        DataBinding.FieldName = 'MAT_COMVAR5'
        Position.BandIndex = 8
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_COMVAR6: TcxGridDBBandedColumn
        Caption = 'Com. Vend. Int.'
        DataBinding.FieldName = 'MAT_COMVAR6'
        Position.BandIndex = 9
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_COMVAR7: TcxGridDBBandedColumn
        Caption = 'Com. Vend. Int.'
        DataBinding.FieldName = 'MAT_COMVAR7'
        Position.BandIndex = 10
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object MAT_COMATA1: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext Loja'
        DataBinding.FieldName = 'MAT_COMATA'
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_COMATA2: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext Loja'
        DataBinding.FieldName = 'MAT_COMATA2'
        Position.BandIndex = 5
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_COMATA3: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext Loja'
        DataBinding.FieldName = 'MAT_COMATA3'
        Position.BandIndex = 6
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_COMATA4: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext Loja'
        DataBinding.FieldName = 'MAT_COMATA4'
        Position.BandIndex = 7
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_COMATA5: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext Loja'
        DataBinding.FieldName = 'MAT_COMATA5'
        Position.BandIndex = 8
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_COMATA6: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext Loja'
        DataBinding.FieldName = 'MAT_COMATA6'
        Position.BandIndex = 9
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_COMATA7: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext Loja'
        DataBinding.FieldName = 'MAT_COMATA7'
        Position.BandIndex = 10
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object MAT_COMDIS1: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext. Dis.'
        DataBinding.FieldName = 'MAT_COMDIS'
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_COMDIS2: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext. Dis.'
        DataBinding.FieldName = 'MAT_COMDIS2'
        Position.BandIndex = 5
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_COMDIS3: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext. Dis.'
        DataBinding.FieldName = 'MAT_COMDIS3'
        Position.BandIndex = 6
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_COMDIS4: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext. Dis.'
        DataBinding.FieldName = 'MAT_COMDIS4'
        Position.BandIndex = 7
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_COMDIS5: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext. Dis.'
        DataBinding.FieldName = 'MAT_COMDIS5'
        Position.BandIndex = 8
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_COMDIS6: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext. Dis.'
        DataBinding.FieldName = 'MAT_COMDIS6'
        Position.BandIndex = 9
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_COMDIS7: TcxGridDBBandedColumn
        Caption = 'Com. Rep. Ext. Dis.'
        DataBinding.FieldName = 'MAT_COMDIS7'
        Position.BandIndex = 10
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object MAT_COMDIG1: TcxGridDBBandedColumn
        Caption = 'Com. Dig.'
        DataBinding.FieldName = 'MAT_COMDIG'
        Position.BandIndex = 4
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object MAT_COMDIG2: TcxGridDBBandedColumn
        Caption = 'Com. Dig.'
        DataBinding.FieldName = 'MAT_COMDIG2'
        Position.BandIndex = 5
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object MAT_COMDIG3: TcxGridDBBandedColumn
        Caption = 'Com. Dig.'
        DataBinding.FieldName = 'MAT_COMDIG3'
        Position.BandIndex = 6
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object MAT_COMDIG4: TcxGridDBBandedColumn
        Caption = 'Com. Dig.'
        DataBinding.FieldName = 'MAT_COMDIG4'
        Position.BandIndex = 7
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object MAT_COMDIG5: TcxGridDBBandedColumn
        Caption = 'Com. Dig.'
        DataBinding.FieldName = 'MAT_COMDIG5'
        Position.BandIndex = 8
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object MAT_COMDIG6: TcxGridDBBandedColumn
        Caption = 'Com. Dig.'
        DataBinding.FieldName = 'MAT_COMDIG6'
        Position.BandIndex = 9
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object MAT_COMDIG7: TcxGridDBBandedColumn
        Caption = 'Com. Dig.'
        DataBinding.FieldName = 'MAT_COMDIG7'
        Position.BandIndex = 10
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
    end
    object grdMatrizDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      Bands = <
        item
        end>
      Zebra = False
      Destaque = False
      DestacarRegistro = False
      CorZebra = clMoneyGreen
    end
    object grdMatrizLv: TcxGridLevel
      GridView = grdMatrizTv
    end
  end
  object dsMatriz: TDataSource
    Left = 384
    Top = 216
  end
end
