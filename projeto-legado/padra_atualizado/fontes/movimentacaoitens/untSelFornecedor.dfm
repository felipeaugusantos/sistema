inherited frmSelFornecedor: TfrmSelFornecedor
  Width = 744
  Height = 422
  Caption = 'Sele'#231#227'o de Fornecedor'
  Position = poMainFormCenter
  ExplicitWidth = 744
  ExplicitHeight = 422
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 349
    Width = 738
    ExplicitTop = 349
    ExplicitWidth = 738
    inherited FlwBotoes: TFlowPanel
      Left = 117
      Width = 542
    end
    inherited btnSair: TBitBtnLocked
      Left = 659
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 659
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnOK: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 115
      Height = 24
      Align = alLeft
      Caption = 'Selecionar'
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
      ModalResult = 1
      TabOrder = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 377
    Width = 738
    ExplicitTop = 377
    ExplicitWidth = 738
    inherited pnlNomeForm: TPanel
      Left = 567
      ExplicitLeft = 567
    end
    inherited pnlInfo: TPanel
      Width = 567
      ExplicitWidth = 567
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 738
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Selecione o fornecedor para os pedidos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentColor = True
    ParentFont = False
    TabOrder = 3
  end
  object dbgConsulta: TDBGridCitel [3]
    Left = 0
    Top = 57
    Width = 738
    Height = 292
    Align = alClient
    DataSource = dtsConsulta
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'FOR_CODFOR'
        Title.Caption = 'C'#243'digo'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOR_NOMFOR'
        Title.Caption = 'Raz'#227'o Social'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOR_C_G_C_'
        Title.Caption = 'CNPJ'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CID_NOMCID'
        Title.Caption = 'Cidade'
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CID_ESTADO'
        Title.Caption = 'Estado'
        Visible = True
      end>
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 120
    Top = 104
  end
  object dtsConsulta: TDataSource
    DataSet = qryConsulta
    Left = 216
    Top = 104
  end
end
