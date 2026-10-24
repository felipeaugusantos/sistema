inherited frmEditorLayout: TfrmEditorLayout
  Width = 460
  Height = 569
  Caption = 'Editor Layout'
  Position = poMainFormCenter
  ExplicitWidth = 460
  ExplicitHeight = 569
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 496
    Width = 454
    ExplicitTop = 496
    ExplicitWidth = 454
    inherited FlwBotoes: TFlowPanel
      Width = 450
      ExplicitWidth = 450
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 113
        Height = 24
        Caption = '&Confirma'
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
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 374
      Top = 2
      Height = 24
      ExplicitLeft = 374
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 524
    Width = 454
    ExplicitTop = 524
    ExplicitWidth = 454
    inherited pnlNomeForm: TPanel
      Left = 283
      ExplicitLeft = 283
    end
    inherited pnlInfo: TPanel
      Width = 283
      ExplicitWidth = 283
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 454
    Height = 49
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 2
      Top = 4
      Width = 81
      Height = 14
      Caption = 'Nome do Layout:'
    end
    object edtNomLayout: TEdit
      Tag = 99
      Left = 2
      Top = 19
      Width = 419
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 0
    end
  end
  object cxCampos: TcxGrid [3]
    Left = 0
    Top = 49
    Width = 454
    Height = 427
    Align = alClient
    TabOrder = 4
    object cxCamposDB: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxCamposDBCustomDrawCell
      DataController.DataSource = dtsCampos
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxCamposDBColumn1: TcxGridDBColumn
        Caption = 'Campo'
        DataBinding.FieldName = 'LAY_DESCRI'
        Options.Editing = False
        Width = 339
      end
      object cxCamposDBColuna: TcxGridDBColumn
        Caption = 'Coluna Excel'
        DataBinding.FieldName = 'LAY_POSLAY'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        HeaderAlignmentHorz = taCenter
        Width = 81
      end
      object cxCamposObrigatorio: TcxGridDBColumn
        DataBinding.FieldName = 'LAY_OBRIGA'
        Visible = False
      end
    end
    object cxCamposLvl: TcxGridLevel
      GridView = cxCamposDB
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 476
    Width = 454
    Height = 20
    Align = alBottom
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 2
      Width = 194
      Height = 14
      Caption = 'Campos de preenchimentos obrigatorios'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  object dtsCampos: TDataSource
    Left = 340
    Top = 228
  end
end
