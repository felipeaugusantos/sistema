inherited frmSelCtaPag: TfrmSelCtaPag
  Width = 780
  Height = 425
  Caption = 'Duplicatas em Aberto'
  OnDestroy = FormDestroy
  ExplicitWidth = 780
  ExplicitHeight = 425
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 354
    Width = 774
    ExplicitTop = 354
    ExplicitWidth = 774
    inherited FlwBotoes: TFlowPanel
      Width = 770
      ExplicitTop = 2
      ExplicitWidth = 770
    end
    inherited btnSair: TBitBtnLocked
      Left = 694
      ExplicitLeft = 694
    end
  end
  inherited pnlStatus: TPanel
    Top = 380
    Width = 774
    ExplicitTop = 380
    ExplicitWidth = 774
    inherited pnlNomeForm: TPanel
      Left = 603
      ExplicitLeft = 603
    end
    inherited pnlInfo: TPanel
      Width = 603
      ExplicitWidth = 603
    end
  end
  object grdCtaPag: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 774
    Height = 354
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdCtaPagTv: TcxGridDBTableViewCitel
      OnDblClick = grdCtaPagTvDblClick
      OnKeyDown = grdCtaPagTvKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdCtaPagTvCustomDrawCell
      DataController.DataSource = dsCtaPag
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
      object grdCtaPagTvCTP_DTACAD: TcxGridDBColumn
        Caption = 'Dt.Cad'
        DataBinding.FieldName = 'CTP_DTACAD'
      end
      object grdCtaPagTvCTP_DTAVEN: TcxGridDBColumn
        Caption = 'Dt.Vencto'
        DataBinding.FieldName = 'CTP_DTAVEN'
      end
      object grdCtaPagTvDOCUMENTO: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DOCUMENTO'
        Width = 114
      end
      object grdCtaPagTvCTP_SERIE_: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'CTP_SERIE_'
        Width = 59
      end
      object grdCtaPagTvCTA_DESCTA: TcxGridDBColumn
        Caption = 'Plano Contas'
        DataBinding.FieldName = 'CTA_DESCTA'
        Width = 166
      end
      object grdCtaPagTvCTP_HIST01: TcxGridDBColumn
        Caption = 'Hist'#243'rico'
        DataBinding.FieldName = 'CTP_HIST01'
        Width = 199
      end
      object grdCtaPagTvCTP_VALDUP: TcxGridDBColumn
        Caption = 'Vr.Duplicata'
        DataBinding.FieldName = 'CTP_VALDUP'
        Width = 77
      end
      object grdCtaPagTvMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
        VisibleForCustomization = False
        VisibleForEditForm = bFalse
      end
    end
    object grdCtaPagLevel1: TcxGridLevel
      GridView = grdCtaPagTv
    end
  end
  object dsCtaPag: TDataSource
    Left = 304
    Top = 240
  end
end
