inherited frmFatRetirarVinculoReq_Transf: TfrmFatRetirarVinculoReq_Transf
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 
    'Retirar V'#237'nculo com Requisi'#231#227'o de Compra e/ou Solicita'#231#227'o de Tra' +
    'nsfer'#234'ncia'
  WindowState = wsMaximized
  OnClose = FormClose
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 514
    Width = 1008
    Height = 31
    BevelInner = bvNone
    BevelOuter = bvRaised
    BorderWidth = 2
    Color = 16770261
    ExplicitTop = 514
    ExplicitWidth = 1008
    ExplicitHeight = 31
    object Label1: TLabel [0]
      Left = 12
      Top = 3
      Width = 916
      Height = 25
      Align = alClient
      Alignment = taCenter
      Caption = 
        'Pressione [ DELETE ] para remover o V'#237'nculo do produto posiciona' +
        'do com a Requisi'#231#227'o de Compra ou Solicita'#231#227'o de Transfer'#234'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 3
      ExplicitWidth = 716
      ExplicitHeight = 14
    end
    inherited FlwBotoes: TFlowPanel
      Left = 3
      Top = 3
      Width = 9
      Height = 25
      Align = alLeft
      ExplicitLeft = 3
      ExplicitTop = 3
      ExplicitWidth = 9
      ExplicitHeight = 25
    end
    inherited btnSair: TBitBtnLocked
      Left = 928
      Height = 25
      Align = alRight
      Caption = 'Sair'
      ExplicitLeft = 928
      ExplicitHeight = 25
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 514
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBBandedTableViewCitel
      OnKeyDown = cxgItensViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsItens
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
      Bands = <
        item
          Caption = 'PRODUTOS'
          Styles.Header = cxsHeader
        end
        item
          Caption = 'COMPRAS'
          Styles.Header = cxsHeader
        end
        item
          Caption = 'TRANSFER'#202'NCIAS'
          Styles.Header = cxsHeader
        end>
      Zebra = True
      Destaque = False
      DestacarRegistro = False
      CorZebra = clMoneyGreen
      object cxgItensViewAutoincremento: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Autoincremento'
        Visible = False
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensViewCdigo: TcxGridDBBandedColumn
        DataBinding.FieldName = 'C'#243'digo'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 51
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensViewDescrio: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Descri'#231#227'o'
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 321
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensViewUnidade: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Unidade'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 45
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensViewQuantidade: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Quantidade'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 61
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensViewFaturTotal: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Fatur. Total'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 58
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensViewEmpFat: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Emp. Fat.'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 62
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensViewSaldoEstoque: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Saldo Estoque'
        Visible = False
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 77
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgItensViewRequisio: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Requisi'#231#227'o'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 64
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensViewQtdRequisio: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Qtd. Requisi'#231#227'o'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 82
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensViewPeddeCompra: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Ped. de Compra'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 117
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensViewDataEntrega: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Data Entrega'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 68
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensViewNotadeEntrada: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Nota de Entrada'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 95
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensViewQtdTransf: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Qtd. Transf.'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensViewPeddeTransf: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Ped. de Transf.'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 117
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensViewNotadeTransf: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Nota de Transf.'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 117
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    ExplicitTop = 545
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 694
      Width = 314
      ExplicitLeft = 694
      ExplicitWidth = 314
    end
    inherited pnlInfo: TPanel
      Width = 694
      ExplicitWidth = 694
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 164
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 476
    Top = 164
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 180
    Top = 168
  end
  object dsItens: TDataSource
    DataSet = qryItens
    Left = 560
    Top = 164
  end
  object cxStyle: TcxStyleRepository
    Left = 220
    Top = 272
    PixelsPerInch = 96
    object cxsHeader: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object qryItens: TUniQuery
    SQL.Strings = (
      'SELECT '
      '  FD.AUTOINCREM AS '#39'Autoincremento'#39','
      '  FD.FDO_CODITE AS '#39'C'#243'digo'#39','
      '  FD.FDO_DESCRI AS '#39'Descri'#231#227'o'#39','
      '  UN.UNI_SIGUNI AS '#39'Unidade'#39','
      '  FD.FDO_QTDITE AS '#39'Quantidade'#39','
      '  IF(EG.FGO_FATTOT = '#39'S'#39', '#39'Sim'#39','#39#39') AS '#39'Fatur. Total'#39',    '
      '  FD.FDO_EMPITE AS '#39'Emp. Fat.'#39','
      '  IT.ITE_SALDOS AS '#39'Saldo Estoque'#39',    '
      '  RQ.AUTOINCREM '#39'Seq. Requisi'#231#227'o'#39','
      '  CONCAT(RC.RCD_CODIGO, '#39'-'#39', RC.RCD_CODEMP) AS '#39'Requisi'#231#227'o'#39','
      '  RQ.PRQ_QTDITE AS '#39'Qtd. Requisi'#231#227'o'#39','
      
        '  CONCAT(PD.PCD_NUMPED, '#39'-'#39', PD.PCD_ESPDOC, '#39'-'#39', PD.PCD_CODEMP) ' +
        'AS '#39'Ped. de Compra'#39','
      '  PD.PCD_DTAENT AS '#39'Data Entrega'#39',  '
      
        '  (SELECT CONCAT(DET_NUMDOC, '#39'-'#39', DET_ESPDOC) FROM MOVDET WHERE ' +
        'AUTOINCREM = BQ.BAI_AUTDET) AS '#39'Nota de Entrada'#39',  '
      '  COALESCE(TE.AUTOINCREM, TV.AUTOINCREM) '#39'Seq. Transf.'#39','
      '  IFNULL(TE.PRE_QTDITE, TV.PRE_QTDITE) AS '#39'Qtd. Transf.'#39','
      
        '  (SELECT CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) F' +
        'ROM FATGOR WHERE FGO_NUMDOC = IFNULL(TE.PRE_NUMDOC, TV.PRE_NUMDO' +
        'C) AND FGO_ESPDOC = IFNULL(TE.PRE_ESPDOC, TV.PRE_ESPDOC) AND FGO' +
        '_CODEMP = IFNULL(TE.PRE_EMPDOC, TV.PRE_EMPDOC)) AS '#39'Ped. de Tran' +
        'sf.'#39','
      
        '  (SELECT CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT) F' +
        'ROM FATGOR WHERE FGO_NUMDOC = IFNULL(TE.PRE_NUMDOC, TV.PRE_NUMDO' +
        'C) AND FGO_ESPDOC = IFNULL(TE.PRE_ESPDOC, TV.PRE_ESPDOC) AND FGO' +
        '_CODEMP = IFNULL(TE.PRE_EMPDOC, TV.PRE_EMPDOC)) AS '#39'Nota de Tran' +
        'sf.'#39','
      '  CONCAT(FGO_NUMDOC,'#39'-'#39',FGO_ESPDOC,'#39'-'#39',FGO_CODEMP) AS Documento'
      'FROM FATGOR FG'
      'JOIN EXTGOR EG ON EG.FGO_SEQFGO = FG.AUTOINCREM'
      'JOIN FATDOR FD ON FD.FDO_SEQGER = FG.AUTOINCREM'
      
        'JOIN ITEGER IT ON IT.ITE_CODITE = FD.FDO_CODITE AND IT.ITE_CODEM' +
        'P = IFNULL(FD.FDO_EMPITE, FD.FDO_CODEMP)'
      'JOIN CADUNI UN ON UN.UNI_CODUNI = FD.FDO_UNIDAD'
      'LEFT JOIN FDOABS AB ON AB.ABS_SEQFDO = FD.AUTOINCREM'
      'LEFT JOIN PREPRQ RQ ON RQ.AUTOINCREM = AB.ABS_SEQPRQ'
      
        'LEFT JOIN MOVRCD RC ON RC.RCD_CODIGO = RQ.PRQ_CODREQ AND RC.RCD_' +
        'CODEMP = RQ.PRQ_EMPREQ AND RC.RCD_CODITE = FD.FDO_CODITE AND ROU' +
        'ND(RC.RCD_QTDITE, 2) = ROUND(RQ.PRQ_QTDITE, 2)'
      'LEFT JOIN BAIREQ BQ ON BQ.BAI_AUTREQ = RC.AUTOINCREM'
      'LEFT JOIN PCMDET PD ON PD.AUTOINCREM = RC.RCD_SEQPCD'
      'LEFT JOIN PREPTE TE ON TE.AUTOINCREM = AB.ABS_SEQPTE'
      'LEFT JOIN REQVEN VE ON VE.SEQ_MOVRCD = RC.AUTOINCREM'
      'LEFT JOIN PREPTE TV ON TV.AUTOINCREM = VE.SEQ_PREPTE'
      'WHERE TRUE'
      '  AND FG.FGO_JAFATU = 0'
      '  AND FG.FGO_NUMDOC = :NUMDOC'
      '  AND FG.FGO_ESPDOC = :ESPDOC'
      '  AND FG.FGO_CODEMP = :EMPDOC'
      
        'HAVING (IFNULL(`Qtd. Requisi'#231#227'o`, 0) + IFNULL(`Qtd. Transf.`, 0)' +
        ') > 0'
      'ORDER BY `Autoincremento`')
    Constraints = <>
    Left = 560
    Top = 124
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NUMDOC'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ESPDOC'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'EMPDOC'
        Value = nil
      end>
    object qryItensAutoincremento: TStringField
      FieldName = 'Autoincremento'
      Required = True
    end
    object qryItensCódigo: TStringField
      Alignment = taCenter
      FieldName = 'C'#243'digo'
      Required = True
      Size = 5
    end
    object qryItensDescrição: TStringField
      FieldName = 'Descri'#231#227'o'
      Size = 101
    end
    object qryItensUnidade: TStringField
      Alignment = taCenter
      FieldName = 'Unidade'
      ReadOnly = True
      Size = 4
    end
    object qryItensQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = '#,##0.000'
    end
    object qryItensFaturTotal: TStringField
      Alignment = taCenter
      FieldName = 'Fatur. Total'
      ReadOnly = True
      Required = True
      Size = 3
    end
    object qryItensEmpFat: TStringField
      Alignment = taCenter
      FieldName = 'Emp. Fat.'
      FixedChar = True
      Size = 3
    end
    object qryItensSaldoEstoque: TFloatField
      FieldName = 'Saldo Estoque'
      ReadOnly = True
      DisplayFormat = '#,##0.000'
    end
    object qryItensSeqRequisição: TStringField
      FieldName = 'Seq. Requisi'#231#227'o'
    end
    object qryItensRequisição: TStringField
      Alignment = taCenter
      FieldName = 'Requisi'#231#227'o'
      ReadOnly = True
      Size = 10
    end
    object qryItensQtdRequisição: TFloatField
      FieldName = 'Qtd. Requisi'#231#227'o'
      ReadOnly = True
      DisplayFormat = '#,##0.000'
    end
    object qryItensPeddeCompra: TStringField
      Alignment = taCenter
      FieldName = 'Ped. de Compra'
      ReadOnly = True
      Size = 19
    end
    object qryItensDataEntrega: TDateField
      Alignment = taCenter
      FieldName = 'Data Entrega'
      ReadOnly = True
    end
    object qryItensNotadeEntrada: TStringField
      Alignment = taCenter
      FieldName = 'Nota de Entrada'
      ReadOnly = True
      Size = 15
    end
    object qryItensSeqTransf: TStringField
      FieldName = 'Seq. Transf.'
    end
    object qryItensQtdTransf: TFloatField
      FieldName = 'Qtd. Transf.'
      ReadOnly = True
      DisplayFormat = '#,##0.000'
    end
    object qryItensPeddeTransf: TStringField
      Alignment = taCenter
      FieldName = 'Ped. de Transf.'
      ReadOnly = True
      Size = 19
    end
    object qryItensNotadeTransf: TStringField
      Alignment = taCenter
      FieldName = 'Nota de Transf.'
      ReadOnly = True
      Size = 19
    end
    object qryItensDocumento: TStringField
      FieldName = 'Documento'
      Visible = False
    end
  end
end
