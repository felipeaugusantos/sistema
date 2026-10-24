inherited frmDigMecanicos: TfrmDigMecanicos
  Left = 246
  Top = 222
  Width = 450
  Height = 359
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o dos Mec'#226'nicos'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 450
  ExplicitHeight = 359
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 258
    Width = 444
    TabOrder = 6
    ExplicitTop = 258
    ExplicitWidth = 444
    DesignSize = (
      444
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 440
      ExplicitWidth = 440
    end
    inherited btnSair: TBitBtnLocked
      Left = 325
      ExplicitLeft = 325
    end
  end
  inherited pnlStatus: TPanel
    Top = 314
    Width = 444
    TabOrder = 4
    ExplicitTop = 314
    ExplicitWidth = 444
    inherited pnlNomeForm: TPanel
      Left = 256
      Width = 188
      ExplicitLeft = 256
      ExplicitWidth = 188
    end
    inherited pnlInfo: TPanel
      Width = 256
      ExplicitWidth = 256
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 258
    Align = alNone
    TabOrder = 3
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 258
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 226
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 286
    Width = 444
    Height = 28
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      444
      28)
    object btnConfirmaDados: TBitBtnLocked
      Left = 6
      Top = 0
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
      ModalResult = 1
      TabOrder = 0
      OnClick = btnConfirmaDadosClick
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 362
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akTop, akRight]
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
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelaClick
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 444
    Height = 91
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    DesignSize = (
      444
      91)
    object lbl1: TLabel
      Left = 14
      Top = 4
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mec'#226'nico'
    end
    object lblObs: TLabel
      Left = 14
      Top = 46
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#227'o'
    end
    object btnAdicionar: TBitBtnLocked
      Left = 343
      Top = 18
      Width = 87
      Height = 22
      Anchors = [akTop, akRight]
      Caption = '&Adicionar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
        4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
        D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
        FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
        C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
        E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
        D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
        258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
        68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
        123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
        93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
        3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
        2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
        2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
        FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
        13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnAdicionarClick
    end
    object edtCodMec: TEditFocus
      Tag = 99
      Left = 14
      Top = 18
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodMecKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomMec: TEditFocus
      Left = 64
      Top = 18
      Width = 268
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObsMec: TEditFocus
      Left = 14
      Top = 62
      Width = 416
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlAltMecGer: TPanel [5]
    Left = 0
    Top = 258
    Width = 444
    Height = 28
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    Visible = False
    object chkAltMecGer: TCheckBox
      Left = 4
      Top = 7
      Width = 349
      Height = 17
      Caption = 'Alterar mec'#226'nicos para todos os produtos?'
      TabOrder = 0
    end
  end
  object dbgMecanicos: TDBGridCitel [6]
    Left = 0
    Top = 91
    Width = 444
    Height = 167
    Align = alClient
    DataSource = dtsMecanicos
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgMecanicosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODMEC'
        Width = 49
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMMEC'
        Width = 357
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBSMEC'
        Title.Caption = 'Observa'#231#227'o'
        Width = 600
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 8
  end
  object cdsMecanicos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 184
    object cdsMecanicosCODMEC: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODMEC'
      Size = 3
    end
    object cdsMecanicosNOMMEC: TStringField
      DisplayLabel = 'Nome do Mec'#226'nico'
      FieldName = 'NOMMEC'
      Size = 30
    end
    object cdsMecanicosOBSMEC: TStringField
      FieldName = 'OBSMEC'
      Size = 100
    end
  end
  object dtsMecanicos: TDataSource
    AutoEdit = False
    DataSet = cdsMecanicos
    Left = 200
    Top = 128
  end
  object cdsTempMec: TUniClientDataSet
    PersistDataPacket.Data = {
      350000009619E0BD010000001800000001000000000003000000350006434F44
      4D454301004900000001000557494454480200020003000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODMEC'
        DataType = ftString
        Size = 3
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 368
    Top = 176
    object StringField1: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODMEC'
      Size = 3
    end
  end
end
