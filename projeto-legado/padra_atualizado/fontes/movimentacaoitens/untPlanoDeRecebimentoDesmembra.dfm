inherited frmPlanoDeRecebimentoDesmembra: TfrmPlanoDeRecebimentoDesmembra
  Width = 725
  Height = 347
  Caption = 'Plano de Recebimento - Desmembrar Documentos'
  ExplicitWidth = 725
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 275
    Width = 719
    ExplicitTop = 275
    ExplicitWidth = 719
    object Label1: TLabel [0]
      Left = 91
      Top = 6
      Width = 232
      Height = 14
      Caption = '[ENTER] - Marca/Desmarca os documentos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shpLegenda: TShape [1]
      Left = 368
      Top = 5
      Width = 16
      Height = 16
      Brush.Color = 16777117
    end
    object Label2: TLabel [2]
      Left = 390
      Top = 6
      Width = 221
      Height = 14
      Caption = 'Documentos que ser'#227'o desmembrados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 638
      ExplicitTop = 2
      ExplicitWidth = 638
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
        Enabled = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 640
      Top = 2
      Align = alRight
      ExplicitLeft = 640
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 303
    Width = 719
    ExplicitTop = 303
    ExplicitWidth = 719
    inherited pnlNomeForm: TPanel
      Left = 548
      ExplicitLeft = 548
    end
    inherited pnlInfo: TPanel
      Width = 548
      ExplicitWidth = 548
    end
  end
  object cxgDocumentos: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 719
    Height = 275
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDocumentosTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgDocumentosTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgDocumentosTableViewCustomDrawCell
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
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDocumentosTableViewNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'ADC_NUMDOC'
        Width = 114
      end
      object cxgDocumentosTableViewESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'ADC_ESPDOC'
        Width = 52
      end
      object cxgDocumentosTableViewSERIE_: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'ADC_SERIE_'
        Width = 54
      end
      object cxgDocumentosTableViewCODFOR: TcxGridDBColumn
        Caption = 'C'#243'd. Fornecedor'
        DataBinding.FieldName = 'ADC_CODFOR'
        Width = 96
      end
      object cxgDocumentosTableViewNOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Width = 368
      end
      object cxgDocumentosTableViewMARCA: TcxGridDBColumn
        DataBinding.FieldName = 'MARCA'
        Visible = False
      end
    end
    object cxgDocumentosLevel: TcxGridLevel
      GridView = cxgDocumentosTableView
    end
  end
end
