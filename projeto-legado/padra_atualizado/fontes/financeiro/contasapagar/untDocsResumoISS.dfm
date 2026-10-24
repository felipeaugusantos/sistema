inherited frmDocsResumoISS: TfrmDocsResumoISS
  Width = 546
  Height = 635
  Caption = 'Visualiza'#231#227'o de Documentos'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 546
  ExplicitHeight = 635
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 562
    Width = 540
    inherited FlwBotoes: TFlowPanel
      Width = 536
    end
    inherited btnSair: TBitBtnLocked
      Left = 460
    end
  end
  inherited pnlStatus: TPanel
    Top = 590
    Width = 540
    inherited pnlNomeForm: TPanel
      Left = 369
    end
    inherited pnlInfo: TPanel
      Width = 369
    end
  end
  object cxGridDocs: TcxGridCitel [2]
    Left = 0
    Top = 49
    Width = 540
    Height = 513
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 136
    ExplicitTop = 96
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxGridDocsView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridDocsViewCustomDrawCell
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
      object cxGridFIS_DTADOC: TcxGridDBColumn
        Caption = 'Dt. Emiss'#227'o'
        DataBinding.FieldName = 'FIS_DTADOC'
        Width = 70
      end
      object cxGridFIS_NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'FIS_NUMDOC'
        Width = 80
      end
      object cxGridFIS_ESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'FIS_ESPDOC'
        Width = 45
      end
      object cxGridFIS_VLCON1: TcxGridDBColumn
        Caption = 'VR. Cont'#225'bil'
        DataBinding.FieldName = 'FIS_VLCON1'
        Width = 90
      end
      object cxGridFIS_BASISS: TcxGridDBColumn
        Caption = 'BC. ISS'
        DataBinding.FieldName = 'FIS_BASISS'
        Width = 90
      end
      object cxGridFIS_ALQISS: TcxGridDBColumn
        Caption = 'ALQ. ISS'
        DataBinding.FieldName = 'FIS_ALQISS'
        Width = 54
      end
      object cxGridFIS_VALISS: TcxGridDBColumn
        Caption = 'VR. ISS'
        DataBinding.FieldName = 'FIS_VALISS'
        Width = 90
      end
    end
    object cxGridDocsLevel1: TcxGridLevel
      GridView = cxGridDocsView
    end
  end
  object pnlSuperior: TPanel [3]
    Left = 0
    Top = 0
    Width = 540
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 671
    object lblEmpRaiz: TLabel
      Left = 8
      Top = 8
      Width = 80
      Height = 14
      Caption = 'Emp/Raiz Cnpj:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCidade: TLabel
      Left = 47
      Top = 28
      Width = 41
      Height = 14
      Caption = 'Cidade:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblInfoEmpRaiz: TLabel
      Left = 92
      Top = 8
      Width = 69
      Height = 14
      Caption = 'lblInfoEmpRaiz'
    end
    object lblInfoCidade: TLabel
      Left = 92
      Top = 28
      Width = 61
      Height = 14
      Caption = 'lblInfoCidade'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 65496
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 65448
    Top = 65480
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 65376
    Top = 65504
  end
end
