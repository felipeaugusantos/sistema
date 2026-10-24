inherited frmConfigLucroPresumidoCopiarDe: TfrmConfigLucroPresumidoCopiarDe
  Width = 918
  Height = 318
  Caption = 'Copiar de'
  ExplicitWidth = 918
  ExplicitHeight = 318
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 247
    Width = 912
    ExplicitTop = 247
    ExplicitWidth = 912
    inherited FlwBotoes: TFlowPanel
      Width = 908
      ExplicitWidth = 908
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 832
      ExplicitLeft = 832
    end
  end
  inherited pnlStatus: TPanel
    Top = 273
    Width = 912
    ExplicitTop = 273
    ExplicitWidth = 912
    inherited pnlNomeForm: TPanel
      Left = 741
      ExplicitLeft = 741
    end
    inherited pnlInfo: TPanel
      Width = 741
      ExplicitWidth = 741
    end
  end
  object GridConfs: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 912
    Height = 247
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object GridConfsView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsConfs
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object GridConfsViewCODIGO: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODIGO'
        Visible = False
        VisibleForCustomization = False
      end
      object GridConfsViewCODEMP: TcxGridDBColumn
        Caption = 'C'#243'digo Empresa'
        DataBinding.FieldName = 'CODEMP'
        Width = 158
      end
      object GridConfsViewNOMEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'NOMEMP'
      end
      object GridConfsViewEXERCI: TcxGridDBColumn
        Caption = 'Exerc'#237'cio'
        DataBinding.FieldName = 'EXERCI'
        Width = 128
      end
    end
    object GridConfsLevel1: TcxGridLevel
      GridView = GridConfsView
    end
  end
  object cdsConfs: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 16
    object cdsConfsCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsConfsCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsConfsNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 55
    end
    object cdsConfsEXERCI: TIntegerField
      FieldName = 'EXERCI'
    end
  end
  object dsConfs: TDataSource
    AutoEdit = False
    DataSet = cdsConfs
    Left = 488
    Top = 64
  end
end
