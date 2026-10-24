inherited frmEntConferenciaGarantiaDigRefugo: TfrmEntConferenciaGarantiaDigRefugo
  Width = 809
  Height = 412
  Caption = 'frmEntConferenciaGarantiaDigRefugo'
  ExplicitWidth = 809
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 341
    Width = 803
    ExplicitTop = 341
    ExplicitWidth = 803
    inherited FlwBotoes: TFlowPanel
      Width = 799
      ExplicitLeft = 18
      ExplicitTop = 0
      ExplicitWidth = 799
    end
    inherited btnSair: TBitBtnLocked
      Left = 724
      Top = 2
      ExplicitLeft = 724
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 367
    Width = 803
    ExplicitTop = 367
    ExplicitWidth = 803
    inherited pnlNomeForm: TPanel
      Left = 632
      ExplicitLeft = 632
    end
    inherited pnlInfo: TPanel
      Width = 632
      ExplicitWidth = 632
    end
  end
  object cxgRefugo: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 803
    Height = 341
    Align = alClient
    TabOrder = 3
    OnExit = cxgRefugoExit
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgRefugoTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgRefugoNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Options.Editing = False
        Options.Focusing = False
        Width = 98
      end
      object cxgRefugoDTAENT: TcxGridDBColumn
        Caption = 'Data Emi.'
        DataBinding.FieldName = 'DTAENT'
        Options.Editing = False
        Options.Focusing = False
        Width = 68
      end
      object cxgRefugoCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 50
      end
      object cxgRefugoDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 176
      end
      object cxgRefugoCODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Options.Editing = False
        Options.Focusing = False
        Width = 83
      end
      object cxgRefugoREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Options.Editing = False
        Options.Focusing = False
        Width = 92
      end
      object cxgRefugoSIGUNI: TcxGridDBColumn
        Caption = 'UN.'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
        Options.Focusing = False
        Width = 28
      end
      object cxgRefugoQTDITE: TcxGridDBColumn
        Caption = 'Qtde. NF.'
        DataBinding.FieldName = 'QTDITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 67
      end
      object cxgRefugoQTDREF: TcxGridDBColumn
        Caption = 'Qtde. Refugo'
        DataBinding.FieldName = 'QTDREF'
        Width = 76
      end
    end
    object cxgRefugoLevel: TcxGridLevel
      GridView = cxgRefugoTableView
    end
  end
end
