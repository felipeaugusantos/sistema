inherited frmRecuperarVendaSelec: TfrmRecuperarVendaSelec
  Width = 795
  Height = 432
  BorderStyle = bsSizeable
  Caption = 'Vendas que n'#227'o foram finalizadas corretamente'
  ExplicitWidth = 795
  ExplicitHeight = 432
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 351
    Width = 779
    TabOrder = 1
    ExplicitTop = 351
    ExplicitWidth = 779
    inherited FlwBotoes: TFlowPanel
      Width = 698
      ExplicitWidth = 698
      inherited btnConfirma: TBitBtnLocked
        Width = 135
        Caption = '&Recuperar venda'
        ExplicitWidth = 135
      end
      object btnDescarta: TBitBtnLocked
        Left = 135
        Top = 0
        Width = 237
        Height = 22
        Caption = '&Descartar c'#243'pia de seguran'#231'a da venda'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnDescartaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 700
      Top = 2
      Align = alRight
      Caption = 'S&air'
      ExplicitLeft = 700
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 377
    Width = 779
    TabOrder = 2
    ExplicitTop = 377
    ExplicitWidth = 779
    inherited pnlNomeForm: TPanel
      Left = 608
      ExplicitLeft = 608
    end
    inherited pnlInfo: TPanel
      Width = 608
      ExplicitWidth = 608
    end
  end
  object cxgVendas: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 779
    Height = 351
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgVendasView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsVendas
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgVendasViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'd. Ope.'
        DataBinding.FieldName = 'CODOPE'
        HeaderAlignmentHorz = taCenter
        Width = 56
      end
      object cxgVendasViewColumn2: TcxGridDBColumn
        Caption = 'Nome Operador'
        DataBinding.FieldName = 'NOMOPE'
        Width = 93
      end
      object cxgVendasViewColumn3: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        HeaderAlignmentHorz = taCenter
        Width = 51
      end
      object cxgVendasViewNUMPED: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        HeaderAlignmentHorz = taCenter
        Width = 117
      end
      object cxgVendasViewColumn5: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CODCLI'
        HeaderAlignmentHorz = taCenter
        Width = 67
      end
      object cxgVendasViewColumn6: TcxGridDBColumn
        Caption = 'Nome Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Width = 184
      end
      object cxgVendasViewVALPED: TcxGridDBColumn
        Caption = 'Total dos Itens'
        DataBinding.FieldName = 'VALDOC'
        HeaderAlignmentHorz = taRightJustify
        Width = 101
      end
      object cxgVendasViewColumn7: TcxGridDBColumn
        Caption = 'Data/Hora Venda'
        DataBinding.FieldName = 'HORVEN'
        HeaderAlignmentHorz = taCenter
        Width = 108
      end
    end
    object cxgVendasLevel: TcxGridLevel
      GridView = cxgVendasView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 520
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
  end
  object cdsVendas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 184
    object cdsVendasCODOPE: TStringField
      Alignment = taCenter
      FieldName = 'CODOPE'
      Size = 3
    end
    object cdsVendasNOMOPE: TStringField
      FieldName = 'NOMOPE'
      Size = 50
    end
    object cdsVendasCODEMP: TStringField
      Alignment = taCenter
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsVendasNUMDOC: TStringField
      Alignment = taCenter
      FieldName = 'NUMDOC'
    end
    object cdsVendasCODCLI: TStringField
      Alignment = taCenter
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsVendasNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 50
    end
    object cdsVendasHORVEN: TDateTimeField
      Alignment = taCenter
      FieldName = 'HORVEN'
    end
    object cdsVendasNOMTAB: TStringField
      FieldName = 'NOMTAB'
      Size = 50
    end
    object cdsVendasVALDOC: TFloatField
      FieldName = 'VALDOC'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsVendas: TDataSource
    DataSet = cdsVendas
    Left = 384
    Top = 200
  end
end
