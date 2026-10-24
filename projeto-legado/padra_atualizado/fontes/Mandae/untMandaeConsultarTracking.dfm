inherited frmMandaeConsultarTracking: TfrmMandaeConsultarTracking
  Left = 0
  Top = 0
  Width = 641
  Height = 328
  BorderIcons = [biSystemMenu]
  Caption = 'Documentos Integrados com Manda'#234' - Consultar Tracking'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poScreenCenter
  ExplicitWidth = 641
  ExplicitHeight = 328
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 255
    Width = 635
    ExplicitTop = 255
    ExplicitWidth = 635
    inherited FlwBotoes: TFlowPanel
      Width = 631
      ExplicitTop = 2
      ExplicitWidth = 631
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 549
      ExplicitLeft = 549
    end
  end
  inherited pnlStatus: TPanel
    Top = 283
    Width = 635
    ExplicitTop = 283
    ExplicitWidth = 635
    inherited pnlNomeForm: TPanel
      Left = 464
      ExplicitLeft = 464
    end
    inherited pnlInfo: TPanel
      Width = 464
      ExplicitWidth = 464
    end
  end
  object grdDocumentos: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 635
    Height = 255
    Align = alClient
    TabOrder = 3
    object grdDbDocumentos: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDocumentos
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
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdDbDocumentosColumn1: TcxGridDBColumn
        Caption = 'Data\Hora do Tracking'
        DataBinding.FieldName = 'TRC_DTATRC'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 138
      end
      object grdDbDocumentosColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'TRC_DESCRI'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 407
      end
    end
    object grdDocumentosLevel1: TcxGridLevel
      GridView = grdDbDocumentos
    end
  end
  object dtsDocumentos: TDataSource
    Left = 49
    Top = 88
  end
end
