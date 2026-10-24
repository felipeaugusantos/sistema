inherited frmCamposRotina: TfrmCamposRotina
  Width = 818
  Height = 569
  BorderStyle = bsSizeable
  Caption = 'Campos da Rotina (obrigat'#243'rios no relat'#243'rio)'
  ExplicitWidth = 818
  ExplicitHeight = 569
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 486
    Width = 802
    ExplicitTop = 355
    ExplicitWidth = 802
    inherited FlwBotoes: TFlowPanel
      Width = 798
      ExplicitWidth = 798
    end
    inherited btnSair: TBitBtnLocked
      Left = 719
      ExplicitLeft = 719
    end
  end
  inherited pnlStatus: TPanel
    Top = 514
    Width = 802
    ExplicitTop = 383
    ExplicitWidth = 802
    inherited pnlNomeForm: TPanel
      Left = 631
      ExplicitLeft = 631
    end
    inherited pnlInfo: TPanel
      Width = 631
      ExplicitWidth = 631
    end
  end
  object pnlRotina: TPanel [2]
    Left = 0
    Top = 0
    Width = 802
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlRotina'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object cxgCampos: TcxGrid [3]
    Left = 0
    Top = 41
    Width = 802
    Height = 445
    Align = alClient
    TabOrder = 3
    ExplicitHeight = 314
    object cxvCampos: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum campo cadastrado>'
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle4
      object cxvCamposColumn1: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'NOMCAM'
        Width = 133
      end
      object cxvCamposColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCAM'
        Width = 506
      end
      object cxvCamposColumn3: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'TIPCAM'
        HeaderAlignmentHorz = taCenter
        Width = 140
      end
    end
    object cxgCamposLevel1: TcxGridLevel
      GridView = cxvCampos
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 152
    Top = 152
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 616
    Top = 238
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = 16770736
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor]
      Color = 14674687
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 14548923
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor]
      Color = 14737632
    end
  end
end
