inherited frmPaiOrdenaCxGrid: TfrmPaiOrdenaCxGrid
  Left = 220
  Top = 226
  Width = 733
  Height = 327
  BorderStyle = bsSizeable
  Caption = 'frmPaiOrdenaCxGrid'
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 733
  ExplicitHeight = 327
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 244
    Width = 717
    ExplicitTop = 244
    ExplicitWidth = 717
    DesignSize = (
      717
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 713
      ExplicitWidth = 713
    end
    inherited btnSair: TBitBtnLocked
      Left = 639
      Cancel = False
      ModalResult = 0
      ExplicitLeft = 639
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 717
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
  end
  object pnlTail: TPanel [3]
    Left = 0
    Top = 196
    Width = 717
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    Visible = False
  end
  object pnlPesquisa: TPanel [4]
    Left = 0
    Top = 57
    Width = 717
    Height = 40
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 272
    Width = 717
    ExplicitTop = 272
    ExplicitWidth = 717
    inherited pnlNomeForm: TPanel
      Left = 546
      ExplicitLeft = 546
    end
    inherited pnlInfo: TPanel
      Width = 546
      ExplicitWidth = 546
    end
  end
  object dbgConsulta: TcxGridCitel [6]
    Left = 0
    Top = 97
    Width = 717
    Height = 99
    Align = alClient
    TabOrder = 6
    ExplicitTop = 93
    object dbgConsultaDados: TcxGridDBTableViewCitel
      OnDblClick = dbgConsultaDadosDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
    end
    object dbgConsultaNivel: TcxGridLevel
      GridView = dbgConsultaDados
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 104
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 120
    Top = 104
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 152
    Top = 104
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    AfterInsert = cdsConsultaAfterInsert
    Left = 184
    Top = 104
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 216
    Top = 104
  end
end
