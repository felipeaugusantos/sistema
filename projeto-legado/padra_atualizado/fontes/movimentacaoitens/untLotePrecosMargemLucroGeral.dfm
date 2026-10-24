inherited frmLotePrecosMargemLucroGeral: TfrmLotePrecosMargemLucroGeral
  Width = 295
  Height = 424
  Caption = 'Margem de lucro geral'
  ExplicitWidth = 295
  ExplicitHeight = 424
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 353
    Width = 289
    ExplicitTop = 353
    ExplicitWidth = 289
    inherited FlwBotoes: TFlowPanel
      Width = 285
      ExplicitWidth = 285
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 209
      ExplicitLeft = 209
    end
  end
  inherited pnlStatus: TPanel
    Top = 379
    Width = 289
    ExplicitTop = 379
    ExplicitWidth = 289
    inherited pnlNomeForm: TPanel
      Left = 118
      ExplicitLeft = 118
    end
    inherited pnlInfo: TPanel
      Width = 118
      ExplicitWidth = 118
    end
  end
  object cxGridTabelas: TcxGrid [2]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 283
    Height = 347
    Align = alClient
    TabOrder = 2
    object cxvTabelas: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCanFocusRecord = cxvTabelasCanFocusRecord
      DataController.DataSource = dtsTabelas
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      object cxGridTabelasMARDES: TcxGridDBColumn
        Caption = 'Habilitar?'
        DataBinding.FieldName = 'MARDES'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'M'
        Properties.ValueUnchecked = 'D'
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.AutoWidthSizable = False
        Width = 58
      end
      object cxGridTabelasDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        Options.Editing = False
        Width = 166
      end
      object cxGridTabelasMARGEM: TcxGridDBColumn
        Caption = 'Margem %'
        DataBinding.FieldName = 'MARGEM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ' ,0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 57
      end
    end
    object cxGridTabelasLevel1: TcxGridLevel
      GridView = cxvTabelas
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 56
    Top = 104
  end
  object dtsTabelas: TDataSource
    DataSet = cdsTabelas
    Left = 48
    Top = 184
  end
  object cdsTabelas: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 112
    Top = 184
    object cdsTabelasMARDES: TStringField
      FieldName = 'MARDES'
      Size = 1
    end
    object cdsTabelasDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 35
    end
    object cdsTabelasMARGEM: TFloatField
      FieldName = 'MARGEM'
    end
    object cdsTabelasNUMTAB: TIntegerField
      FieldName = 'NUMTAB'
    end
  end
end
