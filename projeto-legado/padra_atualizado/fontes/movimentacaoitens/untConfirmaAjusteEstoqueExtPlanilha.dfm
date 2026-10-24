inherited frmConfirmaAjusteEstoqueExtPlanilha: TfrmConfirmaAjusteEstoqueExtPlanilha
  Width = 1024
  Height = 455
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Confirmar Ajuste de Estoque Externo'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 384
    Width = 1018
    ExplicitTop = 384
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 410
    Width = 1018
    ExplicitTop = 410
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlInfoPlan: TPanel [2]
    Left = 0
    Top = 360
    Width = 1018
    Height = 24
    Align = alBottom
    TabOrder = 2
    object Label1: TLabel
      Left = 10
      Top = 5
      Width = 596
      Height = 14
      Caption = 
        'A quantidade movimentada posteriormente mostra o saldo movimenta' +
        'do pelo full ap'#243's a data e hora da extra'#231#227'o da planilha.'
    end
  end
  object cxgGrid: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 360
    Align = alClient
    TabOrder = 3
    object cxgGridTBV: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsGrid
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnGrouping = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum informa'#231#227'o dispon'#237'vel>'
      OptionsView.GroupByBox = False
      object cxgGridTBVCODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'CODITE'
        PropertiesClassName = 'TcxTextEditProperties'
        Options.Editing = False
        Width = 70
      end
      object cxgGridTBVDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 350
      end
      object cxgGridTBVQTDPLA: TcxGridDBColumn
        Caption = 'Qtde Planilha'
        DataBinding.FieldName = 'QTDPLA'
        Options.Editing = False
        Width = 100
      end
      object cxgGridTBVQTDMOV: TcxGridDBColumn
        Caption = 'Qtde Mov. Post.'
        DataBinding.FieldName = 'QTDMOV'
        Options.Editing = False
        Width = 100
      end
      object cxgGridTBVQTDAJU: TcxGridDBColumn
        Caption = 'Qtde Ajuste'
        DataBinding.FieldName = 'QTDAJU'
        Options.Editing = False
        Width = 100
      end
      object cxgGridTBVOPERAC: TcxGridDBColumn
        Caption = 'Opera'#231#227'o'
        DataBinding.FieldName = 'OPERAC'
        PropertiesClassName = 'TcxTextEditProperties'
        Options.Editing = False
        Width = 75
      end
      object cxgGridTBVSALATU: TcxGridDBColumn
        Caption = 'Saldo Atual'
        DataBinding.FieldName = 'SALATU'
        Options.Editing = False
        Width = 100
      end
      object cxgGridTBVSALAPO: TcxGridDBColumn
        Caption = 'Saldo Ap'#243's Ajuste'
        DataBinding.FieldName = 'SALAPO'
        Options.Editing = False
        Width = 100
      end
    end
    object cxgGridLevel: TcxGridLevel
      GridView = cxgGridTBV
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 40
  end
  object dtsGrid: TDataSource
    Left = 472
    Top = 40
  end
end
