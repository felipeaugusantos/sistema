inherited frmFatConfeEntDocNaoEntregues: TfrmFatConfeEntDocNaoEntregues
  Width = 938
  Height = 455
  Caption = 'Confer'#234'ncia de Entrada para Documentos n'#227'o Entregues'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 938
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 382
    Width = 932
    ExplicitTop = 382
    ExplicitWidth = 932
    inherited FlwBotoes: TFlowPanel
      Width = 928
      ExplicitWidth = 928
      object btnConfVolumes: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 153
        Height = 22
        Caption = '[F2] Conferir Volumes'
        TabOrder = 0
        OnClick = btnConfVolumesClick
      end
      object btnDevProdutos: TBitBtnLocked
        Left = 153
        Top = 0
        Width = 201
        Height = 22
        Caption = '[F3] Realizar Devolu'#231#227'o de Produtos'
        TabOrder = 1
        OnClick = btnDevProdutosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 849
      ExplicitLeft = 849
    end
  end
  inherited pnlStatus: TPanel
    Top = 410
    Width = 932
    ExplicitTop = 410
    ExplicitWidth = 932
    inherited pnlNomeForm: TPanel
      Left = 761
      ExplicitLeft = 761
    end
    inherited pnlInfo: TPanel
      Width = 761
      ExplicitWidth = 761
    end
  end
  object dbgDocs: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 932
    Height = 382
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    LookAndFeel.ScrollbarMode = sbmClassic
    LookAndFeel.SkinName = ''
    object dbgDocsDBView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDocs
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GridLines = glVertical
      OptionsView.GroupByBox = False
      object dbgDocsNUMROM: TcxGridDBColumn
        Caption = 'Romaneio'
        DataBinding.FieldName = 'NUMROM'
        Width = 90
      end
      object dbgDocsDTAROM: TcxGridDBColumn
        AlternateCaption = 'Item'
        Caption = 'Data Romaneio'
        DataBinding.FieldName = 'DTAROM'
        Width = 90
      end
      object dbgDocsNUMDOC: TcxGridDBColumn
        Caption = 'N'#186' Documento'
        DataBinding.FieldName = 'NUMDOC'
        Width = 100
      end
      object dbgDocsESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'ESPDOC'
        Width = 30
      end
      object dbgDocsEMPDOC: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'EMPDOC'
        Width = 40
      end
      object dbgDocsDTADOC: TcxGridDBColumn
        Caption = 'Dt. Documento'
        DataBinding.FieldName = 'DTADOC'
        Width = 90
      end
      object dbgDocsNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Width = 378
      end
      object dbgDocsQTDVOL: TcxGridDBColumn
        Caption = 'Qtd. Vol.'
        DataBinding.FieldName = 'QTDVOL'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
    end
    object dbgDocslevel: TcxGridLevel
      GridView = dbgDocsDBView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 40
  end
  object dtsDocs: TDataSource
    Left = 496
    Top = 40
  end
end
