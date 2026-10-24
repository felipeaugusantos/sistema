inherited frmRelNossoNum: TfrmRelNossoNum
  Width = 1239
  Height = 596
  Caption = 'frmRelNossoNum'
  ExplicitWidth = 1239
  ExplicitHeight = 596
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 524
    Width = 1233
    ExplicitTop = 524
    ExplicitWidth = 1233
    inherited btnSair: TBitBtnLocked
      Left = 1150
      ExplicitLeft = 1150
    end
  end
  inherited pnlStatus: TPanel
    Top = 552
    Width = 1233
    ExplicitTop = 552
    ExplicitWidth = 1233
    inherited pnlNomeForm: TPanel
      Left = 1062
      ExplicitLeft = 1062
    end
    inherited pnlInfo: TPanel
      Width = 1062
      ExplicitWidth = 1062
    end
  end
  object grdDetalhe: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 1233
    Height = 524
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdDetalheDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsRegistros
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      object grdDetalheDBTableView1CTR_BANCO_: TcxGridDBColumn
        Caption = 'BANCO'
        DataBinding.FieldName = 'CTR_BANCO_'
        Width = 117
      end
      object grdDetalheDBTableView1CTR_NUMDUP: TcxGridDBColumn
        Caption = 'DUPLICATA'
        DataBinding.FieldName = 'CTR_NUMDUP'
        Width = 86
      end
      object grdDetalheDBTableView1CTR_PARCEL: TcxGridDBColumn
        Caption = 'PARCELA'
        DataBinding.FieldName = 'CTR_PARCEL'
      end
      object grdDetalheDBTableView1CTR_ESPDOC: TcxGridDBColumn
        Caption = 'ESP.'
        DataBinding.FieldName = 'CTR_ESPDOC'
      end
      object grdDetalheDBTableView1CTR_CLIENTE: TcxGridDBColumn
        DataBinding.FieldName = 'CTR_CLIENTE'
        Width = 421
      end
      object grdDetalheDBTableView1CTR_DTAVEN: TcxGridDBColumn
        Caption = 'VENCIMENTO'
        DataBinding.FieldName = 'CTR_DTAVEN'
        Width = 111
      end
      object grdDetalheDBTableView1CTR_CODEMP: TcxGridDBColumn
        Caption = 'EMPRESA'
        DataBinding.FieldName = 'CTR_CODEMP'
      end
      object grdDetalheDBTableView1CTR_VALORI: TcxGridDBColumn
        Caption = 'VALOR'
        DataBinding.FieldName = 'CTR_VALORI'
        Width = 106
      end
      object grdDetalheDBTableView1CTR_NOSNUM: TcxGridDBColumn
        Caption = 'NOSSO N'#218'M. AUTCOM'
        DataBinding.FieldName = 'CTR_NOSNUM'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 182
      end
      object grdDetalheDBTableView1CTR_NOSNU_: TcxGridDBColumn
        Caption = 'NOSSO N'#218'M. REMESSA'
        DataBinding.FieldName = 'CTR_NOSNU_'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 197
      end
      object grdDetalheDBTableView1CTR_LINDIG: TcxGridDBColumn
        DataBinding.FieldName = 'CTR_LINDIG'
        Width = 575
      end
    end
    object grdDetalheLevel1: TcxGridLevel
      GridView = grdDetalheDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 200
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 64
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 96
  end
  object dsRegistros: TDataSource
    Left = 272
    Top = 96
  end
end
