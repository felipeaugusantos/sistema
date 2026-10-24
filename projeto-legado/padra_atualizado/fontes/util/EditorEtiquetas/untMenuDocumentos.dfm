inherited frmMenuDocumentos: TfrmMenuDocumentos
  Width = 367
  Height = 389
  BorderIcons = []
  Caption = '                  Selecione o Tipo de Documento'
  Position = poMainFormCenter
  ExplicitWidth = 367
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 317
    Width = 361
    Visible = False
    ExplicitTop = 317
    ExplicitWidth = 361
    inherited btnSair: TBitBtnLocked
      Left = 278
      ExplicitLeft = 278
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 361
    Height = 317
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgItensViewCellDblClick
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Header = False
      Styles.Background = cxStyle1
      Styles.Content = cxStyle2
      Styles.Selection = cxStyle3
      object cxgItensDESOPC: TcxGridDBColumn
        DataBinding.FieldName = 'DESOPC'
        Options.Editing = False
      end
      object cxgItensCODOPC: TcxGridDBColumn
        DataBinding.FieldName = 'CODOPC'
        Visible = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited pnlStatus: TPanel
    Top = 345
    Width = 361
    Visible = False
    ExplicitTop = 345
    ExplicitWidth = 361
    inherited pnlNomeForm: TPanel
      Left = 190
      ExplicitLeft = 190
    end
    inherited pnlInfo: TPanel
      Width = 190
      ExplicitWidth = 190
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlue
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clYellow
      TextColor = clBlue
    end
  end
end
