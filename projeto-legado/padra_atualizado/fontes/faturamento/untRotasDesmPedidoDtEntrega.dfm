inherited frmRotasDesmPedidoDtEntrega: TfrmRotasDesmPedidoDtEntrega
  Width = 731
  Height = 381
  BorderIcons = []
  Caption = 'Informar Rotas por Pedidos Desmembrados'
  Position = poMainFormCenter
  ExplicitWidth = 731
  ExplicitHeight = 381
  PixelsPerInch = 96
  TextHeight = 14
  object LPedidos: TLabel [0]
    Left = 8
    Top = 10
    Width = 160
    Height = 13
    Caption = 'Pedidos por Data de Entrega'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Legenda: TLabel [1]
    Left = 10
    Top = 291
    Width = 221
    Height = 13
    Caption = 'Para pesquisar a Rota digite a tecla "/"'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 308
    Width = 725
    ExplicitTop = 308
    ExplicitWidth = 725
    inherited FlwBotoes: TFlowPanel
      Width = 721
      ExplicitWidth = 721
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 25
        Caption = 'Confirmar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000030000000E000000150000000C0000
          0002000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000200000012072B199C136940FF051E127A0000
          000C000000010000000000000000000000000000000000000000000000000000
          0000000000000000000200000010082D1B9A278B63FF3CB58BFF16623FF4020B
          063D000000060000000000000000000000000000000000000000000000000000
          0000000000020000000E082F1C972C9068FF45C097FF44BF96FF36A67DFF0C46
          2BCE000000150000000200000000000000000000000000000000000000000000
          00010000000C09321F9430966FFF56CAA4FF95E3C8FF7BD7B8FF48C39AFF2A8D
          65FF082B1A8A0000000C00000001000000000000000000000000000000000000
          00060A352190349B75FF7BDBBBFFACE9D3FF4EA07EFF6DB99AFF7DDABBFF4CC4
          9DFF1F7852FC03120B4800000007000000010000000000000000000000000000
          00084B8E60FF99E8CEFF90D0B7FF287F5BEF09281B680E422D9A6EBA9DFF75D9
          B7FF4ABE97FF196747E70209062B000000040000000000000000000000000000
          0003082016494D9063FF14573CB2020B0723000000070000000C135239B280CA
          AEFF71D8B8FF46B691FF135639CA000101140000000200000000000000000000
          0000000000030000000600000005000000020000000000000002010302121A63
          44C28CD3B9FF7ADDBEFF3FAA84FF0D432CA10000000D00000002000000000000
          0000000000000000000000000000000000000000000000000000000000020105
          03151B6748C484CFB3FF81E1C4FF38A27BFF0B34237D00000007000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000101030210175E42B27ECCAFFF97E9D0FF4E9265FF00000009000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000010002010B15573DA5509769FF0822184A00000004000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000100000004000000060000000300000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 645
      ExplicitLeft = 645
    end
  end
  inherited pnlStatus: TPanel
    Top = 336
    Width = 725
    ExplicitTop = 336
    ExplicitWidth = 725
    inherited pnlNomeForm: TPanel
      Left = 554
      ExplicitLeft = 554
    end
    inherited pnlInfo: TPanel
      Width = 554
      ExplicitWidth = 554
    end
  end
  object DBGridCitel1: TDBGridCitel [4]
    Left = 8
    Top = 26
    Width = 710
    Height = 263
    DataSource = dsPedDesm
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyPress = DBGridCitel1KeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DtEntrega'
        Title.Caption = 'Dt. Entrega'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CodItems'
        Title.Caption = 'Itens da Entrega'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TotValor'
        Title.Caption = 'Valor Total'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TotPeso'
        Title.Caption = 'Peso Total'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CodSeqRota'
        Title.Caption = 'Cod. Seq. Rota'
        Width = 120
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 632
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 632
    Top = 176
  end
  object cdsPedDesm: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 200
    object cdsPedDesmDtEntrega: TDateField
      FieldName = 'DtEntrega'
    end
    object cdsPedDesmCodItems: TStringField
      FieldName = 'CodItems'
      Size = 200
    end
    object cdsPedDesmTotValor: TFloatField
      FieldName = 'TotValor'
      DisplayFormat = '#,###,##0.00'
    end
    object cdsPedDesmTotPeso: TFloatField
      FieldName = 'TotPeso'
      DisplayFormat = '#,###,##0.00'
    end
    object cdsPedDesmCodSeqRota: TStringField
      FieldName = 'CodSeqRota'
      Size = 40
    end
  end
  object dsPedDesm: TDataSource
    DataSet = cdsPedDesm
    Left = 280
    Top = 200
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = cdsPedDesm
    Left = 144
    Top = 152
  end
end
