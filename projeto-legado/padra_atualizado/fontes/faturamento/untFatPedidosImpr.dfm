inherited frmFatPedidosImpr: TfrmFatPedidosImpr
  Width = 935
  Caption = 'Documentos Gerados'
  ExplicitWidth = 935
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 191
    Width = 929
    Height = 26
    ExplicitTop = 191
    ExplicitWidth = 929
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 112
      Width = 738
      Height = 22
      TabOrder = 2
      ExplicitLeft = 112
      ExplicitWidth = 738
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 850
      Top = 2
      Align = alRight
      ExplicitLeft = 850
      ExplicitTop = 2
    end
    object btnConfirmar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 110
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] Confirmar'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
  end
  inherited pnlStatus: TPanel
    Width = 929
    ExplicitWidth = 929
    inherited pnlNomeForm: TPanel
      Left = 758
      ExplicitLeft = 758
    end
    inherited pnlInfo: TPanel
      Width = 758
      ExplicitWidth = 758
    end
  end
  object cxGrid: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 929
    Height = 191
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDocumentos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
    end
    object cxGridBandedTableView1: TcxGridBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      Bands = <
        item
        end>
      object cxGridBandedTableView1Column1: TcxGridBandedColumn
        Caption = 'DOCUMENTO'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 67
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object cxGridBandedTableView1Column2: TcxGridBandedColumn
        Width = 84
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object cxGridBandedTableView1Column3: TcxGridBandedColumn
        Width = 85
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object cxGridBandedTableView1Column4: TcxGridBandedColumn
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object cxGridBandedTableView1Column5: TcxGridBandedColumn
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object cxGridBandedTableView1Column6: TcxGridBandedColumn
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object cxGridBandedTableView1Column7: TcxGridBandedColumn
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object cxGridBandedTableView1Column8: TcxGridBandedColumn
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
      object cxGridBandedTableView1Column9: TcxGridBandedColumn
        Position.BandIndex = -1
        Position.ColIndex = -1
        Position.RowIndex = -1
      end
    end
    object cxGridDBBandedTableView1: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Bands = <
        item
        end>
    end
    object cxGridBand: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDocumentos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      Bands = <
        item
          Width = 348
        end
        item
          Caption = 'IMPRESS'#195'O DO DOCUMENTO'
          Width = 398
        end
        item
          Caption = 'IMPRESS'#195'O DA SEPARA'#199#195'O'
          Width = 168
        end>
      object cxGridBandColumn1: TcxGridDBBandedColumn
        Caption = 'DOCUMENTO'
        DataBinding.FieldName = 'NUMDOC'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 122
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxGridBandColumn4: TcxGridDBBandedColumn
        Caption = 'ESP'#201'CIE'
        DataBinding.FieldName = 'ESPDOC'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 64
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxGridBandColumn7: TcxGridDBBandedColumn
        Caption = 'EMPRESA'
        DataBinding.FieldName = 'CODEMP'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 65
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxGridBandColumn10: TcxGridDBBandedColumn
        Caption = 'VALOR TOTAL'
        DataBinding.FieldName = 'VLRTOT'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 97
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxGridBandColumn2: TcxGridDBBandedColumn
        Caption = 'MOSTRAR TOTAL'
        DataBinding.FieldName = 'IMPTOT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        FooterAlignmentHorz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 95
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxGridBandColumn5: TcxGridDBBandedColumn
        Caption = 'VIAS'
        DataBinding.FieldName = 'QTDVIA'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Width = 51
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxGridBandColumn6: TcxGridDBBandedColumn
        Caption = 'MOSTRAR PRE'#199'O'
        DataBinding.FieldName = 'IMPPRE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Width = 98
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxGridBandColumn8: TcxGridDBBandedColumn
        Caption = 'IMPRIMIR'
        DataBinding.FieldName = 'IMPRIM'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxGridBandIMPTRM: TcxGridDBBandedColumn
        Caption = 'TERMO ACEITE'
        DataBinding.FieldName = 'IMPTRM'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        HeaderHint = 'Termo de Aceite de Compra e Venda'
        Width = 104
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxGridBandColumn3: TcxGridDBBandedColumn
        Caption = 'VIAS'
        DataBinding.FieldName = 'SEPVIA'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxGridBandColumn9: TcxGridDBBandedColumn
        Caption = 'IMPRIMIR'
        DataBinding.FieldName = 'IMPSEP'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.OnChange = cxGridBandColumn9PropertiesChange
        HeaderAlignmentHorz = taCenter
        Width = 61
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridBand
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 260
    Top = 92
  end
  object dtsDocumentos: TDataSource
    Left = 152
    Top = 104
  end
end
