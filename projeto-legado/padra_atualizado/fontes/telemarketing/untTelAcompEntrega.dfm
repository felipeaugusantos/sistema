inherited frmTelAcompEntrega: TfrmTelAcompEntrega
  Left = 230
  Top = 255
  Width = 779
  Height = 532
  BorderIcons = [biSystemMenu]
  Caption = 'Teleatendimento - Acompanhamento da Entrega'
  Position = poOwnerFormCenter
  ExplicitWidth = 779
  ExplicitHeight = 532
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 459
    Width = 773
    ExplicitTop = 460
    ExplicitWidth = 773
    inherited btnSair: TBitBtnLocked
      Left = 690
      TabOrder = 4
      ExplicitLeft = 690
    end
    object btnHistoricoPed: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 154
      Height = 22
      Caption = '[ ENTER ] - Hist'#243'rico do Pedido'
      TabOrder = 1
      OnClick = btnHistoricoPedClick
    end
    object btnDadosEntrega: TBitBtnLocked
      Left = 158
      Top = 3
      Width = 153
      Height = 22
      Caption = '[ F2 ] Endere'#231'o de Entrega'
      TabOrder = 2
      OnClick = btnDadosEntregaClick
    end
    object btnEnviaEmail: TBitBtnLocked
      Left = 312
      Top = 3
      Width = 153
      Height = 22
      Caption = '[ F9 ] Enviar E-mail'
      TabOrder = 3
      OnClick = btnEnviaEmailClick
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 773
    Height = 180
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 32
      Height = 14
      Caption = 'Cliente'
    end
    object Label2: TLabel
      Left = 8
      Top = 135
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
    end
    object Label3: TLabel
      Left = 84
      Top = 135
      Width = 47
      Height = 14
      Caption = 'Data Final'
    end
    object Label4: TLabel
      Left = 8
      Top = 48
      Width = 42
      Height = 14
      Caption = 'Empresa'
    end
    object Label5: TLabel
      Left = 8
      Top = 87
      Width = 47
      Height = 14
      Caption = 'Vendedor'
    end
    object mskDtaIni: TMaskEditFocus
      Left = 8
      Top = 151
      Width = 73
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      OnExit = mskDtaIniExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Left = 84
      Top = 151
      Width = 73
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 8
      Top = 23
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 79
      Top = 23
      Width = 450
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 166
      Top = 128
      Width = 108
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
      TabOrder = 6
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 166
      Top = 149
      Width = 108
      Height = 23
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
      TabOrder = 7
      OnClick = btnCancelaItemClick
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 63
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 79
      Top = 63
      Width = 450
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
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 8
      Top = 102
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomVen: TEditFocus
      Left = 79
      Top = 102
      Width = 450
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgPedidos: TDBGridCitel [3]
    Left = 0
    Top = 180
    Width = 773
    Height = 279
    Align = alClient
    DataSource = dtsPedidos
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgPedidosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'FGO_NUMDOC'
        Title.Caption = 'Pedido'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_CODEMP'
        Title.Caption = 'Emp.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 147
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_DTAENT'
        Title.Caption = 'Data Pedido'
        Width = 104
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_NUMFAT'
        Title.Caption = 'Doc. Fat.'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_TIPFAT'
        Title.Caption = 'Esp. Fat.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_EMPFAT'
        Title.Caption = 'Emp. Fat.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_DTAFAT'
        Title.Caption = 'Data Faturamento'
        Width = 102
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 487
    Width = 773
    ExplicitTop = 488
    ExplicitWidth = 773
    inherited pnlNomeForm: TPanel
      Left = 602
      ExplicitLeft = 602
    end
    inherited pnlInfo: TPanel
      Width = 602
      ExplicitWidth = 602
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
  end
  object qryPedidos: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Constraints = <>
    AfterScroll = qryPedidosAfterScroll
    Left = 328
    Top = 56
  end
  object dtsPedidos: TDataSource
    DataSet = qryPedidos
    Left = 360
    Top = 56
  end
end
