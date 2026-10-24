inherited frmClassifCentroCusto: TfrmClassifCentroCusto
  Width = 700
  Height = 400
  BorderIcons = [biSystemMenu]
  Caption = 'Classifica'#231#227'o do Plano de Contas'
  Position = poMainFormCenter
  ExplicitWidth = 700
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 327
    Width = 694
    Height = 28
    Enabled = True
    Visible = True
    ExplicitTop = 327
    ExplicitWidth = 694
    ExplicitHeight = 28
    DesignSize = (
      694
      28)
    inherited FlwBotoes: TFlowPanel
      Top = 2
      Width = 690
      Height = 24
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 690
      ExplicitHeight = 24
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 22
        Caption = '[F10] Gravar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 591
      Top = 2
      Width = 100
      Caption = '[ESC] Sair'
      ExplicitLeft = 591
      ExplicitTop = 2
      ExplicitWidth = 100
    end
  end
  inherited pgcDados: TPageControl
    Width = 694
    Height = 327
    ExplicitWidth = 694
    ExplicitHeight = 327
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 686
      ExplicitHeight = 295
    end
  end
  object pnl1: TPanel [3]
    Left = 0
    Top = 0
    Width = 694
    Height = 327
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object gridDados: TcxGrid
      Left = 0
      Top = 0
      Width = 694
      Height = 327
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.ScrollbarMode = sbmClassic
      object gridDadosDBTable: TcxGridDBTableView
        OnKeyDown = gridDadosDBTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsCadCta
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object gridDadosDBTableCODCTA: TcxGridDBColumn
          Caption = 'C'#243'd. Conta'
          DataBinding.FieldName = 'CTA_CODCTA'
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 100
        end
        object gridDadosDBTableDESCTA: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'CTA_DESCTA'
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 325
        end
        object gridDadosDBTableCODCCC: TcxGridDBColumn
          Caption = 'Classifica'#231#227'o'
          DataBinding.FieldName = 'CTA_CODCCC'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'CCC_CODIGO'
          Properties.ListColumns = <
            item
              Caption = 'Classifica'#231#227'o'
              FieldName = 'CCC_DESCRI'
            end>
          Properties.ListSource = dtsCadCCu
          Styles.Header = cxStyle1
          Width = 250
        end
      end
      object gridDadosLevel: TcxGridLevel
        GridView = gridDadosDBTable
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 355
    Width = 694
    ExplicitTop = 355
    ExplicitWidth = 694
    inherited pnlNomeForm: TPanel
      Left = 523
      ExplicitLeft = 523
    end
    inherited pnlInfo: TPanel
      Width = 523
      ExplicitWidth = 523
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
    Top = 152
  end
  object dtsCadCta: TDataSource
    DataSet = cdsCadCta
    Left = 344
    Top = 152
  end
  object dtsCadCCu: TDataSource
    Left = 504
    Top = 152
  end
  object cdsCadCta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCadCta'
    Left = 312
    Top = 152
  end
  object dspCadCta: TUniDataSetProvider
    DataSet = qryCadCta
    Options = []
    Left = 280
    Top = 152
  end
  object qryCadCta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 248
    Top = 152
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 536
    Top = 152
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
