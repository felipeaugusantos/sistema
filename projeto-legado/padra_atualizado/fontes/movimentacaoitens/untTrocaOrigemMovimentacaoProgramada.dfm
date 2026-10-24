inherited frmTrocaOrigemMovimentacaoProgramada: TfrmTrocaOrigemMovimentacaoProgramada
  Width = 980
  Height = 593
  Caption = 'Trocar Localiza'#231#227'o de Origem'
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 980
  ExplicitHeight = 593
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 520
    Width = 974
    TabOrder = 4
    ExplicitTop = 520
    ExplicitWidth = 974
    inherited FlwBotoes: TFlowPanel
      Width = 970
      ExplicitWidth = 970
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 117
        Height = 23
        Caption = '[F10] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 891
      ExplicitLeft = 891
    end
  end
  inherited pnlStatus: TPanel
    Top = 548
    Width = 974
    TabOrder = 5
    ExplicitTop = 548
    ExplicitWidth = 974
    inherited pnlNomeForm: TPanel
      Left = 723
      Width = 251
      ExplicitLeft = 723
      ExplicitWidth = 251
    end
    inherited pnlInfo: TPanel
      Width = 723
      ExplicitWidth = 723
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 974
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 488
      Top = 0
      Width = 486
      Height = 66
      Align = alClient
      Caption = 'Destino'
      TabOrder = 0
      object Label2: TLabel
        Left = 14
        Top = 40
        Width = 61
        Height = 14
        Caption = 'Localiza'#231#227'o:'
      end
      object Label4: TLabel
        Left = 284
        Top = 40
        Width = 60
        Height = 14
        Caption = 'Capacidade:'
      end
      object Label12: TLabel
        Left = 51
        Top = 17
        Width = 24
        Height = 14
        Caption = 'Lote:'
      end
      object edtLocFisDes: TEditFocus
        Left = 78
        Top = 37
        Width = 200
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 0
        Text = 'EditFocus1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCapacidade: TEditFocus
        Left = 348
        Top = 37
        Width = 108
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 1
        Text = 'EditFocus1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumLotDes: TEditFocus
        Left = 78
        Top = 13
        Width = 200
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 2
        Text = 'edtLocFisOri'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 0
      Width = 488
      Height = 66
      Align = alLeft
      Caption = 'Origem'
      TabOrder = 1
      object Label1: TLabel
        Left = 11
        Top = 40
        Width = 61
        Height = 14
        Caption = 'Localiza'#231#227'o:'
      end
      object Label3: TLabel
        Left = 284
        Top = 40
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object Label11: TLabel
        Left = 48
        Top = 16
        Width = 24
        Height = 14
        Caption = 'Lote:'
      end
      object edtLocFisOri: TEditFocus
        Left = 78
        Top = 37
        Width = 200
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 0
        Text = 'edtLocFisOri'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdMov: TEditFocus
        Left = 342
        Top = 37
        Width = 108
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 1
        Text = 'EditFocus1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumLotOri: TEditFocus
        Left = 78
        Top = 13
        Width = 200
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 2
        Text = 'edtLocFisOri'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlitem: TPanel [3]
    Left = 0
    Top = 145
    Width = 974
    Height = 92
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 3
    object Label10: TLabel
      Left = 23
      Top = 68
      Width = 96
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Quantidade:'
    end
    object lblOrigem: TLabel
      Left = 12
      Top = 31
      Width = 107
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Novo Lote de Origem:'
    end
    object grbOrigem: TGroupBox
      Left = 223
      Top = -3
      Width = 517
      Height = 62
      Caption = 'Lote de Origem:'
      TabOrder = 0
      object lblSalOri: TLabel
        Left = 19
        Top = 16
        Width = 61
        Height = 14
        Caption = 'Saldo F'#237'sico:'
      end
      object lblMaxOri: TLabel
        Left = 395
        Top = 16
        Width = 92
        Height = 14
        Caption = 'Localiza'#231#227'o F'#237'sica:'
      end
      object Label8: TLabel
        Left = 149
        Top = 16
        Width = 89
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Saldo Reservado:'
      end
      object Label9: TLabel
        Left = 276
        Top = 16
        Width = 82
        Height = 14
        AutoSize = False
        Caption = 'Saldo Dispon'#237'vel:'
      end
      object dbeSalOri: TEditFocus
        Left = 19
        Top = 31
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeMaxOri: TEditFocus
        Left = 395
        Top = 31
        Width = 111
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeSalOriRes: TEditFocus
        Left = 149
        Top = 31
        Width = 103
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeSalOriDis: TEditFocus
        Left = 275
        Top = 31
        Width = 103
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeLotOri: TEditFocus
      Tag = 99
      Left = 122
      Top = 28
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 1
      OnKeyPress = dbeLotOriKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdIte: TEditFocus
      Tag = 99
      Left = 121
      Top = 65
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 223
      Top = 65
      Width = 81
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 3
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 306
      Top = 65
      Width = 81
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
      TabOrder = 4
      OnClick = btnCancelaItemClick
    end
  end
  object pnlCabec: TPanel [4]
    Left = 0
    Top = 117
    Width = 974
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lblDigita: TLabel
      Left = 74
      Top = 9
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
    end
    object edtSenDig: TEditFocus
      Tag = 99
      Left = 121
      Top = 3
      Width = 54
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 0
      OnExit = edtSenDigExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 175
      Top = 3
      Width = 464
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgItens: TcxGridCitel [5]
    Left = 0
    Top = 237
    Width = 974
    Height = 283
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 6
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableViewCitel
      OnKeyDown = cxgItensViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsGrid
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxgItensViewColumn5
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgItensViewColumn8: TcxGridDBColumn
        Caption = 'Lote de Origem'
        DataBinding.FieldName = 'LOT_NUMLOT'
        Width = 120
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Loc. F'#237'sica Origem'
        DataBinding.FieldName = 'LOT_LOCFIS'
        Width = 120
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Loc. de Destino '
        DataBinding.FieldName = 'LOC_CODLOC'
        Width = 120
      end
      object cxgItensViewColumn5: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTD_TRANSF'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object Panel2: TPanel [6]
    Left = 0
    Top = 66
    Width = 974
    Height = 51
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Label5: TLabel
      Left = 59
      Top = 6
      Width = 56
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Produto:'
    end
    object Label6: TLabel
      Left = 63
      Top = 31
      Width = 56
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Marca:'
    end
    object Label7: TLabel
      Left = 526
      Top = 31
      Width = 56
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Unidade:'
    end
    object edtCodite: TEditFocus
      Tag = 99
      Left = 121
      Top = 2
      Width = 54
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 175
      Top = 2
      Width = 465
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMar: TEditFocus
      Left = 121
      Top = 26
      Width = 54
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 175
      Top = 26
      Width = 345
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSigUni: TEditFocus
      Left = 586
      Top = 26
      Width = 54
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cdsItens: TUniClientDataSet
    PersistDataPacket.Data = {
      DB0000009619E0BD010000001800000007000000000003000000DB000A495445
      5F434F4449544501004900000001000557494454480200020007000A4954455F
      44455349544501004900000001000557494454480200020046000A4C4F435F43
      4F444C4F430100490000000100055749445448020002001E000A5154445F5452
      414E534608000400000000000A4C4F545F4E554D4C4F54010049000000010005
      5749445448020002001E000A4C4F545F4C4F4346495301004900000001000557
      49445448020002001E000A4C4F545F44544156414C04000600000000000000}
    Active = True
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'ITE_CODITE'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'ITE_DESITE'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'LOC_CODLOC'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'QTD_TRANSF'
        DataType = ftFloat
      end
      item
        Name = 'LOT_NUMLOT'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'LOT_LOCFIS'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'LOT_DTAVAL'
        DataType = ftDate
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 184
    Top = 368
    object cdsItensITE_CODITE: TStringField
      FieldName = 'ITE_CODITE'
      Size = 7
    end
    object cdsItensITE_DESITE: TStringField
      FieldName = 'ITE_DESITE'
      Size = 70
    end
    object cdsItensLOC_CODLOC: TStringField
      FieldName = 'LOC_CODLOC'
      Size = 30
    end
    object cdsItensQTD_TRANSF: TFloatField
      FieldName = 'QTD_TRANSF'
    end
    object cdsItensLOT_NUMLOT: TStringField
      FieldName = 'LOT_NUMLOT'
      Size = 30
    end
    object cdsItensLOT_LOCFIS: TStringField
      FieldName = 'LOT_LOCFIS'
      Size = 30
    end
    object cdsItensLOT_DTAVAL: TDateField
      FieldName = 'LOT_DTAVAL'
    end
  end
  object dtsGrid: TDataSource
    DataSet = cdsItens
    Left = 264
    Top = 376
  end
end
