inherited frmImportCadNOPConfirma: TfrmImportCadNOPConfirma
  Width = 635
  Height = 581
  BorderStyle = bsSingle
  Caption = 'Importa'#231#227'o de Cadastro de NCM para Outros Pa'#237'ses - Confirma'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 635
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 510
    Width = 629
    ExplicitTop = 510
    ExplicitWidth = 629
    inherited FlwBotoes: TFlowPanel
      Width = 625
      ExplicitWidth = 625
    end
    inherited btnSair: TBitBtnLocked
      Left = 549
      ExplicitLeft = 549
    end
  end
  inherited pnlStatus: TPanel
    Top = 536
    Width = 629
    ExplicitTop = 536
    ExplicitWidth = 629
    inherited pnlNomeForm: TPanel
      Left = 458
      ExplicitLeft = 458
    end
    inherited pnlInfo: TPanel
      Width = 458
      ExplicitWidth = 458
    end
  end
  object grpLegenda: TGroupBox [2]
    Left = 0
    Top = 440
    Width = 629
    Height = 70
    Align = alBottom
    Caption = 'Legenda'
    TabOrder = 2
    object Shape2: TShape
      Left = 8
      Top = 26
      Width = 17
      Height = 15
      Brush.Color = clYellow
    end
    object Shape3: TShape
      Left = 8
      Top = 42
      Width = 17
      Height = 15
      Brush.Color = clAqua
    end
    object Label2: TLabel
      Left = 31
      Top = 26
      Width = 120
      Height = 14
      Caption = 'NCM que ser'#225' atualizado'
    end
    object Label3: TLabel
      Left = 31
      Top = 42
      Width = 109
      Height = 14
      Caption = 'NCM que ser'#225' inserido'
    end
  end
  object cxgNop: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 629
    Height = 440
    Align = alClient
    TabOrder = 3
    object cxgNopDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgNopDBTableView1CustomDrawCell
      DataController.DataSource = dtsCadNop
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object cxgNopDBCODPAI: TcxGridDBColumn
        Caption = 'C'#243'd. Pa'#237's'
        DataBinding.FieldName = 'NOP_CODPAI'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 90
      end
      object cxgNopDBCODNCM: TcxGridDBColumn
        Caption = 'NCM'
        DataBinding.FieldName = 'NOP_CODNCM'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 90
      end
      object cxgNopDBCODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Produto'
        DataBinding.FieldName = 'NOP_CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 90
      end
      object cxgNopDBACAO: TcxGridDBColumn
        DataBinding.FieldName = 'ACAO'
        Visible = False
      end
    end
    object cxgNopLevel1: TcxGridLevel
      GridView = cxgNopDBTableView1
    end
  end
  object dtsCadNop: TDataSource
    Left = 56
    Top = 32
  end
end
