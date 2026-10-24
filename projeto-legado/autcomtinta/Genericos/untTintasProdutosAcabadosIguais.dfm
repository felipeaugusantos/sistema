inherited frmTintasProdutosAcabadosIguais: TfrmTintasProdutosAcabadosIguais
  Width = 405
  Height = 361
  BorderStyle = bsSizeable
  Caption = 'Produtos Acabados Iguais'
  Position = poScreenCenter
  ExplicitWidth = 405
  ExplicitHeight = 361
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 279
    Width = 389
    TabOrder = 1
    ExplicitTop = 279
    ExplicitWidth = 389
    inherited btnSair: TBitBtnLocked
      Left = 306
      ExplicitLeft = 306
    end
  end
  object dbgDados: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 389
    Height = 279
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = -1
    ExplicitTop = -3
    object dbgvDados: TcxGridDBTableView
      OnKeyDown = dbgvDadosKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object dbcCodAca: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ACA_CODACA'
        PropertiesClassName = 'TcxTextEditProperties'
      end
      object dbcDesCri: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DET_DESCRI'
      end
      object dbcEmpEst: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'ACA_EMPEST'
      end
      object dbcSaldos: TcxGridDBColumn
        Caption = 'Saldos'
        DataBinding.FieldName = 'ACA_SALDOS'
      end
    end
    object dbglDados: TcxGridLevel
      GridView = dbgvDados
    end
  end
  inherited pnlStatus: TPanel
    Top = 307
    Width = 389
    TabOrder = 2
    ExplicitTop = 307
    ExplicitWidth = 389
    inherited pnlNomeForm: TPanel
      Left = 218
      TabOrder = 1
      ExplicitLeft = 218
    end
    inherited pnlInfo: TPanel
      Width = 218
      TabOrder = 0
      ExplicitWidth = 218
    end
  end
  object dtsDados: TDataSource
    AutoEdit = False
    Left = 272
    Top = 128
  end
end
