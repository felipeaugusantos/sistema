inherited frmEntSelItensDevolucao: TfrmEntSelItensDevolucao
  Left = 241
  Top = 213
  Width = 1024
  Height = 730
  Caption = 
    'Sele'#231#227'o de Itens para Devolu'#231#227'o e informe a quantidade a devolve' +
    'r'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 730
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 657
    Width = 1018
    ExplicitTop = 657
    ExplicitWidth = 1018
    DesignSize = (
      1018
      28)
    inherited FlwBotoes: TFlowPanel
      Left = 300
      Width = 716
      ExplicitLeft = 300
      ExplicitWidth = 716
      object btnMarDesTodos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 187
        Height = 24
        Align = alLeft
        Caption = '[F2] Marcar / Desmarcar Todos'
        TabOrder = 0
        OnClick = btnMarDesTodosClick
      end
      object btnEspelhoNF: TBitBtnLocked
        Left = 187
        Top = 0
        Width = 126
        Height = 24
        Align = alLeft
        Caption = 'Gerar Espelho Dev.'
        TabOrder = 1
        OnClick = btnEspelhoNFClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ModalResult = 2
      TabOrder = 3
      ExplicitLeft = 935
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 24
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      Enabled = False
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
    object btnMarDes: TBitBtnLocked
      Left = 113
      Top = 2
      Width = 187
      Height = 24
      Align = alLeft
      Caption = '[ SPACE ] Marca / Desmarca'
      TabOrder = 2
      OnClick = btnMarDesClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 685
    Width = 1018
    ExplicitTop = 685
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
  object cxgItens: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 657
    Align = alClient
    TabOrder = 2
    OnExit = cxgItensExit
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensTableViewCustomDrawCell
      DataController.DataSource = dtsItens
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.Selection = cxStyle2
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensDET_DTAENT: TcxGridDBColumn
        Caption = 'Data Documento'
        DataBinding.FieldName = 'DET_DTAENT'
        Options.Editing = False
        Width = 80
      end
      object cxgItensDET_NUMDOC: TcxGridDBColumn
        Caption = 'Documento Origem'
        DataBinding.FieldName = 'DET_NUMDOC'
        Options.Editing = False
        Width = 90
      end
      object cxgItensDET_ESPDOC: TcxGridDBColumn
        Caption = 'Esp'
        DataBinding.FieldName = 'DET_ESPDOC'
        Options.Editing = False
        Width = 27
      end
      object cxgItensDET_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'DET_CODEMP'
        Options.Editing = False
        Width = 29
      end
      object cxgItensDET_CODITE: TcxGridDBColumn
        DataBinding.FieldName = 'DET_CODITE'
        Options.Editing = False
        Options.Filtering = False
        Width = 50
      end
      object cxgItensITE_CODGRU: TcxGridDBColumn
        DataBinding.FieldName = 'ITE_CODGRU'
        Options.Editing = False
        Options.Filtering = False
        Width = 44
      end
      object cxgItensITE_CODFAB: TcxGridDBColumn
        Caption = 'Cod. Fabrica'
        DataBinding.FieldName = 'ITE_CODFAB'
        Width = 100
      end
      object cxgItensDET_DESCRI: TcxGridDBColumn
        DataBinding.FieldName = 'DET_DESCRI'
        Options.Editing = False
        Options.Filtering = False
        Width = 195
      end
      object cxgItensDET_UNIDAD: TcxGridDBColumn
        Caption = 'Un.'
        DataBinding.FieldName = 'DET_UNIDAD'
        Options.Editing = False
        Options.Filtering = False
        Width = 30
      end
      object cxgItensMAR_DESMAR: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MAR_DESMAR'
        Options.Editing = False
        Width = 104
      end
      object cxgItensDET_QTDITE: TcxGridDBColumn
        DataBinding.FieldName = 'DET_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Width = 63
      end
      object cxgItenQTDDEV: TcxGridDBColumn
        Caption = 'Quant. a Devolver'
        DataBinding.FieldName = 'QTDDEV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Filtering = False
        Styles.Content = cxStyle1
        Width = 95
      end
      object cxgItensDET_UNITAR: TcxGridDBColumn
        Caption = 'Vr. Unit'#225'rio'
        DataBinding.FieldName = 'DET_UNITAR'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Width = 62
      end
      object cxgItensDET_VALIPI: TcxGridDBColumn
        Caption = 'Vr. IPI'
        DataBinding.FieldName = 'DET_VALIPI'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Width = 50
      end
      object cxgItensDET_TOTITE: TcxGridDBColumn
        DataBinding.FieldName = 'DET_TOTITE'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Width = 71
      end
      object cxgItensAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
        Options.Editing = False
      end
      object cxgItensNUMSER: TcxGridDBColumn
        Caption = 'N'#250'mero de S'#233'rie'
        DataBinding.FieldName = 'NUMSER'
        Visible = False
        Width = 94
      end
    end
    object cxgItensLevel: TcxGridLevel
      GridView = cxgItensTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 104
    object TMenuItem
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 336
    Top = 256
  end
  object qryItensDev: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT '
      '  DET_CODITE, '
      '  ITE_CODGRU,'
      '  ITE_CODFAB,'
      '  DET_DESCRI, '
      '  DET_UNIDAD,'
      '  DET_QTDITE,'
      '  DET_QTDITE AS QTDDEV,'
      '  DET_UNITAR,'
      '  DET_VALIPI,'
      '  DET_TOTITE,'
      
        '  (((D.DET_TOTITE + D.DET_VALIPI+ DET_VALRET + T.DET_VFCPST) - D' +
        '.DET_DESESP - D.DET_DESCFF)/D.DET_QTDITE) AS "UNICRD",'
      '  DET_ALQIPI,'
      '  DET_BASIPI,'
      '  D.AUTOINCREM,'
      '  DET_NUMDOC,'
      '  DET_ESPDOC,'
      '  DET_CODEMP,'
      '  DET_CODCLI,'
      '  DET_CODACA,'
      '  DET_PROACA,'
      '  DET_EMPACA,'
      '  DET_CODDIV,'
      '  ACA_SALDOS, '
      '  D.DET_CODVEN,'
      '  CADITE.ITE_ITEATI AS ITEATI,'
      '  ITEGER.ITE_IMPLIS AS IMPLIS,'
      '  D.DET_NUMLOT,'
      '  D.DET_IDEPRO,'
      '  D.DET_IDETIN'
      ''
      'FROM MOVDET D'
      '  JOIN CADITE'
      '    ON CADITE.ITE_CODITE = DET_CODITE'
      '  JOIN ITEGER'
      '    ON ITEGER.ITE_CODITE = DET_CODITE AND'
      '       ITEGER.ITE_CODEMP = DET_CODEMP'
      '  LEFT JOIN ACAGER'
      '    ON DET_EMPACA = ACA_EMPEST'
      '      AND DET_CODACA = ACA_CODACA'
      'WHERE '
      '   DET_TIP_FC = '#39'C'#39' AND'
      '   LOCATE(CONCAT(DET_NUMDOC,  '
      '                                 DET_ESPDOC,  '
      '                                 DET_CODEMP, '
      '                                 DET_CODCLI,'
      
        '                                 IFNULL(DET_ORIDOC,'#39#39')), :DOCSEL' +
        ') > 0'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  DET_CODITE, '
      '  ITE_CODGRU,'
      '  ITE_CODFAB,'
      '  DET_DESCRI, '
      '  DET_UNIDAD,'
      '  DET_QTDITE,'
      '  DET_QTDITE AS QTDDEV,'
      '  DET_UNITAR,'
      '  DET_VALIPI,'
      '  DET_TOTITE,'
      
        '  (((D.DET_TOTITE + D.DET_VALIPI + D.DET_VALRET + T.DET_VFCPST) ' +
        '- D.DET_DESESP - D.DET_DESCFF)/D.DET_QTDITE) AS "UNICRD", '
      '  DET_ALQIPI,'
      '  DET_BASIPI,'
      '  N.AUTOINCREM,'
      '  DET_NUMDOC,'
      '  DET_ESPDOC,'
      '  DET_CODEMP,'
      '  DET_CODCLI,'
      '  DET_CODACA,'
      '  DET_PROACA,'
      '  DET_EMPACA,'
      '  DET_CODDIV,'
      '  ACA_SALDOS,'
      '  CADITE.ITE_ITEATI AS ITEATI,'
      '  ITEGER.ITE_IMPLIS AS IMPLIS,'
      '  DET_NUMLOT,'
      '  DET_IDEPRO,'
      '  DET_ITETIN'

      'FROM NOTDET N'
      '  JOIN CADITE'
      '    ON CADITE.ITE_CODITE = DET_CODITE'
      '  JOIN ITEGER'
      '    ON ITEGER.ITE_CODITE = DET_CODITE AND'
      '       ITEGER.ITE_CODEMP = DET_CODEMP'
      '  LEFT JOIN ACAGER'
      '    ON DET_EMPACA = ACA_EMPEST'
      '      AND DET_CODACA = ACA_CODACA'
      'WHERE '
      '   DET_TIP_FC = '#39'C'#39' AND'
      '   LOCATE(CONCAT(DET_NUMDOC,  '
      '                                 DET_ESPDOC,  '
      '                                 DET_CODEMP, '
      '                                 DET_CODCLI,'
      
        '                                 IFNULL(DET_ORIDOC,'#39#39')), :DOCSEL' +
        ') > 0')
    ReadOnly = True
    Constraints = <>
    Left = 104
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCSEL'
        Value = nil
      end>
    object qryItensDevDET_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'DET_CODITE'
      Size = 5
    end
    object qryItensDevITE_CODGRU: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'ITE_CODGRU'
      Size = 6
    end
    object qryItensDevDET_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DET_DESCRI'
      Size = 100
    end
    object qryItensDevDET_UNIDAD: TStringField
      DisplayLabel = 'UN'
      FieldName = 'DET_UNIDAD'
      Size = 2
    end
    object qryItensDevDET_QTDITE: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'DET_QTDITE'
      DisplayFormat = '##0.00'
    end
    object qryItensDevDET_UNITAR: TFloatField
      DisplayLabel = 'Vr.Unit'#225'rio'
      FieldName = 'DET_UNITAR'
      DisplayFormat = '##0.00'
    end
    object qryItensDevDET_PRECUS: TFloatField
      FieldName = 'DET_PRECUS'
      DisplayFormat = '##0.00'
    end
    object qryItensDevDET_CODFOR: TStringField
      FieldName = 'DET_CODFOR'
    end
    object qryItensDevDET_VALIPI: TFloatField
      DisplayLabel = 'Valor IPI'
      FieldName = 'DET_VALIPI'
      DisplayFormat = '##0.00'
    end
    object qryItensDevDET_TOTITE: TFloatField
      DisplayLabel = 'Total do Item'
      FieldName = 'DET_TOTITE'
      DisplayFormat = '##0.00'
    end
    object qryItensDevDET_ALQIPI: TFloatField
      FieldName = 'DET_ALQIPI'
      Visible = False
    end
    object qryItensDevDET_BASIPI: TFloatField
      FieldName = 'DET_BASIPI'
      Visible = False
    end
    object qryItensDevAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryItensDevDET_NUMDOC: TStringField
      FieldName = 'DET_NUMDOC'
      Visible = False
      Size = 12
    end
    object qryItensDevDET_ESPDOC: TStringField
      FieldName = 'DET_ESPDOC'
      Visible = False
      Size = 2
    end
    object qryItensDevDET_CODEMP: TStringField
      FieldName = 'DET_CODEMP'
      Visible = False
      Size = 3
    end
    object qryItensDevDET_CODCLI: TStringField
      FieldName = 'DET_CODCLI'
      Visible = False
      Size = 8
    end
    object qryItensDevDET_CODACA: TStringField
      FieldName = 'DET_CODACA'
      Visible = False
      Size = 6
    end
    object qryItensDevDET_PROACA: TStringField
      FieldName = 'DET_PROACA'
      Visible = False
      Size = 1
    end
    object qryItensDevDET_EMPACA: TStringField
      FieldName = 'DET_EMPACA'
      Visible = False
      Size = 3
    end
    object qryItensDevACA_SALDOS: TFloatField
      FieldName = 'ACA_SALDOS'
      Visible = False
    end
    object qryItensDevDET_CODMOT: TStringField
      FieldName = 'DET_CODMOT'
      Visible = False
      Size = 65530
    end
    object qryItensDevDET_CODDIV: TStringField
      FieldName = 'DET_CODDIV'
      Size = 8
    end
    object qryItensDevDET_DESESP: TFloatField
      FieldName = 'DET_DESESP'
    end
    object qryItensDevDET_EMP_PD: TStringField
      FieldName = 'DET_EMP_PD'
      Size = 3
    end
    object qryItensDevREPOST: TStringField
      FieldName = 'REPOST'
      Size = 1
    end
    object qryItensDevQTDDEV: TFloatField
      FieldName = 'QTDDEV'
    end
    object qryItensDevDET_VALICM: TFloatField
      FieldName = 'DET_VALICM'
    end
    object qryItensDevDET_BASICM: TFloatField
      FieldName = 'DET_BASICM'
    end
    object qryItensDevDET_VALRET: TFloatField
      FieldName = 'DET_VALRET'
    end
    object qryItensDevDET_BASRET: TFloatField
      FieldName = 'DET_BASRET'
    end
    object qryItensDevDET_DESACE: TFloatField
      FieldName = 'DET_DESACE'
    end
    object qryItensDevDET_VAL_RT: TFloatField
      FieldName = 'DET_VAL_RT'
    end
    object qryItensDevDET_VALCOF: TFloatField
      FieldName = 'DET_VALCOF'
    end
    object qryItensDevDET_BASPIS: TFloatField
      FieldName = 'DET_BASPIS'
    end
    object qryItensDevDET_VALPIS: TFloatField
      FieldName = 'DET_VALPIS'
    end
    object qryItensDevDET_BASCOF: TFloatField
      FieldName = 'DET_BASCOF'
    end
    object qryItensDevDET_PERBAS: TFloatField
      FieldName = 'DET_PERBAS'
    end
    object qryItensDevDET_PERRED: TFloatField
      FieldName = 'DET_PERRED'
    end
    object qryItensDevDET_ALQICM: TFloatField
      FieldName = 'DET_ALQICM'
    end
    object qryItensDevDET_ALQRET: TFloatField
      FieldName = 'DET_ALQRET'
    end
    object qryItensDevDET_INCPIS: TStringField
      FieldName = 'DET_INCPIS'
    end
    object qryItensDevDET_PEBAST: TFloatField
      FieldName = 'DET_PEBAST'
    end
    object qryItensDevDET_ALQCOF: TFloatField
      FieldName = 'DET_ALQCOF'
    end
    object qryItensDevDET_ALQPIS: TFloatField
      FieldName = 'DET_ALQPIS'
    end
    object qryItensDevDET_CSTCOF: TStringField
      FieldName = 'DET_CSTCOF'
    end
    object qryItensDevDET_CSTPIS: TStringField
      FieldName = 'DET_CSTPIS'
    end
    object qryItensDevDET_NR_COF: TStringField
      FieldName = 'DET_NR_COF'
    end
    object qryItensDevDET_NR_PIS: TStringField
      FieldName = 'DET_NR_PIS'
    end
    object qryItensDevDET_CODFIS: TStringField
      FieldName = 'DET_CODFIS'
    end
    object qryItensDevDET_CODUNI: TStringField
      FieldName = 'DET_CODUNI'
    end
    object qryItensDevMAR_DESMAR: TStringField
      FieldName = 'MAR_DESMAR'
      Size = 30
    end
    object qryItensDevOBSP_1: TStringField
      FieldName = 'OBSP_1'
      Size = 70
    end
    object qryItensDevOBSP_2: TStringField
      FieldName = 'OBSP_2'
      Size = 70
    end
    object qryItensDevCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
    object qryItensDevDET_TOTFRE: TFloatField
      FieldName = 'DET_TOTFRE'
    end
    object qryItensDevDET_TABPRE: TStringField
      FieldName = 'DET_TABPRE'
      Visible = False
      Size = 2
    end
    object qryItensDevDET_UNIVIS: TFloatField
      FieldName = 'DET_UNIVIS'
      Visible = False
    end
    object qryItensDevVALIPI: TFloatField
      FieldName = 'VALIPI'
    end
    object qryItensDevBASIPI: TFloatField
      FieldName = 'BASIPI'
    end
    object qryItensDevVALICM: TFloatField
      FieldName = 'VALICM'
    end
    object qryItensDevBASICM: TFloatField
      FieldName = 'BASICM'
    end
    object qryItensDevVALRET: TFloatField
      FieldName = 'VALRET'
    end
    object qryItensDevBASRET: TFloatField
      FieldName = 'BASRET'
    end
    object qryItensDevDESACE: TFloatField
      FieldName = 'DESACE'
    end
    object qryItensDevTOTFRE: TFloatField
      FieldName = 'TOTFRE'
    end
    object qryItensDevVAL_RT: TFloatField
      FieldName = 'VAL_RT'
    end
    object qryItensDevVALCOF: TFloatField
      FieldName = 'VALCOF'
    end
    object qryItensDevBASPIS: TFloatField
      FieldName = 'BASPIS'
    end
    object qryItensDevBASCOF: TFloatField
      FieldName = 'BASCOF'
    end
    object qryItensDevQTDORI: TFloatField
      FieldName = 'QTDORI'
    end
    object qryItensDevTOTITE: TFloatField
      FieldName = 'TOTITE'
    end
    object qryItensDevVALPIS: TFloatField
      FieldName = 'VALPIS'
    end
    object qryItensDevDESESP: TFloatField
      FieldName = 'DESESP'
    end
    object qryItensDevNUMSER: TStringField
      FieldName = 'NUMSER'
      Size = 255
    end
    object qryItensDevDET_PROEMB: TStringField
      FieldName = 'DET_PROEMB'
      Size = 1
    end
    object qryItensDevDET_DTAENT: TDateField
      FieldName = 'DET_DTAENT'
    end
    object qryItensDevNUMLOT: TStringField
      FieldName = 'DET_NUMLOT'
      Size = 30
    end
    object qryItensDevDET_BFCPST: TFloatField
      FieldName = 'DET_BFCPST'
    end
    object qryItensDevDET_PFCPST: TFloatField
      FieldName = 'DET_PFCPST'
    end
    object qryItensDevDET_VFCPST: TFloatField
      FieldName = 'DET_VFCPST'
    end
    object qryItensDevBFCPST: TFloatField
      FieldName = 'BFCPST'
    end
    object qryItensDevPFCPST: TFloatField
      FieldName = 'PFCPST'
    end
    object qryItensDevVFCPST: TFloatField
      FieldName = 'VFCPST'
    end
    object qryItensDevICD_PERFCP: TFloatField
      FieldName = 'ICD_PERFCP'
    end
    object qryItensDevICD_BASFCP: TFloatField
      FieldName = 'ICD_BASFCP'
    end
    object qryItensDevICD_VALFCP: TFloatField
      FieldName = 'ICD_VALFCP'
    end
    object qryItensDevPERFCP: TFloatField
      FieldName = 'PERFCP'
    end
    object qryItensDevBASFCP: TFloatField
      FieldName = 'BASFCP'
    end
    object qryItensDevVALFCP: TFloatField
      FieldName = 'VALFCP'
    end
    object qryItensDevTABELA: TStringField
      FieldName = 'TABELA'
      Size = 6
    end
    object qryItensDevDET_IDEPRO: TStringField
      FieldName = 'DET_IDEPRO'
      Size = 3
    end
    object qryItensDevDET_ITETIN: TStringField
      FieldName = 'DET_ITETIN'
      Size = 3
    end
    object qryItensDevINCORI: TStringField
      FieldName = 'INCORI'
    end
    object qryItensDevITEATI: TStringField
      FieldName = 'ITEATI'
      Size = 1
    end
    object qryItensDevIMPLIS: TStringField
      FieldName = 'IMPLIS'
      Size = 1
    end
    object qryItensDevITE_CODFAB: TStringField
      FieldName = 'ITE_CODFAB'
      Size = 50
    end
    object qryItensDevDET_SERIE_: TStringField
      FieldName = 'DET_SERIE_'
      Size = 3
    end
    object qryItensDevUNICRD: TFloatField
      FieldName = 'UNICRD'
    end
    object qryItensDevINCFUT: TStringField
      FieldName = 'INCFUT'
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItensDev
    Left = 128
    Top = 152
  end
  object cdsItensDev: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItensDev'
    BeforePost = cdsItensDevBeforePost
    Left = 184
    Top = 240
    object cdsItensDevDET_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'DET_CODITE'
      Size = 5
    end
    object cdsItensDevITE_CODGRU: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'ITE_CODGRU'
      Size = 6
    end
    object cdsItensDevDET_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DET_DESCRI'
      Size = 57
    end
    object cdsItensDevDET_UNIDAD: TStringField
      DisplayLabel = 'UN'
      FieldName = 'DET_UNIDAD'
      Size = 2
    end
    object cdsItensDevDET_QTDITE: TFloatField
      DisplayLabel = 'Quantidade'
      DisplayWidth = 9
      FieldName = 'DET_QTDITE'
      DisplayFormat = '##0.00'
    end
    object cdsItensDevDET_PRECUS: TFloatField
      FieldName = 'DET_PRECUS'
      DisplayFormat = '##0.00'
    end
    object cdsItensDevDET_CODFOR: TStringField
      FieldName = 'DET_CODFOR'
    end
    object cdsItensDevDET_UNITAR: TFloatField
      DisplayLabel = 'Vr.Unit'#225'rio'
      DisplayWidth = 9
      FieldName = 'DET_UNITAR'
      DisplayFormat = '##0.0000'
    end
    object cdsItensDevDET_VALIPI: TFloatField
      DisplayLabel = 'Valor IPI'
      FieldName = 'DET_VALIPI'
      DisplayFormat = '##0.00'
    end
    object cdsItensDevDET_TOTITE: TFloatField
      DisplayLabel = 'Total do Item'
      FieldName = 'DET_TOTITE'
      DisplayFormat = '##0.00'
      currency = True
    end
    object cdsItensDevDET_ALQIPI: TFloatField
      FieldName = 'DET_ALQIPI'
      Visible = False
    end
    object cdsItensDevDET_BASIPI: TFloatField
      FieldName = 'DET_BASIPI'
      Visible = False
    end
    object cdsItensDevAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object cdsItensDevDET_NUMDOC: TStringField
      FieldName = 'DET_NUMDOC'
      Visible = False
      Size = 12
    end
    object cdsItensDevDET_ESPDOC: TStringField
      FieldName = 'DET_ESPDOC'
      Visible = False
      Size = 2
    end
    object cdsItensDevDET_CODEMP: TStringField
      FieldName = 'DET_CODEMP'
      Visible = False
      Size = 3
    end
    object cdsItensDevDET_CODCLI: TStringField
      FieldName = 'DET_CODCLI'
      Visible = False
      Size = 8
    end
    object cdsItensDevDET_CODACA: TStringField
      FieldName = 'DET_CODACA'
      Visible = False
      Size = 6
    end
    object cdsItensDevDET_PROACA: TStringField
      FieldName = 'DET_PROACA'
      Visible = False
      Size = 1
    end
    object cdsItensDevITEATI: TStringField
      FieldName = 'ITEATI'
      Visible = False
      Size = 1
    end
    object cdsItensDevIMPLIS: TStringField
      FieldName = 'IMPLIS'
      Visible = False
      Size = 1
    end
    object cdsItensDevDET_EMPACA: TStringField
      FieldName = 'DET_EMPACA'
      Visible = False
      Size = 3
    end
    object cdsItensDevACA_SALDOS: TFloatField
      FieldName = 'ACA_SALDOS'
      Visible = False
    end
    object cdsItensDevDET_CODMOT: TStringField
      FieldName = 'DET_CODMOT'
      Visible = False
      Size = 3
    end
    object cdsItensDevDET_CODDIV: TStringField
      FieldName = 'DET_CODDIV'
      Visible = False
      Size = 8
    end
    object cdsItensDevDET_DESESP: TFloatField
      FieldName = 'DET_DESESP'
      Visible = False
    end
    object cdsItensDevDET_EMP_PD: TStringField
      FieldName = 'DET_EMP_PD'
      Visible = False
      Size = 3
    end
    object cdsItensDevREPOST: TStringField
      DisplayLabel = 'Reposto'
      FieldName = 'REPOST'
      Size = 1
    end
    object cdsItensDevQTDDEV: TFloatField
      FieldName = 'QTDDEV'
    end
    object cdsItensDevDET_VALICM: TFloatField
      FieldName = 'DET_VALICM'
    end
    object cdsItensDevDET_BASICM: TFloatField
      FieldName = 'DET_BASICM'
    end
    object cdsItensDevDET_VALRET: TFloatField
      FieldName = 'DET_VALRET'
    end
    object cdsItensDevDET_BASRET: TFloatField
      FieldName = 'DET_BASRET'
    end
    object cdsItensDevDET_DESACE: TFloatField
      FieldName = 'DET_DESACE'
    end
    object cdsItensDevDET_VAL_RT: TFloatField
      FieldName = 'DET_VAL_RT'
    end
    object cdsItensDevDET_VALCOF: TFloatField
      FieldName = 'DET_VALCOF'
    end
    object cdsItensDevDET_BASPIS: TFloatField
      FieldName = 'DET_BASPIS'
    end
    object cdsItensDevDET_VALPIS: TFloatField
      FieldName = 'DET_VALPIS'
    end
    object cdsItensDevDET_BASCOF: TFloatField
      FieldName = 'DET_BASCOF'
    end
    object cdsItensDevDET_PERBAS: TFloatField
      FieldName = 'DET_PERBAS'
    end
    object cdsItensDevDET_PERRED: TFloatField
      FieldName = 'DET_PERRED'
    end
    object cdsItensDevDET_ALQICM: TFloatField
      FieldName = 'DET_ALQICM'
    end
    object cdsItensDevDET_ALQRET: TFloatField
      FieldName = 'DET_ALQRET'
    end
    object cdsItensDevDET_INCPIS: TStringField
      FieldName = 'DET_INCPIS'
    end
    object cdsItensDevDET_PEBAST: TFloatField
      FieldName = 'DET_PEBAST'
    end
    object cdsItensDevDET_ALQCOF: TFloatField
      FieldName = 'DET_ALQCOF'
    end
    object cdsItensDevDET_ALQPIS: TFloatField
      FieldName = 'DET_ALQPIS'
    end
    object cdsItensDevDET_CSTCOF: TStringField
      FieldName = 'DET_CSTCOF'
      Size = 0
    end
    object cdsItensDevDET_CSTPIS: TStringField
      FieldName = 'DET_CSTPIS'
    end
    object cdsItensDevDET_NR_COF: TStringField
      FieldName = 'DET_NR_COF'
    end
    object cdsItensDevDET_NR_PIS: TStringField
      FieldName = 'DET_NR_PIS'
    end
    object cdsItensDevDET_CODFIS: TStringField
      FieldName = 'DET_CODFIS'
    end
    object cdsItensDevDET_CODUNI: TStringField
      FieldName = 'DET_CODUNI'
    end
    object cdsItensDevMAR_DESMAR: TStringField
      FieldName = 'MAR_DESMAR'
      Size = 30
    end
    object cdsItensDevOBSP_1: TStringField
      FieldName = 'OBSP_1'
      Size = 70
    end
    object cdsItensDevOBSP_2: TStringField
      FieldName = 'OBSP_2'
      Size = 70
    end
    object cdsItensDevCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
    object cdsItensDevDET_TOTFRE: TFloatField
      FieldName = 'DET_TOTFRE'
    end
    object cdsItensDevDET_TABPRE: TStringField
      FieldName = 'DET_TABPRE'
      Visible = False
      Size = 2
    end
    object cdsItensDevDET_UNIVIS: TFloatField
      FieldName = 'DET_UNIVIS'
      Visible = False
    end
    object cdsItensDevVALIPI: TFloatField
      FieldName = 'VALIPI'
    end
    object cdsItensDevBASIPI: TFloatField
      FieldName = 'BASIPI'
    end
    object cdsItensDevVALICM: TFloatField
      FieldName = 'VALICM'
    end
    object cdsItensDevBASICM: TFloatField
      FieldName = 'BASICM'
    end
    object cdsItensDevVALRET: TFloatField
      FieldName = 'VALRET'
    end
    object cdsItensDevBASRET: TFloatField
      FieldName = 'BASRET'
    end
    object cdsItensDevDESACE: TFloatField
      FieldName = 'DESACE'
    end
    object cdsItensDevTOTFRE: TFloatField
      FieldName = 'TOTFRE'
    end
    object cdsItensDevVAL_RT: TFloatField
      FieldName = 'VAL_RT'
    end
    object cdsItensDevBASPIS: TFloatField
      FieldName = 'BASPIS'
    end
    object cdsItensDevBASCOF: TFloatField
      FieldName = 'BASCOF'
    end
    object cdsItensDevQTDORI: TFloatField
      FieldName = 'QTDORI'
    end
    object cdsItensDevTOTITE: TFloatField
      FieldName = 'TOTITE'
    end
    object cdsItensDevVALPIS: TFloatField
      FieldName = 'VALPIS'
    end
    object cdsItensDevVALCOF: TFloatField
      FieldName = 'VALCOF'
    end
    object cdsItensDevDESESP: TFloatField
      FieldName = 'DESESP'
    end
    object cdsItensDevNUMSER: TStringField
      FieldName = 'NUMSER'
      Size = 255
    end
    object cdsItensDevDET_PROEMB: TStringField
      FieldName = 'DET_PROEMB'
      Size = 1
    end
    object cdsItensDevDET_DTAENT: TDateField
      FieldName = 'DET_DTAENT'
    end
    object cdsItensDevDET_NUMLOT: TStringField
      FieldName = 'DET_NUMLOT'
    end
    object cdsItensDevBFCPST: TFloatField
      FieldName = 'BFCPST'
    end
    object cdsItensDevPFCPST: TFloatField
      FieldName = 'PFCPST'
    end
    object cdsItensDevVFCPST: TFloatField
      FieldName = 'VFCPST'
    end
    object cdsItensDevDET_BFCPST: TFloatField
      FieldName = 'DET_BFCPST'
    end
    object cdsItensDevDET_PFCPST: TFloatField
      FieldName = 'DET_PFCPST'
    end
    object cdsItensDevDET_VFCPST: TFloatField
      FieldName = 'DET_VFCPST'
    end
    object cdsItensDevICD_BASFCP: TFloatField
      FieldName = 'ICD_BASFCP'
    end
    object cdsItensDevICD_PERFCP: TFloatField
      FieldName = 'ICD_PERFCP'
    end
    object cdsItensDevICD_VALFCP: TFloatField
      FieldName = 'ICD_VALFCP'
    end
    object cdsItensDevBASFCP: TFloatField
      FieldName = 'BASFCP'
    end
    object cdsItensDevPERFCP: TFloatField
      FieldName = 'PERFCP'
    end
    object cdsItensDevVALFCP: TFloatField
      FieldName = 'VALFCP'
    end
    object cdsItensDevTABELA: TStringField
      FieldName = 'TABELA'
      Size = 6
    end
    object cdsItensDevDET_IDEPRO: TStringField
      FieldName = 'DET_IDEPRO'
      Size = 3
    end
    object cdsItensDevDET_ITETIN: TStringField
      FieldName = 'DET_ITETIN'
      Size = 3
    end
    object cdsItensDevINCORI: TStringField
      FieldName = 'INCORI'
    end
    object cdsItensDevITE_CODFAB: TStringField
      FieldName = 'ITE_CODFAB'
      Size = 50
    end
    object cdsItensDevDET_SERIE_: TStringField
      FieldName = 'DET_SERIE_'
      Size = 3
    end
    object cdsItensDevUNICRD: TFloatField
      FieldName = 'UNICRD'
    end
    object cdsItensDevINCFUT: TStringField
      FieldName = 'INCFUT'
    end
  end
  object dspItensDev: TUniDataSetProvider
    DataSet = qryItensDev
    Options = []
    Left = 200
    Top = 80
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 592
    Top = 112
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
  object cxStyleRepository2: TcxStyleRepository
    Left = 720
    Top = 104
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clSilver
    end
  end
end
