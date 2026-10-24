inherited frmLancamentosContabeis: TfrmLancamentosContabeis
  Width = 1034
  Height = 491
  Caption = 'Lan'#231'amentos Cont'#225'beis'
  Position = poOwnerFormCenter
  ExplicitWidth = 1034
  ExplicitHeight = 491
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 418
    Width = 1028
    ExplicitTop = 418
    ExplicitWidth = 1028
    inherited FlwBotoes: TFlowPanel
      Width = 1024
      ExplicitWidth = 1024
      object btnExportar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Hint = 'Exportar os Dados para Planilha Eletr'#244'nica'
        Caption = '&Exportar'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
          333333333333337FF3333333333333903333333333333377FF33333333333399
          03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
          99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
          99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
          03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
          33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
          33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
          3333777777333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnExportarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 948
      ExplicitLeft = 948
    end
  end
  inherited pnlStatus: TPanel
    Top = 446
    Width = 1028
    ExplicitTop = 446
    ExplicitWidth = 1028
    inherited pnlNomeForm: TPanel
      Left = 857
      ExplicitLeft = 857
    end
    inherited pnlInfo: TPanel
      Width = 857
      ExplicitWidth = 857
    end
  end
  object Grid: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1028
    Height = 418
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object GridTab: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = srcLancamentosContabeis
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsCustomize.ColumnMoving = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object GridTabAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
        VisibleForCustomization = False
      end
      object GridTabCON_EMPLAN: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CON_EMPLAN'
        Width = 80
      end
      object GridTabCON_DTALAN: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'CON_DTALAN'
        Width = 96
      end
      object GridTabCON_VALLAN: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'CON_VALLAN'
        Width = 134
      end
      object GridTabCON_TIPLAN: TcxGridDBColumn
        Caption = 'Tipo de Lancto'
        DataBinding.FieldName = 'CON_TIPLAN'
        Width = 112
      end
      object GridTabCON_DESVAL: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Valor'
        DataBinding.FieldName = 'CON_DESVAL'
        Width = 126
      end
      object GridTabCON_CONDEB: TcxGridDBColumn
        Caption = 'Conta D'#233'bito'
        DataBinding.FieldName = 'CON_CONDEB'
        Width = 98
      end
      object GridTabCON_DESDEB: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Conta D'#233'bito'
        DataBinding.FieldName = 'CON_DESDEB'
        Width = 292
      end
      object GridTabCON_CONCRE: TcxGridDBColumn
        Caption = 'Conta Cr'#233'dito'
        DataBinding.FieldName = 'CON_CONCRE'
        Width = 84
      end
      object GridTabCON_DESCRE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Conta Cr'#233'dito'
        DataBinding.FieldName = 'CON_DESCRE'
        Width = 484
      end
      object GridTabCON_HISTOR: TcxGridDBColumn
        Caption = 'Complemento'
        DataBinding.FieldName = 'CON_HISTOR'
        Width = 504
      end
    end
    object GridLevel: TcxGridLevel
      GridView = GridTab
    end
  end
  object srcLancamentosContabeis: TDataSource
    Left = 488
    Top = 88
  end
end
