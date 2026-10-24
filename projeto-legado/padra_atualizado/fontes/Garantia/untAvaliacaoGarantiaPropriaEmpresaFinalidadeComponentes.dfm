inherited frmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes: TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes
  Width = 849
  Caption = 'Avalia'#231#227'o Garantia Pr'#243'pria Empresa - Finalidade Componentes'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 849
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 843
    ExplicitWidth = 843
    inherited FlwBotoes: TFlowPanel
      Width = 839
      ExplicitWidth = 839
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 137
        Height = 22
        Caption = '[F10] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 763
      ExplicitLeft = 763
    end
  end
  inherited pnlStatus: TPanel
    Width = 843
    ExplicitWidth = 843
    inherited pnlNomeForm: TPanel
      Left = 522
      Width = 321
      ExplicitLeft = 522
      ExplicitWidth = 321
    end
    inherited pnlInfo: TPanel
      Width = 522
      ExplicitWidth = 522
    end
  end
  object cxGridCitel1: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 843
    Height = 189
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsComponente
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridCitel1DBTableViewCitel1ITESUB: TcxGridDBColumn
        DataBinding.FieldName = 'ITESUB'
        Options.Editing = False
        Width = 60
      end
      object cxGridCitel1DBTableViewCitel1CODFAB: TcxGridDBColumn
        DataBinding.FieldName = 'CODFAB'
        Options.Editing = False
      end
      object cxGridCitel1DBTableViewCitel1DESITE: TcxGridDBColumn
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
      end
      object cxGridCitel1DBTableViewCitel1QTDITE: TcxGridDBColumn
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxGridCitel1DBTableViewCitel1QTDDISP: TcxGridDBColumn
        DataBinding.FieldName = 'QTDDISP'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxGridCitel1DBTableViewCitel1QTDAPR: TcxGridDBColumn
        DataBinding.FieldName = 'QTDAPR'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxGridCitel1DBTableViewCitel1ORIGEM: TcxGridDBColumn
        DataBinding.FieldName = 'ORIGEM'
        PropertiesClassName = 'TcxComboBoxProperties'
      end
      object cxGridCitel1DBTableViewCitel1MOTIVO: TcxGridDBColumn
        DataBinding.FieldName = 'MOTIVO'
        PropertiesClassName = 'TcxComboBoxProperties'
      end
      object cxGridCitel1DBTableViewCitel1DESTINO: TcxGridDBColumn
        DataBinding.FieldName = 'DESTINO'
        PropertiesClassName = 'TcxComboBoxProperties'
      end
    end
    object cxGridCitel1Level1: TcxGridLevel
      GridView = cxGridCitel1DBTableViewCitel1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 48
  end
  object cdsComponente: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsComponenteBeforePost
    BeforeScroll = cdsComponenteBeforeScroll
    Left = 552
    Top = 64
    object cdsComponenteDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o Componente'
      FieldName = 'DESITE'
      Size = 50
    end
    object cdsComponenteITESUB: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ITESUB'
      Size = 5
    end
    object cdsComponenteQTDITE: TFloatField
      DisplayLabel = 'Qtd Consumida'
      FieldName = 'QTDITE'
      DisplayFormat = '#0'
    end
    object cdsComponenteQTDDISP: TFloatField
      DisplayLabel = 'Dispon'#237'vel'
      FieldName = 'QTDDISP'
      DisplayFormat = '#0'
    end
    object cdsComponenteQTDAPR: TFloatField
      DisplayLabel = 'Aproveitar'
      FieldName = 'QTDAPR'
      OnValidate = cdsComponenteQTDAPRValidate
      DisplayFormat = '#0'
    end
    object cdsComponenteCUSITE: TFloatField
      FieldName = 'CUSITE'
    end
    object cdsComponenteCODFAB: TStringField
      DisplayLabel = 'C'#243'd. Fab.'
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsComponenteORIGEM: TStringField
      FieldName = 'ORIGEM'
      Size = 10
    end
    object cdsComponenteMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Size = 10
    end
    object cdsComponenteDESTINO: TStringField
      FieldName = 'DESTINO'
      Size = 10
    end
  end
  object dtsComponente: TDataSource
    DataSet = cdsComponente
    Left = 208
    Top = 72
  end
end
