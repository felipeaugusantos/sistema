inherited frmAjusteICMST: TfrmAjusteICMST
  Width = 715
  Height = 270
  Caption = 'Ajuste de ICMS-ST'
  Position = poScreenCenter
  ExplicitWidth = 715
  ExplicitHeight = 270
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 198
    Width = 709
    ExplicitTop = 198
    ExplicitWidth = 709
    DesignSize = (
      709
      28)
    inherited btnSair: TBitBtnLocked
      Left = 626
      ExplicitLeft = 626
    end
  end
  object dbgICMST: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 709
    Height = 198
    Hint = 'Ajuste de ICMS ST'
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgICMSTDBTableView1: TcxGridDBTableView
      OnKeyDown = dbgICMSTDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsAux
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NewItemRow.InfoText = 'Clique aqui para adicionar um novo registro'
      NewItemRow.Visible = True
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' dados a exibir'
      OptionsView.GroupByBox = False
      object dbgMesAno: TcxGridDBColumn
        Caption = 'M'#234's / Ano'
        DataBinding.FieldName = 'AJI_MESANO'
        RepositoryItem = cxMascaraData
        Width = 70
      end
      object dbgCodAju: TcxGridDBColumn
        Caption = 'C'#243'digo do Ajuste'
        DataBinding.FieldName = 'AJI_CODAJU'
        RepositoryItem = cxUpperCase
        Width = 110
      end
      object dbgCodRec: TcxGridDBColumn
        Caption = 'C'#243'digo Recebimento (E250)'
        DataBinding.FieldName = 'AJI_CODREC'
        RepositoryItem = cxUpperCase
        Width = 140
      end
      object dbgDesAju: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Complementar do Ajuste'
        DataBinding.FieldName = 'AJI_DESAJu'
        RepositoryItem = cxUpperCase
        Width = 254
      end
      object dbgValAju: TcxGridDBColumn
        Caption = 'Valor do Ajuste'
        DataBinding.FieldName = 'AJI_VALAJU'
        RepositoryItem = cxFormataFloat
        Width = 100
      end
    end
    object dbgICMSTLevel1: TcxGridLevel
      GridView = dbgICMSTDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 226
    Width = 709
    ExplicitTop = 226
    ExplicitWidth = 709
    inherited pnlNomeForm: TPanel
      Left = 538
      ExplicitLeft = 538
    end
    inherited pnlInfo: TPanel
      Width = 538
      ExplicitWidth = 538
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 448
    Top = 64
  end
  object dsAux: TDataSource
    DataSet = qryAjuste
    Left = 384
    Top = 64
  end
  object cxRepository: TcxEditRepository
    Left = 320
    Top = 64
    PixelsPerInch = 96
    object cxFormataFloat: TcxEditRepositoryCurrencyItem
      Properties.DisplayFormat = '#,##0.00'
    end
    object cxUpperCase: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxMascaraData: TcxEditRepositoryMaskItem
      Properties.EditMask = '99/9999'
    end
  end
  object qryAjuste: TUniQuery
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      '  AJICST'
      'WHERE FALSE')
    Constraints = <>
    BeforeEdit = qryAjusteBeforeEdit
    BeforePost = qryAjusteBeforePost
    AfterPost = qryAjusteAfterPost
    Left = 352
    Top = 64
    object qryAjusteAJI_MESANO: TStringField
      FieldName = 'AJI_MESANO'
      Size = 7
    end
    object qryAjusteAJI_CODAJU: TStringField
      FieldName = 'AJI_CODAJU'
      Size = 8
    end
    object qryAjusteAJI_DESAJU: TStringField
      FieldName = 'AJI_DESAJU'
    end
    object qryAjusteAJI_VALAJU: TFloatField
      FieldName = 'AJI_VALAJU'
    end
    object qryAjusteAJI_CODEMP: TStringField
      FieldName = 'AJI_CODEMP'
    end
    object qryAjusteAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryAjusteAJI_CODREC: TStringField
      FieldName = 'AJI_CODREC'
      Size = 50
    end
  end
end
