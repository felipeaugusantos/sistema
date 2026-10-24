inherited frmImportCadProdutoConfirma: TfrmImportCadProdutoConfirma
  Width = 1024
  Height = 725
  BorderStyle = bsSizeable
  Caption = 'Importa'#231#227'o Cadastro de Produto - Confirma'#231#227'o'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 725
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 644
    Width = 1008
    ExplicitTop = 644
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 927
      ExplicitWidth = 927
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
      object btnVisProdNaoImp: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 196
        Height = 22
        Caption = 'Visualizar Relat'#243'rio de Criticas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000030000000C000000120000001400000014000000150000
          0015000000140000000D00000003000000000000000000000000000000000000
          00000000000000000009896256C2BD8A78FFBE8A78FFBD8A78FFBD8978FFBD89
          78FFBE8978FF876356C30000000B000000000000000000000000000000030000
          000E0000001500000021C08D7CFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
          E8FFF5ECE7FFBF8D7BFF00000026000000180000000F000000040000000C7B50
          42C5A76E5BFF9F6755FFC2917FFFF7F0ECFFE2B47DFFE2B37AFFE1B077FFE0AE
          72FFF6EEEAFFC2907FFF845545FF895847FF613E32C70000000E00000011BB7E
          6BFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFE0B1
          76FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67763FF0000001400000010BE85
          71FFF1E5DAFFECDBD0FF7A4835FF7A4835FF7A4835FF7A4835FF7A4835FF7A48
          35FF7A4835FF7A4835FFEBDBCFFFF1E2D8FFB97C69FF000000130000000EC28B
          78FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
          DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826EFF000000120000000CC793
          7FFFFAF4F1FFCDBEB8FF6F5448FF614337FF614035FF5F3F34FF5E3F33FF5D3D
          32FF5D3D34FF6A4C44FFCABCB6FFF9F5F1FFC18875FF000000100000000ACC99
          86FFFDFAFAFF7D6054FF745043FF744F43FF744E43FF734E43FF734E42FF724D
          42FF724C41FF724C40FF73584DFFFDFAFAFFC58F7CFF0000000E00000008CF9F
          8DFFFFFFFFFF7A5A4CFF8E695AFFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
          DEFFF6EFEBFF866253FF704F43FFFFFFFFFFCA9683FF0000000B00000005BE95
          84E9F5ECE8FF866656FF977262FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
          E1FFF8F2EEFF8E6A5BFF7A5B4CFFF5EAE6FFBA8E7DEA00000008000000023429
          2545A78375CC947262FFA07B6AFFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
          E3FFF9F5F3FF977263FF876658FFA68072CE3428234800000003000000000000
          0001000000030000000AC89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
          E7FFFBF7F6FFC59685FF00000011000000040000000200000000000000000000
          00000000000000000005CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
          EAFFFCFAF8FFC89A89FF00000009000000000000000000000000000000000000
          00000000000000000003CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
          FBFFFDFBFAFFCB9F8DFF00000007000000000000000000000000000000000000
          000000000000000000019A796DBFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
          91FFCDA391FF98786BC100000004000000000000000000000000}
        TabOrder = 1
        OnClick = btnVisProdNaoImpClick
      end
      object btnRelProdCad: TBitBtnLocked
        Left = 271
        Top = 0
        Width = 196
        Height = 22
        Caption = 'Produtos que ser'#227'o cadastrados'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000030000000C000000120000001400000014000000150000
          0015000000140000000D00000003000000000000000000000000000000000000
          00000000000000000009896256C2BD8A78FFBE8A78FFBD8A78FFBD8978FFBD89
          78FFBE8978FF876356C30000000B000000000000000000000000000000030000
          000E0000001500000021C08D7CFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
          E8FFF5ECE7FFBF8D7BFF00000026000000180000000F000000040000000C7B50
          42C5A76E5BFF9F6755FFC2917FFFF7F0ECFFE2B47DFFE2B37AFFE1B077FFE0AE
          72FFF6EEEAFFC2907FFF845545FF895847FF613E32C70000000E00000011BB7E
          6BFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFE0B1
          76FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67763FF0000001400000010BE85
          71FFF1E5DAFFECDBD0FF7A4835FF7A4835FF7A4835FF7A4835FF7A4835FF7A48
          35FF7A4835FF7A4835FFEBDBCFFFF1E2D8FFB97C69FF000000130000000EC28B
          78FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
          DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826EFF000000120000000CC793
          7FFFFAF4F1FFCDBEB8FF6F5448FF614337FF614035FF5F3F34FF5E3F33FF5D3D
          32FF5D3D34FF6A4C44FFCABCB6FFF9F5F1FFC18875FF000000100000000ACC99
          86FFFDFAFAFF7D6054FF745043FF744F43FF744E43FF734E43FF734E42FF724D
          42FF724C41FF724C40FF73584DFFFDFAFAFFC58F7CFF0000000E00000008CF9F
          8DFFFFFFFFFF7A5A4CFF8E695AFFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
          DEFFF6EFEBFF866253FF704F43FFFFFFFFFFCA9683FF0000000B00000005BE95
          84E9F5ECE8FF866656FF977262FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
          E1FFF8F2EEFF8E6A5BFF7A5B4CFFF5EAE6FFBA8E7DEA00000008000000023429
          2545A78375CC947262FFA07B6AFFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
          E3FFF9F5F3FF977263FF876658FFA68072CE3428234800000003000000000000
          0001000000030000000AC89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
          E7FFFBF7F6FFC59685FF00000011000000040000000200000000000000000000
          00000000000000000005CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
          EAFFFCFAF8FFC89A89FF00000009000000000000000000000000000000000000
          00000000000000000003CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
          FBFFFDFBFAFFCB9F8DFF00000007000000000000000000000000000000000000
          000000000000000000019A796DBFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
          91FFCDA391FF98786BC100000004000000000000000000000000}
        TabOrder = 2
        OnClick = btnRelProdCadClick
      end
      object btnRelSemReducao: TBitBtnLocked
        Left = 467
        Top = 0
        Width = 238
        Height = 22
        Caption = 'Produtos que n'#227'o tem redu'#231#227'o de pre'#231'o'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000030000000C000000120000001400000014000000150000
          0015000000140000000D00000003000000000000000000000000000000000000
          00000000000000000009896256C2BD8A78FFBE8A78FFBD8A78FFBD8978FFBD89
          78FFBE8978FF876356C30000000B000000000000000000000000000000030000
          000E0000001500000021C08D7CFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
          E8FFF5ECE7FFBF8D7BFF00000026000000180000000F000000040000000C7B50
          42C5A76E5BFF9F6755FFC2917FFFF7F0ECFFE2B47DFFE2B37AFFE1B077FFE0AE
          72FFF6EEEAFFC2907FFF845545FF895847FF613E32C70000000E00000011BB7E
          6BFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFE0B1
          76FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67763FF0000001400000010BE85
          71FFF1E5DAFFECDBD0FF7A4835FF7A4835FF7A4835FF7A4835FF7A4835FF7A48
          35FF7A4835FF7A4835FFEBDBCFFFF1E2D8FFB97C69FF000000130000000EC28B
          78FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
          DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826EFF000000120000000CC793
          7FFFFAF4F1FFCDBEB8FF6F5448FF614337FF614035FF5F3F34FF5E3F33FF5D3D
          32FF5D3D34FF6A4C44FFCABCB6FFF9F5F1FFC18875FF000000100000000ACC99
          86FFFDFAFAFF7D6054FF745043FF744F43FF744E43FF734E43FF734E42FF724D
          42FF724C41FF724C40FF73584DFFFDFAFAFFC58F7CFF0000000E00000008CF9F
          8DFFFFFFFFFF7A5A4CFF8E695AFFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
          DEFFF6EFEBFF866253FF704F43FFFFFFFFFFCA9683FF0000000B00000005BE95
          84E9F5ECE8FF866656FF977262FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
          E1FFF8F2EEFF8E6A5BFF7A5B4CFFF5EAE6FFBA8E7DEA00000008000000023429
          2545A78375CC947262FFA07B6AFFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
          E3FFF9F5F3FF977263FF876658FFA68072CE3428234800000003000000000000
          0001000000030000000AC89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
          E7FFFBF7F6FFC59685FF00000011000000040000000200000000000000000000
          00000000000000000005CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
          EAFFFCFAF8FFC89A89FF00000009000000000000000000000000000000000000
          00000000000000000003CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
          FBFFFDFBFAFFCB9F8DFF00000007000000000000000000000000000000000000
          000000000000000000019A796DBFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
          91FFCDA391FF98786BC100000004000000000000000000000000}
        TabOrder = 3
        OnClick = btnRelSemReducaoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Top = 2
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 929
      ExplicitTop = 2
    end
    object chkExibirEmbala: TCheckBox
      Left = 707
      Top = 4
      Width = 218
      Height = 17
      Caption = 'Exibir embalagens ao navegar pelo grid?'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = chkExibirEmbalaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 670
    Width = 1008
    ExplicitTop = 670
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
  object pgcContainer: TPageControl [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 593
    ActivePage = tbsInclui
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    OnChange = pgcContainerChange
    object tbsAltera: TTabSheet
      Caption = 'Produtos que ser'#227'o Atualizados'
      object cxgItens: TcxGrid
        Left = 0
        Top = 0
        Width = 1000
        Height = 540
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfStandard
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgItensView: TcxGridDBTableView
          OnKeyDown = cxgItensViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgItensViewCustomDrawCell
          OnFocusedRecordChanged = cxgItensViewFocusedRecordChanged
          DataController.DataModeController.GridMode = True
          DataController.DataModeController.SyncMode = False
          DataController.DataSource = dtsDados
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Filter.OnChanged = cxgItensViewDataControllerFilterChanged
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir o filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhum registro para ser alterado'
          OptionsView.GroupByBox = False
          object cxgItensViewMARCADO: TcxGridDBColumn
            DataBinding.FieldName = 'MARCADO'
            Visible = False
          end
          object cxgItensViewCodIte: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ITE_CODITE'
            BestFitMaxWidth = 20
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 60
          end
          object cxgItensViewDesIte: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'ITE_DESITE'
            Width = 228
          end
          object cxgItensViewDESITE_NOV: TcxGridDBColumn
            Caption = 'Descri'#231#227'o (Novo)'
            DataBinding.FieldName = 'ITE_DESITE_NOV'
            Width = 186
          end
          object cxgItensViewCodFab: TcxGridDBColumn
            Caption = 'C'#243'd. F'#225'brica'
            DataBinding.FieldName = 'ITE_CODFAB'
            Width = 111
          end
          object cxgItensViewCODFAB_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. F'#225'brica (Novo)'
            DataBinding.FieldName = 'ITE_CODFAB_NOV'
            Width = 110
          end
          object cxgItensViewCodBar: TcxGridDBColumn
            Caption = 'C'#243'd. Barras'
            DataBinding.FieldName = 'ITE_CODBAR'
            Width = 111
          end
          object cxgItensViewCODBAR_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Barras (Novo *) '
            DataBinding.FieldName = 'ITE_CODBAR_NOV'
            Width = 110
          end
          object cxgItensViewCODFOR: TcxGridDBColumn
            Caption = 'C'#243'd. Fornecedor'
            DataBinding.FieldName = 'ITE_CODFOR'
            Width = 111
          end
          object cxgItensViewCODFOR_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Fornecedor (Novo)'
            DataBinding.FieldName = 'ITE_CODFOR_NOV'
            Width = 123
          end
          object cxgItensViewCODDEP: TcxGridDBColumn
            Caption = 'C'#243'd. Departamento'
            DataBinding.FieldName = 'ITE_CODDEP'
            Width = 111
          end
          object cxgItensViewCODDEP_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Departamento(Novo)'
            DataBinding.FieldName = 'ITE_CODDEP_NOV'
            Width = 134
          end
          object cxgItensViewCODGRU: TcxGridDBColumn
            Caption = 'C'#243'd. Linha/Grupo.'
            DataBinding.FieldName = 'ITE_CODGRU'
            Width = 111
          end
          object cxgItensViewCODGRU_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Linha/Grupo(Novo)'
            DataBinding.FieldName = 'ITE_CODGRU_NOV'
            Width = 124
          end
          object cxgItensViewDESFAB: TcxGridDBColumn
            Caption = 'Desc. F'#225'brica'
            DataBinding.FieldName = 'ITE_DESFAB'
            Width = 175
          end
          object cxgItensViewDESFAB_NOV: TcxGridDBColumn
            Caption = 'Desc. F'#225'brica(Novo)'
            DataBinding.FieldName = 'ITE_DESFAB_NOV'
            Width = 184
          end
          object cxgItensViewCODMAR: TcxGridDBColumn
            Caption = 'C'#243'd. Marca.'
            DataBinding.FieldName = 'ITE_CODMAR'
            Width = 111
          end
          object cxgItensViewCODMAR_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Marca(Novo)'
            DataBinding.FieldName = 'ITE_CODMAR_NOV'
            Width = 94
          end
          object cxgItensViewREFERE: TcxGridDBColumn
            Caption = 'Ref'#234'rencia'
            DataBinding.FieldName = 'ITE_REFERE'
            Width = 111
          end
          object cxgItensViewREFERE_NOV: TcxGridDBColumn
            Caption = 'Ref'#234'rencia(Novo)'
            DataBinding.FieldName = 'ITE_REFERE_NOV'
            Width = 92
          end
          object cxgItensViewCODUNI: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'ITE_CODUNI'
            Width = 51
          end
          object cxgItensViewCODUNI_NOV: TcxGridDBColumn
            Caption = 'Unidade(Novo)'
            DataBinding.FieldName = 'ITE_CODUNI_NOV'
            Width = 78
          end
          object cxgItensViewUNICOM: TcxGridDBColumn
            Caption = 'Unidade Compra'
            DataBinding.FieldName = 'ITE_UNICOM'
            Width = 86
          end
          object cxgItensViewUNICOM_NOV: TcxGridDBColumn
            Caption = 'Unidade Compra(Novo)'
            DataBinding.FieldName = 'ITE_UNICOM_NOV'
            Width = 117
          end
          object cxgItensViewCODABF: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o ICMS'
            DataBinding.FieldName = 'ITE_CODABF'
            Width = 115
          end
          object cxgItensViewCODABF_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o ICMS(Novo)'
            DataBinding.FieldName = 'ITE_CODABF_NOV'
            Width = 147
          end
          object cxgItensViewABFPIS: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o PIS'
            DataBinding.FieldName = 'ITE_ABFPIS'
            Width = 108
          end
          object cxgItensViewABFPIS_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o PIS(Novo)'
            DataBinding.FieldName = 'ITE_ABFPIS_NOV'
            Width = 140
          end
          object cxgItensViewABFCOF: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o COFINS'
            DataBinding.FieldName = 'ITE_ABFCOF'
            Width = 119
          end
          object cxgItensViewABFCOF_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o COFINS(Novo)'
            DataBinding.FieldName = 'ITE_ABFCOF_NOV'
            Width = 159
          end
          object cxgItensViewABFIPI: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o IPI'
            DataBinding.FieldName = 'ITE_ABFIPI'
            Width = 111
          end
          object cxgItensViewABFIPI_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o IPI(Novo)'
            DataBinding.FieldName = 'ITE_ABFIPI_NOV'
            Width = 132
          end
          object cxgItensViewIPISAI: TcxGridDBColumn
            Caption = '%IPI de Sa'#237'da'
            DataBinding.FieldName = 'ITE_IPISAI'
            Width = 72
          end
          object cxgItensViewIPISAI_NOV: TcxGridDBColumn
            Caption = '%IPI de Sa'#237'da(Novo)'
            DataBinding.FieldName = 'ITE_IPISAI_NOV'
            Width = 105
          end
          object cxgItensViewINCPIS: TcxGridDBColumn
            Caption = 'Incide PIS/COFINS'
            DataBinding.FieldName = 'ITE_INCPIS'
            Width = 91
          end
          object cxgItensViewINCPIS_NOV: TcxGridDBColumn
            Caption = 'Incide PIS/COFINS(Novo)'
            DataBinding.FieldName = 'ITE_INCPIS_NOV'
            Width = 126
          end
          object cxgItensViewCLAIPI: TcxGridDBColumn
            Caption = 'NCM/Classif. IPI'
            DataBinding.FieldName = 'ITE_CLAIPI'
            Width = 116
          end
          object cxgItensViewCLAIPI_NOV: TcxGridDBColumn
            Caption = 'NCM/Classif. IPI(Novo)'
            DataBinding.FieldName = 'ITE_CLAIPI_NOV'
            Width = 111
          end
          object cxgItensViewEXCIPI: TcxGridDBColumn
            Caption = 'C'#243'd. Ex NCM'
            DataBinding.FieldName = 'ITE_EXCIPI'
            Width = 104
          end
          object cxgItensViewEXCIPI_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Ex NCM(Novo)'
            DataBinding.FieldName = 'ITE_EXCIPI_NOV'
            Width = 102
          end
          object cxgItensViewCDCEST: TcxGridDBColumn
            Caption = 'C'#243'd. Classif. CEST'
            DataBinding.FieldName = 'ITE_CDCEST'
            Width = 111
          end
          object cxgItensViewCDCEST_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Classif. CEST(Novo)'
            DataBinding.FieldName = 'ITE_CDCEST_NOV'
            Width = 139
          end
          object cxgItensViewCODONU: TcxGridDBColumn
            Caption = 'C'#243'd. Classif. ONU'
            DataBinding.FieldName = 'ITE_CODONU'
            Width = 98
          end
          object cxgItensViewCODONU_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Classif. ONU(Novo)'
            DataBinding.FieldName = 'ITE_CODONU_NOV'
            Width = 125
          end
          object cxgItensViewIMPLIS: TcxGridDBColumn
            Caption = 'Imprime Lista'
            DataBinding.FieldName = 'ITE_IMPLIS'
            Width = 68
          end
          object cxgItensViewIMPLIS_NOV: TcxGridDBColumn
            Caption = 'Imprime Lista(Novo)'
            DataBinding.FieldName = 'ITE_IMPLIS_NOV'
            Width = 111
          end
          object cxgItensViewITEATI: TcxGridDBColumn
            Caption = 'Ativo'
            DataBinding.FieldName = 'ITE_ITEATI'
            Width = 32
          end
          object cxgItensViewITEATI_NOV: TcxGridDBColumn
            Caption = 'Ativo(Novo)'
            DataBinding.FieldName = 'ITE_ITEATI_NOV'
            Width = 63
          end
          object cxgItensViewATICOM: TcxGridDBColumn
            Caption = 'Ativo para Compra'
            DataBinding.FieldName = 'ITE_ATICOM'
            Width = 94
          end
          object cxgItensViewATICOM_NOV: TcxGridDBColumn
            Caption = 'Ativo para Compra(Novo)'
            DataBinding.FieldName = 'ITE_ATICOM_NOV'
            Width = 127
          end
          object cxgItensViewPESOIT: TcxGridDBColumn
            Caption = 'Peso Bruto'
            DataBinding.FieldName = 'ITE_PESOIT'
            Width = 111
          end
          object cxgItensViewPESOIT_NOV: TcxGridDBColumn
            Caption = 'Peso Bruto(Novo)'
            DataBinding.FieldName = 'ITE_PESOIT_NOV'
            Width = 111
          end
          object cxgItensViewPESLIQ: TcxGridDBColumn
            Caption = 'Peso L'#237'quido'
            DataBinding.FieldName = 'ITE_PESLIQ'
            Width = 111
          end
          object cxgItensViewPESLIQ_NOV: TcxGridDBColumn
            Caption = 'Peso L'#237'quido(Novo)'
            DataBinding.FieldName = 'ITE_PESLIQ_NOV'
            Width = 111
          end
          object cxgItensViewCODGPR: TcxGridDBColumn
            Caption = 'C'#243'd. Grupo Pre'#231'o'
            DataBinding.FieldName = 'ITE_CODGPR'
            Width = 92
          end
          object cxgItensViewCODGPR_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Grupo Pre'#231'o(Novo)'
            DataBinding.FieldName = 'ITE_CODGPR_NOV'
            Width = 124
          end
          object cxgItensViewPRDGRU: TcxGridDBColumn
            Caption = 'C'#243'd. Grupo de Produto'
            DataBinding.FieldName = 'ITE_PRDGRU'
            Width = 118
          end
          object cxgItensViewPRDGRU_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Grupo de Produto(Novo)'
            DataBinding.FieldName = 'ITE_PRDGRU_NOV'
            Width = 149
          end
          object cxgItensViewGRUCMP: TcxGridDBColumn
            Caption = 'C'#243'd. Grupo de Compra'
            DataBinding.FieldName = 'ITE_GRUCMP'
            Width = 120
          end
          object cxgItensViewGRUCMP_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Grupo de Compra(Novo)'
            DataBinding.FieldName = 'ITE_GRUCMP_NOV'
            Width = 149
          end
          object cxgItensViewMLTVEN: TcxGridDBColumn
            Caption = 'Multiplo de Venda'
            DataBinding.FieldName = 'ITE_MLTVEN'
            Width = 94
          end
          object cxgItensViewMLTVEN_NOV: TcxGridDBColumn
            Caption = 'Multiplo de Venda(Novo)'
            DataBinding.FieldName = 'ITE_MLTVEN_NOV'
            Width = 124
          end
          object cxgItensViewMLTCOM: TcxGridDBColumn
            Caption = 'Multiplo de Compra'
            DataBinding.FieldName = 'ITE_MLTCOM'
            Width = 95
          end
          object cxgItensViewMLTCOM_NOV: TcxGridDBColumn
            Caption = 'Multiplo de Compra(Novo)'
            DataBinding.FieldName = 'ITE_MLTCOM_NOV'
            Width = 127
          end
          object cxgItensViewNVLGIR: TcxGridDBColumn
            Caption = 'Nivel Giro Geral'
            DataBinding.FieldName = 'ITE_NVLGIR'
            Width = 82
          end
          object cxgItensViewNVLGIR_NOV: TcxGridDBColumn
            Caption = 'Nivel Giro Geral(Novo)'
            DataBinding.FieldName = 'ITE_NVLGIR_NOV'
            Width = 114
          end
          object cxgItensViewNIVGIR: TcxGridDBColumn
            Caption = 'Nivel Giro Por Empresa'
            DataBinding.FieldName = 'ITE_NIVGIR'
            Width = 119
          end
          object cxgItensViewNIVGIR_NOV: TcxGridDBColumn
            Caption = 'Nivel Giro Por Empresa(Novo)'
            DataBinding.FieldName = 'ITE_NIVGIR_NOV'
            Width = 150
          end
          object cxgItensViewACOOBJ: TcxGridDBColumn
            Caption = 'Acordo Objetivo'
            DataBinding.FieldName = 'ITE_ACOOBJ'
            Width = 83
          end
          object cxgItensViewACOOBJ_NOV: TcxGridDBColumn
            Caption = 'Acordo Objetivo(Novo)'
            DataBinding.FieldName = 'ITE_ACOOBJ_NOV'
            Width = 115
          end
          object cxgItensViewAPLICA: TcxGridDBColumn
            Caption = 'Aplica'#231#227'o'
            DataBinding.FieldName = 'ITE_APLICA'
            Width = 111
          end
          object cxgItensViewAPLICA_NOV: TcxGridDBColumn
            Caption = 'Aplica'#231#227'o(Novo)'
            DataBinding.FieldName = 'ITE_APLICA_NOV'
            Width = 111
          end
          object cxgItensViewPRECOM: TcxGridDBColumn
            Caption = 'Pre'#231'o de Compra'
            DataBinding.FieldName = 'ITE_PRECOM'
            Width = 94
          end
          object cxgItensViewPRECOM_NOV: TcxGridDBColumn
            Caption = 'Pre'#231'o de Compra(Novo)'
            DataBinding.FieldName = 'ITE_PRECOM_NOV'
            Width = 125
          end
          object cxgItensViewDESF01: TcxGridDBColumn
            Caption = 'Desc. Forn. 01'
            DataBinding.FieldName = 'ITE_DESF01'
            Width = 79
          end
          object cxgItensViewDESF01_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 01(Novo)'
            DataBinding.FieldName = 'ITE_DESF01_NOV'
            Width = 111
          end
          object cxgItensViewDESF02: TcxGridDBColumn
            Caption = 'Desc. Forn. 02'
            DataBinding.FieldName = 'ITE_DESF02'
            Width = 79
          end
          object cxgItensViewDESF02_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 02(Novo)'
            DataBinding.FieldName = 'ITE_DESF02_NOV'
            Width = 111
          end
          object cxgItensViewDESF03: TcxGridDBColumn
            Caption = 'Desc. Forn. 03'
            DataBinding.FieldName = 'ITE_DESF03'
            Width = 81
          end
          object cxgItensViewDESF03_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 03(Novo)'
            DataBinding.FieldName = 'ITE_DESF03_NOV'
            Width = 111
          end
          object cxgItensViewDESF04: TcxGridDBColumn
            Caption = 'Desc. Forn. 04'
            DataBinding.FieldName = 'ITE_DESF04'
            Width = 78
          end
          object cxgItensViewDESF04_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 04(Novo)'
            DataBinding.FieldName = 'ITE_DESF04_NOV'
            Width = 111
          end
          object cxgItensViewDESF05: TcxGridDBColumn
            Caption = 'Desc. Forn. 05'
            DataBinding.FieldName = 'ITE_DESF05'
            Width = 78
          end
          object cxgItensViewDESF05_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 05(Novo)'
            DataBinding.FieldName = 'ITE_DESF05_NOV'
            Width = 111
          end
          object cxgItensViewDESF06: TcxGridDBColumn
            Caption = 'Desc. Forn. 06'
            DataBinding.FieldName = 'ITE_DESF06'
            Width = 80
          end
          object cxgItensViewDESF06_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 06(Novo)'
            DataBinding.FieldName = 'ITE_DESF06_NOV'
            Width = 111
          end
          object cxgItensViewICMENT: TcxGridDBColumn
            Caption = 'ICMS de Entrada'
            DataBinding.FieldName = '%ITE_IMCENT'
            Width = 85
          end
          object cxgItensViewICMENT_NOV: TcxGridDBColumn
            Caption = 'ICMS de Entrada(Novo)'
            DataBinding.FieldName = 'ITE_ICMENT_NOV'
            Width = 116
          end
          object cxgItensViewSUBFED: TcxGridDBColumn
            Caption = '%Impostos Federais(-)'
            DataBinding.FieldName = 'ITE_SUBFED'
            Width = 116
          end
          object cxgItensViewSUBFED_NOV: TcxGridDBColumn
            Caption = '%Impostos Federais(-)(Novo)'
            DataBinding.FieldName = 'ITE_SUBFED_NOV'
            Width = 148
          end
          object cxgItensViewIPIENT: TcxGridDBColumn
            Caption = '%IPI Entrada'
            DataBinding.FieldName = 'ITE_IPIENT'
            Width = 67
          end
          object cxgItensViewIPIENT_NOV: TcxGridDBColumn
            Caption = '%IPI Entrada(Novo)'
            DataBinding.FieldName = 'ITE_IPIENT_NOV'
            Width = 100
          end
          object cxgItensViewFREENT: TcxGridDBColumn
            Caption = '% Frete'
            DataBinding.FieldName = 'ITE_FREENT'
            Width = 48
          end
          object cxgItensViewFREENT_NOV: TcxGridDBColumn
            Caption = '% Frete(Novo)'
            DataBinding.FieldName = 'ITE_FREENT_NOV'
            Width = 78
          end
          object cxgItensViewVALFRE: TcxGridDBColumn
            Caption = 'Valor Frete'
            DataBinding.FieldName = 'ITE_VALFRE'
            Width = 79
          end
          object cxgItensViewVALFRE_NOV: TcxGridDBColumn
            Caption = 'Valor Frete(Novo)'
            DataBinding.FieldName = 'ITE_VALFRE_NOV'
            Width = 95
          end
          object cxgItensViewACRFIN: TcxGridDBColumn
            Caption = 'Acr'#233'cimo Financeiro'
            DataBinding.FieldName = 'ITE_ACRFIN'
            Width = 107
          end
          object cxgItensViewACRFIN_NOV: TcxGridDBColumn
            Caption = 'Acr'#233'cimo Financeiro(Novo)'
            DataBinding.FieldName = 'ITE_ACRFIN_NOV'
            Width = 142
          end
          object cxgItensViewSUBSTI: TcxGridDBColumn
            Caption = 'Sub. Tributaria'
            DataBinding.FieldName = 'ITE_SUBSTI'
            Width = 84
          end
          object cxgItensViewSUBSTI_NOV: TcxGridDBColumn
            Caption = 'Sub. Tributaria(Novo)'
            DataBinding.FieldName = 'ITE_SUBSTI_NOV'
            Width = 111
          end
          object cxgItensViewDESADB: TcxGridDBColumn
            Caption = 'Descontos Adicionais'
            DataBinding.FieldName = 'ITE_DESADB'
            Width = 111
          end
          object cxgItensViewDESADB_NOV: TcxGridDBColumn
            Caption = 'Descontos Adicionais(Novo)'
            DataBinding.FieldName = 'ITE_DESADB_NOV'
            Width = 142
          end
          object cxgItensViewTCIFCU: TcxGridDBColumn
            Caption = 'TCIF'
            DataBinding.FieldName = 'ITE_TCIFCU'
            Visible = False
            Width = 90
          end
          object cxgItensViewTCIFCU_NOV: TcxGridDBColumn
            Caption = 'TCIF(Novo)'
            DataBinding.FieldName = 'ITE_TCIFCU_NOV'
            Visible = False
            Width = 90
          end
          object cxgItensViewTSCUST: TcxGridDBColumn
            Caption = 'TS'
            DataBinding.FieldName = 'ITE_TSCUST'
            Visible = False
            Width = 90
          end
          object cxgItensViewTSCUST_NOV: TcxGridDBColumn
            Caption = 'TS(Novo)'
            DataBinding.FieldName = 'ITE_TSCUST_NOV'
            Visible = False
            Width = 90
          end
          object cxgItensView_DEPICO: TcxGridDBColumn
            Caption = 'Desconto PIS/COFINS'
            DataBinding.FieldName = 'ITE_DEPICO'
            Visible = False
            Width = 120
          end
          object cxgItensViewDEPICO_NOV: TcxGridDBColumn
            Caption = 'Desconto PIS/COFINS(Novo)'
            DataBinding.FieldName = 'ITE_DEPICO_NOV'
            Visible = False
            Width = 150
          end
          object cxgItensViewDEICMS: TcxGridDBColumn
            Caption = 'Desconto de ICMS'
            DataBinding.FieldName = 'ITE_DEICMS'
            Visible = False
            Width = 110
          end
          object cxgItensViewDEICMS_NOV: TcxGridDBColumn
            Caption = 'Desconto de ICMS(Novo)'
            DataBinding.FieldName = 'ITE_DEICMS_NOV'
            Visible = False
            Width = 130
          end
          object cxgItensViewFATREG: TcxGridDBColumn
            Caption = 'Fator Regional'
            DataBinding.FieldName = 'ITE_FATREG'
            Visible = False
            Width = 90
          end
          object cxgItensViewFATREG_NOV: TcxGridDBColumn
            Caption = 'Fator Regional(Novo)'
            DataBinding.FieldName = 'ITE_FATREG_NOV'
            Visible = False
            Width = 110
          end
          object cxgItensViewOUTVAL: TcxGridDBColumn
            Caption = 'Outros Valores'
            DataBinding.FieldName = 'ITE_OUTVAL'
            Width = 83
          end
          object cxgItensViewOUTVAL_NOV: TcxGridDBColumn
            Caption = 'Outros Valores(Novo)'
            DataBinding.FieldName = 'ITE_OUTVAL_NOV'
            Width = 111
          end
          object cxgItensViewICMSAI: TcxGridDBColumn
            Caption = '%ICMS Sa'#237'da'
            DataBinding.FieldName = 'ITE_ICMSAI'
            Width = 75
          end
          object cxgItensViewICMSAI_NOV: TcxGridDBColumn
            Caption = '%ICMS Sa'#237'da(Novo)'
            DataBinding.FieldName = 'ITE_ICMSAI_NOV'
            Width = 104
          end
          object cxgItensViewIMPFED: TcxGridDBColumn
            Caption = '%Impostos Federais(+)'
            DataBinding.FieldName = 'ITE_IMPFED'
            Width = 118
          end
          object cxgItensViewIMPFED_NOV: TcxGridDBColumn
            Caption = '%Impostos Federais(+)(Novo)'
            DataBinding.FieldName = 'ITE_IMPFED_NOV'
            Width = 154
          end
          object cxgItensViewDESOPE: TcxGridDBColumn
            Caption = 'Despesas Operacionais'
            DataBinding.FieldName = 'ITE_DESOPE'
            Width = 125
          end
          object cxgItensViewDESOPE_NOV: TcxGridDBColumn
            Caption = 'Despesas Operacionais(Novo)'
            DataBinding.FieldName = 'ITE_DESOPE_NOV'
            Width = 153
          end
          object cxgItensViewMARBR1: TcxGridDBColumn
            Caption = 'Margem Bruta 1'
            DataBinding.FieldName = 'ITE_MARBR1'
            Width = 82
          end
          object cxgItensViewMARBR1_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 1(Novo)'
            DataBinding.FieldName = 'ITE_MARBR1_NOV'
            Width = 116
          end
          object cxgItensViewCOMTB1: TcxGridDBColumn
            Caption = '%Comiss'#227'o 1'
            DataBinding.FieldName = 'ITE_COMTB1'
            Width = 76
          end
          object cxgItensViewCOMTB1_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 1(Novo)'
            DataBinding.FieldName = 'ITE_COMTB1_NOV'
            Width = 111
          end
          object cxgItensViewPREVE1: TcxGridDBColumn
            Caption = 'Preco Venda 1'
            DataBinding.FieldName = 'ITE_PREVE1'
            Width = 80
          end
          object cxgItensViewPREVE1_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 1(Novo)'
            DataBinding.FieldName = 'ITE_PREVE1_NOV'
            Width = 111
          end
          object cxgItensViewMARBR2: TcxGridDBColumn
            Caption = 'Margem Bruta 2'
            DataBinding.FieldName = 'ITE_MARBR2'
            Width = 82
          end
          object cxgItensViewMARBR2_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 2(Novo)'
            DataBinding.FieldName = 'ITE_MARBR2_NOV'
            Width = 116
          end
          object cxgItensViewCOMTB2: TcxGridDBColumn
            Caption = '%Comiss'#227'o 2'
            DataBinding.FieldName = 'ITE_COMTB2'
            Width = 74
          end
          object cxgItensViewCOMTB2_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 2(Novo)'
            DataBinding.FieldName = 'ITE_COMTB2_NOV'
            Width = 111
          end
          object cxgItensViewPREVE2: TcxGridDBColumn
            Caption = 'Preco Venda 2'
            DataBinding.FieldName = 'ITE_PREVE2'
            Width = 81
          end
          object cxgItensViewPREVE2_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 2(Novo)'
            DataBinding.FieldName = 'ITE_PREVE2_NOV'
            Width = 111
          end
          object cxgItensViewMARBR3: TcxGridDBColumn
            Caption = 'Margem Bruta 3'
            DataBinding.FieldName = 'ITE_MARBR3'
            Width = 83
          end
          object cxgItensViewMARBR3_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 3(Novo)'
            DataBinding.FieldName = 'ITE_MARBR3_NOV'
            Width = 114
          end
          object cxgItensViewCOMTB3: TcxGridDBColumn
            Caption = '%Comiss'#227'o 3'
            DataBinding.FieldName = 'ITE_COMTB3'
            Width = 74
          end
          object cxgItensViewCOMTB3_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 3(Novo)'
            DataBinding.FieldName = 'ITE_COMTB3_NOV'
            Width = 104
          end
          object cxgItensViewPREVE3: TcxGridDBColumn
            Caption = 'Preco Venda 3'
            DataBinding.FieldName = 'ITE_PREVE3'
            Width = 79
          end
          object cxgItensViewPREVE3_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 3(Novo)'
            DataBinding.FieldName = 'ITE_PREVE3_NOV'
            Width = 111
          end
          object cxgItensViewMARBR4: TcxGridDBColumn
            Caption = 'Margem Bruta 4'
            DataBinding.FieldName = 'ITE_MARBR4'
            Width = 84
          end
          object cxgItensViewMARBR4_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 4(Novo)'
            DataBinding.FieldName = 'ITE_MARBR4_NOV'
            Width = 114
          end
          object cxgItensViewCOMTB4: TcxGridDBColumn
            Caption = '%Comiss'#227'o 4'
            DataBinding.FieldName = 'ITE_COMTB4'
            Width = 76
          end
          object cxgItensViewCOMTB4_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 4(Novo)'
            DataBinding.FieldName = 'ITE_COMTB4_NOV'
            Width = 111
          end
          object cxgItensViewPREVE4: TcxGridDBColumn
            Caption = 'Preco Venda 4'
            DataBinding.FieldName = 'ITE_PREVE4'
            Width = 78
          end
          object cxgItensViewPREVE4_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 4(Novo)'
            DataBinding.FieldName = 'ITE_PREVE4_NOV'
            Width = 111
          end
          object cxgItensViewMARBR5: TcxGridDBColumn
            Caption = 'Margem Bruta 5'
            DataBinding.FieldName = 'ITE_MARBR5'
            Width = 82
          end
          object cxgItensViewMARBR5_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 5(Novo)'
            DataBinding.FieldName = 'ITE_MARBR5_NOV'
            Width = 114
          end
          object cxgItensViewCOMTB5: TcxGridDBColumn
            Caption = '%Comis'#227'o 5'
            DataBinding.FieldName = 'ITE_COMTB5'
            Width = 74
          end
          object cxgItensViewCOMTB5_NOV: TcxGridDBColumn
            Caption = '%Comis'#227'o 5(Novo)'
            DataBinding.FieldName = 'ITE_COMTB5_NOV'
            Width = 111
          end
          object cxgItensViewPREVE5: TcxGridDBColumn
            Caption = 'Preco Venda 5'
            DataBinding.FieldName = 'ITE_PREVE5'
            Width = 80
          end
          object cxgItensViewPREVE5_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 5(Novo)'
            DataBinding.FieldName = 'ITE_PREVE5_NOV'
            Width = 111
          end
          object cxgItensViewMARBR6: TcxGridDBColumn
            Caption = 'Margem Bruta 6'
            DataBinding.FieldName = 'ITE_MARBR6'
            Width = 84
          end
          object cxgItensViewMARBR6_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 6(Novo)'
            DataBinding.FieldName = 'ITE_MARBR6_NOV'
            Width = 118
          end
          object cxgItensViewCOMTB6: TcxGridDBColumn
            Caption = '%Comiss'#227'o 6'
            DataBinding.FieldName = 'ITE_COMTB6'
            Width = 79
          end
          object cxgItensViewCOMTB6_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 6(Novo)'
            DataBinding.FieldName = 'ITE_COMTB6_NOV'
            Width = 111
          end
          object cxgItensViewPREVE6: TcxGridDBColumn
            Caption = 'Preco Venda 6'
            DataBinding.FieldName = 'ITE_PREVE6'
            Width = 81
          end
          object cxgItensViewPREVE6_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 6(Novo)'
            DataBinding.FieldName = 'ITE_PREVE6_NOV'
            Width = 111
          end
          object cxgItensViewMARBR7: TcxGridDBColumn
            Caption = 'Margem Bruta 7'
            DataBinding.FieldName = 'ITE_MARBR7'
            Width = 83
          end
          object cxgItensViewMARBR7_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 7(Novo)'
            DataBinding.FieldName = 'ITE_MARBR7_NOV'
            Width = 114
          end
          object cxgItensViewCOMTB7: TcxGridDBColumn
            Caption = '%Comiss'#227'o 7'
            DataBinding.FieldName = 'ITE_COMTB7'
            Width = 77
          end
          object cxgItensViewCOMTB7_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 7(Novo)'
            DataBinding.FieldName = 'ITE_COMTB7_NOV'
            Width = 111
          end
          object cxgItensViewPREVE7: TcxGridDBColumn
            Caption = 'Preco Venda 7'
            DataBinding.FieldName = 'ITE_PREVE7'
            Width = 80
          end
          object cxgItensViewPREVE7_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 7(Novo)'
            DataBinding.FieldName = 'ITE_PREVE7_NOV'
            Width = 111
          end
          object cxgItensViewCOMVAR: TcxGridDBColumn
            Caption = '% Comiss'#227'o Vendedor Interno Loja'
            DataBinding.FieldName = 'ITE_COMVAR'
            Width = 179
          end
          object cxgItensViewCOMVAR_NOV: TcxGridDBColumn
            Caption = '% Comiss'#227'o Vendedor Interno Loja(Novo)'
            DataBinding.FieldName = 'ITE_COMVAR_NOV'
            Width = 211
          end
          object cxgItensViewCOMATA: TcxGridDBColumn
            Caption = '% Comiss'#227'o Vendedor Externo Loja'
            DataBinding.FieldName = 'ITE_COMATA'
            Width = 185
          end
          object cxgItensViewCOMATA_NOV: TcxGridDBColumn
            Caption = '% Comiss'#227'o Vendedor Externo Loja(Novo)'
            DataBinding.FieldName = 'ITE_COMATA_NOV'
            Width = 214
          end
          object cxgItensViewCOMDIS: TcxGridDBColumn
            Caption = 'Comiss'#227'o Vendedor Externo Distribuidor'
            DataBinding.FieldName = 'ITE_CODDIS'
            Width = 205
          end
          object cxgItensViewCOMDIS_NOV: TcxGridDBColumn
            Caption = 'Comiss'#227'o Vendedor Externo Distribuidor(Novo)'
            DataBinding.FieldName = 'ITE_CODDIS_NOV'
            Width = 235
          end
          object cxgItensViewCOMPRO: TcxGridDBColumn
            Caption = 'Comiss'#227'o Profissional'
            DataBinding.FieldName = 'ITE_COMPRO'
            Width = 117
          end
          object cxgItensViewCOMPRO_NOV: TcxGridDBColumn
            Caption = 'Comiss'#227'o Profissional(Novo)'
            DataBinding.FieldName = 'ITE_COMPRO_NOV'
            Width = 146
          end
          object cxgItensViewDESMAX: TcxGridDBColumn
            Caption = '% Desconto M'#225'ximo Vendedor'
            DataBinding.FieldName = 'ITE_DESMAX'
            Width = 158
          end
          object cxgItensViewDESMAX_NOV: TcxGridDBColumn
            Caption = '% Desconto M'#225'ximo Vendedor(Novo)'
            DataBinding.FieldName = 'ITE_DESMAX_NOV'
            Width = 188
          end
          object cxgItensViewDESMSU: TcxGridDBColumn
            Caption = '% Desconto M'#225'ximo Sub-gerente'
            DataBinding.FieldName = 'ITE_DESMSU'
            Width = 166
          end
          object cxgItensViewDESMSU_NOV: TcxGridDBColumn
            Caption = '% Desconto M'#225'ximo Sub-gerente(Novo)'
            DataBinding.FieldName = 'ITE_DESMSU_NOV'
            Width = 199
          end
          object cxgItensViewDESMGE: TcxGridDBColumn
            Caption = '% Desconto M'#225'ximo Gerente'
            DataBinding.FieldName = 'ITE_DESMGE'
            Width = 149
          end
          object cxgItensViewDESMGE_NOV: TcxGridDBColumn
            Caption = '% Desconto M'#225'ximo Gerente(Novo)'
            DataBinding.FieldName = 'ITE_DESMGE_NOV'
            Width = 181
          end
          object cxgItensViewMARMIN: TcxGridDBColumn
            Caption = '% Margem M'#237'nima Vendedor'
            DataBinding.FieldName = 'ITE_MARMIN'
            Width = 144
          end
          object cxgItensViewMARMIN_NOV: TcxGridDBColumn
            Caption = '% Margem M'#237'nima Vendedor(Novo)'
            DataBinding.FieldName = 'ITE_MARMIN_NOV'
            Width = 141
          end
          object cxgItensViewMARMSG: TcxGridDBColumn
            Caption = '% Margem M'#237'nima Sub-gerente'
            DataBinding.FieldName = 'ITE_MARMSG'
            Width = 156
          end
          object cxgItensViewMARMSG_NOV: TcxGridDBColumn
            Caption = '% Margem M'#237'nima Sub-gerente(Novo)'
            DataBinding.FieldName = 'ITE_MARMSG_NOV'
            Width = 190
          end
          object cxgItensViewMARMGE: TcxGridDBColumn
            Caption = '% Margem M'#237'nima Gerente'
            DataBinding.FieldName = 'ITE_MARMGE'
            Width = 139
          end
          object cxgItensViewMARMGE_NOV: TcxGridDBColumn
            Caption = '% Margem M'#237'nima Gerente(Novo)'
            DataBinding.FieldName = 'ITE_MARMGE_NOV'
            Width = 171
          end
          object cxgItensViewTMPGAR: TcxGridDBColumn
            Caption = 'Tempo de Garantia(Meses)'
            DataBinding.FieldName = 'ITE_TMPGAR'
            Width = 141
          end
          object cxgItensViewTMPGAR_NOV: TcxGridDBColumn
            Caption = 'Tempo de Garantia(Meses)(Novo)'
            DataBinding.FieldName = 'ITE_TMPGAR_NOV'
            Width = 171
          end
          object cxgItensViewINFGAR: TcxGridDBColumn
            Caption = 'Informa'#231#245'es da Garantia'
            DataBinding.FieldName = 'ITE_INFGAR'
            Width = 129
          end
          object cxgItensViewINFGAR_NOV: TcxGridDBColumn
            Caption = 'Informa'#231#245'es da Garantia(Novo)'
            DataBinding.FieldName = 'ITE_INFGAR_NOV'
            Width = 158
          end
          object cxgItensViewLOCFIS: TcxGridDBColumn
            Caption = 'Localiza'#231#227'o Fisica'
            DataBinding.FieldName = 'ITE_LOCFIS'
            Width = 114
          end
          object cxgItensViewLOCFIS_NOV: TcxGridDBColumn
            Caption = 'Localiza'#231#227'o Fisica(Novo)'
            DataBinding.FieldName = 'ITE_LOCFIS_NOV'
            Width = 130
          end
          object cxgItensViewLOCSUP: TcxGridDBColumn
            Caption = 'Localiza'#231#227'o Super Estoque'
            DataBinding.FieldName = 'ITE_LOCSUP'
            Width = 143
          end
          object cxgItensViewLOCSUP_NOV: TcxGridDBColumn
            Caption = 'Localiza'#231#227'o Super Estoque(Novo)'
            DataBinding.FieldName = 'ITE_LOCSUP_NOV'
            Width = 170
          end
          object cxgItensViewCODLSE: TcxGridDBColumn
            Caption = 'Local Separa'#231#227'o'
            DataBinding.FieldName = 'ITE_CODLSE'
            Width = 114
          end
          object cxgItensViewCODLSE_NOV: TcxGridDBColumn
            Caption = 'Local Separa'#231#227'o(Novo)'
            DataBinding.FieldName = 'ITE_CODLSE_NOV'
            Width = 130
          end
          object cxgItensViewITEBAS: TcxGridDBColumn
            Caption = 'Base'
            DataBinding.FieldName = 'ITE_ITEBAS'
            Width = 38
          end
          object cxgItensViewITEBAS_NOV: TcxGridDBColumn
            Caption = 'Base(Novo)'
            DataBinding.FieldName = 'ITE_ITEBAS_NOV'
            Width = 64
          end
          object cxgItensViewITEPIG: TcxGridDBColumn
            Caption = 'Pigmento'
            DataBinding.FieldName = 'ITE_ITEPIG'
            Width = 52
          end
          object cxgItensViewITEPIG_NOV: TcxGridDBColumn
            Caption = 'Pigmento(Novo)'
            DataBinding.FieldName = 'ITE_ITEPIG_NOV'
            Width = 83
          end
          object cxgItensViewBAREXP: TcxGridDBColumn
            Caption = 'Cod. Barr. Exped.'
            DataBinding.FieldName = 'ITE_BAREXP'
            Width = 97
          end
          object cxgItensViewBAREXP_NOV: TcxGridDBColumn
            Caption = 'Cod. Barr. Exped.(Novo)'
            DataBinding.FieldName = 'ITE_BAREXP_NOV'
            Width = 126
          end
          object cxgItensViewCPRCEN: TcxGridDBColumn
            Caption = 'Compr. Central.'
            DataBinding.FieldName = 'ITE_CPRCEN'
            Width = 77
          end
          object cxgItensViewCPRCEN_NOV: TcxGridDBColumn
            Caption = 'Compr. Central.(Novo)'
            DataBinding.FieldName = 'ITE_CPRCEN_NOV'
            Width = 113
          end
          object cxgItensViewCODMON: TcxGridDBColumn
            Caption = 'Montadoras'
            DataBinding.FieldName = 'ITE_CODMON'
            Width = 170
          end
          object cxgItensViewCODMON_NOV: TcxGridDBColumn
            Caption = 'Montadoras(Novo)'
            DataBinding.FieldName = 'ITE_CODMON_NOV'
            Width = 170
          end
          object cxgItensViewDIAFOR: TcxGridDBColumn
            Caption = 'Dias Entrega Fornec'
            DataBinding.FieldName = 'ITE_DIAFOR'
            Width = 111
          end
          object cxgItensViewDIAFOR_NOV: TcxGridDBColumn
            Caption = 'Dias Entrega Fornec.(Novo)'
            DataBinding.FieldName = 'ITE_DIAFOR_NOV'
            Width = 111
          end
          object cxgItensViewEXPSIT: TcxGridDBColumn
            Caption = 'Exporta'#231#227'o para E-Commerce'
            DataBinding.FieldName = 'ITE_EXPSIT'
            Width = 150
          end
          object cxgItensViewEXPSIT_NOV: TcxGridDBColumn
            Caption = 'Exporta'#231#227'o para E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_EXPSIT_NOV'
            Width = 185
          end
          object cxgItensViewDSSITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Produto E-Commerce'
            DataBinding.FieldName = 'ITE_DESITE_SITE'
            Width = 180
          end
          object cxgItensViewDSSITE_NOV: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Produto E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_DESITE_SITE_NOV'
            Width = 210
          end
          object cxgItensViewDADTEC: TcxGridDBColumn
            Caption = 'Dados T'#233'cnicos E-Commerce'
            DataBinding.FieldName = 'ITE_DADTEC'
            Width = 150
          end
          object cxgItensViewDADTEC_NOV: TcxGridDBColumn
            Caption = 'Dados T'#233'cnicos E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_DADTEC_NOV'
            Width = 185
          end
          object cxgItensViewURLIMG: TcxGridDBColumn
            Caption = 'URL da imagem E-Commerce'
            DataBinding.FieldName = 'ITE_URLIMG'
            Width = 255
          end
          object cxgItensViewURLIMG_NOV: TcxGridDBColumn
            Caption = 'URL da imagem E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_URLIMG_NOV'
            Width = 255
          end
          object cxgItensViewNOMITE: TcxGridDBColumn
            Caption = 'Nome do Produto E-Commerce'
            DataBinding.FieldName = 'ITE_NOMITE'
            Width = 255
          end
          object cxgItensViewNOMITE_NOV: TcxGridDBColumn
            Caption = 'Nome do Produto E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_NOMITE_NOV'
            Width = 255
          end
          object cxgItensViewAPLITE: TcxGridDBColumn
            Caption = 'Aplica'#231#227'o E-Commerce'
            DataBinding.FieldName = 'ITE_APLITE'
            Width = 255
          end
          object cxgItensViewAPLITE_NOV: TcxGridDBColumn
            Caption = 'Aplica'#231#227'o E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_APLITE_NOV'
            Width = 255
          end
          object cxgItensViewINCLUS: TcxGridDBColumn
            Caption = 'Itens Inclusos E-Commerce'
            DataBinding.FieldName = 'ITE_INCLUS'
            Width = 255
          end
          object cxgItensViewINCLUS_NOV: TcxGridDBColumn
            Caption = 'Itens Inclusos E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_INCLUS_NOV'
            Width = 255
          end
          object cxgItensViewEXPALT: TcxGridDBColumn
            Caption = 'Altura E-Commerce'
            DataBinding.FieldName = 'ITE_EXPALT'
            Width = 100
          end
          object cxgItensViewEXPALT_NOV: TcxGridDBColumn
            Caption = 'Altura E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_EXPALT_NOV'
            Width = 135
          end
          object cxgItensViewEXPLAR: TcxGridDBColumn
            Caption = 'Largura E-Commerce'
            DataBinding.FieldName = 'ITE_EXPLAR'
            Width = 110
          end
          object cxgItensViewEXPLAR_NOV: TcxGridDBColumn
            Caption = 'Largura E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_EXPLAR_NOV'
            Width = 145
          end
          object cxgItensViewEXPPRO: TcxGridDBColumn
            Caption = 'Profundidade E-Commerce'
            DataBinding.FieldName = 'ITE_EXPPRO'
            Width = 135
          end
          object cxgItensViewEXPPRO_NOV: TcxGridDBColumn
            Caption = 'Profundidade E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_EXPPRO_NOV'
            Width = 170
          end
          object cxgItensViewDESSIT: TcxGridDBColumn
            Caption = 'Desconto para Site E-Commerce'
            DataBinding.FieldName = 'ITE_DESSIT'
            Width = 165
          end
          object cxgItensViewDESSIT_NOV: TcxGridDBColumn
            Caption = 'Desconto para Site E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_DESSIT_NOV'
            Width = 200
          end
          object cxgItensViewCODCAT: TcxGridDBColumn
            Caption = 'Categorias E-Commerce'
            DataBinding.FieldName = 'ITE_CODCAT'
            Width = 130
          end
          object cxgItensViewCODCAT_NOV: TcxGridDBColumn
            Caption = 'Categorias E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_CODCAT_NOV'
            Width = 160
          end
          object cxgItensViewDESTAQ: TcxGridDBColumn
            Caption = 'Destaque E-Commerce'
            DataBinding.FieldName = 'ITE_DESTAQ'
            Width = 120
          end
          object cxgItensViewDESTAQ_NOV: TcxGridDBColumn
            Caption = 'Destaque E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_DESTAQ_NOV'
            Width = 150
          end
          object cxgItensViewATZPRE: TcxGridDBColumn
            Caption = 'Atualiza pre'#231'os no site? E-Commerce'
            DataBinding.FieldName = 'ITE_ATZPRE'
            Width = 190
          end
          object cxgItensViewATZPRE_NOV: TcxGridDBColumn
            Caption = 'Atualiza pre'#231'os no site?E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_ATZPRE_NOV'
            Width = 220
          end
          object cxgItensViewEXPAPP: TcxGridDBColumn
            Caption = 'Exporta'#231#227'o APP Venda Assistida E-Commerce'
            DataBinding.FieldName = 'ITE_EXPAPP'
            Width = 230
          end
          object cxgItensViewEXPAPP_NOV: TcxGridDBColumn
            Caption = 'Exporta'#231#227'o APP Venda Assistida E-Commerce(Novo)'
            DataBinding.FieldName = 'ITE_EXPAPP_NOV'
            Width = 265
          end
          object cxgItensViewLIS_CODFOR: TcxGridDBColumn
            Caption = 'Lista Fornecedores'
            DataBinding.FieldName = 'LIS_CODFOR'
            Width = 200
          end
          object cxgItensViewLIS_CODFAB: TcxGridDBColumn
            Caption = 'Lista C'#243'd. F'#225'brica'
            DataBinding.FieldName = 'LIS_CODFAB'
            Width = 200
          end
          object cxgItensViewLIS_CODCNA: TcxGridDBColumn
            Caption = 'Lista C'#243'd. CNA'
            DataBinding.FieldName = 'LIS_CODCNA'
            Width = 200
          end
          object cxgItensViewESTMIN: TcxGridDBColumn
            Caption = 'Estoque M'#237'nimo'
            DataBinding.FieldName = 'ITE_ESTMIN'
            Width = 93
          end
          object cxgItensViewESTMIN_NOV: TcxGridDBColumn
            Caption = 'Estoque M'#237'nimo(Novo)'
            DataBinding.FieldName = 'ITE_ESTMIN_NOV'
            Width = 122
          end
          object cxgItensViewESTMAX: TcxGridDBColumn
            Caption = 'Estoque M'#225'ximo'
            DataBinding.FieldName = 'ITE_ESTMAX'
            Width = 92
          end
          object cxgItensViewESTMAX_NOV: TcxGridDBColumn
            Caption = 'Estoque M'#225'ximo(Novo)'
            DataBinding.FieldName = 'ITE_ESTMAX_NOV'
            Width = 116
          end
          object cxgItensViewUNITRI: TcxGridDBColumn
            Caption = 'Uni. Trib.'
            DataBinding.FieldName = 'ITE_UNITRI'
            Width = 92
          end
          object cxgItensViewUNITRI_NOV: TcxGridDBColumn
            Caption = 'Uni. Trib.(Novo)'
            DataBinding.FieldName = 'ITE_UNITRI_NOV'
            Width = 116
          end
          object cxgItensViewEXPPOK: TcxGridDBColumn
            Caption = 'Exporta Tablet'
            DataBinding.FieldName = 'ITE_EXPPOK'
            Width = 92
          end
          object cxgItensViewEXPPOK_NOV: TcxGridDBColumn
            Caption = 'Exporta Tablet(Novo)'
            DataBinding.FieldName = 'ITE_EXPPOK_NOV'
            Width = 116
          end
          object cxgItensViewTIPPRO: TcxGridDBColumn
            Caption = 'Tipo de Produto(SPED)'
            DataBinding.FieldName = 'ITE_TIPPRO'
            Width = 110
          end
          object cxgItensViewTIPPRO_NOV: TcxGridDBColumn
            Caption = 'Tipo de Produto(SPED)(Novo)'
            DataBinding.FieldName = 'ITE_TIPPRO_NOV'
            Width = 150
          end
          object cxgItensViewINDREV: TcxGridDBColumn
            Caption = 'Industrializa'#231#227'o ou Revenda'
            DataBinding.FieldName = 'ITE_INDREV'
            Width = 150
          end
          object cxgItensViewINDREV_NOV: TcxGridDBColumn
            Caption = 'Industrializa'#231#227'o ou Revenda(Novo)'
            DataBinding.FieldName = 'ITE_INDREV_NOV'
            Width = 170
          end
          object cxgItensViewIMPDIR: TcxGridDBColumn
            Caption = 'Importa'#231#227'o Direta'
            DataBinding.FieldName = 'ITE_IMPDIR'
            Width = 100
          end
          object cxgItensViewIMPDIR_NOV: TcxGridDBColumn
            Caption = 'Importa'#231#227'o Direta(Novo)'
            DataBinding.FieldName = 'ITE_IMPDIR_NOV'
            Width = 126
          end
          object cxgItensViewMSGLV1: TcxGridDBColumn
            Caption = 'Mensagem Livre 1'
            DataBinding.FieldName = 'ITE_MSGLV1'
          end
          object cxgItensViewMSGLV1_NOV: TcxGridDBColumn
            Caption = 'Mensagem Livre 1(Novo)'
            DataBinding.FieldName = 'ITE_MSGLV1_NOV'
          end
          object cxgItensViewMSGLV2: TcxGridDBColumn
            Caption = 'Mensagem Livre 2'
            DataBinding.FieldName = 'ITE_MSGLV2'
          end
          object cxgItensViewMSGLV2_NOV: TcxGridDBColumn
            Caption = 'Mensagem Livre 2(Novo)'
            DataBinding.FieldName = 'ITE_MSGLV2_NOV'
          end
          object cxgItensViewPEEFUT: TcxGridDBColumn
            Caption = 'Permitir Entrega Futura com Status "Aguardando o Cliente"'
            DataBinding.FieldName = 'ITE_PEEFUT'
            Width = 300
          end
          object cxgItensViewPEEFUT_NOV: TcxGridDBColumn
            Caption = 'Permitir Entrega Futura com Status "Aguardando o Cliente"(Novo)'
            DataBinding.FieldName = 'ITE_PEEFUT_NOV'
            Width = 334
          end
          object cxgItensViewPEFUTP: TcxGridDBColumn
            Caption = #39'Permitir Entrega Futura com Status "Previs'#227'o de Entrega"'#39
            DataBinding.FieldName = 'ITE_PEFUTP'
            Width = 295
          end
          object cxgItensViewPEFUTP_NOV: TcxGridDBColumn
            Caption = #39'Permitir Entrega Futura com Status "Previs'#227'o de Entrega"'#39'(Novo)'
            DataBinding.FieldName = 'ITE_PEFUTP_NOV'
            Width = 325
          end
          object cxgItensViewPEFFPR: TcxGridDBColumn
            Caption = #39'Permitir Entrega Futura com Status "Falta de Produto"'#39
            DataBinding.FieldName = 'ITE_PEFFPR'
            Width = 276
          end
          object cxgItensViewPEFFPR_NOV: TcxGridDBColumn
            Caption = #39'Permitir Entrega Futura com Status "Falta de Produto"'#39'(Novo)'
            DataBinding.FieldName = 'ITE_PEFFPR_NOV'
            Width = 310
          end
          object cxgItensViewLIS_ESMIDG: TcxGridDBColumn
            Caption = 'Lista Op'#231#227'o Estoque Minimo'
            DataBinding.FieldName = 'LIS_ESMIDG'
            Width = 160
          end
          object cxgItensViewLIS_ESTMIN: TcxGridDBColumn
            Caption = 'Lista Estoque M'#237'nimo'
            DataBinding.FieldName = 'LIS_ESTMIN'
            Width = 160
          end
          object cxgItensViewLIS_ESTMAX: TcxGridDBColumn
            Caption = 'Lista Estoque M'#225'ximo'
            DataBinding.FieldName = 'LIS_ESTMAX'
            Width = 160
          end
          object cxgItensViewLIS_SITPRO: TcxGridDBColumn
            Caption = 'Lista Situa'#231#227'o do Produto'
            DataBinding.FieldName = 'LIS_SITPRO'
            Width = 160
          end
          object cxgItensViewDESSIM: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Simplificada'
            DataBinding.FieldName = 'ITE_DESSIM'
            Width = 115
          end
          object cxgItensViewDESSIM_NOV: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Simplificada (Novo)'
            DataBinding.FieldName = 'ITE_DESSIM_NOV'
            Width = 151
          end
          object cxgItensViewTIPFRE: TcxGridDBColumn
            Caption = 'Tipo de Frete'
            DataBinding.FieldName = 'ITE_TIPFRE'
            Width = 69
          end
          object cxgItensViewTIPFRE_NOV: TcxGridDBColumn
            Caption = 'Tipo de Frete (Novo)'
            DataBinding.FieldName = 'ITE_TIPFRE_NOV'
            Width = 105
          end
          object cxgItensViewVLCFRE: TcxGridDBColumn
            Caption = 'Valor do Frete'
            DataBinding.FieldName = 'ITE_VLCFRE'
            Width = 74
          end
          object cxgItensViewVLCFRE_NOV: TcxGridDBColumn
            Caption = 'Valor do Frete (Novo)'
            DataBinding.FieldName = 'ITE_VLCFRE_NOV'
            Width = 110
          end
          object cxgItensViewQRCODE: TcxGridDBColumn
            Caption = 'Qrcode'
            DataBinding.FieldName = 'ITE_QRCODE'
            Width = 300
          end
          object cxgItensViewQRCODE_NOV: TcxGridDBColumn
            Caption = 'Qrcode (Novo)'
            DataBinding.FieldName = 'ITE_QRCODE_NOV'
            Width = 300
          end
          object cxgItensViewEXPB2B: TcxGridDBColumn
            Caption = 'Exportar para B2B'
            DataBinding.FieldName = 'ITE_EXPB2B'
            Width = 95
          end
          object cxgItensViewEXPB2B_NOV: TcxGridDBColumn
            Caption = 'Exportar para B2B (Novo)'
            DataBinding.FieldName = 'ITE_EXPB2B_NOV'
            Width = 131
          end
          object cxgItensViewPRAVAL: TcxGridDBColumn
            Caption = 'Prazo de Validade (Meses)'
            DataBinding.FieldName = 'ITE_PRAVAL'
            Width = 136
          end
          object cxgItensViewPRAVAL_NOV: TcxGridDBColumn
            Caption = 'Prazo de Validade(Meses) (Novo)'
            DataBinding.FieldName = 'ITE_PRAVAL_NOV'
            Width = 169
          end
          object cxgItensViewITE_NVLCRI: TcxGridDBColumn
            Caption = 'N'#237'vel de Criticidade de Estoque Geral'
            DataBinding.FieldName = 'ITE_NVLCRI'
            Width = 200
          end
          object cxgItensViewITE_NVLCRI_NOV: TcxGridDBColumn
            Caption = 'N'#237'vel de Criticidade de Estoque Geral (NOVO)'
            DataBinding.FieldName = 'ITE_NVLCRI_NOV'
            Width = 230
          end
          object cxgItensViewLIS_ABVFIS: TcxGridDBColumn
            Caption = 'Lista Abrevia'#231#227'o Fiscal'
            DataBinding.FieldName = 'LIS_ABVFIS'
          end
          object cxgItensViewLIS_ABFPIS: TcxGridDBColumn
            Caption = 'Lista Abrevia'#231#227'o Fiscal PIS'
            DataBinding.FieldName = 'LIS_ABFPIS'
          end
          object cxgItensViewLIS_ABFCOF: TcxGridDBColumn
            Caption = 'Lista Abrevia'#231#227'o Fiscal COFINS'
            DataBinding.FieldName = 'LIS_ABFCOF'
          end
          object cxgItensViewRECDEV: TcxGridDBColumn
            Caption = 'Permitir receber devolu'#231#227'o deste produto'
            DataBinding.FieldName = 'ITE_RECDEV'
          end
          object cxgItensViewRECDEV_NOV: TcxGridDBColumn
            Caption = 'Permitir receber devolu'#231#227'o deste produto ( NOVO )'
            DataBinding.FieldName = 'ITE_RECDEV_NOV'
          end
          object cxgItensViewVALOBR: TcxGridDBColumn
            Caption = 'Validade Obrigat'#243'ria'
            DataBinding.FieldName = 'ITE_VALOBR'
          end
          object cxgItensViewVALOBR_NOVO: TcxGridDBColumn
            Caption = 'Validade Obrigat'#243'ria (NOVO)'
            DataBinding.FieldName = 'ITE_VALOBR_NOV'
          end
          object cxgItensViewCOMPOS: TcxGridDBColumn
            Caption = 'Composi'#231#227'o'
            DataBinding.FieldName = 'ITE_COMPOS'
          end
          object cxgItensViewCOMPOS_NOVO: TcxGridDBColumn
            Caption = 'Composi'#231#227'o (NOVO)'
            DataBinding.FieldName = 'ITE_COMPOS_NOV'
          end
          object cxgItensViewITESAC: TcxGridDBColumn
            Caption = 'SAC'
            DataBinding.FieldName = 'ITE_ITESAC'
          end
          object cxgItensViewITESAC_NOVO: TcxGridDBColumn
            Caption = 'SAC (Novo)'
            DataBinding.FieldName = 'ITE_ITESAC_NOV'
          end
          object cxgItensViewPAISOR: TcxGridDBColumn
            Caption = 'Pais Origem'
            DataBinding.FieldName = 'ITE_PAISOR'
          end
          object cxgItensViewPAISOR_NOVO: TcxGridDBColumn
            Caption = 'Pais Origem (Novo)'
            DataBinding.FieldName = 'ITE_PAISOR_NOV'
          end
          object cxgItensViewCODATC: TcxGridDBColumn
            DataBinding.FieldName = 'ITE_CODATC'
          end
          object cxgItensViewCODATC_NOV: TcxGridDBColumn
            DataBinding.FieldName = 'ITE_CODATC_NOV'
          end
          object cxgItensViewMARID1: TcxGridDBColumn
            Caption = 'Margem Ideal 1'
            DataBinding.FieldName = 'ITE_MARID1'
          end
          object cxgItensViewMARID1_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 1 (Novo)'
            DataBinding.FieldName = 'ITE_MARID1_NOV'
          end
          object cxgItensViewMARID2: TcxGridDBColumn
            Caption = 'Margem Ideal 2'
            DataBinding.FieldName = 'ITE_MARID2'
          end
          object cxgItensViewMARID2_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 2 (Novo)'
            DataBinding.FieldName = 'ITE_MARID2_NOV'
          end
          object cxgItensViewMARID3: TcxGridDBColumn
            Caption = 'Margem Ideal 3'
            DataBinding.FieldName = 'ITE_MARID3'
          end
          object cxgItensViewMARID3_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 3 (Novo)'
            DataBinding.FieldName = 'ITE_MARID3_NOV'
          end
          object cxgItensViewMARID4: TcxGridDBColumn
            Caption = 'Margem Ideal 4'
            DataBinding.FieldName = 'ITE_MARID4'
          end
          object cxgItensViewMARID4_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 4 (Novo)'
            DataBinding.FieldName = 'ITE_MARID4_NOV'
          end
          object cxgItensViewMARID5: TcxGridDBColumn
            Caption = 'Margem Ideal 5'
            DataBinding.FieldName = 'ITE_MARID5'
          end
          object cxgItensViewMARID5_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 5 (Novo)'
            DataBinding.FieldName = 'ITE_MARID5_NOV'
          end
          object cxgItensViewMARID6: TcxGridDBColumn
            Caption = 'Margem Ideal 6'
            DataBinding.FieldName = 'ITE_MARID6'
          end
          object cxgItensViewMARID6_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 6 (Novo)'
            DataBinding.FieldName = 'ITE_MARID6_NOV'
          end
          object cxgItensViewMARID7: TcxGridDBColumn
            Caption = 'Margem Ideal 7'
            DataBinding.FieldName = 'ITE_MARID7'
          end
          object cxgItensViewMARID7_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 7 (Novo)'
            DataBinding.FieldName = 'ITE_MARID7_NOV'
          end
          object cxgItensViewQTDPES: TcxGridDBColumn
            Caption = 'Qtde m'#237'n. estoque para ponta de estoque'
            DataBinding.FieldName = 'ITE_QTDPES'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
            Visible = False
          end
          object cxgItensViewQTDPES_NOV: TcxGridDBColumn
            Caption = 'Qtde m'#237'n. estoque para ponta de estoque (Novo)'
            DataBinding.FieldName = 'ITE_QTDPES_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
            Visible = False
          end
          object cxgItensViewPORPES: TcxGridDBColumn
            Caption = '% de desconto aplicado para ponta de estoque'
            DataBinding.FieldName = 'ITE_PORPES'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
            Visible = False
          end
          object cxgItensViewPORPES_NOV: TcxGridDBColumn
            Caption = '% de desconto aplicado para ponta de estoque (Novo)'
            DataBinding.FieldName = 'ITE_PORPES_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
            Visible = False
          end
          object cxgItensViewPER_CI: TcxGridDBColumn
            Caption = 'Percentual (CI)'
            DataBinding.FieldName = 'ITE_PER_CI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
          end
          object cxgItensViewPER_CI_NOV: TcxGridDBColumn
            Caption = 'Percentual (CI) (Novo)'
            DataBinding.FieldName = 'ITE_PER_CI_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
          end
          object cxgItensViewNUMFCI: TcxGridDBColumn
            Caption = 'N'#250'mero da Ficha (FCI)'
            DataBinding.FieldName = 'ITE_NUMFCI'
          end
          object cxgItensViewNUMFCI_NOV: TcxGridDBColumn
            Caption = 'N'#250'mero da Ficha (FCI) (Novo)'
            DataBinding.FieldName = 'ITE_NUMFCI_NOV'
          end
          object cxgItensViewFATUTR: TcxGridDBColumn
            Caption = 'Fator Convers'#227'o (Unid. Trib)'
            DataBinding.FieldName = 'ITE_FATUTR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
          end
          object cxgItensViewFATUTR_NOV: TcxGridDBColumn
            Caption = 'Fator Convers'#227'o (Unid. Trib) (Novo)'
            DataBinding.FieldName = 'ITE_FATUTR_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
          end
          object cxgItensViewPRAPEL: TcxGridDBColumn
            Caption = 'Desconto Referente Rapel'
            DataBinding.FieldName = 'ITE_PRAPEL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
            Visible = False
          end
          object cxgItensViewPRAPEL_NOVO: TcxGridDBColumn
            Caption = 'Desconto Referente Rapel (Novo)'
            DataBinding.FieldName = 'ITE_PRAPEL_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
            Visible = False
          end
          object cxItensITEEMB: TcxGridDBColumn
            Caption = 'Desconto Emb. Fechado'
            DataBinding.FieldName = 'ITE_ITEEMB'
          end
          object cxItensITEEMB_NOV: TcxGridDBColumn
            Caption = 'Desconto Emb. Fechado(Novo)'
            DataBinding.FieldName = 'ITE_ITEEMB_NOV'
          end
          object cxgItensViewCEREPI: TcxGridDBColumn
            Caption = 'Certificado de Aprova'#231#227'o EPI'
            DataBinding.FieldName = 'ITE_CEREPI'
          end
          object cxgItensViewCEREPI_NOV: TcxGridDBColumn
            Caption = 'Certificado de Aprova'#231#227'o EPI(Novo)'
            DataBinding.FieldName = 'ITE_CEREPI_NOV'
          end
          object cxgItensViewMARPAD: TcxGridDBColumn
            Caption = 'Margem Padr'#227'o'
            DataBinding.FieldName = 'ITE_MARPAD'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Visible = False
          end
          object cxgItensViewMARPAD_NOV: TcxGridDBColumn
            Caption = 'Margem Padr'#227'o(Novo)'
            DataBinding.FieldName = 'ITE_MARPAD_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Visible = False
          end
          object cxgItensViewLIS_TPESTM: TcxGridDBColumn
            Caption = 'Tipo de Estoque M'#237'nimo'
            DataBinding.FieldName = 'LIS_TPESTM'
          end
        end
        object cxgItensLevel1: TcxGridLevel
          GridView = cxgItensView
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 540
        Width = 1000
        Height = 21
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label1: TLabel
          Left = 3
          Top = 3
          Width = 522
          Height = 14
          Caption = 
            '(*) Caso o c'#243'digo de barras seja diferente, um novo c'#243'digo de ba' +
            'rras ser'#225' inclu'#237'do, mantendo o j'#225' existente.'
        end
        object btnVariacao: TBitBtnLocked
          Left = 531
          Top = 0
          Width = 197
          Height = 22
          Caption = 'Exibir Varia'#231#227'o do Pre'#231'o de Venda'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000090000
            000E0000000F0000000F0000000F0000000F0000000F0000000F000000100000
            0010000000100000001000000010000000100000000F0000000A7B574BC1AC79
            68FFAC7968FFAB7968FFAB7968FFAB7968FFAA7968FFAA7969FFAA7969FFA979
            69FFA97969FFA97969FFA97A69FFA97A6AFFA87A6AFF78584CC1B27967FFF9F3
            EFFFF9F3EEFFFAF3EEFFFAF3EEFFFAF3EDFFF9F3EEFFF9F3EEFFF9F2EEFFF9F2
            EDFFF9F2EDFFF9F2EDFFF9F2EEFFF9F3EDFFF9F2EDFFB07764FFB37B69FFFAF3
            EFFF78675FFF443026FF7A6961FFA0938CFFF5EEEAFFF9F3EFFF9F928DFF5E4D
            46FFC5BCB6FF44322AFF44322AFFD3CAC4FFF9F2EEFFB17966FFB47C6AFFFAF5
            F0FF75645CFF75635CFFEDE6E1FF503C33FF817169FFFAF3EFFFF9F3F0FFFAF3
            EFFF6C5C55FF38251DFFDFD8D2FFF9F3EFFFF9F3EFFFB27A67FFB57E6CFFFAF5
            F1FFFAF5F1FFFAF4F1FFFAF5F0FF82726BFF473228FFCBC2BCFFFAF4F0FFFAF4
            F0FF877972FF47352CFFFAF4F0FFFAF4EFFFFAF4EFFFB37B69FFB7806EFFFAF6
            F2FFFAF6F2FFFAF6F1FFFAF5F1FFAC9F98FF49332AFF92837CFFFAF5F0FFFAF5
            F0FF55423CFF54433CFFE1DAD4FFFAF5F1FFFAF4F0FFB57D6AFFB88270FFFBF6
            F3FFFBF7F3FFFBF6F2FFFBF6F2FFD4CBC7FF4B362BFF68554CFFEEE8E3FF6354
            4BFF3D2A21FFAFA49EFF897B74FF63514BFFFAF5F1FFB67F6DFFB98472FFFBF7
            F3FFFCF7F3FFFBF7F4FFFBF7F3FFF5F0ECFF533E34FF4D362DFFE6DFDCFFFBF6
            F2FFFBF6F2FFFBF6F2FFFBF6F2FFFBF6F2FFFAF5F2FFB7806EFFBB8674FFFCF8
            F5FFFCF8F5FFFCF8F4FFFBF7F4FF503A30FF513930FF4F3930FF4F392FFF4F37
            2EFFFBF7F4FFFBF7F3FFFBF6F3FFFBF6F3FFFBF7F3FFB88270FFBC8976FFFCF8
            F6FFFCF9F5FFFBF8F5FFFCF8F5FFFCF8F5FFD6CEC9FF513B31FF79675EFFFBF8
            F5FFFCF7F4FFFBF7F5FFFBF8F4FFFBF7F4FFFBF7F4FFBA8473FFBE8B78FFFCF9
            F7FFFCF9F6FFFCF9F6FFFCF8F6FFFCF9F6FFFCF8F6FF91827AFF553F35FFEAE4
            E0FF827168FF827169FFFCF8F5FFFCF8F5FFFCF8F4FFBB8774FFBF8C7AFFFDFA
            F8FFFCFAF7FFFCFAF7FFFDFAF7FFFCF9F7FFFDFAF6FFFBF7F4FFAA9E97FF8271
            69FF543F34FF7F6E66FFFCF9F6FFFCF9F6FFFCF8F6FFBD8977FFC08F7DFFFDFA
            F8FFFDFAF8FFFCFBF8FFFCFAF7FFFDFAF7FFFCFAF8FFFCFAF8FFFDF9F7FFFCFA
            F8FFFDF9F7FFFCF9F7FFFCF9F6FFFCF9F6FFFCF9F7FFBE8B78FF98766AC0CD9F
            8EFFCC9F8EFFCC9F8EFFCC9F8DFFCC9E8DFFCB9E8DFFCB9D8CFFCB9D8CFFCA9C
            8BFFCA9C8BFFCA9B8AFFC99A89FFC89A88FFC89988FF947264C1000000030000
            0004000000050000000500000005000000050000000500000005000000050000
            0005000000050000000500000005000000050000000500000003}
          TabOrder = 0
          OnClick = btnVariacaoClick
        end
      end
    end
    object tbsInclui: TTabSheet
      Caption = 'Produtos que ser'#227'o Inclu'#237'dos'
      ImageIndex = 1
      object cxItensInsert: TcxGrid
        Left = 0
        Top = 0
        Width = 1000
        Height = 561
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfStandard
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxItensIns: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgItensViewCustomDrawCell
          OnFocusedRecordChanged = cxItensInsFocusedRecordChanged
          DataController.DataModeController.GridMode = True
          DataController.DataModeController.SyncMode = False
          DataController.DataSource = dtsDadosIns
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Filter.OnChanged = cxItensInsDataControllerFilterChanged
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir o filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhum registro para ser inclu'#237'do'
          OptionsView.GroupByBox = False
          object cxItensInsViewCodIte: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ITE_CODITE'
            BestFitMaxWidth = 20
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 60
          end
          object cxItensInsViewDesIte: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'ITE_DESITE_NOV'
            Width = 228
          end
          object cxItensInsViewCodFab: TcxGridDBColumn
            Caption = 'C'#243'd. Fabr.'
            DataBinding.FieldName = 'ITE_CODFAB_NOV'
            Width = 111
          end
          object cxItensInsViewCodBar: TcxGridDBColumn
            Caption = 'C'#243'd. Barras.'
            DataBinding.FieldName = 'ITE_CODBAR_NOV'
            Width = 111
          end
          object cxItensInsViewCODFOR_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Fornecedor'
            DataBinding.FieldName = 'ITE_CODFOR_NOV'
            Width = 119
          end
          object cxItensInsViewCODDEP_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Departamento'
            DataBinding.FieldName = 'ITE_CODDEP_NOV'
            Width = 134
          end
          object cxItensInsViewCODGRU_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Linha/Grupo'
            DataBinding.FieldName = 'ITE_CODGRU_NOV'
            Width = 124
          end
          object cxItensInsViewDESFAB_NOV: TcxGridDBColumn
            Caption = 'Desc. F'#225'brica'
            DataBinding.FieldName = 'ITE_DESFAB_NOV'
            Width = 184
          end
          object cxItensInsViewCODMAR_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Marca'
            DataBinding.FieldName = 'ITE_CODMAR_NOV'
            Width = 94
          end
          object cxItensInsViewREFERE_NOV: TcxGridDBColumn
            Caption = 'Ref'#234'rencia'
            DataBinding.FieldName = 'ITE_REFERE_NOV'
            Width = 92
          end
          object cxItensInsViewCODUNI_NOV: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'ITE_CODUNI_NOV'
            Width = 78
          end
          object cxItensInsViewUNICOM_NOV: TcxGridDBColumn
            Caption = 'Unidade Compra'
            DataBinding.FieldName = 'ITE_UNICOM_NOV'
            Width = 117
          end
          object cxItensInsViewCODABF_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o ICMS'
            DataBinding.FieldName = 'ITE_CODABF_NOV'
            Width = 147
          end
          object cxItensInsViewABFPIS_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o PIS'
            DataBinding.FieldName = 'ITE_ABFPIS_NOV'
            Width = 140
          end
          object cxItensInsViewABFCOF_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o COFINS'
            DataBinding.FieldName = 'ITE_ABFCOF_NOV'
            Width = 159
          end
          object cxItensInsViewABFIPI_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Abrevia'#231#227'o IPI'
            DataBinding.FieldName = 'ITE_ABFIPI_NOV'
            Width = 132
          end
          object cxItensInsViewIPISAI_NOV: TcxGridDBColumn
            Caption = '%IPI de Sa'#237'da'
            DataBinding.FieldName = 'ITE_IPISAI_NOV'
            Width = 105
          end
          object cxItensInsViewINCPIS_NOV: TcxGridDBColumn
            Caption = 'Incide PIS/COFINS'
            DataBinding.FieldName = 'ITE_INCPIS_NOV'
            Width = 126
          end
          object cxItensInsViewCLAIPI_NOV: TcxGridDBColumn
            Caption = 'NCM/Classif. IPI'
            DataBinding.FieldName = 'ITE_CLAIPI_NOV'
            Width = 111
          end
          object cxItensInsViewEXCIPI_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Ex NCM'
            DataBinding.FieldName = 'ITE_EXCIPI_NOV'
            Width = 102
          end
          object cxItensInsViewCDCEST_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Classif. CEST'
            DataBinding.FieldName = 'ITE_CDCEST_NOV'
            Width = 139
          end
          object cxItensInsViewCODONU_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Classif. ONU'
            DataBinding.FieldName = 'ITE_CODONU_NOV'
            Width = 125
          end
          object cxItensInsViewIMPLIS_NOV: TcxGridDBColumn
            Caption = 'Imprime Lista'
            DataBinding.FieldName = 'ITE_IMPLIS_NOV'
            Width = 111
          end
          object cxItensInsViewITEATI_NOV: TcxGridDBColumn
            Caption = 'Ativo'
            DataBinding.FieldName = 'ITE_ITEATI_NOV'
            Width = 63
          end
          object cxItensInsViewATICOM_NOV: TcxGridDBColumn
            Caption = 'Ativo para Compra'
            DataBinding.FieldName = 'ITE_ATICOM_NOV'
            Width = 127
          end
          object cxItensInsViewPESOIT_NOV: TcxGridDBColumn
            Caption = 'Peso Bruto'
            DataBinding.FieldName = 'ITE_PESOIT_NOV'
            Width = 111
          end
          object cxItensInsViewPESLIQ_NOV: TcxGridDBColumn
            Caption = 'Peso L'#237'quido'
            DataBinding.FieldName = 'ITE_PESLIQ_NOV'
            Width = 111
          end
          object cxItensInsViewCODGPR_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Grupo Pre'#231'o'
            DataBinding.FieldName = 'ITE_CODGPR_NOV'
            Width = 124
          end
          object cxItensInsViewPRDGRU_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Grupo de Produto'
            DataBinding.FieldName = 'ITE_PRDGRU_NOV'
            Width = 149
          end
          object cxItensInsViewGRUCMP_NOV: TcxGridDBColumn
            Caption = 'C'#243'd. Grupo de Compra'
            DataBinding.FieldName = 'ITE_GRUCMP_NOV'
            Width = 149
          end
          object cxItensInsViewMLTVEN_NOV: TcxGridDBColumn
            Caption = 'Multiplo de Venda'
            DataBinding.FieldName = 'ITE_MLTVEN_NOV'
            Width = 124
          end
          object cxItensInsViewMLTCOM_NOV: TcxGridDBColumn
            Caption = 'Multiplo de Compra'
            DataBinding.FieldName = 'ITE_MLTCOM_NOV'
            Width = 127
          end
          object cxItensInsViewNVLGIR_NOV: TcxGridDBColumn
            Caption = 'Nivel Giro Geral'
            DataBinding.FieldName = 'ITE_NVLGIR_NOV'
            Width = 83
          end
          object cxItensInsViewNIVGIR_NOV: TcxGridDBColumn
            Caption = 'Nivel Giro Por Empresa'
            DataBinding.FieldName = 'ITE_NIVGIR_NOV'
            Width = 117
          end
          object cxItensInsViewACOOBJ_NOV: TcxGridDBColumn
            Caption = 'Acordo Objetivo'
            DataBinding.FieldName = 'ITE_ACOOBJ_NOV'
            Width = 115
          end
          object cxItensInsViewAPLICA_NOV: TcxGridDBColumn
            Caption = 'Aplica'#231#227'o'
            DataBinding.FieldName = 'ITE_APLICA_NOV'
            Width = 111
          end
          object cxItensInsViewPRECOM_NOV: TcxGridDBColumn
            Caption = 'Pre'#231'o de Compra'
            DataBinding.FieldName = 'ITE_PRECOM_NOV'
            Width = 125
          end
          object cxItensInsViewDESF01_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 01'
            DataBinding.FieldName = 'ITE_DESF01_NOV'
            Width = 111
          end
          object cxItensInsViewDESF02_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 02'
            DataBinding.FieldName = 'ITE_DESF02_NOV'
            Width = 111
          end
          object cxItensInsViewDESF03_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 03'
            DataBinding.FieldName = 'ITE_DESF03_NOV'
            Width = 111
          end
          object cxItensInsViewDESF04_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 04'
            DataBinding.FieldName = 'ITE_DESF04_NOV'
            Width = 111
          end
          object cxItensInsViewDESF05_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 05'
            DataBinding.FieldName = 'ITE_DESF05_NOV'
            Width = 111
          end
          object cxItensInsViewDESF06_NOV: TcxGridDBColumn
            Caption = 'Desc. Forn. 06'
            DataBinding.FieldName = 'ITE_DESF06_NOV'
            Width = 111
          end
          object cxItensInsViewICMENT_NOV: TcxGridDBColumn
            Caption = 'ICMS de Entrada'
            DataBinding.FieldName = 'ITE_ICMENT_NOV'
            Width = 116
          end
          object cxItensInsViewSUBFED_NOV: TcxGridDBColumn
            Caption = '%Impostos Federais(-)'
            DataBinding.FieldName = 'ITE_SUBFED_NOV'
            Width = 148
          end
          object cxItensInsViewIPIENT_NOV: TcxGridDBColumn
            Caption = '%IPI Entrada'
            DataBinding.FieldName = 'ITE_IPIENT_NOV'
            Width = 100
          end
          object cxItensInsViewFREENT_NOV: TcxGridDBColumn
            Caption = '% Frete'
            DataBinding.FieldName = 'ITE_FREENT_NOV'
            Width = 78
          end
          object cxItensInsViewVALFRE_NOV: TcxGridDBColumn
            Caption = 'Valor Frete'
            DataBinding.FieldName = 'ITE_VALFRE_NOV'
            Width = 95
          end
          object cxItensInsViewACRFIN_NOV: TcxGridDBColumn
            Caption = 'Acr'#233'cimo Financeiro'
            DataBinding.FieldName = 'ITE_ACRFIN_NOV'
            Width = 142
          end
          object cxItensInsViewSUBSTI_NOV: TcxGridDBColumn
            Caption = 'Sub. Tributaria'
            DataBinding.FieldName = 'ITE_SUBSTI_NOV'
            Width = 111
          end
          object cxItensInsViewDESADB_NOV: TcxGridDBColumn
            Caption = 'Descontos Adicionais'
            DataBinding.FieldName = 'ITE_DESADB_NOV'
            Width = 142
          end
          object cxItensInsViewTCIFCU_NOV: TcxGridDBColumn
            Caption = 'TCIF'
            DataBinding.FieldName = 'ITE_TCIFCU_NOV'
            Visible = False
          end
          object cxItensInsViewTSCUST_NOV: TcxGridDBColumn
            Caption = 'TS'
            DataBinding.FieldName = 'ITE_TSCUST_NOV'
            Visible = False
          end
          object cxItensInsViewDEPICO_NOV: TcxGridDBColumn
            Caption = 'Desconto PIS/COFINS'
            DataBinding.FieldName = 'ITE_DEPICO_NOV'
            Visible = False
          end
          object cxItensInsViewDEICMS_NOV: TcxGridDBColumn
            Caption = 'Desconto de ICMS'
            DataBinding.FieldName = 'ITE_DEICMS_NOV'
            Visible = False
          end
          object cxItensInsViewFATREG_NOV: TcxGridDBColumn
            Caption = 'Fator Regional'
            DataBinding.FieldName = 'ITE_FATREG_NOV'
            Visible = False
          end
          object cxItensInsViewOUTVAL_NOV: TcxGridDBColumn
            Caption = 'Outros Valores'
            DataBinding.FieldName = 'ITE_OUTVAL_NOV'
            Width = 111
          end
          object cxItensInsViewICMSAI_NOV: TcxGridDBColumn
            Caption = '%ICMS Sa'#237'da'
            DataBinding.FieldName = 'ITE_ICMSAI_NOV'
            Width = 104
          end
          object cxItensInsViewIMPFED_NOV: TcxGridDBColumn
            Caption = '%Impostos Federais(+)'
            DataBinding.FieldName = 'ITE_IMPFED_NOV'
            Width = 154
          end
          object cxItensInsViewDESOPE_NOV: TcxGridDBColumn
            Caption = 'Despesas Operacionais'
            DataBinding.FieldName = 'ITE_DESOPE_NOV'
            Width = 153
          end
          object cxItensInsViewMARBR1_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 1'
            DataBinding.FieldName = 'ITE_MARBR1_NOV'
            Width = 116
          end
          object cxItensInsViewCOMTB1_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 1'
            DataBinding.FieldName = 'ITE_COMTB1_NOV'
            Width = 111
          end
          object cxItensInsViewPREVE1_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 1'
            DataBinding.FieldName = 'ITE_PREVE1_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Options.Editing = False
            Width = 111
          end
          object cxItensInsViewMARBR2_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 2'
            DataBinding.FieldName = 'ITE_MARBR2_NOV'
            Width = 116
          end
          object cxItensInsViewCOMTB2_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 2'
            DataBinding.FieldName = 'ITE_COMTB2_NOV'
            Width = 111
          end
          object cxItensInsViewPREVE2_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 2'
            DataBinding.FieldName = 'ITE_PREVE2_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Options.Editing = False
            Width = 111
          end
          object cxItensInsViewMARBR3_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 3'
            DataBinding.FieldName = 'ITE_MARBR3_NOV'
            Width = 114
          end
          object cxItensInsViewCOMTB3_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 3'
            DataBinding.FieldName = 'ITE_COMTB3_NOV'
            Width = 104
          end
          object cxItensInsViewPREVE3_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 3'
            DataBinding.FieldName = 'ITE_PREVE3_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Options.Editing = False
            Width = 111
          end
          object cxItensInsViewMARBR4_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 4'
            DataBinding.FieldName = 'ITE_MARBR4_NOV'
            Width = 114
          end
          object cxItensInsViewCOMTB4_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 4'
            DataBinding.FieldName = 'ITE_COMTB4_NOV'
            Width = 111
          end
          object cxItensInsViewPREVE4_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 4'
            DataBinding.FieldName = 'ITE_PREVE4_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Options.Editing = False
            Width = 111
          end
          object cxItensInsViewMARBR5_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 5'
            DataBinding.FieldName = 'ITE_MARBR5_NOV'
            Width = 114
          end
          object cxItensInsViewCOMTB5_NOV: TcxGridDBColumn
            Caption = '%Comis'#227'o 5'
            DataBinding.FieldName = 'ITE_COMTB5_NOV'
            Width = 111
          end
          object cxItensInsViewPREVE5_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 5'
            DataBinding.FieldName = 'ITE_PREVE5_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Options.Editing = False
            Width = 111
          end
          object cxItensInsViewMARBR6_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 6'
            DataBinding.FieldName = 'ITE_MARBR6_NOV'
            Width = 118
          end
          object cxItensInsViewCOMTB6_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 6'
            DataBinding.FieldName = 'ITE_COMTB6_NOV'
            Width = 111
          end
          object cxItensInsViewPREVE6_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 6'
            DataBinding.FieldName = 'ITE_PREVE6_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Options.Editing = False
            Width = 111
          end
          object cxItensInsViewMARBR7_NOV: TcxGridDBColumn
            Caption = 'Margem Bruta 7'
            DataBinding.FieldName = 'ITE_MARBR7_NOV'
            Width = 114
          end
          object cxItensInsViewCOMTB7_NOV: TcxGridDBColumn
            Caption = '%Comiss'#227'o 7'
            DataBinding.FieldName = 'ITE_COMTB7_NOV'
            Width = 111
          end
          object cxItensInsViewPREVE7_NOV: TcxGridDBColumn
            Caption = 'Preco Venda 7'
            DataBinding.FieldName = 'ITE_PREVE7_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Options.Editing = False
            Width = 111
          end
          object cxItensInsViewCOMVAR_NOV: TcxGridDBColumn
            Caption = '% Comiss'#227'o Vendedor Interno Loja'
            DataBinding.FieldName = 'ITE_COMVAR_NOV'
            Width = 211
          end
          object cxItensInsViewCOMATA_NOV: TcxGridDBColumn
            Caption = '% Comiss'#227'o Vendedor Externo Loja'
            DataBinding.FieldName = 'ITE_COMATA_NOV'
            Width = 214
          end
          object cxItensInsViewCOMDIS_NOV: TcxGridDBColumn
            Caption = 'Comiss'#227'o Vendedor Externo Distribuidor'
            DataBinding.FieldName = 'ITE_CODDIS_NOV'
            Width = 235
          end
          object cxItensInsViewCOMPRO_NOV: TcxGridDBColumn
            Caption = 'Comiss'#227'o Profissional'
            DataBinding.FieldName = 'ITE_COMPRO_NOV'
            Width = 146
          end
          object cxItensInsViewDESMAX_NOV: TcxGridDBColumn
            Caption = '% Desconto M'#225'ximo Vendedor'
            DataBinding.FieldName = 'ITE_DESMAX_NOV'
            Width = 188
          end
          object cxItensInsViewDESMSU_NOV: TcxGridDBColumn
            Caption = '% Desconto M'#225'ximo Sub-gerente'
            DataBinding.FieldName = 'ITE_DESMSU_NOV'
            Width = 199
          end
          object cxItensInsViewDESMGE_NOV: TcxGridDBColumn
            Caption = '% Desconto M'#225'ximo Gerente'
            DataBinding.FieldName = 'ITE_DESMGE_NOV'
            Width = 181
          end
          object cxItensInsViewMARMIN_NOV: TcxGridDBColumn
            Caption = '% Margem M'#237'nima Vendedor'
            DataBinding.FieldName = 'ITE_MARMIN_NOV'
            Width = 141
          end
          object cxItensInsViewMARMSG_NOV: TcxGridDBColumn
            Caption = '% Margem M'#237'nima Sub-gerente'
            DataBinding.FieldName = 'ITE_MARMSG_NOV'
            Width = 190
          end
          object cxItensInsViewMARMGE_NOV: TcxGridDBColumn
            Caption = '% Margem M'#237'nima Gerente'
            DataBinding.FieldName = 'ITE_MARMGE_NOV'
            Width = 171
          end
          object cxItensInsViewTMPGAR_NOV: TcxGridDBColumn
            Caption = 'Tempo de Garantia(Meses)'
            DataBinding.FieldName = 'ITE_TMPGAR_NOV'
            Width = 171
          end
          object cxItensInsViewINFGAR_NOV: TcxGridDBColumn
            Caption = 'Informa'#231#245'es da Garantia'
            DataBinding.FieldName = 'ITE_INFGAR_NOV'
            Width = 158
          end
          object cxItensInsViewLOCFIS_NOV: TcxGridDBColumn
            Caption = 'Localiza'#231#227'o Fisica'
            DataBinding.FieldName = 'ITE_LOCFIS_NOV'
            Width = 130
          end
          object cxItensInsViewLOCSUP_NOV: TcxGridDBColumn
            Caption = 'Localiza'#231#227'o Super Estoque'
            DataBinding.FieldName = 'ITE_LOCSUP_NOV'
            Width = 170
          end
          object cxgItensInsViewCODLSE_NOV: TcxGridDBColumn
            Caption = 'Local Separa'#231#227'o(Novo)'
            DataBinding.FieldName = 'ITE_CODLSE_NOV'
            Width = 130
          end
          object cxItensInsViewITEBAS_NOV: TcxGridDBColumn
            Caption = 'Base'
            DataBinding.FieldName = 'ITE_ITEBAS_NOV'
            Width = 38
          end
          object cxItensInsViewITEPIG_NOV: TcxGridDBColumn
            Caption = 'Pigmento'
            DataBinding.FieldName = 'ITE_ITEPIG_NOV'
            Width = 50
          end
          object cxItensInsViewBAREXP_NOV: TcxGridDBColumn
            Caption = 'Cod. Barr. Exped.'
            DataBinding.FieldName = 'ITE_BAREXP_NOV'
            Width = 90
          end
          object cxItensInsViewCPRCEN_NOV: TcxGridDBColumn
            Caption = 'Compr. Central.'
            DataBinding.FieldName = 'ITE_CPRCEN_NOV'
            Width = 77
          end
          object cxItensInsViewCODMON_NOV: TcxGridDBColumn
            Caption = 'Montadoras'
            DataBinding.FieldName = 'ITE_CODMON_NOV'
            Width = 170
          end
          object cxItensInsViewDIAFOR: TcxGridDBColumn
            Caption = 'Dias Entrega Fornec.'
            DataBinding.FieldName = 'ITE_DIAFOR_NOV'
            Width = 111
          end
          object cxItensInsViewEXPSIT_NOV: TcxGridDBColumn
            Caption = 'Exporta'#231#227'o para E-Commerce'
            DataBinding.FieldName = 'ITE_EXPSIT_NOV'
            Width = 185
          end
          object cxItensInsViewDSSITE_NOV: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Produto E-Commerce'
            DataBinding.FieldName = 'ITE_DESITE_SITE_NOV'
            Width = 210
          end
          object cxItensInsViewDADTEC_NOV: TcxGridDBColumn
            Caption = 'Dados T'#233'cnicos E-Commerce'
            DataBinding.FieldName = 'ITE_DADTEC_NOV'
            Width = 185
          end
          object cxItensInsViewURLIMG_NOV: TcxGridDBColumn
            Caption = 'URL da imagem E-Commerce'
            DataBinding.FieldName = 'ITE_URLIMG_NOV'
            Width = 255
          end
          object cxItensInsViewNOMITE_NOV: TcxGridDBColumn
            Caption = 'Nome do Produto E-Commerce'
            DataBinding.FieldName = 'ITE_NOMITE_NOV'
            Width = 255
          end
          object cxItensInsViewAPLITE_NOV: TcxGridDBColumn
            Caption = 'Aplica'#231#227'o E-Commerce'
            DataBinding.FieldName = 'ITE_APLITE_NOV'
            Width = 255
          end
          object cxItensInsViewINCLUS_NOV: TcxGridDBColumn
            Caption = 'Itens Inclusos E-Commerce'
            DataBinding.FieldName = 'ITE_INCLUS_NOV'
            Width = 255
          end
          object cxItensInsViewEXPALT_NOV: TcxGridDBColumn
            Caption = 'Altura E-Commerce'
            DataBinding.FieldName = 'ITE_EXPALT_NOV'
            Width = 135
          end
          object cxItensInsViewEXPLAR_NOV: TcxGridDBColumn
            Caption = 'Largura E-Commerce'
            DataBinding.FieldName = 'ITE_EXPLAR_NOV'
            Width = 145
          end
          object cxItensInsViewEXPPRO_NOV: TcxGridDBColumn
            Caption = 'Profundidade E-Commerce'
            DataBinding.FieldName = 'ITE_EXPPRO_NOV'
            Width = 170
          end
          object cxItensInsViewDESSIT_NOV: TcxGridDBColumn
            Caption = 'Desconto para Site E-Commerce'
            DataBinding.FieldName = 'ITE_DESSIT_NOV'
            Width = 200
          end
          object cxItensInsViewCODCAT_NOV: TcxGridDBColumn
            Caption = 'Categorias E-Commerce'
            DataBinding.FieldName = 'ITE_CODCAT_NOV'
            Width = 160
          end
          object cxItensInsViewDESTAQ_NOV: TcxGridDBColumn
            Caption = 'Destaque E-Commerce'
            DataBinding.FieldName = 'ITE_DESTAQ_NOV'
            Width = 150
          end
          object cxItensInsViewATZPRE_NOV: TcxGridDBColumn
            Caption = 'Atualiza pre'#231'os no site?E-Commerce'
            DataBinding.FieldName = 'ITE_ATZPRE_NOV'
            Width = 220
          end
          object cxItensInsViewEXPAPP_NOV: TcxGridDBColumn
            Caption = 'Exporta'#231#227'o APP Venda Assistida E-Commerce'
            DataBinding.FieldName = 'ITE_EXPAPP_NOV'
          end
          object cxItensInsESTMIN_NOV: TcxGridDBColumn
            Caption = 'Estoque M'#237'nimo'
            DataBinding.FieldName = 'ITE_ESTMIN_NOV'
            Width = 92
          end
          object cxItensInsESTMAX_NOV: TcxGridDBColumn
            Caption = 'Estoque M'#225'ximo'
            DataBinding.FieldName = 'ITE_ESTMAX_NOV'
            Width = 93
          end
          object cxgItensInsLIS_CODFOR: TcxGridDBColumn
            Caption = 'Lista Fornecedores'
            DataBinding.FieldName = 'LIS_CODFOR'
            Width = 200
          end
          object cxgItensInsLIS_CODFAB: TcxGridDBColumn
            Caption = 'Lista C'#243'd. F'#225'brica'
            DataBinding.FieldName = 'LIS_CODFAB'
            Width = 200
          end
          object cxgItensInsLIS_CODCNA: TcxGridDBColumn
            Caption = 'Lista C'#243'd. CNA'
            DataBinding.FieldName = 'LIS_CODCNA'
            Width = 200
          end
          object cxItensInsUNITRI_NOV: TcxGridDBColumn
            Caption = 'Uni. Trib.'
            DataBinding.FieldName = 'ITE_UNITRI_NOV'
            Width = 92
          end
          object cxItensInsEXPPOK_NOV: TcxGridDBColumn
            Caption = 'Exporta Tablet'
            DataBinding.FieldName = 'ITE_EXPPOK_NOV'
            Width = 92
          end
          object cxItensInsTIPPRO_NOV: TcxGridDBColumn
            Caption = 'Tipo de Produto(SPED)'
            DataBinding.FieldName = 'ITE_TIPPRO_NOV'
            Width = 130
          end
          object cxItensInsINDREV_NOV: TcxGridDBColumn
            Caption = 'Industrializa'#231#227'o ou Revenda'
            DataBinding.FieldName = 'ITE_INDREV_NOV'
            Width = 170
          end
          object cxItensInsIMPDIR_NOV: TcxGridDBColumn
            Caption = 'Importa'#231#227'o Direta'
            DataBinding.FieldName = 'ITE_IMPDIR_NOV'
            Width = 100
          end
          object cxItensInsMSGLV1_NOV: TcxGridDBColumn
            Caption = 'Mensagem Livre 1'
            DataBinding.FieldName = 'ITE_MSGLV1_NOV'
          end
          object cxItensInsMSGLV2_NOV: TcxGridDBColumn
            Caption = 'Mensagem Livre 2'
            DataBinding.FieldName = 'ITE_MSGLV2_NOV'
          end
          object cxItensInsPEEFUT_NOV: TcxGridDBColumn
            Caption = 'Permitir Entrega Futura com Status "Aguardando o Cliente"'
            DataBinding.FieldName = 'ITE_PEEFUT_NOV'
            Width = 299
          end
          object cxItensInsPEFUTP_NOV: TcxGridDBColumn
            Caption = 'Permitir Entrega Futura com Status "Previs'#227'o de Entrega"'
            DataBinding.FieldName = 'ITE_PEFUTP_NOV'
            Width = 289
          end
          object cxItensInsPEFFPR_NOV: TcxGridDBColumn
            Caption = 'Permitir Entrega Futura com Status "Falta de Produto"'
            DataBinding.FieldName = 'ITE_PEFFPR_NOV'
            Width = 273
          end
          object cxItensInsLIS_ESMIDG_NOV: TcxGridDBColumn
            Caption = 'Lista Op'#231#227'o estoque M'#237'nimo'
            DataBinding.FieldName = 'LIS_ESMIDG'
            Width = 160
          end
          object cxItensInsLIS_ESTMIN_NOV: TcxGridDBColumn
            Caption = 'Lista Estoque M'#237'nimo'
            DataBinding.FieldName = 'LIS_ESTMIN'
            Width = 160
          end
          object cxItensInsLIS_ESTMAX_NOV: TcxGridDBColumn
            Caption = 'Lista Estoque M'#225'ximo'
            DataBinding.FieldName = 'LIS_ESTMAX'
            Width = 160
          end
          object cxItensInsLIS_SITPRO_NOV: TcxGridDBColumn
            Caption = 'Lista Situa'#231#227'o do Produto'
            DataBinding.FieldName = 'LIS_SITPRO'
            Width = 160
          end
          object cxItensInsDESSIM_NOV: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Simplificada'
            DataBinding.FieldName = 'ITE_DESSIM_NOV'
            Width = 115
          end
          object cxItensInsTIPFRE_NOV: TcxGridDBColumn
            Caption = 'Tipo de Frete'
            DataBinding.FieldName = 'ITE_TIPFRE_NOV'
            Width = 69
          end
          object cxItensInsVLCFRE_NOV: TcxGridDBColumn
            Caption = 'Valor do Frete'
            DataBinding.FieldName = 'ITE_VLCFRE_NOV'
            Width = 74
          end
          object cxItensInsQRCODE_NOV: TcxGridDBColumn
            Caption = 'Qrcode'
            DataBinding.FieldName = 'ITE_QRCODE_NOV'
            Width = 300
          end
          object cxItensInsEXPB2B_NOV: TcxGridDBColumn
            Caption = 'Exportar para B2B'
            DataBinding.FieldName = 'ITE_EXPB2B_NOV'
            Width = 107
          end
          object cxItensInsPRAVAL_NOV: TcxGridDBColumn
            Caption = 'Prazo de Validade(Meses)'
            DataBinding.FieldName = 'ITE_PRAVAL_NOV'
            Width = 133
          end
          object cxItensInsITE_NVLCRI: TcxGridDBColumn
            Caption = 'N'#237'vel de Criticidade'
            DataBinding.FieldName = 'ITE_NVLCRI'
            Width = 230
          end
          object cxItensInsITE_NVLCRI_NOV: TcxGridDBColumn
            Caption = 'N'#237'vel de Criticidade (NOVO)'
            DataBinding.FieldName = 'ITE_NVLCRI_NOV'
            Width = 230
          end
          object cxItensInsLIS_ABVFIS_NOV: TcxGridDBColumn
            Caption = 'Lista Abrevia'#231#227'o Fiscal'
            DataBinding.FieldName = 'LIS_ABVFIS'
          end
          object cxItensInsLIS_ABFCOF_NOV: TcxGridDBColumn
            Caption = 'Lista Abrevia'#231#227'o Fiscal COFINS'
            DataBinding.FieldName = 'LIS_ABFCOF'
          end
          object cxItensInsLIS_ABFPIS_NOV: TcxGridDBColumn
            Caption = 'Lista Abrevia'#231#227'o Fiscal PIS'
            DataBinding.FieldName = 'LIS_ABFPIS'
          end
          object cxItensInsRECDEV_NOV: TcxGridDBColumn
            Caption = 'Permitir receber devolu'#231#227'o deste produto'
            DataBinding.FieldName = 'ITE_RECDEV_NOV'
          end
          object cxItensInsVALOBR_NOV: TcxGridDBColumn
            Caption = 'Validade Obrigat'#243'ria'
            DataBinding.FieldName = 'ITE_VALOBR_NOV'
          end
          object cxItensInsCOMPOS_NOV: TcxGridDBColumn
            Caption = 'Composi'#231#227'o'
            DataBinding.FieldName = 'ITE_COMPOS_NOV'
          end
          object cxItensInsITESAC_NOV: TcxGridDBColumn
            Caption = 'SAC'
            DataBinding.FieldName = 'ITE_ITESAC_NOV'
          end
          object cxItensInsPAISOR_NOV: TcxGridDBColumn
            Caption = 'Pais Origem'
            DataBinding.FieldName = 'ITE_PAISOR_NOV'
          end
          object cxItensInsMARID1_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 1'
            DataBinding.FieldName = 'ITE_MARID1_NOV'
          end
          object cxItensInsMARID2_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 2'
            DataBinding.FieldName = 'ITE_MARID2_NOV'
          end
          object cxItensInsMARID3_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 3'
            DataBinding.FieldName = 'ITE_MARID3_NOV'
          end
          object cxItensInsMARID4_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 4'
            DataBinding.FieldName = 'ITE_MARID4_NOV'
          end
          object cxItensInsMARID5_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 5'
            DataBinding.FieldName = 'ITE_MARID5_NOV'
          end
          object cxItensInsMARID6_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 6'
            DataBinding.FieldName = 'ITE_MARID6_NOV'
          end
          object cxItensInsMARID7_NOV: TcxGridDBColumn
            Caption = 'Margem Ideal 7'
            DataBinding.FieldName = 'ITE_MARID7_NOV'
          end
          object cxItensInsQTDPES_NOV: TcxGridDBColumn
            Caption = 'Qtde m'#237'n. estoque para ponta de estoque'
            DataBinding.FieldName = 'ITE_QTDPES_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
            Visible = False
          end
          object cxItensInsPORPES_NOV: TcxGridDBColumn
            Caption = '% de desconto aplicado para ponta de estoque'
            DataBinding.FieldName = 'ITE_PORPES_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
            Visible = False
          end
          object cxItensInsMARCADO: TcxGridDBColumn
            DataBinding.FieldName = 'MARCADO'
            Visible = False
          end
          object cxItensInsPER_CI_NOV: TcxGridDBColumn
            Caption = 'Percentual (CI)'
            DataBinding.FieldName = 'ITE_PER_CI_NOV'
          end
          object cxItensInsNUMFCI_NOV: TcxGridDBColumn
            Caption = 'N'#250'mero da Ficha (FCI)'
            DataBinding.FieldName = 'ITE_NUMFCI_NOV'
          end
          object cxItensInsFATUTR: TcxGridDBColumn
            Caption = 'Fator Convers'#227'o (Unid. Trib)'
            DataBinding.FieldName = 'ITE_FATUTR_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
          end
          object cxItensInsPRAPEL_NOV: TcxGridDBColumn
            Caption = 'Desconto Referente Rapel'
            DataBinding.FieldName = 'ITE_PRAPEL_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
            Visible = False
          end
          object cxItensInsITEEMB_NOV: TcxGridDBColumn
            Caption = 'Desconto Emb. Fechado'
            DataBinding.FieldName = 'ITE_ITEEMB_NOV'
          end
          object cxItensInsCEREPI_NOV: TcxGridDBColumn
            Caption = 'Certificado de Aprova'#231#227'o EPI'
            DataBinding.FieldName = 'ITE_CEREPI_NOV'
          end
          object cxItensInsMARPAD_NOV: TcxGridDBColumn
            Caption = 'Margem Padr'#227'o'
            DataBinding.FieldName = 'ITE_MARPAD_NOV'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Visible = False
          end
          object cxItensInsLIS_TPESTM: TcxGridDBColumn
            Caption = 'Tipo de Estoque M'#237'nimo'
            DataBinding.FieldName = 'LIS_TPESTM'
          end
        end
        object cxItensInsLlv: TcxGridLevel
          GridView = cxItensIns
        end
      end
    end
  end
  object cxgEmbala: TcxGridCitel [3]
    Left = 90
    Top = 348
    Width = 697
    Height = 136
    TabOrder = 2
    Visible = False
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgEmbalaView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      OnFocusedItemChanged = cxgEmbalaViewFocusedItemChanged
      DataController.DataSource = dtsEmbalagens
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgEmbalaCodBar: TcxGridDBColumn
        AlternateCaption = 'cxgEmbalaCodBar'
        Caption = 'C'#243'digo Barras'
        DataBinding.FieldName = 'BAR_CODBAR'
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 105
      end
      object cxgEmbalaDescri: TcxGridDBColumn
        AlternateCaption = 'cxgEmbalaDescri'
        Caption = 'Descri'#231#227'o Embalagem'
        DataBinding.FieldName = 'BAR_DESCRI'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 130
      end
      object cxgEmbalaEmbala: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'BAR_EMBALA'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 61
      end
      object cxgEmbalaPreVen: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda'
        DataBinding.FieldName = 'BAR_PREVEN'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxgEmbalaPrinci: TcxGridDBColumn
        Caption = 'Principal'
        DataBinding.FieldName = 'BAR_PRINCI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 55
      end
      object cxgEmbalaCompra: TcxGridDBColumn
        Caption = 'Principal Compras'
        DataBinding.FieldName = 'BAR_COMPRA'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 92
      end
      object cxgEmbalaExbFat: TcxGridDBColumn
        Caption = 'Exibir Faturamento'
        DataBinding.FieldName = 'BAR_EXBFAT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 95
      end
      object cxgEmbalaCODFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'BAR_CODFOR'
        Width = 63
      end
      object cxgEmbalaViewBAR_ALTURA: TcxGridDBColumn
        Caption = 'Altura'
        DataBinding.FieldName = 'BAR_ALTURA'
      end
      object cxgEmbalaViewBAR_LARGUR: TcxGridDBColumn
        Caption = 'Largura'
        DataBinding.FieldName = 'BAR_LARGUR'
      end
      object cxgEmbalaViewBAR_PROFUN: TcxGridDBColumn
        Caption = 'Profundidade'
        DataBinding.FieldName = 'BAR_PROFUN'
      end
      object cxgEmbalaViewBAR_LASTRO: TcxGridDBColumn
        Caption = 'Lastro'
        DataBinding.FieldName = 'BAR_LASTRO'
      end
      object cxgEmbalaViewBAR_CAMADA: TcxGridDBColumn
        Caption = 'Camada'
        DataBinding.FieldName = 'BAR_CAMADA'
      end
      object cxgEmbalaViewBAR_EMPMAX: TcxGridDBColumn
        Caption = 'Empilhamento M'#225'x.'
        DataBinding.FieldName = 'BAR_EMPMAX'
      end
      object cxgEmbalaViewBAR_PESOBR: TcxGridDBColumn
        Caption = 'Peso Bruto'
        DataBinding.FieldName = 'BAR_PESOBR'
      end
      object cxgEmbalaViewBAR_PESOLQ: TcxGridDBColumn
        Caption = 'Peso L'#237'quido'
        DataBinding.FieldName = 'BAR_PESOLQ'
      end
    end
    object cxgEmbalaLevel1: TcxGridLevel
      GridView = cxgEmbalaView
    end
  end
  object TPanel [4]
    Left = 0
    Top = 593
    Width = 1008
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object lstTabPreco: TCheckListBox
      Left = 513
      Top = 0
      Width = 493
      Height = 51
      Columns = 7
      ItemHeight = 14
      Items.Strings = (
        'Tabela 1'
        'Tabela 2'
        'Tabela 3'
        'Tabela 4'
        'Tabela 5'
        'Tabela 6'
        'Tabela 7')
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 513
      Height = 51
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object btnMarcar: TBitBtnLocked
        Left = 4
        Top = 0
        Width = 167
        Height = 22
        Caption = '[Espa'#231'o]Marcar/Desmarcar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000030000000E000000150000000C0000
          0002000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000200000012072B199C136940FF051E127A0000
          000C000000010000000000000000000000000000000000000000000000000000
          0000000000000000000200000010082D1B9A278B63FF3CB58BFF16623FF4020B
          063D000000060000000000000000000000000000000000000000000000000000
          0000000000020000000E082F1C972C9068FF45C097FF44BF96FF36A67DFF0C46
          2BCE000000150000000200000000000000000000000000000000000000000000
          00010000000C09321F9430966FFF56CAA4FF95E3C8FF7BD7B8FF48C39AFF2A8D
          65FF082B1A8A0000000C00000001000000000000000000000000000000000000
          00060A352190349B75FF7BDBBBFFACE9D3FF4EA07EFF6DB99AFF7DDABBFF4CC4
          9DFF1F7852FC03120B4800000007000000010000000000000000000000000000
          00084B8E60FF99E8CEFF90D0B7FF287F5BEF09281B680E422D9A6EBA9DFF75D9
          B7FF4ABE97FF196747E70209062B000000040000000000000000000000000000
          0003082016494D9063FF14573CB2020B0723000000070000000C135239B280CA
          AEFF71D8B8FF46B691FF135639CA000101140000000200000000000000000000
          0000000000030000000600000005000000020000000000000002010302121A63
          44C28CD3B9FF7ADDBEFF3FAA84FF0D432CA10000000D00000002000000000000
          0000000000000000000000000000000000000000000000000000000000020105
          03151B6748C484CFB3FF81E1C4FF38A27BFF0B34237D00000007000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000101030210175E42B27ECCAFFF97E9D0FF4E9265FF00000009000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000010002010B15573DA5509769FF0822184A00000004000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000100000004000000060000000300000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 0
        OnClick = btnMarcarClick
      end
      object btnMarcAll: TBitBtnLocked
        Left = 174
        Top = 0
        Width = 167
        Height = 22
        Caption = '[F2]Marcar Todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000002000000070000000C0000001000000012000000110000
          000E000000080000000200000000000000000000000000000000000000000000
          000100000004000101120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A53
          3AD20F2F21840001011500000005000000010000000000000000000000000000
          0005050F0A351C5B40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE
          80FF258560FF1A563DD405110C3D00000007000000010000000000000003040E
          0A31206548ED299D74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C9
          96FF32CA99FF2BA479FF227050F805110C3D00000005000000000000000A1A57
          3DD02EA57CFF33CA99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB
          99FF31CB98FF34CC9CFF31AD83FF1B5C41D300010113000000020B23185E2E8A
          66FF3BCD9EFF30CA97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3
          A8FF36CF9FFF33CD9BFF3ED0A3FF319470FF0F32237F00000007184D37B63DB3
          8CFF39CD9FFF4BD5A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4
          A1FF43D5A8FF3ED3A4FF3CD1A4FF41BC95FF1B5C43CD0000000B1C6446DF4BCA
          A4FF44D2A8FF4FB392FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B75
          4FFF60DCB8FF48D8ACFF47D6AAFF51D4ACFF247A58F80000000E217050F266D9
          B8FF46D3A8FF0B6741FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A2
          8BFF46A685FF5EDFBAFF4CD9AFFF6BE2C2FF278460FF020604191E684ADC78D9
          BEFF52DAB1FF3DBA92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EA
          E7FF4F886CFF5ABB9AFF5BDEB9FF7FE2C7FF27835FF80000000C19523BAB77C8
          B0FF62E0BCFF56DDB7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E
          76FFE6E1DCFF176B47FF5FD8B4FF83D5BDFF1E674CC60000000909201747439C
          7BFF95ECD6FF5ADFBAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A1
          7EFF1F6D4AFF288B64FF98EFD9FF4DAC8CFF1036286D00000004000000041C5F
          46B578C6ADFF9AEED9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEA
          C9FF5ED6B6FF97EDD7FF86D3BBFF237759D20102010C0000000100000001030A
          0718247B5BDA70C1A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2
          DDFFBAF4E7FF78CDB3FF2A906DEA0615102E0000000200000000000000000000
          0001030A07171E694FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8
          C1FF4BB692FF237F60CB05130E27000000030000000000000000000000000000
          000000000001000000030A241B411B60489D258464CF2C9D77EE258867CF1F71
          56B00E3226560000000600000002000000000000000000000000}
        TabOrder = 1
        OnClick = btnMarcAllClick
      end
      object btnDesmAll: TBitBtnLocked
        Left = 344
        Top = 0
        Width = 167
        Height = 22
        Caption = '[F3]Desmarcar Todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000C05031A46110852AB190C76E31D0E89FF1C0E89FF190C
          76E4120852AD06031B4D0000000E000000030000000000000000000000000000
          000301010519130A55A9211593FF2225AEFF2430C2FF2535CBFF2535CCFF2430
          C3FF2225AFFF211594FF140B58B20101051E0000000400000000000000020101
          03151C1270CD2522A6FF2D3DCCFF394BD3FF3445D1FF2939CDFF2839CDFF3344
          D0FF394AD4FF2D3CCDFF2523A8FF1C1270D20101051D00000003000000091912
          5BA72A27AAFF2F41D0FF3541C7FF2726ABFF3137BCFF384AD3FF384BD3FF3137
          BCFF2726ABFF3540C7FF2E40D0FF2927ACFF1A115EB10000000D08061C3D3129
          A2FD2C3CCCFF3842C6FF5F5DBDFFEDEDF8FF8B89CEFF3337B9FF3437B9FF8B89
          CEFFEDEDF8FF5F5DBDFF3741C6FF2B3ACDFF3028A4FF0907204A1E185F9F373B
          BCFF3042D0FF2621A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
          EDFFF3E9E2FFECE6EBFF2621A5FF2E3FCFFF343ABEFF201A66B0312A92E03542
          CBFF3446D1FF2C2FB5FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
          E2FFEADAD1FF7F6FACFF2B2EB5FF3144D0FF3040CBFF312A95E53E37AEFA3648
          D0FF374AD3FF3A4ED5FF3234B4FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
          E5FF897DB8FF3233B4FF384BD3FF3547D2FF3446D1FF3E37AEFA453FB4FA4557
          D7FF3B50D5FF4C5FDAFF4343B7FF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
          E8FF9087C5FF4242B7FF495DD8FF394CD4FF3F52D4FF443FB3FA403DA1DC5967
          DAFF5B6EDDFF4F4DBAFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
          EAFFFAF5F2FF8F89CAFF4E4DB9FF576ADCFF5765D9FF403EA4E12E2D70987C85
          DDFF8798E8FF291D9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
          D8FFF4ECE7FFE5D9DCFF291D9BFF8494E7FF7A81DDFF33317BAC111125356768
          D0FC9EACEDFF686FCEFF5646A1FFCCB6BCFF7A68A8FF4C4AB6FF4D4BB7FF7A68
          A8FFCBB5BCFF5646A1FF666DCCFF9BAAEEFF696CD0FD1212273F000000043B3B
          79977D84DFFFA5B6F1FF6D74D0FF2D219BFF5151B9FF8EA2ECFF8EA1ECFF5252
          BBFF2D219BFF6B72D0FFA2B3F0FF8086E0FF404183A700000008000000010303
          050C4E509DBC8087E2FFAEBDF3FFA3B6F1FF9DAFF0FF95A9EEFF95A8EEFF9BAD
          EFFFA2B3F0FFACBCF3FF838AE3FF4F52A0C10303051100000002000000000000
          000100000005323464797378D9F8929CEAFFA1AEEFFFB0BFF3FFB0BFF4FFA2AE
          EFFF939DE9FF7479DAF83234647D000000080000000200000000000000000000
          000000000000000000031213232D40437D935D61B5D07378DFFC7378DFFC5D61
          B5D040437D951212223000000004000000010000000000000000}
        TabOrder = 2
        OnClick = btnDesmAllClick
      end
    end
    object btnAlterarMargens: TBitBtnLocked
      Left = 833
      Top = 2
      Width = 170
      Height = 22
      Caption = 'Alterar Margens'
      TabOrder = 2
      OnClick = btnAlterarMargensClick
    end
    object btnAlterarPrecosVenda: TBitBtnLocked
      Left = 833
      Top = 24
      Width = 170
      Height = 22
      Caption = 'Alterar Pre'#231'os de Venda'
      TabOrder = 3
      OnClick = btnAlterarPrecosVendaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 232
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 48
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
    Top = 104
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    OnGetValue = frxGenGetValue
    Left = 136
    Top = 232
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 64
    Top = 200
  end
  object dtsDados: TDataSource
    Left = 336
    Top = 72
  end
  object frxRepNaoImp: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42164.690826412040000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '{*  if <frxRelatorio."DESEXC"> = '#39#39' then'
      
        '    chdObservacao.Visible := False                              ' +
        '    '
      '  else'
      '    chdObservacao.Visible := True;'
      
        '  mmoZebra2.Visible := not mmoZebra2.Visible;*}                 ' +
        '                                                                ' +
        '                            '
      'end;'
      ''
      'procedure chdObservacaoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '//  mmoZebra2.Color := mmoZebra.Color  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 200
    Top = 232
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 296.862308280000000000
      PaperHeight = 203.199868770000000000
      PaperSize = 256
      LeftMargin = 4.497913761764030000
      RightMargin = 4.497913761764030000
      TopMargin = 2.539998359584390000
      BottomMargin = 2.539998359584390000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 26.456710000000000000
        ParentFont = False
        Top = 196.535560000000000000
        Width = 1088.000000013508000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1088.000000013508000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          UseDefaultCharset = True
        end
        object Memo2: TfrxMemoView
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]')
        end
        object Memo3: TfrxMemoView
          Left = 45.354330710000000000
          Width = 86.929150940000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."ITE_CODBAR_NOV"> = '#39#39', <frxRelatorio."ITE_CO' +
              'DBAR">, <frxRelatorio."ITE_CODBAR_NOV">)]')
        end
        object Memo7: TfrxMemoView
          Left = 136.440944880000000000
          Width = 49.133855830000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."ITE_CODFOR_NOV"> = '#39#39', <frxRelatorio."ITE_CO' +
              'DFOR">, <frxRelatorio."ITE_CODFOR_NOV">)]')
        end
        object Memo8: TfrxMemoView
          Left = 189.732283460000000000
          Width = 83.149616060000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."ITE_CODFAB_NOV"> = '#39#39', <frxRelatorio."ITE_CO' +
              'DFAB">, <frxRelatorio."ITE_CODFAB_NOV">)]')
        end
        object Memo17: TfrxMemoView
          Left = 277.039370080000000000
          Width = 47.244094490000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESF01_NOV"]')
        end
        object Memo18: TfrxMemoView
          Left = 327.685039370000000000
          Width = 47.244094490000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESF02_NOV"]')
        end
        object Memo19: TfrxMemoView
          Left = 378.708661420000000000
          Width = 47.244094490000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESF03_NOV"]')
        end
        object Memo20: TfrxMemoView
          Left = 430.866141730000000000
          Width = 47.244094490000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESF04_NOV"]')
        end
        object Memo21: TfrxMemoView
          Left = 481.889763780000000000
          Width = 47.244094490000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESF05_NOV"]')
        end
        object Memo22: TfrxMemoView
          Left = 532.535433070000000000
          Width = 47.244094490000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESF06_NOV"]')
        end
        object Memo23: TfrxMemoView
          Left = 583.559055120000000000
          Width = 39.685039370000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_ICMENT_NOV"]')
        end
        object Memo36: TfrxMemoView
          Left = 866.267716540000000000
          Width = 43.464566930000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESADB_NOV"]')
        end
        object Memo37: TfrxMemoView
          Left = 913.889763780000000000
          Width = 32.125984250000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_OUTVAL_NOV"]')
        end
        object Memo38: TfrxMemoView
          Left = 949.039370080000000000
          Width = 35.905511810000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_ICMSAI_NOV"]')
        end
        object Memo39: TfrxMemoView
          Left = 988.346456690000000000
          Width = 51.023622050000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SUBFED_NOV"]')
        end
        object Memo40: TfrxMemoView
          Left = 1042.771653540000000000
          Width = 43.464566930000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESOPE_NOV"]')
        end
        object Memo41: TfrxMemoView
          Left = 627.023622050000000000
          Width = 39.685039370000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_IMPFED_NOV"]')
        end
        object Memo42: TfrxMemoView
          Left = 669.732283460000000000
          Width = 32.125984250000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_IPIENT_NOV"]')
        end
        object Memo43: TfrxMemoView
          Left = 704.881889760000000000
          Width = 32.125984250000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_FREENT_NOV"]')
        end
        object Memo44: TfrxMemoView
          Left = 740.409448820000000000
          Width = 39.685039370000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_VALFRE_NOV"]')
        end
        object Memo45: TfrxMemoView
          Left = 783.874015750000000000
          Width = 39.685039370000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_ACRFIN_NOV"]')
        end
        object Memo46: TfrxMemoView
          Left = 826.960629920000000000
          Width = 35.905511810000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SUBSTI_NOV"]')
        end
        object Memo47: TfrxMemoView
          Left = 1.779530000000000000
          Top = 12.338590000000010000
          Width = 1080.945548270000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."DESEXC"]')
        end
        object Line1: TfrxLineView
          Align = baBottom
          Top = 26.456710000000000000
          Width = 1088.504640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Width = 1088.504640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 283.464750000000000000
        Width = 1088.000000013508000000
        object rllTotalImpresso: TfrxMemoView
          Left = 729.978170000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object rllNomeForm: TfrxMemoView
          Top = 15.118119999999980000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial Unicode MS'
        Font.Style = [fsBold]
        Height = 13.984254410000000000
        ParentFont = False
        Top = 158.740260000000000000
        Width = 1088.000000013508000000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Align = baClient
          Width = 1088.000000013508000000
          Height = 13.984254410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial Unicode MS'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 45.354360000000000000
          Width = 86.929094800000000000
          Height = 13.228348900000000000
          Memo.UTF8W = (
            'C'#211'D.BARRAS')
        end
        object Memo6: TfrxMemoView
          Left = 136.401528430000000000
          Width = 49.133794800000000000
          Height = 13.228348900000000000
          Memo.UTF8W = (
            'C'#211'D.FORN')
        end
        object Memo9: TfrxMemoView
          Left = 189.756030000000000000
          Width = 83.149564800000000000
          Height = 13.228348900000000000
          Memo.UTF8W = (
            'C'#211'D.FABRICA')
        end
        object Memo10: TfrxMemoView
          Left = 277.023810000000000000
          Width = 47.244099370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DES FOR 1')
        end
        object Memo16: TfrxMemoView
          Left = 583.488560000000000000
          Width = 39.685039370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'ICMS (+)')
        end
        object Memo25: TfrxMemoView
          Left = 626.842920000000000000
          Width = 39.685039370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'IMP. FED')
        end
        object Memo26: TfrxMemoView
          Left = 669.756340000000000000
          Width = 32.125979370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'IPI (+)')
        end
        object Memo27: TfrxMemoView
          Left = 704.992580000000000000
          Width = 32.125979370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'FRETE')
        end
        object Memo28: TfrxMemoView
          Left = 740.567410000000000000
          Width = 39.685039370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR. FRE')
        end
        object Memo29: TfrxMemoView
          Left = 783.921770000000000000
          Width = 39.685039370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'ACR.FIN.')
        end
        object Memo30: TfrxMemoView
          Left = 826.937540000000000000
          Width = 35.905509370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'SUB.TRI.')
        end
        object Memo31: TfrxMemoView
          Left = 866.394250000000000000
          Width = 43.464569370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DES.ADC.')
        end
        object Memo4: TfrxMemoView
          Width = 41.574830000000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'C'#211'DIGO')
        end
        object Memo11: TfrxMemoView
          Left = 327.598640000000000000
          Width = 47.244089610000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DES FOR 2')
        end
        object Memo12: TfrxMemoView
          Left = 378.732530000000000000
          Width = 47.244089610000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DES FOR 3')
        end
        object Memo13: TfrxMemoView
          Left = 430.748300000000000000
          Width = 47.244089610000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DES FOR 4')
        end
        object Memo14: TfrxMemoView
          Left = 481.779840000000000000
          Width = 47.244089610000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DES FOR 5')
        end
        object Memo15: TfrxMemoView
          Left = 532.472790000000000000
          Width = 47.244089610000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DES FOR 6')
        end
        object Memo32: TfrxMemoView
          Left = 913.866730000000000000
          Width = 32.125979370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'OUTR.')
        end
        object Memo33: TfrxMemoView
          Left = 949.102970000000000000
          Width = 35.905509370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'ICMS (-)')
        end
        object Memo34: TfrxMemoView
          Left = 988.457330000000000000
          Width = 51.023629370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'IMP.FED (-)')
        end
        object Memo35: TfrxMemoView
          Left = 1042.929810000000000000
          Width = 43.464569370000000000
          Height = 13.228348900000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DES. OP.')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 77.425170000000000000
        Top = 18.897650000000000000
        Width = 1088.000000013508000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 179.200000006754200000
          Top = 9.440940000000001000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 299.200000006754200000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 969.978170000001900000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 1017.978170000002000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 893.178170000002000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
    end
  end
  object dtsDadosIns: TDataSource
    Left = 408
    Top = 80
  end
  object frxItensInsert: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43027.590798541660000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '{*  if <frxRelatorio."DESEXC"> = '#39#39' then'
      
        '    chdObservacao.Visible := False                              ' +
        '    '
      '  else'
      '    chdObservacao.Visible := True;'
      
        '  mmoZebra2.Visible := not mmoZebra2.Visible;*}                 ' +
        '                                                                ' +
        '                            '
      'end;'
      ''
      'procedure chdObservacaoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '//  mmoZebra2.Color := mmoZebra.Color  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 400
    Top = 240
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 203.199868770000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 37.779530000000000000
        Top = 283.464750000000000000
        Width = 748.800000012278100000
        object rllTotalImpresso: TfrxMemoView
          Left = 386.040940000000000000
          Top = 15.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object rllNomeForm: TfrxMemoView
          Top = 15.118119999999980000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 77.425170000000000000
        Top = 18.897650000000000000
        Width = 748.800000012278100000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 9.600000006139060000
          Top = 9.440940000000001000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 129.600000006139100000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 969.978170000002000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 1017.978170000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 893.178170000002000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object Line1: TfrxLineView
        Align = baBottom
        Top = 1088.000000013508000000
        Width = 1088.504640000000000000
        Color = clBlack
        Frame.Typ = [ftTop]
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 158.740260000000000000
        Width = 748.800000012278100000
        object Memo5: TfrxMemoView
          Left = 83.149660000000000000
          Top = 3.779529999999994000
          Width = 113.385804800000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D.BARRAS')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 200.692913385826800000
          Top = 3.779529999999994000
          Width = 79.370034800000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D.FORN')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 284.220472440944900000
          Top = 3.779529999999994000
          Width = 166.299224800000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D.FABRICA')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999994000
          Width = 52.913420000000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 457.700787401574800000
          Top = 3.779529999999994000
          Width = 291.023714800000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 204.094620000000000000
        Width = 748.800000012278100000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Left = 0.779530000000000000
          Width = 748.346940000000000000
          Height = 15.118120000000000000
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 83.149630710000000000
          Top = 1.000000000000000000
          Width = 113.385860940000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODBAR_NOV"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 200.692913390000000000
          Top = 1.000000000000000000
          Width = 75.590565830000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFOR_NOV"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 284.220472440000000000
          Top = 1.000000000000000000
          Width = 162.519746060000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB_NOV"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 457.700787400000000000
          Top = 1.000000000000057000
          Width = 287.244236060000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE_NOV"]')
          ParentFont = False
        end
      end
    end
  end
  object dtsEmbalagens: TDataSource
    Left = 556
    Top = 204
  end
  object frxRelatorioPrecComReduzido: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44418.679155590270000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '{*  if <frxRelatorio."DESEXC"> = '#39#39' then'
      
        '    chdObservacao.Visible := False                              ' +
        '    '
      '  else'
      '    chdObservacao.Visible := True;'
      
        '  mmoZebra2.Visible := not mmoZebra2.Visible;*}                 ' +
        '                                                                ' +
        '                            '
      'end;'
      ''
      'procedure chdObservacaoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '//  mmoZebra2.Color := mmoZebra.Color  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxRelatorioPrecComReduzidoUserFunction
    Left = 544
    Top = 272
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 296.862308280000000000
      PaperHeight = 203.199868770000000000
      PaperSize = 256
      LeftMargin = 4.497913761764030000
      RightMargin = 4.497913761764030000
      TopMargin = 2.539998359584390000
      BottomMargin = 2.539998359584390000
      ColumnWidth = 2.539998359584390000
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 37.779530000000000000
        Top = 283.464750000000000000
        Width = 1088.000000013508000000
        object rllTotalImpresso: TfrxMemoView
          Left = 727.040940000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object rllNomeForm: TfrxMemoView
          Left = 6.000000000000000000
          Top = 17.118119999999980000
          Width = 728.518120000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 77.425170000000000000
        Top = 18.897650000000000000
        Width = 1088.000000013508000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 179.200000006754200000
          Top = 9.440940000000001000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 299.200000006754200000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 969.978170000002000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 1017.978170000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 893.178170000002000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object Line1: TfrxLineView
        Align = baBottom
        Top = 748.800000012278100000
        Width = 1088.504640000000000000
        Color = clBlack
        Frame.Typ = [ftTop]
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 21.543294880000000000
        Top = 158.740260000000000000
        Width = 1088.000000013508000000
        object Memo46: TfrxMemoView
          Align = baClient
          Width = 1088.000000013508000000
          Height = 21.543294880000000000
          Fill.BackColor = clScrollBar
        end
        object Shape1: TfrxShapeView
          Left = 0.866139290000000000
          Top = 2.157480310000011000
          Width = 1086.992128430000000000
          Height = 18.897650000000000000
        end
        object Memo5: TfrxMemoView
          Left = 79.482993330000000000
          Top = 3.890641109999990000
          Width = 205.047214800000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O DO ITEM')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 292.294026720000000000
          Top = 3.890641109999990000
          Width = 64.251914800000030000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D.FORN')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 364.482995769999900000
          Top = 3.890641109999990000
          Width = 221.519694800000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO FORNECEDOR')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 4.112863330000000000
          Top = 3.890641109999990000
          Width = 67.795300000000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 593.656260729999900000
          Top = 3.890641109999990000
          Width = 94.126064800000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PRE. DE COMPRA')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 697.230983330000000000
          Top = 4.370851109999990000
          Width = 79.007944800000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PRE. DE CUSTO')
          ParentFont = False
        end
        object memHederMargem: TfrxMemoView
          Left = 784.372603330000000000
          Top = 4.370851109999990000
          Width = 56.007944800000000000
          Height = 14.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARGEM')
          ParentFont = False
        end
        object memHeaderPrev: TfrxMemoView
          Left = 846.900123330000000000
          Top = 5.370851109999990000
          Width = 84.228414800000000000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PRE. DE VENDA')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 936.608843330000000000
          Top = 5.268501109999988000
          Width = 52.228414799999990000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 1000.608843330000000000
          Top = 5.268501109999988000
          Width = 80.567004800000010000
          Height = 13.228348900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA ULT. COMP.')
          ParentFont = False
        end
        object Line8: TfrxLineView
          Left = 77.333333330000000000
          Top = 2.511811020000010000
          Height = 18.897637795275600000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 288.333333330000000000
          Top = 2.511811020000010000
          Height = 18.897637795275600000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 360.215213330000000000
          Top = 2.511811020000010000
          Height = 18.897637800000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 591.215213330000000000
          Top = 2.511811020000010000
          Height = 18.897637800000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 692.215213330000000000
          Top = 2.511811020000010000
          Height = 18.897637800000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line14: TfrxLineView
          Left = 778.876623330000000000
          Top = 2.511811020000010000
          Height = 18.897637800000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 843.876623330000000000
          Top = 2.511811020000010000
          Height = 18.897637800000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line2: TfrxLineView
          Left = 934.000000000000000000
          Top = 2.259739999999994000
          Height = 18.897637800000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line3: TfrxLineView
          Left = 995.000000000000000000
          Top = 2.259739999999994000
          Height = 18.897637800000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 20.073670000000000000
        Top = 204.094620000000000000
        Width = 1088.000000013508000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo45: TfrxMemoView
          Left = 2.440940000000000000
          Top = 0.448669999999992800
          Width = 1084.971940000000000000
          Height = 19.624999999999990000
        end
        object Shape2: TfrxShapeView
          Left = 0.755905510000000000
          Top = 1.228199999999987000
          Width = 1086.992125980000000000
          Height = 18.897637800000000000
        end
        object mmoZebra: TfrxMemoView
          Left = 4.000000000000000000
          Top = 4.220470000000006000
          Width = 1080.346940000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 4.220470000000000000
          Top = 4.220470000000006000
          Width = 59.795300000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 80.590600000000000000
          Top = 4.220470000000006000
          Width = 202.606330940000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."ITE_DESITE_NOV"> = '#39#39', <frxRelatorio."ITE_DE' +
              'SITE">, <frxRelatorio."ITE_DESITE_NOV">)]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 293.401633390000000000
          Top = 4.220470000000006000
          Width = 62.370095830000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."ITE_CODFOR_NOV"> = '#39#39', <frxRelatorio."ITE_CO' +
              'DFOR">, <frxRelatorio."ITE_CODFOR_NOV">)]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 365.590602440000000000
          Top = 4.220470000000006000
          Width = 221.740216060000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[fRetFornecedor(<frxRelatorio."ITE_CODFOR">, <frxRelatorio."ITE_' +
              'CODFOR_NOV">)]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 596.763816140000000000
          Top = 4.220470000000006000
          Width = 87.126116060000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."ITE_PRECOM_NOV"> > 0, <frxRelatorio."ITE_PRE' +
              'COM_NOV">, <frxRelatorio."ITE_PRECOM">)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 699.897598740000000000
          Top = 4.220470000000006000
          Width = 75.448936060000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."ITE_PRECUS_NOV"> > 0, <frxRelatorio."ITE_PRE' +
              'CUS_NOV">, <frxRelatorio."ITE_PRECUS">)]')
          ParentFont = False
        end
        object memPreVen: TfrxMemoView
          Left = 849.527468740000000000
          Top = 4.220470000000006000
          Width = 77.889876060000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 933.685220000000000000
          Top = 5.220470000000006000
          Width = 58.992226060000000000
          Height = 14.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
        end
        object Line52: TfrxLineView
          Left = 591.215213330000000000
          Top = 3.228199999999987000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo20: TfrxMemoView
          Left = 1002.000000000000000000
          Top = 5.220470000000006000
          Width = 82.653636060000000000
          Height = 14.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DTAULT"]')
          ParentFont = False
        end
        object Line49: TfrxLineView
          Left = 78.440940000000000000
          Top = 3.228199999999987000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line50: TfrxLineView
          Left = 289.440940000000000000
          Top = 3.228199999999987000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line51: TfrxLineView
          Left = 360.215213330000000000
          Top = 3.228199999999987000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line53: TfrxLineView
          Left = 692.215213330000000000
          Top = 3.228199999999987000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line54: TfrxLineView
          Left = 778.876623330000000000
          Top = 3.228199999999987000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line55: TfrxLineView
          Left = 996.385900000000600000
          Top = 3.228199999999987000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object memMargem: TfrxMemoView
          Left = 783.000000000000000000
          Top = 4.220470000000006000
          Width = 58.992226060000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 843.876623330000000000
          Top = 3.007730000000010000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 934.000000000000000000
          Top = 2.007730000000009000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
    end
  end
  object cdsItensInseridos: TUniClientDataSet
    PersistDataPacket.Data = {
      860000009619E0BD010000001800000004000000000003000000860006434F44
      464F52010049000000010005574944544802000200080006434F444641420100
      4900000001000557494454480200020046000644455349544501004900000001
      0005574944544802000200460006434F44424152010049000000010005574944
      54480200020014000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODFOR'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'CODFAB'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'DESITE'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'CODBAR'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 496
    Top = 352
    object cdsItensInseridosCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 8
    end
    object cdsItensInseridosCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 70
    end
    object cdsItensInseridosDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensInseridosCODBAR: TStringField
      FieldName = 'CODBAR'
    end
  end
  object dtsEmbDescFech: TDataSource
    Left = 700
    Top = 188
  end
end
