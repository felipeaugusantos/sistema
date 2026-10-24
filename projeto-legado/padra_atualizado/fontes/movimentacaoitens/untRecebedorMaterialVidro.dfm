inherited frmRecebedorMaterialVidro: TfrmRecebedorMaterialVidro
  Width = 701
  Height = 387
  Caption = 'Recebedor de Material'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 701
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 314
    Width = 695
    ExplicitTop = 314
    ExplicitWidth = 695
    inherited FlwBotoes: TFlowPanel
      Width = 691
      ExplicitWidth = 691
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Confirmar'
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
      Left = 615
      ExplicitLeft = 615
    end
  end
  inherited pnlStatus: TPanel
    Top = 342
    Width = 695
    ExplicitTop = 342
    ExplicitWidth = 695
    inherited pnlNomeForm: TPanel
      Left = 524
      ExplicitLeft = 524
    end
    inherited pnlInfo: TPanel
      Width = 524
      ExplicitWidth = 524
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 695
    Height = 33
    Align = alTop
    TabOrder = 2
    object lblOperador: TLabel
      Left = 6
      Top = 5
      Width = 78
      Height = 19
      Caption = 'Operador:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object cxDados: TcxGridCitel [3]
    Left = 0
    Top = 33
    Width = 695
    Height = 281
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDadosCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        MinWidth = 64
        Options.Editing = False
      end
      object cxgDadosDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 288
      end
      object cxgDadosREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Width = 99
      end
      object cxgDadosSIGUNI: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
      end
      object cxgDadosQTDBAI: TcxGridDBColumn
        Caption = 'Qtd. Recebida'
        DataBinding.FieldName = 'QTDBAI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 95
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxgDados
    end
  end
  object dtsDados: TDataSource
    Left = 432
    Top = 232
  end
end
