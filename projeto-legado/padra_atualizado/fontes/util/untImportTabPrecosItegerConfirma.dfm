inherited frmImportTabPrecosItegerConfirma: TfrmImportTabPrecosItegerConfirma
  Width = 1071
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Importa'#231#227'o Tabela de Pre'#231'os - Confirma'#231#227'o'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1071
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 1055
    ExplicitTop = 519
    ExplicitWidth = 1055
    inherited FlwBotoes: TFlowPanel
      Width = 1051
      ExplicitWidth = 1051
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 968
      Top = 2
      TabOrder = 2
      ExplicitLeft = 968
      ExplicitTop = 2
    end
    object btnVisProdNaoImp: TBitBtnLocked
      Left = 77
      Top = 2
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
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1055
    ExplicitTop = 545
    ExplicitWidth = 1055
    inherited pnlNomeForm: TPanel
      Left = 884
      ExplicitLeft = 884
    end
    inherited pnlInfo: TPanel
      Width = 884
      ExplicitWidth = 884
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1055
    Height = 456
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir o filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
    end
    object cxgItensDBBandedTableView: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensDBBandedTableViewCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      OptionsView.GroupByBox = False
      Bands = <
        item
          Caption = 'Informa'#231#245'es b'#225'sicas'
          FixedKind = fkLeft
          Options.Moving = False
          Options.Sizing = False
        end
        item
          Caption = 'Valores'
        end>
      object cxgItensViewMARCADO: TcxGridDBBandedColumn
        Caption = 'Sel.'
        DataBinding.FieldName = 'MARCADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Width = 34
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensViewCodIte: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        BestFitMaxWidth = 20
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 60
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensViewDesIte: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DesIte'
        Options.Editing = False
        Width = 228
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensViewCodFab: TcxGridDBBandedColumn
        Caption = 'C'#243'd. Fabr.'
        DataBinding.FieldName = 'CodFab'
        Options.Editing = False
        Width = 111
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensViewDESF01: TcxGridDBBandedColumn
        Caption = 'Desconto 01(Atual)'
        DataBinding.FieldName = 'ITE_DESF01'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensViewDESF01_NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 01(Novo)'
        DataBinding.FieldName = 'ITE_DESF01_NOV'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensViewDESF02: TcxGridDBBandedColumn
        Caption = 'Desconto 02(Atual)'
        DataBinding.FieldName = 'ITE_DESF02'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensViewDESF02_NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 02(Novo)'
        DataBinding.FieldName = 'ITE_DESF02_NOV'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensViewDESF03: TcxGridDBBandedColumn
        Caption = 'Desconto 03(Atual)'
        DataBinding.FieldName = 'ITE_DESF03'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensViewDESF03_NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 03(Novo)'
        DataBinding.FieldName = 'ITE_DESF03_NOV'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensViewDESF04: TcxGridDBBandedColumn
        Caption = 'Desconto 04(Atual)'
        DataBinding.FieldName = 'ITE_DESF04'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensViewDESF04_NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 04(Novo)'
        DataBinding.FieldName = 'ITE_DESF04_NOV'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgItensViewDESF05: TcxGridDBBandedColumn
        Caption = 'Desconto 05(Atual)'
        DataBinding.FieldName = 'ITE_DESF05'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgItensViewDESF05_NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 05(Novo)'
        DataBinding.FieldName = 'ITE_DESF05_NOV'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxgItensViewDESF06: TcxGridDBBandedColumn
        Caption = 'Desconto 06(Atual)'
        DataBinding.FieldName = 'ITE_DESF06'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxgItensViewDESF06_NOV: TcxGridDBBandedColumn
        Caption = 'Desconto 06(Novo)'
        DataBinding.FieldName = 'ITE_DESF06_NOV'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxgItensViewICMENT: TcxGridDBBandedColumn
        Caption = 'ICMS Entrada(Atual)'
        DataBinding.FieldName = 'ITE_ICMENT'
        Options.Editing = False
        Width = 110
        Position.BandIndex = 1
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxgItensViewICMENT_NOV: TcxGridDBBandedColumn
        Caption = 'ICMS Entrada(Novo)'
        DataBinding.FieldName = 'ITE_ICMENT_NOV'
        Options.Editing = False
        Width = 110
        Position.BandIndex = 1
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxgItensViewIMPFED: TcxGridDBBandedColumn
        Caption = 'Impostos Federais(Atual)'
        DataBinding.FieldName = 'ITE_IMPFED'
        Options.Editing = False
        Width = 130
        Position.BandIndex = 1
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxgItensViewIMPFED2: TcxGridDBBandedColumn
        Caption = 'Impostos Federais(Novo)'
        DataBinding.FieldName = 'ITE_IMPFED_NOV'
        Options.Editing = False
        Width = 130
        Position.BandIndex = 1
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxgItensViewIPIEnt: TcxGridDBBandedColumn
        Caption = 'IPI(Atual)'
        DataBinding.FieldName = 'ITE_IPIENT'
        Options.Editing = False
        Width = 55
        Position.BandIndex = 1
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxgItensViewIpiEnt_NOV: TcxGridDBBandedColumn
        Caption = 'IPI(Novo)'
        DataBinding.FieldName = 'ITE_IPIENT_NOV'
        Options.Editing = False
        Width = 55
        Position.BandIndex = 1
        Position.ColIndex = 17
        Position.RowIndex = 0
      end
      object cxgItensViewFreEnt: TcxGridDBBandedColumn
        Caption = 'Frete %(Atual)'
        DataBinding.FieldName = 'ITE_FREENT'
        Options.Editing = False
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 18
        Position.RowIndex = 0
      end
      object cxgItensViewFreEnt_NOV: TcxGridDBBandedColumn
        Caption = 'Frete %(Novo)'
        DataBinding.FieldName = 'ITE_FREENT_NOV'
        Options.Editing = False
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 19
        Position.RowIndex = 0
      end
      object cxgItensViewValFre: TcxGridDBBandedColumn
        Caption = 'Valor Frete(Atual)'
        DataBinding.FieldName = 'ITE_VALFRE'
        Options.Editing = False
        Width = 95
        Position.BandIndex = 1
        Position.ColIndex = 20
        Position.RowIndex = 0
      end
      object cxgItensViewValFre_NOV: TcxGridDBBandedColumn
        Caption = 'Valor Frete(Novo)'
        DataBinding.FieldName = 'ITE_VALFRE_NOV'
        Options.Editing = False
        Width = 95
        Position.BandIndex = 1
        Position.ColIndex = 21
        Position.RowIndex = 0
      end
      object cxgItensViewACRFIN: TcxGridDBBandedColumn
        Caption = 'Acr.Financ.(Atual)'
        DataBinding.FieldName = 'ITE_ACRFIN'
        Options.Editing = False
        Width = 97
        Position.BandIndex = 1
        Position.ColIndex = 22
        Position.RowIndex = 0
      end
      object cxgItensViewACRFIN_NOV: TcxGridDBBandedColumn
        Caption = 'Acr.Financ.(Novo)'
        DataBinding.FieldName = 'ITE_ACRFIN_NOV'
        Options.Editing = False
        Width = 97
        Position.BandIndex = 1
        Position.ColIndex = 23
        Position.RowIndex = 0
      end
      object cxgItensViewSUBSTI: TcxGridDBBandedColumn
        Caption = 'Sub. Tribut'#225'ria(Atual)'
        DataBinding.FieldName = 'ITE_SUBSTI'
        Options.Editing = False
        Width = 115
        Position.BandIndex = 1
        Position.ColIndex = 24
        Position.RowIndex = 0
      end
      object cxgItensViewSUBSTI_NOV: TcxGridDBBandedColumn
        Caption = 'Sub. Tribut'#225'ria(Novo)'
        DataBinding.FieldName = 'ITE_SUBSTI_NOV'
        Options.Editing = False
        Width = 115
        Position.BandIndex = 1
        Position.ColIndex = 25
        Position.RowIndex = 0
      end
      object cxgItensViewDESADB: TcxGridDBBandedColumn
        Caption = 'Desc. Adc. (Atual)'
        DataBinding.FieldName = 'ITE_DESADB'
        Options.Editing = False
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 26
        Position.RowIndex = 0
      end
      object cxgItensViewDESADB_NOV: TcxGridDBBandedColumn
        Caption = 'Desc. Adc. (Novo)'
        DataBinding.FieldName = 'ITE_DESADB_NOV'
        Options.Editing = False
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 27
        Position.RowIndex = 0
      end
      object cxgItensViewTCIFCU: TcxGridDBBandedColumn
        Caption = 'TCIF(Atual)'
        DataBinding.FieldName = 'ITE_TCIFCU'
        Visible = False
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 28
        Position.RowIndex = 0
      end
      object cxgItensViewTCIFCU_NOV: TcxGridDBBandedColumn
        Caption = 'TCIF(Novo)'
        DataBinding.FieldName = 'ITE_TCIFCU_NOV'
        Visible = False
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 29
        Position.RowIndex = 0
      end
      object cxgItensViewTSCUST: TcxGridDBBandedColumn
        Caption = 'TS(Atual)'
        DataBinding.FieldName = 'ITE_TSCUST'
        Visible = False
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 30
        Position.RowIndex = 0
      end
      object cxgItensViewTSCUST_NOV: TcxGridDBBandedColumn
        Caption = 'TS(Novo)'
        DataBinding.FieldName = 'ITE_TSCUST_NOV'
        Visible = False
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 31
        Position.RowIndex = 0
      end
      object cxgItensViewDEPICO: TcxGridDBBandedColumn
        Caption = 'Desconto PIS/COFINS(Atual)'
        DataBinding.FieldName = 'ITE_DEPICO'
        Visible = False
        Options.Editing = False
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 32
        Position.RowIndex = 0
      end
      object cxgItensViewDEPICO_NOV: TcxGridDBBandedColumn
        Caption = 'Desconto PIS/COFINS(Novo)'
        DataBinding.FieldName = 'ITE_DEPICO_NOV'
        Visible = False
        Options.Editing = False
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 33
        Position.RowIndex = 0
      end
      object cxgItensViewDEICMS: TcxGridDBBandedColumn
        Caption = 'Desconto ICMS(Atual)'
        DataBinding.FieldName = 'ITE_DEICMS'
        Visible = False
        Options.Editing = False
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 34
        Position.RowIndex = 0
      end
      object cxgItensViewDEICMS_NOV: TcxGridDBBandedColumn
        Caption = 'Desconto ICMS(Novo)'
        DataBinding.FieldName = 'ITE_DEICMS_NOV'
        Visible = False
        Options.Editing = False
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 35
        Position.RowIndex = 0
      end
      object cxgItensViewFATREG: TcxGridDBBandedColumn
        Caption = 'Fator Regional(Atual)'
        DataBinding.FieldName = 'ITE_FATREG'
        Visible = False
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 36
        Position.RowIndex = 0
      end
      object cxgItensViewFATREG_NOV: TcxGridDBBandedColumn
        Caption = 'Fator Regional(Novo)'
        DataBinding.FieldName = 'ITE_FATREG_NOV'
        Visible = False
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 37
        Position.RowIndex = 0
      end
      object cxgItensViewICMSAI: TcxGridDBBandedColumn
        Caption = 'ICMS Sa'#237'da(Atual)'
        DataBinding.FieldName = 'ITE_ICMSAI'
        Options.Editing = False
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 38
        Position.RowIndex = 0
      end
      object cxgItensViewICMSAI_NOV: TcxGridDBBandedColumn
        Caption = 'ICMS Sa'#237'da(Novo)'
        DataBinding.FieldName = 'ITE_ICMSAI_NOV'
        Options.Editing = False
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 39
        Position.RowIndex = 0
      end
      object cxgItensViewSUBFED: TcxGridDBBandedColumn
        Caption = 'Impostos Fed. (-)(Atual)'
        DataBinding.FieldName = 'ITE_SUBFED'
        Options.Editing = False
        Width = 130
        Position.BandIndex = 1
        Position.ColIndex = 40
        Position.RowIndex = 0
      end
      object cxgItensViewSUBFED_NOV: TcxGridDBBandedColumn
        Caption = 'Impostos Fed. (-)(Novo)'
        DataBinding.FieldName = 'ITE_SUBFED_NOV'
        Options.Editing = False
        Width = 130
        Position.BandIndex = 1
        Position.ColIndex = 41
        Position.RowIndex = 0
      end
      object cxgItensViewOUTVAL: TcxGridDBBandedColumn
        Caption = 'Outros Valores(Atual)'
        DataBinding.FieldName = 'ITE_OUTVAL'
        Options.Editing = False
        Width = 120
        Position.BandIndex = 1
        Position.ColIndex = 42
        Position.RowIndex = 0
      end
      object cxgItensViewOUTVAL_NOV: TcxGridDBBandedColumn
        Caption = 'Outros Valores(Novo)'
        DataBinding.FieldName = 'ITE_OUTVAL_NOV'
        Options.Editing = False
        Width = 120
        Position.BandIndex = 1
        Position.ColIndex = 43
        Position.RowIndex = 0
      end
      object cxgItensViewDESOPE: TcxGridDBBandedColumn
        Caption = 'Desp. Oper. (Atual)'
        DataBinding.FieldName = 'ITE_DESOPE'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 44
        Position.RowIndex = 0
      end
      object cxgItensViewDESOPE_NOV: TcxGridDBBandedColumn
        Caption = 'Desp. Oper. (Novo)'
        DataBinding.FieldName = 'ITE_DESOPE_NOV'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 45
        Position.RowIndex = 0
      end
      object cxgItensViewPRECOM: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Compra(Atual)'
        DataBinding.FieldName = 'ITE_PRECOM'
        Options.Editing = False
        Width = 115
        Position.BandIndex = 1
        Position.ColIndex = 46
        Position.RowIndex = 0
      end
      object cxgItensViewPRECOM_NOV: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Compra(Novo)'
        DataBinding.FieldName = 'ITE_PRECOM_NOV'
        Options.Editing = False
        Styles.Content = styEditavel
        Width = 115
        Position.BandIndex = 1
        Position.ColIndex = 47
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR1: TcxGridDBBandedColumn
        Caption = 'Margem Bruta 1 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR1'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 48
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR1_NOV: TcxGridDBBandedColumn
        Tag = 1
        Caption = 'Margem Bruta 1 (Novo)'
        DataBinding.FieldName = 'ITE_MARBR1_NOV'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 49
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE1: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 1 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 50
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE1_NOV: TcxGridDBBandedColumn
        Tag = 1
        Caption = 'Pre'#231'o Venda 1 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE1_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 51
        Position.RowIndex = 0
      end
      object cxgItensViewVariacao1: TcxGridDBBandedColumn
        Caption = 'Varia'#231#227'o. Tab. Pre'#231'o 1'
        DataBinding.FieldName = 'VARIACAO_1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00 %;-#,##0.00 %'
        Properties.EditFormat = '#,##0.00 %'
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensViewVariacao1StylesGetContentStyle
        Position.BandIndex = 1
        Position.ColIndex = 52
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR2: TcxGridDBBandedColumn
        Caption = 'Margem Bruta 2 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR2'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 53
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR2_NOV: TcxGridDBBandedColumn
        Tag = 2
        Caption = 'Margem Bruta 2 (Novo)'
        DataBinding.FieldName = 'ITE_MARBR2_NOV'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 54
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE2: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 2 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 55
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE2_NOV: TcxGridDBBandedColumn
        Tag = 2
        Caption = 'Pre'#231'o Venda 2 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 56
        Position.RowIndex = 0
      end
      object cxgItensViewVariacao2: TcxGridDBBandedColumn
        Caption = 'Varia'#231#227'o. Tab. Pre'#231'o 2'
        DataBinding.FieldName = 'VARIACAO_2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00 %;-#,##0.00 %'
        Properties.EditFormat = '#,##0.00 %'
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensViewVariacao1StylesGetContentStyle
        Position.BandIndex = 1
        Position.ColIndex = 57
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR3: TcxGridDBBandedColumn
        Caption = 'Margem Bruta 3 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR3'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 58
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR3_NOV: TcxGridDBBandedColumn
        Tag = 3
        Caption = 'Margem Bruta 3 (Novo)'
        DataBinding.FieldName = 'ITE_MARBR3_NOV'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 59
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE3: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 3 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 60
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE3_NOV: TcxGridDBBandedColumn
        Tag = 3
        Caption = 'Pre'#231'o Venda 3 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 61
        Position.RowIndex = 0
      end
      object cxgItensViewVariacao3: TcxGridDBBandedColumn
        Caption = 'Varia'#231#227'o. Tab. Pre'#231'o 3'
        DataBinding.FieldName = 'VARIACAO_3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00 %;-#,##0.00 %'
        Properties.EditFormat = '#,##0.00 %'
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensViewVariacao1StylesGetContentStyle
        Position.BandIndex = 1
        Position.ColIndex = 62
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR4: TcxGridDBBandedColumn
        Caption = 'Margem Bruta 4 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR4'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 63
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR4_NOV: TcxGridDBBandedColumn
        Tag = 4
        Caption = 'Margem Bruta 4 (Novo)'
        DataBinding.FieldName = 'ITE_MARBR4_NOV'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 64
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE4: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 4 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 65
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE4_NOV: TcxGridDBBandedColumn
        Tag = 4
        Caption = 'Pre'#231'o Venda 4 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 66
        Position.RowIndex = 0
      end
      object cxgItensViewVariacao4: TcxGridDBBandedColumn
        Caption = 'Varia'#231#227'o. Tab. Pre'#231'o 4'
        DataBinding.FieldName = 'VARIACAO_4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00 %;-#,##0.00 %'
        Properties.EditFormat = '#,##0.00 %'
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensViewVariacao1StylesGetContentStyle
        Position.BandIndex = 1
        Position.ColIndex = 67
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR5: TcxGridDBBandedColumn
        Caption = 'Margem Bruta 5 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR5'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 68
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR5_NOV: TcxGridDBBandedColumn
        Tag = 5
        Caption = 'Margem Bruta 5 (Novo)'
        DataBinding.FieldName = 'ITE_MARBR5_NOV'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 69
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE5: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 5 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 70
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE5_NOV: TcxGridDBBandedColumn
        Tag = 5
        Caption = 'Pre'#231'o Venda 5 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 71
        Position.RowIndex = 0
      end
      object cxgItensViewVariacao5: TcxGridDBBandedColumn
        Caption = 'Varia'#231#227'o. Tab. Pre'#231'o 5'
        DataBinding.FieldName = 'VARIACAO_5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00 %;-#,##0.00 %'
        Properties.EditFormat = '#,##0.00 %'
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensViewVariacao1StylesGetContentStyle
        Position.BandIndex = 1
        Position.ColIndex = 72
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR6: TcxGridDBBandedColumn
        Caption = 'Margem Bruta 6 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR6'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 73
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR6_NOV: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Margem Bruta 6 (Novo)'
        DataBinding.FieldName = 'ITE_MARBR6_NOV'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 74
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE6: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 6 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 75
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE6_NOV: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Pre'#231'o Venda 6 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 76
        Position.RowIndex = 0
      end
      object cxgItensViewVariacao6: TcxGridDBBandedColumn
        Caption = 'Varia'#231#227'o. Tab. Pre'#231'o 6'
        DataBinding.FieldName = 'VARIACAO_6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00 %;-#,##0.00 %'
        Properties.EditFormat = '#,##0.00 %'
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensViewVariacao1StylesGetContentStyle
        Position.BandIndex = 1
        Position.ColIndex = 77
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR7: TcxGridDBBandedColumn
        Caption = 'Margem Bruta 7 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR7'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 78
        Position.RowIndex = 0
      end
      object cxgItensViewMARBR7_NOV: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Bruta 7 (Novo)'
        DataBinding.FieldName = 'ITE_MARBR7_NOV'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 79
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE7: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 7 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 80
        Position.RowIndex = 0
      end
      object cxgItensViewPREVE7_NOV: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Pre'#231'o Venda 7 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 81
        Position.RowIndex = 0
      end
      object cxgItensViewVariacao7: TcxGridDBBandedColumn
        Caption = 'Varia'#231#227'o. Tab. Pre'#231'o 7'
        DataBinding.FieldName = 'VARIACAO_7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00 %;-#,##0.00 %'
        Properties.EditFormat = '#,##0.00 %'
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensViewVariacao1StylesGetContentStyle
        Position.BandIndex = 1
        Position.ColIndex = 82
        Position.RowIndex = 0
      end
      object cxgItensViewMARID1: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 1 (Atual)'
        DataBinding.FieldName = 'ITE_MARID1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 83
        Position.RowIndex = 0
      end
      object cxgItensViewMARID1_NOV: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 1 (Novo)'
        DataBinding.FieldName = 'ITE_MARID1_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 84
        Position.RowIndex = 0
      end
      object cxgItensViewMARID2: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 2 (Atual)'
        DataBinding.FieldName = 'ITE_MARID2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 85
        Position.RowIndex = 0
      end
      object cxgItensViewMARID2_NOV: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 2 (Novo)'
        DataBinding.FieldName = 'ITE_MARID2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 86
        Position.RowIndex = 0
      end
      object cxgItensViewMARID3: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 3 (Atual)'
        DataBinding.FieldName = 'ITE_MARID3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 87
        Position.RowIndex = 0
      end
      object cxgItensViewMARID3_NOV: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 3 (Novo)'
        DataBinding.FieldName = 'ITE_MARID3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 88
        Position.RowIndex = 0
      end
      object cxgItensViewMARID4: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 4 (Atual)'
        DataBinding.FieldName = 'ITE_MARID4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 89
        Position.RowIndex = 0
      end
      object cxgItensViewMARID4_NOV: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 4 (Novo)'
        DataBinding.FieldName = 'ITE_MARID4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 90
        Position.RowIndex = 0
      end
      object cxgItensViewMARID5: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 5 (Atual)'
        DataBinding.FieldName = 'ITE_MARID5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 91
        Position.RowIndex = 0
      end
      object cxgItensViewMARID5_NOV: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 5 (Novo)'
        DataBinding.FieldName = 'ITE_MARID5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 92
        Position.RowIndex = 0
      end
      object cxgItensViewMARID6: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 6 (Atual)'
        DataBinding.FieldName = 'ITE_MARID6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 93
        Position.RowIndex = 0
      end
      object cxgItensViewMARID6_NOV: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 6 (Novo)'
        DataBinding.FieldName = 'ITE_MARID6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 94
        Position.RowIndex = 0
      end
      object cxgItensViewMARID7: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 7 (Atual)'
        DataBinding.FieldName = 'ITE_MARID7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 95
        Position.RowIndex = 0
      end
      object cxgItensViewMARID7_NOV: TcxGridDBBandedColumn
        Tag = 7
        Caption = 'Margem Ideal 7 (Novo)'
        DataBinding.FieldName = 'ITE_MARID7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Styles.Content = styEditavel
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 96
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensDBBandedTableView
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 496
    Width = 1055
    Height = 23
    Align = alBottom
    TabOrder = 3
    object Label1: TLabel
      Left = 544
      Top = 4
      Width = 208
      Height = 14
      Caption = 'Apenas os itens em azul ser'#227'o atualizados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblAlerta: TLabel
      Left = 768
      Top = 4
      Width = 276
      Height = 14
      Caption = 'O Campo %Substitui'#231#227'o foi Calculado pelo Autcom'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnMarcar: TBitBtnLocked
      Left = 2
      Top = 0
      Width = 170
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
      Left = 173
      Top = 0
      Width = 170
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
      Left = 343
      Top = 0
      Width = 170
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
  object grpLegenda: TGroupBox [4]
    Left = 0
    Top = 456
    Width = 1055
    Height = 40
    Align = alBottom
    Caption = 'Legenda'
    TabOrder = 4
    ExplicitLeft = 69
    ExplicitTop = 454
    object shpVarMaior: TShape
      Left = 23
      Top = 19
      Width = 17
      Height = 15
      Brush.Color = clRed
    end
    object lblLegVarMaior: TLabel
      Left = 46
      Top = 20
      Width = 71
      Height = 14
      Caption = 'C'#243'pias de hoje'
    end
    object lblLegVarMenor: TLabel
      Left = 158
      Top = 20
      Width = 71
      Height = 14
      Caption = 'C'#243'pias de hoje'
    end
    object shpVarMenor: TShape
      Left = 135
      Top = 19
      Width = 17
      Height = 15
      Brush.Color = clSkyBlue
    end
    object Shape1: TShape
      Left = 255
      Top = 19
      Width = 17
      Height = 15
      Brush.Color = 8454143
    end
    object lblCamposEditaveis: TLabel
      Left = 278
      Top = 20
      Width = 85
      Height = 14
      Caption = 'Campos edit'#225'veis'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 152
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    OnGetValue = frxGenGetValue
    Left = 96
    Top = 44
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 304
    Top = 244
  end
  object dtsDados: TDataSource
    Left = 392
    Top = 96
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
    Left = 172
    Top = 96
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
          DataField = 'CODITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
        end
        object Memo3: TfrxMemoView
          Left = 45.354330710000000000
          Width = 86.929150940000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODBAR"]')
        end
        object Memo7: TfrxMemoView
          Left = 136.440944880000000000
          Width = 49.133855830000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"]')
        end
        object Memo8: TfrxMemoView
          Left = 189.732283460000000000
          Width = 83.149616060000000000
          Height = 11.338590000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
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
  object cxStyleRepository: TcxStyleRepository
    Left = 184
    Top = 216
    PixelsPerInch = 96
    object styDentro: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object styFora: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 8421631
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object styEditavel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 8454143
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clDefault
    end
  end
end
