inherited frmReqMaterialConsumoEdit: TfrmReqMaterialConsumoEdit
  Width = 638
  Height = 451
  ActiveControl = dbeDtaEnt
  Caption = 'Requisi'#231#227'o de Material de Consumo'
  OnDestroy = FormDestroy
  ExplicitWidth = 638
  ExplicitHeight = 451
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 380
    Width = 632
    TabOrder = 3
    ExplicitTop = 380
    ExplicitWidth = 632
    inherited FlwBotoes: TFlowPanel
      Width = 551
      ExplicitWidth = 551
      inherited btnConfirma: TBitBtnLocked
        Width = 116
        Caption = '(F10) &Confirma'
        ExplicitWidth = 116
      end
      object btnExcluir: TBitBtnLocked
        Left = 116
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ DEL ] Exclui item'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 553
      Top = 2
      Align = alRight
      ExplicitLeft = 553
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 406
    Width = 632
    TabOrder = 4
    ExplicitTop = 406
    ExplicitWidth = 632
    inherited pnlNomeForm: TPanel
      Left = 461
      ExplicitLeft = 461
    end
    inherited pnlInfo: TPanel
      Width = 461
      ExplicitWidth = 461
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 632
    Height = 139
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object Label2: TLabel
      Left = 394
      Top = 216
      Width = 97
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data altera'#231#227'o :'
    end
    object Label1: TLabel
      Left = 212
      Top = 7
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 34
      Top = 9
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Entrada:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblTip_fc: TLabel
      Left = 55
      Top = 31
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDigita: TLabel
      Left = 69
      Top = 51
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 58
      Top = 73
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Entregador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblObserv: TLabel
      Left = 51
      Top = 95
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 366
      Top = 9
      Width = 77
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data altera'#231#227'o:'
    end
    object edtNomForCli: TEditFocus
      Left = 190
      Top = 27
      Width = 339
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaEnt: TDBEditFocus
      Tag = 99
      Left = 115
      Top = 5
      Width = 75
      Height = 22
      DataField = 'REQ_DTAENT'
      DataSource = dtsGerMco
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForCli: TDBEditFocus
      Tag = 99
      Left = 115
      Top = 27
      Width = 75
      Height = 22
      AutoSize = False
      CharCase = ecUpperCase
      DataField = 'REQ_FORCLI'
      DataSource = dtsGerMco
      MaxLength = 8
      TabOrder = 3
      OnKeyPress = dbeForCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeCodDig: TDBEditFocus
      Tag = 99
      Left = 115
      Top = 48
      Width = 75
      Height = 22
      AutoSize = False
      CharCase = ecUpperCase
      DataField = 'CODDIG'
      DataSource = dtsGerMco
      PasswordChar = '*'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEnt: TDBEditFocus
      Tag = 99
      Left = 115
      Top = 70
      Width = 75
      Height = 22
      AutoSize = False
      CharCase = ecUpperCase
      DataField = 'REQ_CODENT'
      DataSource = dtsGerMco
      MaxLength = 5
      TabOrder = 7
      OnKeyPress = dbeCodEntKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeMen001: TDBEditFocus
      Tag = 99
      Left = 115
      Top = 92
      Width = 414
      Height = 22
      AutoSize = False
      CharCase = ecUpperCase
      DataField = 'REQ_MEN001'
      DataSource = dtsGerMco
      MaxLength = 80
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMen002: TDBEditFocus
      Tag = 99
      Left = 115
      Top = 115
      Width = 414
      Height = 22
      AutoSize = False
      CharCase = ecUpperCase
      DataField = 'REQ_MEN002'
      DataSource = dtsGerMco
      MaxLength = 80
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 190
      Top = 48
      Width = 339
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomEnt: TEditFocus
      Left = 190
      Top = 70
      Width = 339
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeNumReq: TDBEditFocus
      Tag = 99
      Left = 270
      Top = 5
      Width = 90
      Height = 22
      AutoSize = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'REQ_NUMREQ'
      DataSource = dtsGerMco
      Enabled = False
      MaxLength = 6
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaAlt: TDBEditFocus
      Left = 446
      Top = 5
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'REQ_DTAALT'
      DataSource = dtsGerMco
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgMateriais: TcxGrid [3]
    Left = 0
    Top = 192
    Width = 632
    Height = 188
    Align = alClient
    TabOrder = 2
    OnEnter = cxgMateriaisEnter
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgMateriaisTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDetMcoGrid
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgMateriaisCODMCO: TcxGridDBColumn
        Caption = 'C'#243'd. Material'
        DataBinding.FieldName = 'REQ_CODMCO'
        Width = 72
      end
      object cxgMateriaisDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'REQ_DESCRI'
        Width = 304
      end
      object cxgMateriaisQTDMCO: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'REQ_QTDMCO'
        HeaderAlignmentHorz = taRightJustify
        Width = 71
      end
      object cxgMateriaisUNITAR: TcxGridDBColumn
        Caption = 'Valor Unit'#225'rio'
        DataBinding.FieldName = 'REQ_UNITAR'
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgMateriaisTOTMCO: TcxGridDBColumn
        Caption = 'Valor Total'
        DataBinding.FieldName = 'REQ_TOTMCO'
        HeaderAlignmentHorz = taRightJustify
        Width = 95
      end
    end
    object cxgMateriaisLevel1: TcxGridLevel
      GridView = cxgMateriaisTableView
    end
  end
  object pnlMaterial: TPanel [4]
    Left = 0
    Top = 139
    Width = 632
    Height = 53
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 1
    OnEnter = pnlMaterialEnter
    OnExit = pnlMaterialExit
    object Label9: TLabel
      Left = 17
      Top = 7
      Width = 97
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo do Material:'
    end
    object Label10: TLabel
      Left = 39
      Top = 31
      Width = 75
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Quantidade:'
    end
    object Label11: TLabel
      Left = 218
      Top = 31
      Width = 72
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor unit'#225'rio:'
    end
    object Label13: TLabel
      Left = 385
      Top = 31
      Width = 58
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor total:'
    end
    object dbeCodMco: TDBEditFocus
      Tag = 99
      Left = 115
      Top = 3
      Width = 75
      Height = 22
      DataField = 'REQ_CODMCO'
      DataSource = dtsDetMcoEdit
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = dbeCodMcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Left = 193
      Top = 3
      Width = 336
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'REQ_DESCRI'
      DataSource = dtsDetMcoEdit
      MaxLength = 40
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdMco: TDBEditFocus
      Tag = 99
      Left = 115
      Top = 27
      Width = 75
      Height = 22
      DataField = 'REQ_QTDMCO'
      DataSource = dtsDetMcoEdit
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnitar: TDBEditFocus
      Tag = 99
      Left = 291
      Top = 27
      Width = 70
      Height = 22
      DataField = 'REQ_UNITAR'
      DataSource = dtsDetMcoEdit
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTotMco: TDBEditFocus
      Left = 446
      Top = 27
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'REQ_TOTMCO'
      DataSource = dtsDetMcoEdit
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 532
      Top = 3
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
      TabOrder = 5
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 532
      Top = 26
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
      TabOrder = 6
      OnClick = btnCancelaItemClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 368
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 80
  end
  object dtsDetMcoGrid: TDataSource
    Left = 432
    Top = 80
  end
  object dtsDetMcoEdit: TDataSource
    Left = 464
    Top = 80
  end
  object dtsGerMco: TDataSource
    Left = 496
    Top = 80
  end
end
