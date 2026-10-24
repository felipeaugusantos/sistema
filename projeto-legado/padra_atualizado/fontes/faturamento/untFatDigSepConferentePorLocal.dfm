inherited frmFatDigSepConferentePorLocal: TfrmFatDigSepConferentePorLocal
  Width = 800
  Height = 500
  Caption = 'Selecione o Separador e o Conferente Por Local'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  object lblLimparExpedido: TLabel [0]
    Left = 0
    Top = 413
    Width = 794
    Height = 14
    Align = alBottom
    Alignment = taCenter
    Caption = 
      '[ENTER] navega/edita valores          [SETOR N/I] itens sem seto' +
      'r informado no cadastro'
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    ExplicitWidth = 416
  end
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 794
    ExplicitTop = 427
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
    end
  end
  inherited pgcDados: TPageControl
    Width = 794
    Height = 413
    Visible = False
    ExplicitWidth = 794
    ExplicitHeight = 413
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 381
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 794
    ExplicitTop = 455
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object cxGrid: TcxGrid [5]
    Tag = 99
    Left = 0
    Top = 0
    Width = 794
    Height = 413
    Align = alClient
    TabOrder = 4
    OnEnter = cxGridEnter
    object cxGridDBGrid: TcxGridDBTableView
      OnKeyDown = cxGridDBGridKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = cxGridDBGridEditKeyDown
      OnEditKeyPress = cxGridDBGridEditKeyPress
      DataController.DataSource = dspSepara
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGridDBGridSETOR_: TcxGridDBColumn
        Caption = 'Setor'
        DataBinding.FieldName = 'SETOR_'
        Options.Editing = False
      end
      object cxGridDBGridCODSEP: TcxGridDBColumn
        Caption = 'Separador'
        DataBinding.FieldName = 'CODSEP'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Width = 59
      end
      object cxGridDBGridDESSEP: TcxGridDBColumn
        DataBinding.FieldName = 'DESSEP'
        Options.Editing = False
      end
      object cxGridDBGridCODCON: TcxGridDBColumn
        Caption = 'Conferente'
        DataBinding.FieldName = 'CODCON'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.EchoMode = eemPassword
        Properties.PasswordChar = '*'
        Width = 59
      end
      object cxGridDBGridDESCON: TcxGridDBColumn
        DataBinding.FieldName = 'DESCON'
        Options.Editing = False
      end
      object cxGridDBGridCODEMB: TcxGridDBColumn
        Caption = 'Embalador'
        DataBinding.FieldName = 'CODEMB'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Width = 59
      end
      object cxGridDBGridDESEMB: TcxGridDBColumn
        DataBinding.FieldName = 'DESEMB'
        Options.Editing = False
      end
      object cxGridDBGridOBSEXP: TcxGridDBColumn
        Caption = 'Observa'#231#227'o'
        DataBinding.FieldName = 'OBSEXP'
        Width = 128
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBGrid
    end
  end
  object edtCod: TEditFocus [6]
    Tag = 99
    Left = 510
    Top = 26
    Width = 36
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 5
    Visible = False
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNom: TEditFocus [7]
    Tag = 99
    Left = 549
    Top = 26
    Width = 37
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 6
    Visible = False
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object pnlConfirma: TPanel [8]
    Left = 0
    Top = 427
    Width = 794
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 7
    object btnConfirmaDados: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
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
      OnClick = btnConfirmaDadosClick
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 711
      Top = 3
      Width = 77
      Height = 22
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnCancelaDadosClick
    end
  end
  object cdsSepara: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforeEdit = cdsSeparaBeforeEdit
    BeforePost = cdsSeparaBeforePost
    AfterPost = cdsSeparaAfterPost
    AfterCancel = cdsSeparaAfterCancel
    AfterScroll = cdsSeparaAfterScroll
    Left = 464
    Top = 80
    object cdsSeparaSEQSEP: TIntegerField
      FieldName = 'SEQSEP'
    end
    object cdsSeparaSETOR_: TStringField
      FieldName = 'SETOR_'
      Size = 40
    end
    object cdsSeparaCODSEP: TStringField
      FieldName = 'CODSEP'
      Size = 3
    end
    object cdsSeparaDESSEP: TStringField
      DisplayLabel = ' '
      DisplayWidth = 20
      FieldName = 'DESSEP'
    end
    object cdsSeparaCODCON: TStringField
      DisplayWidth = 20
      FieldName = 'CODCON'
    end
    object cdsSeparaDESCON: TStringField
      DisplayLabel = ' '
      FieldName = 'DESCON'
    end
    object cdsSeparaCODEMB: TStringField
      FieldName = 'CODEMB'
      Size = 3
    end
    object cdsSeparaDESEMB: TStringField
      DisplayLabel = ' '
      FieldName = 'DESEMB'
    end
    object cdsSeparaOBSEXP: TStringField
      FieldName = 'OBSEXP'
      Size = 50
    end
  end
  object dspSepara: TDataSource
    DataSet = cdsSepara
    Left = 496
    Top = 80
  end
end
