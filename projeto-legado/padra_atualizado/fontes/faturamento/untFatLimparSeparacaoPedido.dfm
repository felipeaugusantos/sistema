inherited frmFatLimparSeparacaoPedido: TfrmFatLimparSeparacaoPedido
  Width = 650
  Height = 447
  Caption = ''
  Position = poScreenCenter
  ExplicitWidth = 650
  ExplicitHeight = 447
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 374
    Width = 644
    ExplicitTop = 374
    ExplicitWidth = 644
    inherited FlwBotoes: TFlowPanel
      Width = 640
      TabOrder = 2
      ExplicitWidth = 640
    end
    inherited btnSair: TBitBtnLocked
      Left = 564
      ExplicitLeft = 564
    end
    object btnLimparSeparacao: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 126
      Height = 22
      Caption = '&Limpar Separa'#231#227'o'
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000203110C50961910
        74DB0504172D000000000504172D181071DB100B4E9600000203000000000000
        000000000000000000040000000D0000001100000011120D55A1414FC0FF4762
        D6FF252390EE09062C5223238FEE415CD4FF3949BCFF110C539C000000000000
        0000000000000000000C3B73B7FF2C5CA8FF87A2CEFF312C99FF8596E1FF5B7C
        E6FF4F6DDEFF2F34A7FE4C6ADDFF5574E4FF7486DDFF1A1276DB000000000000
        0000000000000000000F255FA9FFC1E6F5FF9FD1EFFF7C92C6FF38369AEF8EA1
        E8FF5E7FE7FF5B7BE5FF5B7BE6FF8397E6FF312F93ED0504172A000000000000
        0000000000000000000E235CA7FFABE2F6FF5EB3E7FF86A4CDFF0B09305C4348
        B3FE83A0F1FF84A1F2FF829FF0FF4145B0FE0A082F5200000000000000000000
        0000000000010000000E225BA6FF8FD6F4FF96CCEEFF798EC3FF2F3191EF87A1
        EDFF97B2F6FFC1D0F8FF96B1F6FF859EECFF2D2E8EEE0403172D000000000000
        0001000000060B162549225AA6FF77CAEEFF90C9ECFF3333A9FFA8B7EFFFA4BC
        F8FFCAD3F5FF6261BBFEC7D1F4FFA2BBF8FFA6B5EEFF1F1A88E1000000010000
        000611233A633C75B7FB67A5D8FF7FC9EBFF94D1EDFF525FBEFF9C9CDAFFD6D9
        F3FF4744AAEF0C0B34534542A8EED1D5F1FF9597D6FF1613649F000000041123
        395E4885C3FF84CBEEFFC3EAF9FF8EDAF2FF81D0EEFF9DC7E9FF5867C5FF3738
        B3FF343F67910000000507061E2D221F92DE1614609300000203020406133468
        A5E882C8EBFFBAE9F9FFE2F7FDFF90DEF5FF4BC0E8FF79B7E4FF8AB2E0FF90BB
        E4FF809FC6F10305071500000001000000000000000000000000162C456A5797
        CEFF99E1F7FFDFF7FDFFF5FCFFFF8BDFF5FF4DC5EAFF4CA6DEFF2D74C6FF337E
        CCFF4083C6FF1428436C00000004000000000000000000000000284F7DB284C2
        E6FFC3EDFAFFE6F7FDFFE2F5FCFFDFF6FCFFDEF6FCFFD7F5FBFFB7DCF2FF8FC0
        E7FF5EA6DCFF254979B3000000060000000000000000000000003975B3F4D5EF
        FAFF9BB8DDFF648AC7FF1348A7FF114AA9FF144FADFF1856B1FF6698D1FF99C2
        E5FFC5ECF9FF3468AAEF000000060000000000000000000000001A3450735A91
        C5F9AAD2EBFFCEEAF7FFDCF1FAFFE2F5FBFFE0F5FBFFD6F2FBFFC2E7F6FF9CCC
        EAFF538CC2F918314D740000000300000000000000000000000000000003070D
        14211D3B597E2D5C8BBE32669BD53D7BBDFF3D7ABCFF31639AD52B5888BF1C38
        587F070E16250000000300000001000000000000000000000000}
      TabOrder = 0
      OnClick = btnLimparSeparacaoClick
      OnKeyDown = FormKeyDown
    end
  end
  inherited pnlStatus: TPanel
    Top = 402
    Width = 644
    ExplicitTop = 402
    ExplicitWidth = 644
    inherited pnlNomeForm: TPanel
      Left = 473
      ExplicitLeft = 473
    end
    inherited pnlInfo: TPanel
      Width = 473
      ExplicitWidth = 473
    end
  end
  object pnlCabecalhoPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 644
    Height = 68
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      644
      68)
    object lblPedido: TLabel
      Left = 10
      Top = 40
      Width = 44
      Height = 14
      Caption = 'Pedido...:'
    end
    object lblEmpresa: TLabel
      Left = 10
      Top = 13
      Width = 45
      Height = 14
      Alignment = taCenter
      Caption = 'Empresa:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 59
      Top = 37
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object btnConsultar: TBitBtnLocked
      Left = 522
      Top = 36
      Width = 112
      Height = 24
      Anchors = [akTop, akRight]
      Caption = '&Consultar'
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
      TabOrder = 4
      OnClick = btnConsultarClick
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 59
      Top = 9
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 147
      Top = 37
      Width = 30
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 2
      ReadOnly = True
      TabOrder = 3
      Text = 'PD'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtDesEmp: TEditFocus
      Left = 102
      Top = 9
      Width = 531
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDadosPedido: TPanel [3]
    Left = 0
    Top = 68
    Width = 644
    Height = 101
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      644
      101)
    object lblDtaEmissao: TLabel
      Left = 10
      Top = 13
      Width = 68
      Height = 14
      Caption = 'Dt. Emiss'#227'o ..:'
    end
    object lblCliente: TLabel
      Left = 10
      Top = 41
      Width = 68
      Height = 14
      Caption = 'Cliente ..........:'
    end
    object lblVendedor: TLabel
      Left = 10
      Top = 69
      Width = 68
      Height = 14
      Caption = 'Vendedor .....:'
    end
    object lblVlrContabil: TLabel
      Left = 234
      Top = 13
      Width = 58
      Height = 14
      Caption = 'Vr. Contabil:'
    end
    object edtDtaEmissao: TEditFocus
      Left = 84
      Top = 9
      Width = 93
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCliente: TEditFocus
      Left = 84
      Top = 37
      Width = 549
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtVendedor: TEditFocus
      Left = 84
      Top = 65
      Width = 549
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
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
    object edtVlrContabil: TEditFocus
      Left = 298
      Top = 9
      Width = 93
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgItensPedido: TDBGridCitel [4]
    Left = 0
    Top = 169
    Width = 644
    Height = 205
    Align = alClient
    DataSource = dtsItens
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 4
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
        Alignment = taCenter
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 386
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'UNIDADE'
        Title.Alignment = taCenter
        Title.Caption = 'Unidade'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANTIDADE'
        Title.Alignment = taCenter
        Title.Caption = 'Quantidade'
        Width = 92
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 640
    Top = 56
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 544
    Top = 192
    object cdsItensCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object cdsItensQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Size = 15
    end
    object cdsItensAUTO_FATGOR: TStringField
      FieldName = 'AUTO_FATGOR'
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 576
    Top = 192
  end
end
