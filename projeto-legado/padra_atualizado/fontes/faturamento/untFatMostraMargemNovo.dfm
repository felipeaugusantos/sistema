inherited frmFatMostraMargemNovo: TfrmFatMostraMargemNovo
  Width = 1214
  Height = 680
  Caption = 'Consulta de Custo / Margem de Produtos'
  ExplicitWidth = 1214
  ExplicitHeight = 680
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 425
    Width = 1208
    ExplicitTop = 425
    ExplicitWidth = 1208
    inherited FlwBotoes: TFlowPanel
      Width = 1204
      ExplicitWidth = 1204
    end
  end
  inherited pnlStatus: TPanel
    Top = 635
    Width = 1208
    ExplicitTop = 635
    ExplicitWidth = 1208
    inherited pnlNomeForm: TPanel
      Left = 1037
      ExplicitLeft = 1037
    end
    inherited pnlInfo: TPanel
      Width = 1037
      ExplicitWidth = 1037
    end
  end
  inherited pgcDados: TPageControl
    Width = 1208
    Height = 425
    ExplicitWidth = 1208
    ExplicitHeight = 425
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1200
      ExplicitHeight = 393
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 1208
    Height = 425
    Align = alClient
    PopupMenu = popGrid
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBBandedTableView
      OnKeyDown = cxgItensViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      OnEditKeyDown = cxgItensViewEditKeyDown
      OnEditKeyPress = cxgItensViewEditKeyPress
      DataController.Filter.OnChanged = cxgItensViewDataControllerFilterChanged
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para filtrar'
      FilterRow.Visible = True
      OptionsCustomize.ColumnSorting = False
      OptionsCustomize.BandMoving = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OnColumnHeaderClick = cxgItensViewColumnHeaderClick
      Bands = <
        item
          Caption = 'PRODUTOS'
        end
        item
          Caption = 'PR. VENDA'
        end
        item
          Caption = 'PRE'#199'O DE CUSTO'
        end
        item
          Caption = 'PRE'#199'O DE CUSTO REAL'
        end
        item
          Caption = 'PRE'#199'O M'#201'DIO'
        end
        item
          Caption = 'PRE'#199'O '#218'LTIMA COMPRA'
        end
        item
          Caption = 'PRE'#199'O '#218'LTIMA COMPRA+IMPOSTOS'
        end
        item
          Caption = 'QUANTIDADE / ESTOQUE'
        end
        item
          AlternateCaption = '160'
          Caption = 'MARGEM IDEAL'
        end
        item
          Caption = 'CAT Ressarcimento'
        end
        item
          Caption = 'RESUMO'
        end
        item
          Caption = 'MARGEM DO CADASTRO'
          Width = 150
        end
        item
          Caption = 'TRAVAS M'#205'NIMAS'
        end>
      object cxgItensITE_CODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Options.Editing = False
        Options.Sorting = False
        Width = 61
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensITE_CODFAB: TcxGridDBBandedColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'ITE_CODFAB'
        Options.Editing = False
        Width = 110
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensGIR_DIAEST: TcxGridDBBandedColumn
        Caption = 'Dias Estoque'
        DataBinding.FieldName = 'GIR_DIAEST'
        Options.Editing = False
        Width = 70
        Position.BandIndex = 0
        Position.ColIndex = 18
        Position.RowIndex = 0
      end
      object cxgItensITE_COMISS: TcxGridDBBandedColumn
        Caption = 'Comiss'#195#163'o'
        DataBinding.FieldName = 'ITE_COMISS'
        Options.Editing = False
        Width = 70
        Position.BandIndex = 0
        Position.ColIndex = 19
        Position.RowIndex = 0
      end
      object cxgItensITE_DESITE: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.OnValidate = cxgItensITE_DESITEPropertiesValidate
        Options.Editing = False
        Options.Sorting = False
        Width = 411
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensITE_SIGUNI: TcxGridDBBandedColumn
        Caption = 'UN'
        DataBinding.FieldName = 'ITE_SIGUNI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Options.Editing = False
        Options.Sorting = False
        Width = 29
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensITE_TABPRE: TcxGridDBBandedColumn
        Caption = 'TP'
        DataBinding.FieldName = 'ITE_TABPRE'
        Options.Editing = False
        Options.Sorting = False
        Width = 29
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensITE_DESMAR: TcxGridDBBandedColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'ITE_DESMAR'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Width = 144
        Position.BandIndex = 0
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxgItensITE_UNIDIG: TcxGridDBBandedColumn
        Caption = 'Vr.Unit'#225'rio'
        DataBinding.FieldName = 'ITE_UNIDIG'
        RepositoryItem = cxEditRepositoryValor
        Options.Sorting = False
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensITE_TAXJUR: TcxGridDBBandedColumn
        Caption = 'Tax.Jur.(%)'
        DataBinding.FieldName = 'ITE_TAXJUR'
        Options.Sorting = False
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensITE_UNITAR: TcxGridDBBandedColumn
        Caption = 'Vr.Unit'#225'rio L'#237'quido'
        DataBinding.FieldName = 'ITE_UNITAR'
        RepositoryItem = cxEditRepositoryValor
        Options.Sorting = False
        Width = 95
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensITE_UNIDOL: TcxGridDBBandedColumn
        Caption = 'Vr.Unit.D'#243'lar'
        DataBinding.FieldName = 'ITE_UNIDOL'
        Options.Sorting = False
        Width = 86
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensITE_VLCTVN: TcxGridDBBandedColumn
        Caption = 'Vlr. Cota'#231#227'o'
        DataBinding.FieldName = 'ITE_VLCTVN'
        Options.Sorting = False
        Width = 86
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensITE_DTCTVN: TcxGridDBBandedColumn
        Caption = 'Data Cota'#231#227'o'
        DataBinding.FieldName = 'ITE_DTCTVN'
        Options.Sorting = False
        Width = 86
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensITE_TOTITE: TcxGridDBBandedColumn
        Caption = 'Vlr. Total'
        DataBinding.FieldName = 'ITE_TOTITE'
        Visible = False
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensITE_CUSITE: TcxGridDBBandedColumn
        Caption = 'Vr.Unit'#225'rio'
        DataBinding.FieldName = 'ITE_CUSITE'
        Options.Sorting = False
        Width = 77
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensITE_MARPRO_CUSITE: TcxGridDBBandedColumn
        Caption = 'M.Prop.'
        DataBinding.FieldName = 'ITE_MARPRO_CUSITE'
        Options.Sorting = False
        Width = 62
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensITE_MARPRA_CUSITE: TcxGridDBBandedColumn
        Caption = 'M.Prat.'
        DataBinding.FieldName = 'ITE_MARPRA_CUSITE'
        RepositoryItem = cxEditRepositoryPercentual
        Options.Sorting = False
        Width = 57
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensITE_DESOPE: TcxGridDBBandedColumn
        Caption = 'Desp.Operac.'
        DataBinding.FieldName = 'ITE_DESOPE'
        Options.Sorting = False
        Width = 82
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensITE_IMPFED: TcxGridDBBandedColumn
        Caption = 'Imp.Federais'
        DataBinding.FieldName = 'ITE_IMPFED'
        Options.Sorting = False
        Width = 82
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensITE_ICMSAI: TcxGridDBBandedColumn
        Caption = 'ICMS Sa'#237'da'
        DataBinding.FieldName = 'ITE_ICMSAI'
        Options.Sorting = False
        Width = 82
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensITE_OUTVAL: TcxGridDBBandedColumn
        Caption = 'Outros Valores'
        DataBinding.FieldName = 'ITE_OUTVAL'
        Options.Sorting = False
        Width = 85
        Position.BandIndex = 3
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensITE_PRECUS: TcxGridDBBandedColumn
        Caption = 'Vr.Unit'#225'rio'
        DataBinding.FieldName = 'ITE_PRECUS'
        Options.Sorting = False
        Width = 90
        Position.BandIndex = 3
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensITE_MARPRO_PRECUS: TcxGridDBBandedColumn
        Caption = 'M.Prop.'
        DataBinding.FieldName = 'ITE_MARPRO_PRECUS'
        Options.Sorting = False
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgItensITE_MRPRBT_PRECUS: TcxGridDBBandedColumn
        Caption = 'M.Prat.Bru.'
        DataBinding.FieldName = 'ITE_MRPRBT_PRECUS'
        Options.Sorting = False
        Width = 60
        Position.BandIndex = 3
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgItensITE_MARPRA_PRECUS: TcxGridDBBandedColumn
        Caption = 'M.Prat.'
        DataBinding.FieldName = 'ITE_MARPRA_PRECUS'
        RepositoryItem = cxEditRepositoryPercentual
        Options.Sorting = False
        Width = 55
        Position.BandIndex = 3
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxgItensITE_PREMED: TcxGridDBBandedColumn
        Caption = 'Vr.Unit'#225'rio'
        DataBinding.FieldName = 'ITE_PREMED'
        Options.Sorting = False
        Width = 90
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensITE_MARBRU_PREMED: TcxGridDBBandedColumn
        Caption = 'M.Prop.'
        DataBinding.FieldName = 'ITE_MARBRU_PREMED'
        Options.Sorting = False
        Width = 55
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensITE_PREULT: TcxGridDBBandedColumn
        Caption = 'Vr.Unit'#225'rio'
        DataBinding.FieldName = 'ITE_PREULT'
        Options.Sorting = False
        Width = 91
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensITE_MARBRU_PREULT: TcxGridDBBandedColumn
        Caption = 'M.Prop'
        DataBinding.FieldName = 'ITE_MARBRU_PREULT'
        Options.Sorting = False
        Width = 49
        Position.BandIndex = 5
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensITE_CUSIMP: TcxGridDBBandedColumn
        Caption = 'Vr.Unit'#225'rio'
        DataBinding.FieldName = 'ITE_CUSIMP'
        Options.Sorting = False
        Width = 78
        Position.BandIndex = 6
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensITE_MARBRU_IMPULT: TcxGridDBBandedColumn
        Caption = 'M.Prop.'
        DataBinding.FieldName = 'ITE_MARBRU_IMPULT'
        Options.Sorting = False
        Width = 58
        Position.BandIndex = 6
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensITE_QTDITE: TcxGridDBBandedColumn
        Caption = 'Qtd.Venda'
        DataBinding.FieldName = 'ITE_QTDITE'
        Options.Sorting = False
        Width = 80
        Position.BandIndex = 7
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensITE_SALDOS: TcxGridDBBandedColumn
        Caption = 'Saldo Disp.'
        DataBinding.FieldName = 'ITE_SALDOS'
        Options.Sorting = False
        Width = 80
        Position.BandIndex = 7
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensITE_PROMOC: TcxGridDBBandedColumn
        Caption = 'PROM.'
        DataBinding.FieldName = 'ITE_PROMOC'
        Visible = False
        Options.Sorting = False
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgItensITE_MRPRBT_PREMED: TcxGridDBBandedColumn
        Caption = 'M.Prat.Bru.'
        DataBinding.FieldName = 'ITE_MRPRBT_PREMED'
        Options.Sorting = False
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensITE_MARLIQ_PREMED: TcxGridDBBandedColumn
        Caption = 'M.Prat.'
        DataBinding.FieldName = 'ITE_MARLIQ_PREMED'
        RepositoryItem = cxEditRepositoryPercentual
        Options.Sorting = False
        Width = 55
        Position.BandIndex = 4
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensITE_MARLIQ_PREULT: TcxGridDBBandedColumn
        Caption = 'M.Prat.'
        DataBinding.FieldName = 'ITE_MARLIQ_PREULT'
        RepositoryItem = cxEditRepositoryPercentual
        Options.Sorting = False
        Width = 60
        Position.BandIndex = 5
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensITE_MARLIQ_IMPULT: TcxGridDBBandedColumn
        Caption = 'M.Prat.'
        DataBinding.FieldName = 'ITE_MARLIQ_IMPULT'
        RepositoryItem = cxEditRepositoryPercentual
        Options.Sorting = False
        Position.BandIndex = 6
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensITE_TIPTMQ: TcxGridDBBandedColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'ITE_TIPTMQ'
        Visible = False
        Options.Sorting = False
        Width = 33
        Position.BandIndex = 0
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgItensAUTOINCREM: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
        Options.Sorting = False
        Width = 28
        Position.BandIndex = 0
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxgItensITE_UNIORI: TcxGridDBBandedColumn
        Caption = 'Vr.Original'
        DataBinding.FieldName = 'ITE_UNIORI'
        RepositoryItem = cxEditRepositoryValor
        Options.Sorting = False
        Width = 58
        Position.BandIndex = 0
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxgItensITE_PRETAB: TcxGridDBBandedColumn
        Caption = 'Vr.Tab.Atual'
        DataBinding.FieldName = 'ITE_PRETAB'
        Options.Sorting = False
        Width = 66
        Position.BandIndex = 0
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxgItensITE_IMPULT: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_IMPULT'
        Visible = False
        Options.Sorting = False
        Position.BandIndex = 6
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensITE_MARIDE: TcxGridDBBandedColumn
        Caption = '% Marg. Ideal'
        DataBinding.FieldName = 'ITE_MARIDE'
        Options.Sorting = False
        Width = 80
        Position.BandIndex = 8
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensITE_PREIDE: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Ideal'
        DataBinding.FieldName = 'ITE_PREIDE'
        Options.Sorting = False
        Width = 80
        Position.BandIndex = 8
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensITE_MARCAT: TcxGridDBBandedColumn
        Caption = '% Margem'
        DataBinding.FieldName = 'ITE_MARCAT'
        Options.Sorting = False
        Width = 106
        Position.BandIndex = 9
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensITE_PERDES: TcxGridDBBandedColumn
        Caption = '% Desc.'
        DataBinding.FieldName = 'ITE_PERDES'
        Options.Sorting = False
        Width = 47
        Position.BandIndex = 0
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxgItensITE_RESULT: TcxGridDBBandedColumn
        Caption = 'Resultado'
        DataBinding.FieldName = 'ITE_RESULT'
        Options.Sorting = False
        Width = 54
        Position.BandIndex = 0
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxgItensITE_MARMIN: TcxGridDBBandedColumn
        Caption = '% M. M'#237'n.'
        DataBinding.FieldName = 'ITE_MARMIN'
        Options.Sorting = False
        Width = 59
        Position.BandIndex = 0
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxgItensITE_VDIFAL: TcxGridDBBandedColumn
        Caption = 'Difal(%)'
        DataBinding.FieldName = 'ITE_VDIFAL'
        Options.Sorting = False
        Width = 61
        Position.BandIndex = 3
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensFCP: TcxGridDBBandedColumn
        Caption = 'FCP(%)'
        DataBinding.FieldName = 'ITE_VALFCP'
        Options.Sorting = False
        Width = 58
        Position.BandIndex = 3
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensViewColumn1: TcxGridDBBandedColumn
        Caption = 'Vr.Custo Marg.'
        DataBinding.FieldName = 'ITE_PRECU2'
        Options.Sorting = False
        Width = 80
        Position.BandIndex = 0
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxgItensITE_DESTIN: TcxGridDBBandedColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'ITE_DESTIN'
        Visible = False
        Options.Sorting = False
        Position.BandIndex = 0
        Position.ColIndex = 17
        Position.RowIndex = 0
      end
      object cxgItensViewITE_MKPPRO: TcxGridDBBandedColumn
        Caption = 'Markup Cad.Produtos'
        DataBinding.FieldName = 'ITE_MKPPRO'
        Options.Sorting = False
        Width = 120
        Position.BandIndex = 10
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensViewITE_MARPRO: TcxGridDBBandedColumn
        Caption = 'Vari'#225'vel COMTB'
        DataBinding.FieldName = 'ITE_MARPRO'
        Options.Sorting = False
        Width = 120
        Position.BandIndex = 10
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensViewITE_ENCPRO: TcxGridDBBandedColumn
        Caption = 'Encargos S/Venda'
        DataBinding.FieldName = 'ITE_ENCPRO'
        Options.Sorting = False
        Width = 120
        Position.BandIndex = 10
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensViewITE_MKPPRO2: TcxGridDBBandedColumn
        Caption = '% Margem'
        DataBinding.FieldName = 'ITE_MKPPRO'
        Options.Sorting = False
        Position.BandIndex = 11
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensViewSELECIONADO: TcxGridDBBandedColumn
        Caption = '[X]'
        DataBinding.FieldName = 'SELECIONADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taCenter
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.FilteringPopup = False
        Options.Sorting = False
        Width = 27
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensViewITE_ORDITE: TcxGridDBBandedColumn
        Caption = 'N'#186
        DataBinding.FieldName = 'ITE_ORDITE'
        Visible = False
        Width = 30
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensViewITE_DESMAX: TcxGridDBBandedColumn
        Caption = 'Desc. Max.'
        DataBinding.FieldName = 'TRM_DESMAX'
        Options.Sorting = False
        Position.BandIndex = 12
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensViewITE_VLRMIN: TcxGridDBBandedColumn
        Caption = 'Vlr. Min.'
        DataBinding.FieldName = 'TRM_VLRMIN'
        Options.Sorting = False
        Position.BandIndex = 12
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensViewITE_TOTMIN: TcxGridDBBandedColumn
        Caption = 'Vlr. Tot. Min.'
        DataBinding.FieldName = 'TRM_TOTMIN'
        Options.Sorting = False
        Position.BandIndex = 12
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel2: TcxGridLevel
      Caption = 'cxgItensLevel2'
      GridView = cxgItensView
    end
  end
  object pnlAviTot: TPanel [4]
    Left = 0
    Top = 425
    Width = 1208
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
    object Label8: TLabel
      Left = 9
      Top = 6
      Width = 464
      Height = 13
      Caption = 
        '** A linha referente aos totais leva em considera'#231#227'o a multiplic' +
        'a'#231#227'o pela quantidade do produto.'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsItalic]
      ParentColor = False
      ParentFont = False
    end
  end
  object pnlLegendas: TPanel [5]
    Left = 0
    Top = 449
    Width = 1208
    Height = 27
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object pnlEditaveis: TPanel
      Left = 0
      Top = 0
      Width = 138
      Height = 27
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object Shape1: TShape
        Left = 8
        Top = 3
        Width = 20
        Height = 20
        Brush.Color = clYellow
      end
      object Label3: TLabel
        Left = 34
        Top = 6
        Width = 99
        Height = 13
        Caption = 'Campos Editaveis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlMargemLiquida: TPanel
      Left = 469
      Top = 0
      Width = 132
      Height = 27
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object Shape2: TShape
        Left = 8
        Top = 3
        Width = 20
        Height = 20
        Brush.Color = clAqua
      end
      object Label7: TLabel
        Left = 35
        Top = 6
        Width = 90
        Height = 13
        Caption = 'Margem L'#237'quida'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlPromocao: TPanel
      Left = 251
      Top = 0
      Width = 97
      Height = 27
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      object Shape3: TShape
        Left = 8
        Top = 3
        Width = 20
        Height = 20
        Brush.Color = clGreen
      end
      object Label5: TLabel
        Left = 35
        Top = 6
        Width = 57
        Height = 13
        Caption = 'Promo'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlSemEstoque: TPanel
      Left = 138
      Top = 0
      Width = 113
      Height = 27
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 3
      Visible = False
      object Shape4: TShape
        Left = 8
        Top = 3
        Width = 20
        Height = 18
        Brush.Color = clRed
      end
      object Label4: TLabel
        Left = 34
        Top = 6
        Width = 73
        Height = 13
        Caption = 'Sem Estoque'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlMargemBruta: TPanel
      Left = 348
      Top = 0
      Width = 121
      Height = 27
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 4
      Visible = False
      object Shape5: TShape
        Left = 8
        Top = 3
        Width = 20
        Height = 20
        Brush.Color = clLime
      end
      object Label6: TLabel
        Left = 35
        Top = 6
        Width = 81
        Height = 13
        Caption = 'Margem Bruta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object pnlTotais: TPanel [6]
    Left = 0
    Top = 476
    Width = 1208
    Height = 49
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 6
    DesignSize = (
      1208
      49)
    object lblProVen: TLabel
      Left = 399
      Top = 24
      Width = 66
      Height = 14
      Caption = 'Pr. Promo'#231#227'o:'
      Visible = False
    end
    object lblDesEsp: TLabel
      Left = 13
      Top = 24
      Width = 92
      Height = 14
      Caption = 'Desconto Especial:'
    end
    object edtProVen: TEditFocus
      Left = 467
      Top = 18
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      Visible = False
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object gpbUltVen: TGroupBox
      Left = 706
      Top = 2
      Width = 491
      Height = 43
      Anchors = [akTop, akRight]
      Caption = #218'ltima Venda para o Cliente'
      TabOrder = 1
      object lbl2: TLabel
        Left = 373
        Top = 22
        Width = 25
        Height = 14
        Caption = 'Total:'
      end
      object Label1: TLabel
        Left = 106
        Top = 22
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object Label2: TLabel
        Left = 8
        Top = 22
        Width = 25
        Height = 14
        Caption = 'Data:'
      end
      object Label9: TLabel
        Left = 230
        Top = 22
        Width = 52
        Height = 14
        Caption = 'Valor Unit.:'
      end
      object edtTotVen: TEditFocus
        Left = 402
        Top = 16
        Width = 81
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtQtdVen: TEditFocus
        Left = 167
        Top = 16
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDtaVen: TEditFocus
        Left = 37
        Top = 16
        Width = 63
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtUnitar: TEditFocus
        Left = 287
        Top = 16
        Width = 81
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object edtDesEsp: TEditFocus
      Left = 108
      Top = 18
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  object pnlFrete: TPanel [7]
    Left = 0
    Top = 525
    Width = 1208
    Height = 59
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 8
    object lblFrete: TLabel
      Left = 589
      Top = 16
      Width = 121
      Height = 14
      Caption = 'Frete cobrado do Cliente:'
    end
    object lblFreSuges: TLabel
      Left = 636
      Top = 39
      Width = 74
      Height = 14
      Caption = 'Custo do Frete:'
    end
    object edtTotFrete: TEditFocus
      Left = 714
      Top = 8
      Width = 81
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtFreSuges: TEditFocus
      Left = 714
      Top = 31
      Width = 81
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object chkAcuFreteCobPrecoUni: TCheckBox
      Left = 7
      Top = 13
      Width = 297
      Height = 17
      Caption = 'Acumular o frete cobrado ao pre'#231'o de venda do produto'
      TabOrder = 2
      OnClick = chkAcuFreteCobPrecoUniClick
    end
    object chkAcuFreteSugPrecoCus: TCheckBox
      Left = 7
      Top = 36
      Width = 341
      Height = 17
      Caption = 'Acumular o frete ao pre'#231'o do produto para c'#225'lculo de custo real'
      TabOrder = 3
      OnClick = chkAcuFreteCobPrecoUniClick
    end
  end
  object pnlBotoesMarg: TFlowPanel [8]
    Left = 0
    Top = 584
    Width = 1208
    Height = 51
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 7
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 105
      Height = 23
      Align = alLeft
      Caption = '[F10] Confirmar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      ModalResult = 1
      TabOrder = 0
      WordWrap = True
      OnClick = btnConfirmaClick
    end
    object btnMargemSobreItens: TBitBtnLocked
      Left = 107
      Top = 2
      Width = 205
      Height = 23
      Align = alLeft
      Caption = '[F2] % Margem praticada sobre itens'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAE602A
        AE602AAE602AAE602AAE602AAE602AAE602AAE602AAE602AAE602AAE602AAE60
        2AAE602AAE602AFF00FFDAA039FFD195EAB777E4AE67FFBD60F1AE4FDC9C3EFC
        AA32FFA922FB9F14FB9A05FB9800FB9801FC9900FF9F00AE602AE7AC1DEEC093
        584E44534A41D39D5B866A46433E39BA8338D5902F50433054452F5243305544
        2B624A28F69702AE602AE7AC1DFFD0A0CAA276C09768FBBD6DD69F58B98847ED
        A540E9A142AF7F56C58538E08D12B67937B97B37FE9D02AE602AE7AC1DEDC299
        60554C5C5147D2A2688B704F4F463CB5843F977D922E42DE6D64A1CA8A483047
        D33649CCEB9317AE602AE7AC1DFED1A2BC9B78B3916CFDC47FD3A165A17B4DEF
        AA4DE9A657887394C78D55FEA3179C7469A1745FFE9D01AE602AE7AC1DE9BF97
        63584D5A5149CDA5748A715547413CB386499D8397263EE36E66A5CE904B3148
        D23448CCE3911EAE602AE7AC1DFFD4A5FCC794F5C190FFCF92FEC07DEFB06AFF
        BD61FFB74FE3A45BFCAB3CFFAC24EE9B2CF2981BFF9F00AE602AE7AC1DF5CAA0
        E1DEC0E2E0C1DEDBBCE1DCB9E3DAB1DED5A8E6D39FFFBF5DFCAB3CF3A333F69F
        20F89D13FF9F04AE602AE7AC1DD4AF8C6BD3CA6CD7CE6CD7CE6CD7CF6CD7CF66
        D7D18DE0D9FCC57BCA8D3DB58139AD7A31C18225FFA20BAE602AEFB53EF8C9A2
        D1AC86D1AD86D1AD86D1AC85D1AA7BCFA46EDCAB6BFFBD6AF6AF52FCAF46E79D
        37F3A028FFA716AE602AFF00FFE4A70AEDB339F0B84DEEB64DE9B24DF2BA62F2
        B65AEEB04FEAA945E9A43AE79F31E89B27E6971FD2851AFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      WordWrap = True
      OnClick = btnMargemSobreItensClick
    end
    object btnDesconto: TBitBtnLocked
      Left = 312
      Top = 2
      Width = 235
      Height = 23
      Align = alLeft
      Caption = '[F3] % Desconto / Majoramento sobre Itens'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAE602A
        AE602AAE602AAE602AAE602AAE602AAE602AAE602AAE602AAE602AAE602AAE60
        2AAE602AAE602AFF00FFDAA039FFD195EAB777E4AE67FFBD60F1AE4FDC9C3EFC
        AA32FFA922FB9F14FB9A05FB9800FB9801FC9900FF9F00AE602AE7AC1DEEC093
        584E44534A41D39D5B866A46433E39BA8338D5902F50433054452F5243305544
        2B624A28F69702AE602AE7AC1DFFD0A0CAA276C09768FBBD6DD69F58B98847ED
        A540E9A142AF7F56C58538E08D12B67937B97B37FE9D02AE602AE7AC1DEDC299
        60554C5C5147D2A2688B704F4F463CB5843F977D922E42DE6D64A1CA8A483047
        D33649CCEB9317AE602AE7AC1DFED1A2BC9B78B3916CFDC47FD3A165A17B4DEF
        AA4DE9A657887394C78D55FEA3179C7469A1745FFE9D01AE602AE7AC1DE9BF97
        63584D5A5149CDA5748A715547413CB386499D8397263EE36E66A5CE904B3148
        D23448CCE3911EAE602AE7AC1DFFD4A5FCC794F5C190FFCF92FEC07DEFB06AFF
        BD61FFB74FE3A45BFCAB3CFFAC24EE9B2CF2981BFF9F00AE602AE7AC1DF5CAA0
        E1DEC0E2E0C1DEDBBCE1DCB9E3DAB1DED5A8E6D39FFFBF5DFCAB3CF3A333F69F
        20F89D13FF9F04AE602AE7AC1DD4AF8C6BD3CA6CD7CE6CD7CE6CD7CF6CD7CF66
        D7D18DE0D9FCC57BCA8D3DB58139AD7A31C18225FFA20BAE602AEFB53EF8C9A2
        D1AC86D1AD86D1AD86D1AC85D1AA7BCFA46EDCAB6BFFBD6AF6AF52FCAF46E79D
        37F3A028FFA716AE602AFF00FFE4A70AEDB339F0B84DEEB64DE9B24DF2BA62F2
        B65AEEB04FEAA945E9A43AE79F31E89B27E6971FD2851AFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      WordWrap = True
      OnClick = btnDescontoClick
    end
    object btnCustosMargemTintas: TBitBtnLocked
      Left = 547
      Top = 2
      Width = 155
      Height = 23
      Align = alLeft
      Caption = '[F4] Custo / Margem Tintas'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        D5F1F9FFFFFFA7DEEFA7DEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5FD2F0A7DEEF95DDF264DBEEC1EAF5FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        C3E8F687D9EE4BEDFB8CFDFF64DBEE7EE5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2E9F526D2F735EFFFBDFEFFFFFFFF50
        C2D597A6ACFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECFFFF7ADAF3
        32DAF92CEBFF7CFDFFCAFFFF4491A74B6E82577A868BA6B7FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFABE1F344DEFC59FCFF59FCFF8CFDFF95DDF239657E71
        80862DA0BF278AAED9D9D9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87D9EE7CFDFF
        64DBEE327C9D386B8A386B8A7284882DA0BF23AACA2B8EADCED6D9FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFD5F1F944DEFC4491A71033592B476A81868C3CA7B321
        BAD423AACA609DAEFFF9F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF70C2DA
        154F6810335981868C51AEB319C3D519C3D521BAD46598A5ECE8E7FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFC1EDFB93B1BC58545A4C9C9E0DCFD90DCFD91B
        88AC228CA123AACA4491A7B0BEC4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFCFC9C847898B26ACB23CA7B3CFC9C89AA1A417829E25ADD3278AAE6C96
        A9E3D9D9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D9D9FFF9F6FF
        FFFFFFFFFF72848817829E30ADD32793C02C78A7A8B6BEFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF59788317829E36A8
        D03195C72C78A7A1B4C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFDF4F3577A86278AAE3195C720A6C85186A9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0EAE95978
        8317829E2C78A78BA6B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF81868C8F999DFFFFFF}
      TabOrder = 3
      WordWrap = True
      OnClick = btnCustosMargemTintasClick
    end
    object btnTravasMinimas: TBitBtnLocked
      Left = 702
      Top = 2
      Width = 170
      Height = 23
      Align = alLeft
      Caption = '[F5] Consulta Travas M'#237'nimas'
      Glyph.Data = {
        46050000424D4605000000000000360000002800000012000000120000000100
        2000000000001005000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00CEA58400D69C6B00D6AD7B00DEB58C00E7BD9400E7C6
        A500E7C6A500E7BD9400DEB58C0073845200216B3900186B3100216B39006B9C
        8400FF00FF00FF00FF00FF00FF00CEAD8400E7C6A500FFEFDE00FFEFDE00FFEF
        DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE0084AD8400218C520063BD8C0094D6
        B50063BD8C00218C5200639C7B00FF00FF00FF00FF00D69C6B00FFEFDE00FFEF
        DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00216B390063BD
        8C005ABD8400FFFFFF005ABD840063BD8C00186B3900FF00FF00FF00FF00D6A5
        6B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00317B4A009CD6B500FFFFFF00FFFFFF00FFFFFF0094D6B500186B3100FF00
        FF00FF00FF00D6AD8C00DEAD7B00DEB58400E7BD9400EFC6A500EFCEAD00EFCE
        AD00EFC6A500E7BD94004A845A008CD6B50094D6B500FFFFFF0063BD8C0063BD
        8C00186B3900FF00FF00FF00FF00FF00FF00FF00FF00DEA57300FFF7E700FFF7
        E700FFF7E700FFF7E700FFF7E700FFF7E700A5C6A50063AD840094D6B500BDE7
        D6006BBD8C00298C5200639C7B00FF00FF00FF00FF00FF00FF00FF00FF00DEAD
        7B00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00ADC6
        AD00639C73004A8C630042845A007BA59400FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00E7AD7B00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
        EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00E7AD7B00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00EFB58400FFF7F700FFF7F700FFF7F700FFF7
        F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700EFB58400FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD8400FFFFF700FFFF
        F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFF
        F700EFBD8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7BD
        8C00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFF
        F700FFFFF700FFFFF700F7BD8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00F7C68C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7C68C00F7C68C00EFC69C00FF00
        FF00FF00FF00FF00FF00FF00FF00F7C69400FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7AD7B00FFFF
        FF00F7C69400FF00FF00FF00FF00FF00FF00FF00FF00FFC69400FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00CE9C6300FFFFFF00FFC69400FF00FF00FF00FF00FF00FF00FF00FF00F7CE
        A500FFE7CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFE7CE00F7CEA500FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00F7CEA500FFD6A500FFD6AD00FFDEBD00FFE7C600FFE7
        CE00FFE7CE00FFE7C600FFDEBD00FFD6AD00FFD6A500F7CEA500FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00}
      TabOrder = 4
      WordWrap = True
      OnClick = btnTravasMinimasClick
    end
    object btnDeseja: TBitBtnLocked
      Left = 872
      Top = 2
      Width = 155
      Height = 23
      Align = alLeft
      Caption = '[F6] Total Desejado Venda'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0002000000090000000E0000000F0000000F0000000F00000010000000100000
        00100000001100000011000000100000000B0000000300000000000000000000
        0008285B8FC0357DC6FF327AC4FF3077C2FF2D75C1FF2B73C0FF2870BEFF266E
        BDFF256DBCFF226BBBFF216AB9FF154B84C20000000A00000000000000000000
        000C3C82CAFF77C2EEFF64B7EAFF61B5EAFF5DB4E9FF5AB2E8FF58B0E7FF54AF
        E7FF51ACE7FF50ABE6FF4DAAE6FF216ABAFF0000000F00000000000000000000
        000C3F85CBFF80C7EFFF3F8BCBFF3C88CBFF3986C8FF3583C7FF3381C6FF307F
        C4FF2F7FC4FF2D7DC3FF50ACE7FF246CBBFF0000000F00000000000000000000
        000B4288CDFF88CBF0FF4490CEFFF3ECEAFFEDE6E4FFEFEAE7FFE6E1DEFFE9E4
        E1FFECE5E1FF3181C5FF55AFE7FF256EBDFF0000000F00000000000000000000
        000B458BD0FF91D0F1FF4A95D1FFF5F1EFFFEFECE9FFA8B7AFFF125838FF6688
        77FFE7E2DFFF4D91CDFF59B1E8FF2971BEFF0000000E00000000000000000000
        000A498ED2FF99D4F3FF65A5D8FFF5F3F2FFAEBFB5FF1E825BFF2EE1AAFF1574
        4FFFA2B0A7FF8BB5DAFF63B6E9FF2B73C0FF0000000D00000000000000000000
        00094C92D3FFADDDF5FFA3C8E6FFB6C9C0FF258863FF40ECB9FF38ECB7FF2BD1
        9CFF236749FF87ACC6FF95CCEDFF2F76C2FF0000000D00000000000000000000
        00094E95D5FFB8E1F7FF84B2BEFF34906CFF5EF2C9FF71F9D7FF77F7D7FF41EB
        B9FF23B081FF326D5FFFA7CDE3FF6499D1FF0000000C00000000000000000000
        00085397D7FFBEE4F7FF78AFB3FF4AAA89FF77DBBEFF419E7EFF237956FF6ADF
        C1FF41E9B8FF1D9A6FFF52867FFF92B4D6FF0000000D00000000000000000000
        0007559AD9FFC5E8F9FFAFD2ECFFA3C5B7FF52967BFF98B8A9FFC5D1CBFF408D
        6FFF6DE1C3FF48ECBDFF18855CFF5B8891FF0000001500000001000000000000
        0007589DDAFFBDE6F9FF84BCE4FFF8F8F8FFF0F0EEFFEEEEECFFEDEBEAFFD1D9
        D4FF3D896BFF62D0B3FF66EFCCFF1C6F4DFF0000001B00000002000000000000
        00065B9FDCFFC2E7F7FF6AA6D2FFA5A3A1FF7D7976FF645E5DFF696462FFABA8
        A8FFB2B7B3FF3B826DFF359170FF6D95A5FF0000001300000000000000000000
        00055DA1DEFFC5E6F5FF767C80FFB3AEACFFD2CDCAFFE5E0DDFFCFC6C1FFB8AF
        AAFFC1BEBDFFA6ABAFFFC3D9E6FF9BBDDEFF0000000A00000000000000000000
        00034778A6C05DA0DBFF918987FF8D8682FF88817FFFD0CCCAFFC8C3C1FF6C66
        64FF76726FFF837F7DFF5C95CBFF4E7BA6CA0000000500000000000000000000
        00010000000300000004000000050000000525232243716C6ACA605B59CA1D1B
        1B44000000060000000600000006000000040000000100000000}
      TabOrder = 5
      WordWrap = True
      OnClick = btnDesejaClick
    end
    object btnRestaurar: TBitBtnLocked
      Left = 2
      Top = 25
      Width = 180
      Height = 23
      Align = alLeft
      Caption = '[F7] Restaurar pre'#231'os originais'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000000000001000000050000000D0000000F00000005000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000020000000A170F093B72472CC3A1643DFF00000010000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        00060604031955382594AB754CF9D5A670FFA56942FF00000022000000110000
        000D000000080000000300000000000000000000000000000000000000053525
        195F9A6A48E5CB9C6DFFE8C089FFE8C189FFA86F48FF88512EFC724125E4532E
        17B92F1A0D7B090502270000000700000001000000000000000000000008BD8D
        64FFECD4B3FFF1D8ACFFEBCA95FFEAC68FFFE7CBA4FFF2DBB9FFE1C39EFFC59D
        74FFA16F47FF512C16BE1B0E065200000008000000010000000000000004392C
        1F59A8815EE2DBBB97FFF3DFBDFFF0D4A6FFC69C74FFBB8B62FFC49870FFD3AE
        89FFE0C29BFFB78A60FF5C351CCB120A043E0000000400000000000000010000
        000407050415614B378CC39D76F9E7CEADFFC1936AFF060503242B21174E644A
        359AB48F6BECD7B891FFAB7E56FF3C2110970000000A00000000000000020000
        00080000000B0000000F1A140F328A6C4FBBC79A70FF0000000C000000040000
        000C56412F86D2AD87FFD8BD9DFF60351CD50000000F00000000000000062379
        49F9237B4AFF247A4AFF030A06220000000900000009000000060000000A0000
        000B100C0927C5996FFFC4986EFFAE7C57F90000000D0000000000000005246E
        49CE5BC49EFF308E62FF0D311C7E00000008000000030000000A247B4AFF0A37
        1ABF020B053900000015000000110000000D000000030000000000000003194B
        32885BB691FF6DC3A6FF2F7A54EA103B229107190F470104021C267F4DFF34A5
        78FF17633BF9092B169101030218000000060000000100000000000000010919
        112F2C7451C07AC8AAFF8BD7BFFF56A886FF33875DFF207345FF3A976AFF6ADA
        BBFF4BC89FFF30966AFF145530E5061D0F5F0000000600000000000000000000
        00020E251A41266C4BB263BB96FF8AD3BAFFA8E7D6FFBAF3E7FFA4E4D2FF89EA
        D5FF77E1C6FF75DDBDFF80D7BCFF278551FF0000000A00000000000000000000
        000000000002050D091A17412D6A276D4CAD338E64DF3AA06FFB3AA271FF9EF0
        E0FFB4F1E5FF6EC5A3FF348B60E1102E1F5A0000000500000000000000000000
        000000000000000000010000000200000004000000050000000C3EA977FF9AE0
        C9FF4CAC82F81E52398902060415000000040000000100000000000000000000
        000000000000000000000000000000000000000000000000000541AF7DFF2D79
        56B70816102B0000000500000001000000000000000000000000}
      TabOrder = 6
      WordWrap = True
      OnClick = btnRestaurarClick
    end
    object btnUltCompraEmp: TBitBtnLocked
      Left = 182
      Top = 25
      Width = 155
      Height = 23
      Align = alLeft
      Caption = '[F8] '#218'lt.Compra Empresas'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000070000
        000B0000000C0000000C0000000C0000000C0000000C0000000C0000000D0000
        000D0000000D0000000D0000000D0000000D0000000C0000000882594DBEB47C
        6AFFB37C69FFB37B6AFFB37B69FFB37B68FFB37B68FFB37A69FFB37A68FFB37A
        68FFB37A68FFB27968FFB37967FFB27967FFB27967FF7F574ABFB67F6DFFF9F2
        EEFFF9F2EEFFF9F2EDFFF9F1EDFFC69A8CFFF9F2ECFFF9F1EDFFF9F1ECFFF9F1
        ECFFC5998BFFF8F0EBFFF8F0EBFFF8F0EBFFF8F0EBFFB37B69FFB78170FFF9F3
        EFFFF7EEE9FFF8EEE8FFF8EEE9FFC79C8DFFF7EEE9FFF8EEE8FFF8EEE9FFF7EE
        E8FFC69A8BFFF8EEE8FFF7EDE8FFF7EEE8FFF9F1ECFFB57D6BFFBA8472FFFAF4
        F0FFF8EFEAFFF8F0EAFFF8EFE9FFC99D8FFFF8EFEAFFF8EFEAFFF7EEEAFFF8EF
        EAFFC89D8EFFF7EFE9FFF8EFE9FFF7EFE9FFF9F1EDFFB7806EFFBB8776FFCCA2
        95FFCAA193FFCBA193FFCAA193FFCAA192FFCBA192FFCAA091FFCA9F91FFCA9F
        91FFC99F91FFC99F90FFC99E90FFC99E8FFFC99F90FFB88371FFBD8A79FFFBF6
        F2FFF9F1ECFFF9F1ECFFF9F0EDFFCCA295FFF8F1ECFFF9F1EBFFF9F0ECFFF9F1
        ECFFCAA194FFF9F0ECFFF9F1EBFFF8F0EBFFF9F3F0FFBA8574FFC08E7CFFFBF6
        F3FFF9F2EEFFFAF2EEFFF9F1EDFFCEA697FFF9F1EDFFF9F1EDFFF9F2EDFFF9F2
        ECFFCDA496FFF9F1EDFFF9F1ECFFF9F1EDFFFBF5F1FFBC8977FFC29180FFFCF8
        F5FFF9F2EFFFFAF3EFFFFAF2EFFFCFA89AFFFAF3EEFFF9F2EEFFF9F2EEFFFAF3
        EEFFCEA799FFF9F2EEFFF9F2EEFFF9F2EDFFFBF5F2FFBF8C7AFFC88E5AFFD9AD
        80FFCE9964FFCD9763FFCD9660FFCD9460FFCB935EFFCA925DFFC9905BFFC88F
        5AFFC88E59FFC88D57FFC88C56FFC78B55FFD19D6CFFBB7943FFC98F5AFFF1DA
        B5FFE7C28DFFE7C18DFFE7C18CFFCD9660FFE6BF89FFE5BE89FFE5BD87FFE5BC
        87FFC98E59FFE4BA84FFE4BA83FFE4B983FFECCDA3FFBC7A44FFCA905CFFF1DB
        B8FFE8C28EFFE7C28DFFE7C18CFFCD9662FFE6BF8BFFE6BE89FFE5BD88FFE5BC
        87FFC98F5AFFE4BB86FFE4BB84FFE4BA83FFEDCEA5FFBD7B45FFCA915EFFF2DD
        B9FFF1DAB9FFF1DAB7FFF1D9B6FFD8AC7EFFF0D8B3FFF0D6B2FFF0D6B1FFEFD5
        AFFFD5A576FFEFD2ACFFEED2A9FFEDD1A9FFEDD1A8FFBE7B45FF976C47BECA91
        5DFFCA8F5BFFC88E5AFFC78C58FFC68B57FFC58955FFC48852FFC48651FFC284
        50FFC2834EFFC0814CFFC0804BFFBF7F49FFBE7D48FF8D5D34BF000000010000
        0002000000020000000200000002000000020000000200000002000000020000
        0003000000030000000300000003000000030000000300000002000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 7
      WordWrap = True
      OnClick = btnUltCompraEmpClick
    end
    object btnVenCli: TBitBtnLocked
      Left = 337
      Top = 25
      Width = 140
      Height = 23
      Align = alLeft
      Caption = '[F9] Vendas por Cliente'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000010000
        000300000006000000080000000B0000000D0000000E0000000F0000000F0000
        00100000000F0000000E0000000C00000009000000050000000100000003081A
        1341143F2E921B543CBD1F5E43D3257553FF247353FF247251FF247151FF2370
        51FF23704FFF1C593FD6184E37C1123A29990717104900000006000000072A82
        60FF36A780FF34B186FF33B589FF34C192FF33BF90FF31BD8DFF30BC8CFF2FBA
        8AFF2EB989FF2CAA7DFF2AA378FF2A976FFF257353FF0000000D000000062A7E
        5FE973D9BDFF5AD4B0FF43CCA1FF40C99DFF3EC79AFF3BC598FF38C295FF36C0
        92FF34BE90FF32BD8EFF3ABF93FF42BE95FF247153EE0000000C000000031845
        357B48A787FF74CEB4FF83E5CBFF57CEABFF2F9773FF207D5DFF1B7859FF2189
        66FF42BF98FF5AD1ADFF4BB996FF349674FF1540308800000006000000000000
        00030C221A3C256B53B345A987FF53AC90FF63A9B1FF71A7CCFF5D8CB7FF3674
        89FF2C8E73FF3A9D7BFF22664DBA0B2019460000000700000001000000000000
        00000000000100000003091B15322D7A61CC5588ABFF325994FF2C538FFF3460
        8EFF28735CCD091A143600000007000000030000000100000000000000000000
        00000000000000000000000000071221316B4572ACFF659FD7FF629CD6FF3968
        A5FF0C1B2C6F0000000800000000000000000000000000000000000000000000
        000000000000000000010000000E2B466EC379AFDAFF90CCF5FF77B4E8FF5991
        CBFF1D3A66CA0000000E00000001000000000000000000000000000000000000
        0000000000000101010315253F8A36598DF8BAE1F6FFBDE6FCFF8CC9F2FF69A5
        DBFF21447AF70D19349501010103000000000000000000000000000000000000
        000000000000010101052A4B7DE2385F95FFD5F0FBFFD1EDFBFF94CFF3FF6DA7
        DDFF24467DFF172C59E201010105000000000000000000000000000000000000
        0000000000000101010538649EFA3C6CA8FFBAD7E9FF698EB7FF325A91FF2B50
        86FF28518FFE1D3869FA01010105000000000000000000000000000000000000
        00000000000001010104386498DC539CE0FF497BB7FF5390CDFF4E8FD3FF3C76
        C1FF396CB1FF223F72FF01010105000000000000000000000000000000000000
        000000000000010101021525374D4B84C2F17FB9E7FF86BDE9FF8DC4EEFF75A8
        DAFF5683B8FF1C3359BF01010104000000000000000000000000000000000000
        00000000000000000000010101020E16202B37618DB03D6B9FD24276B3FF3054
        85D51C3251930305071200000001000000000000000000000000000000000000
        0000000000000000000000000000000000010101010301010105010101050101
        0104010101030000000100000000000000000000000000000000}
      TabOrder = 8
      WordWrap = True
      OnClick = btnVenCliClick
    end
    object btnPadrao: TBitBtnLocked
      Left = 477
      Top = 25
      Width = 150
      Height = 23
      Align = alLeft
      Caption = 'Restaurar padr'#227'o do grid'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 9
      WordWrap = True
      OnClick = btnPadraoClick
    end
    object btnMarcarTodos: TBitBtnLocked
      Left = 627
      Top = 25
      Width = 120
      Height = 22
      Caption = '[F11] Marcar Todos'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000051543
        30BC1D5D42FF1D5D42FF15422FBD000000050000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000061E65
        48FF63DBB3FF2FCB95FF1B5F43FF0000000700000000000000000000000A0000
        000F0000001100000011000000110000001200000016000000180000001C216E
        4FFF6EDEBAFF36D09CFF1E6649FF0000001000000007000000057F5648C1B076
        63FFAF7562FFAF7562FFAF7561FFD0B0A5FF54886EFF237556FF237152FF2475
        56FF41D5A4FF40D2A4FF216E50FF1F6448FF1E6246FF154531BCB27B68FFF8F2
        EDFFF8F2EDFFF8F1EEFFF9F2EDFFF8F4F2FF298663FF88E8CBFF4EDAADFF4CDA
        ACFF4BD9ACFF48D9AAFF47D7ABFF46D6AAFF45D6A6FF216F50FFB57E6BFFF9F3
        EFFFF7EFEAFF8C6F63FFF7EFE9FFF7F3F0FF2C8E6BFF90EBD0FF8EEACFFF8DEA
        CFFF8BE9CDFF52DEB3FF51DCB2FF86E7C9FF83E7C9FF247757FFB7826FFFF9F4
        F1FF8F7266FF8E7164FF8D7064FFBEB0A9FF549C7FFF2E926EFF2E906DFF2D8E
        6BFF92EBD3FF59E0B8FF2A8764FF298362FF288260FF1D5E46C0BA8573FFFAF5
        F3FFF8F1EBFF907367FFF7F0EBFFF9F3EEFFE8DCD8FFF9F5F2FFF5F2EFFF2F95
        71FF9BEED7FF5FE4BEFF2D8F6CFF000000170000000400000003BD8977FFFAF6
        F4FF93766BFF92756AFFDFCDC6FFDECCC5FFDECAC4FFDDCAC3FFEBE1DEFF329B
        77FF9EF0DAFF9DEFDAFF2F9572FF000000120000000000000000C08C7BFFFAF8
        F5FFF8F3EFFF94796DFFF8F2EEFFF8F3EFFFDFCDC7FFF8F2EEFFFAF7F5FF60AB
        8DFF34A07BFF339E78FF5DA486FF0000000F0000000000000000C3917FFFFBF9
        F6FF977B70FF967B6FFFE2D2CCFFE2D1CBFFE1CFC9FFE0CFC8FFE4D4CFFFDDC0
        B4FFFAF7F6FFFBF9F8FFD3B4A9FF0000000C0000000000000000C59483FFFCF9
        F7FFFAF5F2FF997E71FFFAF5F1FFFAF5F1FFE4D2CCFFFAF5F1FFF9F4F1FFCA9B
        87FFFAF5F0FFFBF8F6FFBD8977FF0000000C0000000000000000C79787FFFDFA
        F8FF9B8175FF9B7F73FFCFA692FFCFA490FFCEA38FFFCDA08CFFCC9F8AFFCC9D
        89FFFAF6F1FFFCF9F7FFBF8D7CFF0000000B0000000000000000C99A8AFFFCFB
        F9FFFDFBF9FFFDFBF9FFFDFBF9FFFDFBF9FFFCFBF9FFFCFBF8FFFCFBF8FFFDFA
        F8FFFDFBF8FFFCFAF8FFC2917FFF0000000A0000000000000000CC9E8EFFFDFB
        F9FFFDFBFAFFFCFBF9FFFDFBFAFFFDFBF9FFFDFBF9FFFDFBF9FFFDFBFAFFFDFB
        F9FFFCFBF9FFFCFBF9FFC59583FF00000008000000000000000098776AC1CDA0
        8FFFCC9F8EFFCC9E8EFFCB9E8DFFCA9D8CFFCA9D8CFFCA9B8BFFC99A8AFFC99A
        89FFC89989FFC79988FF947164C2000000050000000000000000}
      TabOrder = 10
      OnClick = btnMarcarTodosClick
    end
    object btnDesmarcaTodos: TBitBtnLocked
      Left = 747
      Top = 25
      Width = 140
      Height = 22
      Caption = '[F12] Desmarca Todos'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000020000000900000011000000140000
        00120000000A0000000200000000000000000000000000000000000000000000
        00000000000000000000000000020000000D411F0E9397532BFF914D26FF8C45
        21FF47210F9B0000001000000002000000000000000000000000000000000000
        000000000000000000000000000742221190B17D53FFE1BA86FFE4CA9FFFA761
        32FF99542AFF1E101F9B0000000F000000020000000000000000000000000000
        0000000000000000000000000009AE7247FFE5C18FFFE4BF8DFFE4BF8DFFE7D0
        A5FF9D6E6EFF2D259FFF07073A990000000D00000002000000000000000B0000
        001100000012000000120000002063442E9DD0A478FFE7C69AFFE7C495FFB0A6
        BFFFB0B9EEFF463DC7FF302BA6FF0B0A3F960000000C00000002714F44C29E6D
        5DFF9E6C5DFF9D6C5CFFB59084FFCEB5ADFFBD977EFFD4AC82FFBAB2C7FF8493
        E9FF8494EAFFB6C2F0FF4742C9FF3532ADFF0F0E47930000000BA17162FFF9F2
        EFFFF7EEE9FFF7EEEAFFC29F93FFF9F2EEFFF7F5F4FFB6ABBEFF737DD7FF95A5
        EDFF8E9FEDFF8D9EEDFFBCC8F2FF4846CBFF3B3AB5FF13134C8EA47567FFF9F2
        F0FFF7EEEBFFF7EEEAFFC3A095FFF7EEEAFFFAF2EFFFBFA69BFF8F8DC3FF7B87
        DBFF9FB0F1FF97AAF1FF97AAF0FFC1CEF5FF5353D1FF393BADFFAD724AFFD2A8
        81FFC48F62FFC48F62FFC48F62FFC38F62FFC38E61FFD2AA87FFC3ABA0FFA2A5
        DBFF8290E0FFA9B9F4FFA0B4F3FFA7B9F5FF7D85CDFF15174E88B2774EFFEDD8
        B6FFE7CCA0FFE8CCA1FFC69265FFE7CCA1FFE7CCA0FFE7CCA0FFD3AB8AFFF9F6
        F4FF9793C6FF8896E4FFB7C8F7FF7783D5FF1A1E588600000005B57D53FFEED9
        B6FFE7CDA1FFE8CCA1FFC79569FFE7CDA1FFE8CCA2FFE7CCA1FFC69366FFF9F4
        F1FFDBC7C0FFAAADE2FF606BD6FF1F245F890000000400000001B98359FFD8B0
        8CFFCB996EFFCA9A6DFFCA996DFFC9986CFFC9976CFFC9976BFFC9976BFFC7A6
        9BFFD4BCB3FFEADCD8FFD6C0B8FF0000000A0000000000000000BD885FFFEEDA
        B8FFE9CEA3FFE8CDA3FFCC9D70FFE8CEA3FFE8CDA3FFE8CDA3FFCB9B6FFFF7F0
        EEFFF8F0EDFFFAF4F2FFB08577FF000000090000000000000000C08E64FFEFDA
        B9FFEEDAB8FFEEDAB8FFDAB591FFEEDAB8FFEFDAB8FFEEDAB8FFD9B48EFFFAF4
        F2FFFAF5F2FFFAF5F2FFB48A7CFF000000080000000000000000916D4DC1C292
        67FFC29167FFC29066FFC18F65FFC08E64FFBF8C63FFBF8C62FFBE8B61FFBA91
        83FFB89083FFB88F82FF876A5FC1000000050000000000000000000000030000
        0005000000050000000500000005000000050000000500000005000000060000
        0006000000060000000500000004000000010000000000000000}
      TabOrder = 11
      OnClick = btnDesmarcaTodosClick
    end
    object btnFechar: TBitBtnLocked
      Left = 887
      Top = 25
      Width = 65
      Height = 23
      Align = alLeft
      Caption = '&Fechar'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      ModalResult = 2
      TabOrder = 12
      OnClick = btnFecharClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 140
    Top = 60
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 112
    Top = 60
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 84
    Top = 60
  end
  object popGrid: TPopupMenu
    Left = 168
    Top = 60
    object mnuImprimirF4: TMenuItem
      Caption = 'Imprimir'
      OnClick = mnuImprimirF4Click
    end
  end
  object cxEditRepository: TcxEditRepository
    Left = 201
    Top = 59
    PixelsPerInch = 96
    object cxEditRepositoryValor: TcxEditRepositoryCurrencyItem
      Properties.DisplayFormat = ',0.00;-,0.00'
    end
    object cxEditRepositoryPercentual: TcxEditRepositoryCurrencyItem
      Properties.DisplayFormat = ',0.00;-,0.00'
    end
  end
end
