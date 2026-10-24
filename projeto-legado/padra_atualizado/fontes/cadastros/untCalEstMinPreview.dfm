inherited frmCalEstMinPreview: TfrmCalEstMinPreview
  Width = 971
  Height = 535
  BorderStyle = bsSizeable
  Caption = 'Pr'#233'via do C'#225'lculo de Estoque M'#237'nimo'
  Position = poMainFormCenter
  ExplicitWidth = 971
  ExplicitHeight = 535
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 452
    Width = 955
    ExplicitTop = 452
    ExplicitWidth = 955
    inherited FlwBotoes: TFlowPanel
      Width = 951
      ExplicitWidth = 951
    end
  end
  inherited pnlStatus: TPanel
    Top = 480
    Width = 955
    ExplicitTop = 480
    ExplicitWidth = 955
    inherited pnlNomeForm: TPanel
      Left = 784
      ExplicitLeft = 784
    end
    inherited pnlInfo: TPanel
      Width = 784
      ExplicitWidth = 784
    end
  end
  inherited pgcDados: TPageControl
    Left = 765
    Top = 280
    Width = 68
    Height = 33
    Align = alNone
    ExplicitLeft = 765
    ExplicitTop = 280
    ExplicitWidth = 68
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 60
      ExplicitHeight = 1
    end
  end
  object pnlBotoesMostra: TPanel [3]
    Left = 0
    Top = 452
    Width = 955
    Height = 28
    Align = alBottom
    Color = 16770261
    TabOrder = 3
    DesignSize = (
      955
      28)
    object lblLegendaDeletar: TLabel
      Left = 1
      Top = 1
      Width = 216
      Height = 26
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = 'Pressione [ DELETE ] para excluir o item'
      Color = clMoneyGreen
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object btnCancelar: TBitBtnLocked
      Left = 872
      Top = 4
      Width = 77
      Height = 21
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      TabOrder = 0
      OnClick = btnCancelarClick
    end
    object btnGerar: TBitBtnLocked
      Left = 796
      Top = 4
      Width = 72
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Gravar'
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
      TabOrder = 1
      OnClick = btnGerarClick
    end
  end
  object gridDados: TcxGrid [4]
    Left = 0
    Top = 0
    Width = 955
    Height = 452
    Align = alClient
    TabOrder = 4
    object gridDadosView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object gridDadosViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        MinWidth = 81
        Options.Editing = False
        Options.Focusing = False
        Options.HorzSizing = False
        Width = 81
      end
      object gridDadosViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 244
      end
      object gridDadosViewColumn3: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'UNI_DESUNI'
        MinWidth = 110
        Options.Editing = False
        Options.Focusing = False
        Options.HorzSizing = False
        Width = 110
      end
      object gridDadosViewColumn4: TcxGridDBColumn
        Caption = 'Emp'
        DataBinding.FieldName = 'ITE_CODEMP'
        Visible = False
        GroupIndex = 0
        MinWidth = 95
        Options.Editing = False
        Options.Focusing = False
        Options.HorzSizing = False
        Width = 95
      end
      object gridDadosViewColumn5: TcxGridDBColumn
        Caption = 'Est. Min. Atual'
        DataBinding.FieldName = 'ITE_ESTMIN'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        MinWidth = 94
        Options.Editing = False
        Options.Focusing = False
        Options.HorzSizing = False
        Width = 94
      end
      object gridDadosViewColumn7: TcxGridDBColumn
        Caption = 'Est. Min. Novo'
        DataBinding.FieldName = 'ESTMIN'
        MinWidth = 101
        Options.HorzSizing = False
        Width = 101
      end
      object gridDadosViewColumn6: TcxGridDBColumn
        Caption = 'Est. Max. Atual'
        DataBinding.FieldName = 'ITE_ESTMAX'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        MinWidth = 104
        Options.Editing = False
        Options.Focusing = False
        Options.HorzSizing = False
        Width = 104
      end
      object gridDadosViewColumn8: TcxGridDBColumn
        Caption = 'Est. Max. Novo'
        DataBinding.FieldName = 'ESTMAX'
        MinWidth = 95
        Options.HorzSizing = False
        Width = 95
      end
    end
    object gridDadosLevel: TcxGridLevel
      GridView = gridDadosView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 32
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 32
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 32
    Top = 304
  end
  object dsDados: TUniDataSource
    Left = 344
    Top = 152
  end
end
