inherited frmEntNFEDigManualEdit: TfrmEntNFEDigManualEdit
  Width = 800
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Nota Fiscal Eletr'#244'nica -  Digita'#231#227'o Manual '
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 784
    TabOrder = 2
    ExplicitTop = 519
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Width = 703
      ExplicitWidth = 703
      inherited btnConfirma: TBitBtnLocked
        Width = 108
        Caption = '[F10] Confirma'
        ExplicitWidth = 108
      end
      object btnExcluir: TBitBtnLocked
        Left = 108
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
      object btnImportaPedidos: TBitBtnLocked
        Left = 236
        Top = 0
        Width = 193
        Height = 22
        Caption = '[F9] Importa Pedidos de Compra'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000100000003000000080000000C0000
          000E0000000D0000000800000003000000010000000000000000000000020000
          000A00000010000000110000001300000018050E0A3F16412DAC216043EC256A
          48FF216141ED163F2BAC050E09390000000900000001000000000000000A7B50
          43C2AB705CFFAB6F5AFFC29A8CFFA2A191FF307554FF2D9D71FF24BA82FF23CB
          8EFF23BA82FF25986BFF2C7050FD0A1E145C00000006000000000000000EAD73
          5FFFFDFBF9FFFAF4F2FFDCE4DEFF388260FF40C397FF28CD92FF40956DFF487E
          5DFF3F946CFF26CD91FF27BA84FF297150F5050F0A2F000000030000000EB077
          62FFFDFBFAFFF6EFEBFF80AD96FF54B593FF36D29CFF2ECE95FF4A8362FFFFFF
          FFFF4A8161FF2CD096FF2CCF95FF31A87AFF1B4833A1000000060000000CB079
          66FFFDFBFBFFF7F2EFFF499371FF6CDBBBFF469D76FF4D8865FF4D8765FFF6F1
          EBFF4D8665FF4D8664FF459B73FF33C892FF2B7453E7000000080000000BB37C
          69FFFEFCFBFFF8F4F1FF3C926DFF81E9CCFF508C6AFFEADBD3FFF8F3EFFFF9F3
          EFFFF8F3EFFFFFFFFFFF4E8968FF3FD5A3FF348662FA000000080000000AB67F
          6CFFFEFDFCFFF8F3F1FF4FA07DFFB1E9D8FF6CA98CFF528F6EFF528F6DFFFAF5
          F3FF528F6CFF518E6BFF5EA583FF76DCBBFF338260E70000000700000009B983
          71FFFEFDFCFFFAF5F2FF8CC2AAFF94CBB5FFE2FAF5FFC5F5E9FF539371FFECDE
          D8FF539270FFABF0DDFFB0F1DEFF84C6ADFF2358419A0000000400000007BC88
          77FFFEFEFDFFFBF4F0FFE4ECE6FF4EAA84FFC8E7DBFFEEFDFAFF7AB095FF5696
          74FF74AF94FFD9F9F2FFBEE5D8FF3E9873F208130E250000000100000006BF8C
          7AFFFEFEFDFFFBF6F1FFFBF6F4FFC9E2D5FF4FAD85FF93CEB7FFD2ECE3FFF3FC
          FBFFD2ECE3FF92CDB6FF4DA881FF122D2251000000020000000000000005C18F
          7FFFFEFEFEFFFAF6F3FFFAF5F3FFFAF7F4FFE5EEE7FF90CAB1FF5BB48FFF46AB
          82FF5BB48EFF8EC9B1FFC9BDB1FF00000008000000000000000000000004C493
          82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFBF6F3FFFCF8F6FFFCF7F6FFFCF9
          F7FFFBF8F5FFFCFBFAFFC49587FF00000005000000000000000000000003C799
          85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFDFCFAFFC28F7FFF00000004000000000000000000000002C99A
          89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFC49382FF000000030000000000000000000000019774
          67BECA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
          87FFC79887FFC89886FF927063BF000000020000000000000000}
        TabOrder = 2
        OnClick = btnImportaPedidosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 705
      Top = 2
      Align = alRight
      ExplicitLeft = 705
      ExplicitTop = 2
    end
  end
  object pnlItem: TPanel [2]
    Left = 0
    Top = 190
    Width = 784
    Height = 186
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 1
    OnEnter = pnlItemEnter
    OnExit = pnlItemExit
    object lblCodIte: TLabel
      Left = 26
      Top = 21
      Width = 97
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo do Item:'
    end
    object Label10: TLabel
      Left = 48
      Top = 44
      Width = 75
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Quantidade:'
    end
    object Label11: TLabel
      Left = 203
      Top = 47
      Width = 85
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor unit'#225'rio:'
    end
    object Label13: TLabel
      Left = 368
      Top = 47
      Width = 97
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor total bruto:'
    end
    object Label14: TLabel
      Left = 14
      Top = 67
      Width = 109
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Base de c'#225'lculo do IPI:'
    end
    object Label15: TLabel
      Left = 203
      Top = 70
      Width = 85
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Al'#237'quota IPI:'
    end
    object Label16: TLabel
      Left = 368
      Top = 70
      Width = 97
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor do IPI:'
    end
    object Label17: TLabel
      Left = 14
      Top = 90
      Width = 109
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Base de c'#225'lculo ICMS:'
    end
    object Label18: TLabel
      Left = 203
      Top = 93
      Width = 85
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Al'#237'quota ICMS:'
    end
    object Label19: TLabel
      Left = 368
      Top = 93
      Width = 97
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor do ICMS:'
    end
    object Label20: TLabel
      Left = 4
      Top = 113
      Width = 119
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Base c'#225'lc. ICMS Subst.:'
    end
    object Label22: TLabel
      Left = 322
      Top = 113
      Width = 143
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor ICMS Substitu.:'
    end
    object Label21: TLabel
      Left = 4
      Top = 136
      Width = 119
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Base de c'#225'lculo do PIS:'
    end
    object Label23: TLabel
      Left = 203
      Top = 139
      Width = 85
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Al'#237'quota PIS:'
    end
    object Label24: TLabel
      Left = 368
      Top = 139
      Width = 97
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor do PIS:'
    end
    object Label25: TLabel
      Left = 4
      Top = 159
      Width = 119
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Base c'#225'lculo COFINS:'
    end
    object Label26: TLabel
      Left = 203
      Top = 162
      Width = 85
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Al'#237'quota COFINS:'
    end
    object Label27: TLabel
      Left = 368
      Top = 162
      Width = 97
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor do COFINS:'
    end
    object Label6: TLabel
      Left = 560
      Top = 47
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desconto:'
      Visible = False
    end
    object Label8: TLabel
      Left = 560
      Top = 116
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total l'#237'quido:'
      Visible = False
    end
    object Label9: TLabel
      Left = 560
      Top = 70
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Frete:'
      Visible = False
    end
    object Label37: TLabel
      Left = 560
      Top = 93
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desp. Aces.:'
      Visible = False
    end
    object lblCST: TLabel
      Left = 264
      Top = 113
      Width = 22
      Height = 14
      Caption = 'CST:'
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 18
      Width = 75
      Height = 22
      DataField = 'DET_CODITE'
      DataSource = dtsDetEleEdit
      MaxLength = 7
      TabOrder = 0
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDesIte: TDBEditFocus
      Left = 199
      Top = 18
      Width = 511
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'I04_XPROD'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdIte: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 41
      Width = 75
      Height = 22
      DataField = 'I10_QCOM'
      DataSource = dtsDetEleEdit
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnitar: TDBEditFocus
      Tag = 99
      Left = 290
      Top = 41
      Width = 68
      Height = 22
      DataField = 'I10A_VUNCOM'
      DataSource = dtsDetEleEdit
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTotIte: TDBEditFocus
      Left = 467
      Top = 41
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'I11_VPROD'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBasIpi: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 64
      Width = 75
      Height = 22
      DataField = 'O10_VBC'
      DataSource = dtsDetEleEdit
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAlqIpi: TDBEditFocus
      Tag = 99
      Left = 290
      Top = 64
      Width = 68
      Height = 22
      DataField = 'O13_PIPI'
      DataSource = dtsDetEleEdit
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValIpi: TDBEditFocus
      Left = 467
      Top = 64
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'O14_VIPI'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBasIcm: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 87
      Width = 75
      Height = 22
      DataField = 'N15_VBC'
      DataSource = dtsDetEleEdit
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAlqIcm: TDBEditFocus
      Tag = 99
      Left = 290
      Top = 87
      Width = 68
      Height = 22
      DataField = 'N16_PICMS'
      DataSource = dtsDetEleEdit
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValIcm: TDBEditFocus
      Left = 467
      Top = 87
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'N17_VICMS'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBasSub: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 110
      Width = 75
      Height = 22
      DataField = 'N21_VBCST'
      DataSource = dtsDetEleEdit
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValSub: TDBEditFocus
      Tag = 99
      Left = 467
      Top = 110
      Width = 83
      Height = 22
      DataField = 'N23_VICMSST'
      DataSource = dtsDetEleEdit
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBasPis: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 133
      Width = 75
      Height = 22
      DataField = 'Q07_VBC'
      DataSource = dtsDetEleEdit
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAlqPis: TDBEditFocus
      Left = 290
      Top = 133
      Width = 68
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'Q08_PPIS'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValPis: TDBEditFocus
      Left = 467
      Top = 133
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'Q09_VPIS'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBasCof: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 156
      Width = 75
      Height = 22
      DataField = 'S07_VBC'
      DataSource = dtsDetEleEdit
      TabOrder = 18
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAlqCof: TDBEditFocus
      Left = 290
      Top = 156
      Width = 68
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'S08_PCOFINS'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValCof: TDBEditFocus
      Left = 467
      Top = 156
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'S11_VCOFINS'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 597
      Top = 138
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
      TabOrder = 21
      OnClick = btnAdicionarClick
    end
    object dbeDscIte: TDBEditFocus
      Left = 627
      Top = 41
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'I17_VDESC'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 23
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValLiq: TDBEditFocus
      Left = 627
      Top = 110
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 24
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 597
      Top = 160
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
      TabOrder = 22
      OnClick = btnCancelaItemClick
    end
    object dbeCodBar: TDBEditFocus
      Tag = 99
      Left = 260
      Top = 18
      Width = 129
      Height = 22
      DataField = 'I03_CEAN'
      DataSource = dtsDetEleEdit
      TabOrder = 1
      Visible = False
      OnKeyPress = dbeCodBarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeFreIte: TDBEditFocus
      Left = 627
      Top = 64
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'I15_VFRETE'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 25
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAceIte: TDBEditFocus
      Left = 627
      Top = 87
      Width = 83
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'I17A_VOUTRO'
      DataSource = dtsDetEleEdit
      ReadOnly = True
      TabOrder = 26
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCST: TDBEditFocus
      Tag = 99
      Left = 290
      Top = 110
      Width = 68
      Height = 22
      DataField = 'DET_CSTXML'
      DataSource = dtsDetEleEdit
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 376
    Width = 784
    Height = 143
    Align = alClient
    TabOrder = 3
    OnEnter = cxgItensEnter
    ExplicitLeft = 1
    ExplicitTop = 378
    object cxgItensTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDetEleGrid
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
      object cxgItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'DET_CODITE'
        Width = 55
      end
      object cxgItensCODBAR: TcxGridDBColumn
        Caption = 'C'#243'digo de Barras'
        DataBinding.FieldName = 'I03_CEAN'
        HeaderAlignmentHorz = taCenter
        Width = 95
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'I04_XPROD'
        Width = 435
      end
      object cxgItensQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'I10_QCOM'
        HeaderAlignmentHorz = taRightJustify
        Width = 71
      end
      object cxgItensUNITAR: TcxGridDBColumn
        Caption = 'Valor Unit'#225'rio'
        DataBinding.FieldName = 'I10A_VUNCOM'
        HeaderAlignmentHorz = taRightJustify
        Width = 79
      end
      object cxgItensTOTITE: TcxGridDBColumn
        Caption = 'Valor Total'
        DataBinding.FieldName = 'I11_VPROD'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensTableView
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 0
    Width = 784
    Height = 190
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object pnlNota: TPanel
      Left = 1
      Top = 1
      Width = 782
      Height = 89
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 22
        Width = 97
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Data da Emiss'#227'o:'
      end
      object Label2: TLabel
        Left = 394
        Top = 216
        Width = 97
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Data altera'#231#227'o :'
      end
      object Label3: TLabel
        Left = 16
        Top = 44
        Width = 97
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Documento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 206
        Top = 44
        Width = 48
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'S'#233'rie:'
      end
      object Label5: TLabel
        Left = 297
        Top = 43
        Width = 97
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Fornecedor:'
      end
      object Label7: TLabel
        Left = 15
        Top = 68
        Width = 97
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Total de Descontos:'
      end
      object Label12: TLabel
        Left = 297
        Top = 21
        Width = 97
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Data altera'#231#227'o:'
      end
      object dbeDtaEmi: TDBEditFocus
        Tag = 99
        Left = 114
        Top = 15
        Width = 83
        Height = 22
        DataField = 'B09_DEMI'
        DataSource = dtsGerEle
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNumDoc: TDBEditFocus
        Tag = 99
        Left = 114
        Top = 38
        Width = 83
        Height = 22
        AutoSize = False
        CharCase = ecUpperCase
        DataField = 'B08_NNF'
        DataSource = dtsGerEle
        MaxLength = 12
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNumSer: TDBEditFocus
        Tag = 99
        Left = 256
        Top = 38
        Width = 41
        Height = 22
        CharCase = ecUpperCase
        DataField = 'B07_SERIE'
        DataSource = dtsGerEle
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesCon: TDBEditFocus
        Tag = 99
        Left = 114
        Top = 61
        Width = 83
        Height = 22
        DataField = 'W10_VDESC'
        DataSource = dtsGerEle
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDtaAlt: TDBEditFocus
        Left = 396
        Top = 15
        Width = 83
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'GER_DTAALT'
        DataSource = dtsGerEle
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodFor: TDBEditFocus
        Tag = 99
        Left = 396
        Top = 38
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'GER_CODFOR'
        DataSource = dtsGerEle
        MaxLength = 8
        TabOrder = 4
        OnKeyPress = dbeCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object dbeNomFan: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 38
        Width = 292
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'C04_XFANT'
        DataSource = dtsGerEle
        MaxLength = 8
        ReadOnly = True
        TabOrder = 6
        OnKeyPress = dbeCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 90
      Width = 782
      Height = 94
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object shpCodIte: TShape
        Left = 9
        Top = 10
        Width = 763
        Height = 79
        Brush.Color = 16776176
        Enabled = False
        Shape = stRoundRect
      end
      object Label28: TLabel
        Left = 14
        Top = 15
        Width = 134
        Height = 14
        AutoSize = False
        Caption = 'BASE DE C'#193'LCULO DO ICMS'
        Color = 16776176
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label33: TLabel
        Left = 14
        Top = 53
        Width = 134
        Height = 13
        AutoSize = False
        Caption = 'VALOR DO FRETE'
        Color = 16776176
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label29: TLabel
        Left = 162
        Top = 15
        Width = 83
        Height = 14
        AutoSize = False
        Caption = 'VALOR DO ICMS'
        Color = 16776176
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label30: TLabel
        Left = 259
        Top = 15
        Width = 171
        Height = 14
        AutoSize = False
        Caption = 'BASE DE C'#193'LC. ICMS SUBSTITUI'#199#195'O'
        Color = 16776176
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label34: TLabel
        Left = 258
        Top = 53
        Width = 172
        Height = 14
        AutoSize = False
        Caption = 'OUTRAS DESPESAS ACESS'#211'RIAS'
        Color = 16776176
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label31: TLabel
        Left = 452
        Top = 15
        Width = 148
        Height = 14
        AutoSize = False
        Caption = 'VALOR DO ICMS SUBSTITUI'#199#195'O'
        Color = 16776176
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label35: TLabel
        Left = 452
        Top = 53
        Width = 148
        Height = 14
        AutoSize = False
        Caption = 'VALOR TOTAL DO IPI'
        Color = 16776176
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label32: TLabel
        Left = 621
        Top = 15
        Width = 140
        Height = 14
        AutoSize = False
        Caption = 'VALOR TOTAL DOS PRODUTOS'
        Color = 16776176
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label36: TLabel
        Left = 621
        Top = 53
        Width = 140
        Height = 14
        AutoSize = False
        Caption = 'VALOR TOTAL DA NOTA'
        Color = 16776176
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Shape1: TShape
        Left = 156
        Top = 11
        Width = 1
        Height = 78
      end
      object Shape3: TShape
        Left = 251
        Top = 11
        Width = 1
        Height = 78
      end
      object Shape5: TShape
        Left = 612
        Top = 11
        Width = 1
        Height = 78
      end
      object Shape4: TShape
        Left = 442
        Top = 11
        Width = 1
        Height = 78
      end
      object Shape2: TShape
        Left = 9
        Top = 50
        Width = 763
        Height = 1
      end
      object dbeBasIcmTot: TDBEdit
        Tag = 99
        Left = 14
        Top = 29
        Width = 134
        Height = 18
        BorderStyle = bsNone
        Color = 16776176
        DataField = 'W03_VBC'
        DataSource = dtsGerEle
        TabOrder = 0
        OnKeyDown = dbeBasIcmTotKeyDown
      end
      object dbeValFre: TDBEdit
        Tag = 99
        Left = 14
        Top = 67
        Width = 134
        Height = 18
        BorderStyle = bsNone
        Color = 16776176
        DataField = 'W08_VFRETE'
        DataSource = dtsGerEle
        TabOrder = 5
        OnKeyDown = dbeBasIcmTotKeyDown
      end
      object dbeDesAce: TDBEdit
        Tag = 99
        Left = 258
        Top = 68
        Width = 172
        Height = 18
        BorderStyle = bsNone
        Color = 16776176
        DataField = 'W15_VOUTRO'
        DataSource = dtsGerEle
        TabOrder = 6
        OnKeyDown = dbeBasIcmTotKeyDown
      end
      object dbeBasSubTot: TDBEdit
        Tag = 99
        Left = 258
        Top = 29
        Width = 172
        Height = 18
        BorderStyle = bsNone
        Color = 16776176
        DataField = 'W05_VBCST'
        DataSource = dtsGerEle
        TabOrder = 2
        OnKeyDown = dbeBasIcmTotKeyDown
      end
      object dbeTotSub: TDBEdit
        Tag = 99
        Left = 452
        Top = 29
        Width = 148
        Height = 18
        BorderStyle = bsNone
        Color = 16776176
        DataField = 'W06_VST'
        DataSource = dtsGerEle
        TabOrder = 3
        OnKeyDown = dbeBasIcmTotKeyDown
      end
      object dbeTotIpi: TDBEdit
        Tag = 99
        Left = 452
        Top = 67
        Width = 148
        Height = 18
        BorderStyle = bsNone
        Color = 16776176
        DataField = 'W12_VIPI'
        DataSource = dtsGerEle
        TabOrder = 7
        OnKeyDown = dbeBasIcmTotKeyDown
      end
      object dbeTotNot: TDBEdit
        Tag = 99
        Left = 621
        Top = 67
        Width = 140
        Height = 18
        TabStop = False
        BorderStyle = bsNone
        Color = 16776176
        DataField = 'W16_VNF'
        DataSource = dtsGerEle
        ReadOnly = True
        TabOrder = 8
        OnKeyDown = dbeBasIcmTotKeyDown
      end
      object dbeTotPro: TDBEdit
        Tag = 99
        Left = 621
        Top = 29
        Width = 140
        Height = 18
        BorderStyle = bsNone
        Color = 16776176
        DataField = 'W07_VPROD'
        DataSource = dtsGerEle
        TabOrder = 4
        OnKeyDown = dbeBasIcmTotKeyDown
      end
      object dbeTotIcm: TDBEdit
        Tag = 99
        Left = 163
        Top = 29
        Width = 82
        Height = 18
        BorderStyle = bsNone
        Color = 16776176
        DataField = 'W04_VICMS'
        DataSource = dtsGerEle
        TabOrder = 1
        OnKeyDown = dbeBasIcmTotKeyDown
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 784
    TabOrder = 4
    ExplicitTop = 545
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 448
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 448
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 680
    Top = 24
  end
  object dtsGerEle: TDataSource
    Left = 608
    Top = 16
  end
  object dtsDetEleGrid: TDataSource
    Left = 344
    Top = 448
  end
  object dtsDetEleEdit: TDataSource
    Left = 376
    Top = 448
  end
end
