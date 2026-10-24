inherited frmNFEXMLAuditoria: TfrmNFEXMLAuditoria
  Width = 1024
  Height = 768
  Caption = 'Documentos n'#227'o encotrados no Livro Fiscal'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnExportar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 166
        Height = 22
        Caption = '[ F10 ] &Exportar'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
          FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
          00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
          F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
          00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
          F033777777777337F73309999990FFF0033377777777FFF77333099999000000
          3333777777777777333333399033333333333337773333333333333903333333
          3333333773333333333333303333333333333337333333333333}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnExportarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      ExplicitLeft = 938
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
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
  object cxgDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 695
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dstDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvDadosColumn1: TcxGridDBColumn
        Caption = 'Agrupador'
        DataBinding.FieldName = 'ADT_AGRUPA'
      end
      object cxvDadosColumn10: TcxGridDBColumn
        Caption = 'Chave de Acesso'
        DataBinding.FieldName = 'ADT_CHAVEA'
      end
      object cxvDadosColumn2: TcxGridDBColumn
        Caption = 'Valor da Nota'
        DataBinding.FieldName = 'VLRNF'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 96
      end
      object cxvDadosColumn3: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'ADT_NUMDOC'
        Width = 98
      end
      object cxvDadosColumn4: TcxGridDBColumn
        Caption = 'Serie'
        DataBinding.FieldName = 'ADT_SERIE_'
        Width = 94
      end
      object cxvDadosColumn5: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FORNEC'
      end
      object cxvDadosColumn6: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMPRESA'
      end
      object cxvDadosColumn7: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'ADT_STATUS'
      end
      object cxvDadosColumn8: TcxGridDBColumn
        Caption = 'Motivo'
        DataBinding.FieldName = 'ADT_MOTIVO'
      end
      object cxvDadosColumn9: TcxGridDBColumn
        Caption = 'Arquivo'
        DataBinding.FieldName = 'ADT_ARQUIV'
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxvDados
    end
  end
  object dstDados: TDataSource
    Left = 496
    Top = 368
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Arquivo CSV|*.csv'
    Left = 368
    Top = 216
  end
end
