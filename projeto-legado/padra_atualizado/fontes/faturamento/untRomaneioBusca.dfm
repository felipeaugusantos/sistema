inherited frmRomaneioBusca: TfrmRomaneioBusca
  Left = 203
  Top = 293
  Width = 540
  Height = 340
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 540
  ExplicitHeight = 340
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 295
    Width = 534
    TabOrder = 3
    ExplicitTop = 234
    ExplicitWidth = 534
    inherited FlwBotoes: TFlowPanel
      Width = 530
      ExplicitWidth = 530
    end
  end
  inherited pnlStatus: TPanel
    Top = 295
    Width = 534
    TabOrder = 2
    ExplicitTop = 234
    ExplicitWidth = 534
    inherited pnlNomeForm: TPanel
      Left = 363
      ExplicitLeft = 363
    end
    inherited pnlInfo: TPanel
      Width = 363
      ExplicitWidth = 363
    end
  end
  inherited pgcDados: TPageControl
    Top = 404
    Width = 65
    Height = 33
    Align = alNone
    TabOrder = 4
    Visible = False
    ExplicitTop = 404
    ExplicitWidth = 65
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 57
      ExplicitHeight = 1
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 33
    Width = 534
    Height = 262
    Align = alClient
    Color = 16770261
    TabOrder = 1
    ExplicitTop = 32
    ExplicitHeight = 289
    object Label2: TLabel
      Left = 85
      Top = 62
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Cliente'
    end
    object lblDocum: TLabel
      Left = 8
      Top = 24
      Width = 74
      Height = 14
      AutoSize = False
      Caption = 'N'#186' Documento'
    end
    object Label3: TLabel
      Left = 251
      Top = 24
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Cidade'
    end
    object Label1: TLabel
      Left = 158
      Top = 24
      Width = 39
      Height = 14
      AutoSize = False
      Caption = 'Esp'#233'cie'
    end
    object lblCliFor: TLabel
      Left = 8
      Top = 62
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Cliente'
    end
    object lblPedVen: TLabel
      Left = 8
      Top = 223
      Width = 111
      Height = 14
      AutoSize = False
      Caption = 'N'#186' Pedido de Venda'
    end
    object lblEmpDoc: TLabel
      Left = 201
      Top = 24
      Width = 44
      Height = 14
      AutoSize = False
      Caption = 'Empresa'
    end
    object Label4: TLabel
      Left = 8
      Top = 101
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Endere'#231'o'
    end
    object lblBairro: TLabel
      Left = 8
      Top = 141
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Bairro'
    end
    object lblPeso: TLabel
      Left = 8
      Top = 181
      Width = 53
      Height = 14
      Caption = 'Peso Inicial'
    end
    object lblPesoAte: TLabel
      Left = 90
      Top = 181
      Width = 49
      Height = 14
      Caption = 'Peso Final'
    end
    object edtNomCli: TEditFocus
      Tag = 99
      Left = 85
      Top = 75
      Width = 436
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 8
      Top = 37
      Width = 144
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomCid: TEditFocus
      Tag = 99
      Left = 251
      Top = 37
      Width = 270
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 158
      Top = 37
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 7
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 8
      Top = 75
      Width = 71
      Height = 22
      Hint = 'Pressione INSERT para inserir um novo cliente'
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtPedVen: TEditFocus
      Tag = 99
      Left = 8
      Top = 236
      Width = 144
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkAutomatico: TCheckBox
      Left = 30
      Top = 4
      Width = 275
      Height = 20
      TabStop = False
      Caption = 'Busca Autom'#225'tica'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      WordWrap = True
    end
    object edtEmpDoc: TEditFocus
      Tag = 99
      Left = 201
      Top = 37
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object btnHlpAutomatico: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 21
      Height = 20
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000800000010000000100000
        0008000000010000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
        0B60000000070000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
        27EA0000000E0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
        30EC0000000D0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
        1A51000000050000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000600000011000000140000
        000A000000020000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000670503AA999532EFF4528
        187A000000070000000100000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
        4AF724150D490000000800000002000000000000000000000000000000000000
        0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
        9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
        000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
        AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
        00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
        76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
        000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
        70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
        000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
        C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
        0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
        77E570533B9A17100A2500000002000000000000000000000000000000000000
        0000000000000000000000000000000000010000000100000002000000030000
        0002000000020000000100000000000000000000000000000000}
      ParentFont = False
      TabOrder = 7
      TabStop = False
      OnClick = btnHlpAutomaticoClick
    end
    object edtEndere: TEditFocus
      Tag = 99
      Left = 8
      Top = 114
      Width = 513
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBairro: TEditFocus
      Tag = 99
      Left = 8
      Top = 154
      Width = 513
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPesIni: TEditFocus
      Tag = 99
      Left = 8
      Top = 195
      Width = 78
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtPesFin: TEditFocus
      Tag = 99
      Left = 90
      Top = 195
      Width = 78
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  object pnlLoteSep: TPanel [4]
    Left = 0
    Top = 0
    Width = 534
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label13: TLabel
      Left = 8
      Top = 8
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lote de Separa'#231#227'o:'
    end
    object Label62: TLabel
      Left = 184
      Top = 8
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 31
      Width = 534
      Height = 2
      Align = alBottom
      Shape = bsBottomLine
      ExplicitTop = -24
      ExplicitWidth = 527
    end
    object edtNumLot: TEditFocus
      Tag = 99
      Left = 107
      Top = 4
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 233
      Top = 4
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 290
      Top = 4
      Width = 231
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 425
    Top = 37
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 393
    Top = 37
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 361
    Top = 37
  end
end
