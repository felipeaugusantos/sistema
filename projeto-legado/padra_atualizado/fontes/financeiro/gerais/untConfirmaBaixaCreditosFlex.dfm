inherited frmConfirmaBaixaCreditosFlex: TfrmConfirmaBaixaCreditosFlex
  Width = 691
  Height = 293
  BorderStyle = bsSizeable
  Caption = 'Baixa de Cr'#233'ditos FLEX'
  ExplicitWidth = 691
  ExplicitHeight = 293
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 212
    Width = 675
    ExplicitTop = 212
    ExplicitWidth = 675
    inherited FlwBotoes: TFlowPanel
      Width = 594
      ExplicitTop = 2
      ExplicitWidth = 594
      inherited btnConfirma: TBitBtnLocked
        Width = 121
        Caption = '[F10] &Confirma'
        Enabled = False
        ExplicitWidth = 121
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 596
      Top = 2
      Align = alRight
      Caption = '&Sair'
      ExplicitLeft = 596
      ExplicitTop = 2
    end
  end
  object prbProgresso: TProgressBar [2]
    Left = 0
    Top = 197
    Width = 675
    Height = 15
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 238
    Width = 675
    ExplicitTop = 238
    ExplicitWidth = 675
    inherited pnlNomeForm: TPanel
      Left = 504
      ExplicitLeft = 504
    end
    inherited pnlInfo: TPanel
      Width = 504
      ExplicitWidth = 504
    end
  end
  object cxgConsulta: TcxGrid [4]
    Left = 0
    Top = 0
    Width = 675
    Height = 197
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgConsultaDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = dtsBaiCre
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object cxgConsultaVENREP: TcxGridDBColumn
        Caption = 'VENDEDOR'
        DataBinding.FieldName = 'OPERAD'
        Width = 161
      end
      object cxgConsultaVALSEL: TcxGridDBColumn
        Caption = 'VR.SELEC.'
        DataBinding.FieldName = 'VALSEL'
        Width = 113
      end
      object cxgConsultaPEREMP: TcxGridDBColumn
        Caption = '% EMP.'
        DataBinding.FieldName = 'PEREMP'
        Width = 70
      end
      object cxgConsultaVALEMP: TcxGridDBColumn
        Caption = 'VR.EMPRESA'
        DataBinding.FieldName = 'VALEMP'
        Width = 123
      end
      object cxgConsultaPEVERE: TcxGridDBColumn
        Caption = '% VEN.'
        DataBinding.FieldName = 'PEVERE'
        Width = 73
      end
      object cxgConsultaVRVERE: TcxGridDBColumn
        Caption = 'VR.VEN.'
        DataBinding.FieldName = 'VLVERE'
        Width = 112
      end
      object cxgConsultaMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object cxgConsultaAUTINC: TcxGridDBColumn
        DataBinding.FieldName = 'AUTINC'
        Visible = False
      end
    end
    object cxgConsultaLevel1: TcxGridLevel
      GridView = cxgConsultaDBTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 576
    Top = 32
  end
  object dtsBaiCre: TDataSource
    Left = 496
    Top = 32
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 544
    Top = 32
    PixelsPerInch = 96
    object cxsTitulo1: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
    object cxsTitulo2: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
    object cxsFatura: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clBlue
    end
    object cxsTitulo3: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clGreen
    end
    object cxsEntFut: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clGreen
    end
  end
end
