inherited frmImportCadNCMConfirma: TfrmImportCadNCMConfirma
  Width = 880
  Height = 581
  BorderStyle = bsSingle
  Caption = 'Importa'#231#227'o de Cadastro de NCM - Confirma'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 880
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 510
    Width = 874
    ExplicitTop = 510
    ExplicitWidth = 874
    inherited FlwBotoes: TFlowPanel
      Width = 870
      ExplicitWidth = 870
    end
    inherited btnSair: TBitBtnLocked
      Left = 794
      ExplicitLeft = 794
    end
  end
  inherited pnlStatus: TPanel
    Top = 536
    Width = 874
    ExplicitTop = 536
    ExplicitWidth = 874
    inherited pnlNomeForm: TPanel
      Left = 703
      ExplicitLeft = 703
    end
    inherited pnlInfo: TPanel
      Width = 703
      ExplicitWidth = 703
    end
  end
  object grpLegenda: TGroupBox [2]
    Left = 0
    Top = 440
    Width = 874
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
  object cxgNcm: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 874
    Height = 440
    Align = alClient
    TabOrder = 3
    object cxgNcmDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgNcmDBTableView1CustomDrawCell
      DataController.DataSource = dtsCadNcm
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object cxgNcmNCM: TcxGridDBColumn
        Caption = 'NCM'
        DataBinding.FieldName = 'NCM_CODNCM'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
      end
      object cxgNcmDBCODEXC: TcxGridDBColumn
        Caption = 'C'#243'd. Exc'
        DataBinding.FieldName = 'NCM_CODEXC'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
      end
      object cxgNcmDBALQIPI: TcxGridDBColumn
        Caption = '% IPI'
        DataBinding.FieldName = 'NCM_ALQIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ' ,0.00;- ,0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
      end
      object cxgNcmDBDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'NCM_DESCRI'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 400
      end
      object cxgNcmDBANVOBR: TcxGridDBColumn
        Caption = 'Obrigar anvisa?'
        DataBinding.FieldName = 'NCM_ANVOBR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Options.Editing = False
        Width = 83
      end
      object cxgNcmDBABVIcms: TcxGridDBColumn
        Caption = 'Abv. ICMS'
        DataBinding.FieldName = 'LISICM'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
      end
      object cxgNcmDBABVPIS: TcxGridDBColumn
        Caption = 'Abv. PIS'
        DataBinding.FieldName = 'LISPIS'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
      end
      object cxgNcmDBABVCOFINS: TcxGridDBColumn
        Caption = 'Abv. COFINS'
        DataBinding.FieldName = 'LISCOF'
        Options.Editing = False
        Width = 68
      end
      object cxgNcmDBABVIPI: TcxGridDBColumn
        Caption = 'Abv. IPI'
        DataBinding.FieldName = 'LISIPI'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
      end
      object cxgNcmDBACAO: TcxGridDBColumn
        DataBinding.FieldName = 'ACAO'
        Visible = False
      end
    end
    object cxgNcmLevel1: TcxGridLevel
      GridView = cxgNcmDBTableView1
    end
  end
  object dtsCadNcm: TDataSource
    Left = 56
    Top = 32
  end
end
