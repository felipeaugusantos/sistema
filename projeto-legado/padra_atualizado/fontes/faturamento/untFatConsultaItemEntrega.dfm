inherited frmFatConsultaItemEntrega: TfrmFatConsultaItemEntrega
  Width = 887
  Caption = 'Consulta de Itens'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 887
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 881
    ExplicitWidth = 881
    inherited FlwBotoes: TFlowPanel
      Width = 877
      ExplicitWidth = 877
    end
  end
  inherited pnlStatus: TPanel
    Width = 881
    ExplicitTop = 460
    ExplicitWidth = 881
    inherited pnlNomeForm: TPanel
      Left = 710
      ExplicitLeft = 710
    end
    inherited pnlInfo: TPanel
      Width = 710
      ExplicitWidth = 710
    end
  end
  inherited pgcDados: TPageControl
    Width = 881
    ExplicitWidth = 881
    ExplicitHeight = 460
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 873
      ExplicitHeight = 428
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 881
    Height = 460
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 879
      Height = 80
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 13
        Top = 10
        Width = 57
        Height = 14
        Caption = 'Documento:'
      end
      object Label2: TLabel
        Left = 13
        Top = 27
        Width = 35
        Height = 14
        Caption = 'Cliente:'
      end
      object Label3: TLabel
        Left = 13
        Top = 44
        Width = 25
        Height = 14
        Caption = 'Data:'
      end
      object lblCliente: TLabel
        Left = 77
        Top = 27
        Width = 80
        Height = 14
        Caption = '12345678-XXXX'
      end
      object lblDocumento: TLabel
        Left = 77
        Top = 10
        Width = 111
        Height = 14
        Caption = '123456789012-NF-001'
      end
      object lblData: TLabel
        Left = 77
        Top = 44
        Width = 68
        Height = 14
        Caption = 'DD/MM/AAAA'
      end
    end
    object cxgItens: TcxGrid
      Left = 1
      Top = 81
      Width = 879
      Height = 378
      Align = alClient
      TabOrder = 1
      object cxgItensDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsItens
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxgItensCODIGO: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODIGO'
          Width = 66
        end
        object cxgItensDESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
        end
        object cxgItensQTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
          Width = 98
        end
        object cxgItensTOTVLR: TcxGridDBColumn
          Caption = 'Valor Total'
          DataBinding.FieldName = 'TOTVLR'
          Width = 89
        end
      end
      object cxgItensLevel: TcxGridLevel
        GridView = cxgItensDBTableView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1136
    Top = 240
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1104
    Top = 240
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1032
    Top = 264
  end
  object dtsItens: TDataSource
    Left = 680
    Top = 264
  end
end
