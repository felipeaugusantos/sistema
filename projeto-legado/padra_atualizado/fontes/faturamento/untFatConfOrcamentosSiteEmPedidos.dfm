inherited frmFatConfOrcamentosSiteEmPedidos: TfrmFatConfOrcamentosSiteEmPedidos
  Width = 802
  Height = 600
  Caption = 
    'Confirma'#231#227'o R'#225'pida de Or'#231'amento em Pedido de Venda - (Site / Poc' +
    'ket)'
  ExplicitWidth = 802
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 529
    Width = 796
    ExplicitTop = 529
    ExplicitWidth = 796
    inherited FlwBotoes: TFlowPanel
      Width = 792
      ExplicitTop = 2
      ExplicitWidth = 792
      inherited btnConfirma: TBitBtnLocked
        Width = 140
        ExplicitWidth = 140
      end
      object btnMarcar: TBitBtnLocked
        Left = 140
        Top = 0
        Width = 140
        Height = 22
        Align = alLeft
        Caption = '[ F6 ] Marcar Todos'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
          83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
          DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
          AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
          00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
          E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
          3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
          ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
          CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
          00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
          F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
          0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
          D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
          2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
          43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
          DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
          FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
          0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
          82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnMarcarClick
      end
      object btnDesmarcar: TBitBtnLocked
        Left = 280
        Top = 0
        Width = 140
        Height = 22
        Align = alLeft
        Caption = '[ F7 ] Desmarcar Todos'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
          83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
          DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
          AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
          00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
          E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF00009A
          00009A00009A00009A00009A00009A00009A00009A00009A00009A00009A0000
          9A00009A00009A00009AFF00FF00009ABB8E80FAF0DF00009AF9ECD6F9E9D100
          009A00009A00009A00009A00009A00009AF4DAB2B3897B00009AFF00FF00009A
          00009A00009A00009A00009A00009A00009A00009A00009A00009A00009A0000
          9A00009A00009A00009AFF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
          ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
          CB9C86FCF7EE006600FBF3E6FAF1E19933009933009933009933009933009933
          00F6E2C1B3897BFF00FFFF00FFFF00FFCFA089FDF9F2FDF7EEFBF5EBFCF4E6FB
          F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
          9F7B67BEBBB8BEBBB6BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
          D1F7E6CCB3897BFF00FF00009A00009A00009A00009A00009A00009A00009A73
          2600993300993300993300993300993300F8E9D2B3897BFF00FF00009A4A79FF
          2F62FF0D43FF002BF6021AD100009ABEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
          DCF9EBD7B3897BFF00FF00009A00009A00009A00009A00009A00009A00009AFD
          FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
          DEAD8EDAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA4
          82DAA482DAA482FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnDesmarcarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 691
      Top = 2
      Width = 102
      ModalResult = 0
      ExplicitLeft = 691
      ExplicitTop = 2
      ExplicitWidth = 102
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 796
    Height = 80
    Align = alTop
    Color = 16770261
    TabOrder = 2
    object lbl1: TLabel
      Left = 5
      Top = 12
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Emiss'#227'o:'
    end
    object lbl2: TLabel
      Left = 152
      Top = 12
      Width = 6
      Height = 14
      Caption = 'a'
    end
    object lbl3: TLabel
      Left = 38
      Top = 34
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object lblCodEmp: TLabel
      Left = 28
      Top = 56
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 80
      Top = 8
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 164
      Top = 8
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 80
      Top = 52
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 3
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
      Left = 146
      Top = 52
      Width = 460
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 80
      Top = 30
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 2
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
      Left = 146
      Top = 30
      Width = 460
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object btnFiltrar: TBitBtnLocked
      Left = 613
      Top = 30
      Width = 111
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
      OnClick = btnFiltrarClick
    end
    object btnCancelar: TBitBtnLocked
      Left = 613
      Top = 52
      Width = 111
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
      TabOrder = 7
      OnClick = btnCancelarClick
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 415
    Width = 796
    Height = 56
    Align = alBottom
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object lblCndPag: TLabel
      Left = 10
      Top = 12
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cond.Pagto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 4
      Top = 35
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Forma Pagto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 79
      Top = 6
      Width = 701
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      ReadOnly = True
      TabOrder = 0
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object chkSolSenhaLiberacao: TCheckBox
      Left = 474
      Top = 32
      Width = 306
      Height = 17
      Caption = 'Solicitar senha(s) de Libera'#231#227'o durante a confirma'#231#227'o?'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtForPag: TEditFocus
      Tag = 99
      Left = 79
      Top = 29
      Width = 362
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlLegendas: TPanel [4]
    Left = 0
    Top = 471
    Width = 796
    Height = 58
    Align = alBottom
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object lbl4: TLabel
      Left = 18
      Top = 9
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Legendas:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object clblbl5: TColorLabel
      Left = 79
      Top = 9
      Width = 217
      Height = 14
      Caption = '(T1) Limite de cr'#233'dito excedido'
      Transparent = True
      CorDestaque = clRed
    end
    object clblbl6: TColorLabel
      Left = 443
      Top = 9
      Width = 245
      Height = 14
      Caption = '(T4) Venda com valor m'#237'nimo exigido'
      Transparent = True
      CorDestaque = clRed
    end
    object clblbl7: TColorLabel
      Left = 79
      Top = 23
      Width = 350
      Height = 14
      Caption = '(T2) Libera'#231#227'o de cliente que n'#227'o compra a XX dias'
      Transparent = True
      CorDestaque = clRed
    end
    object clblbl8: TColorLabel
      Left = 443
      Top = 23
      Width = 329
      Height = 14
      Caption = '(T5) Libera'#231#227'o de cliente com d'#233'bitos em atraso'
      Transparent = True
      CorDestaque = clRed
    end
    object clblbl9: TColorLabel
      Left = 79
      Top = 37
      Width = 308
      Height = 14
      Caption = '(T3) Valor unit'#225'rio menor que o pre'#231'o m'#237'nimo'
      Transparent = True
      CorDestaque = clRed
    end
    object clblbl11: TColorLabel
      Left = 443
      Top = 37
      Width = 252
      Height = 14
      Caption = '(TE) Produtos sem estoque dispon'#237'vel'
      Transparent = True
      CorDestaque = clRed
    end
  end
  object pnlProgresso: TPanel [5]
    Left = 0
    Top = 336
    Width = 796
    Height = 79
    Align = alBottom
    BevelInner = bvSpace
    BevelOuter = bvLowered
    Color = clWhite
    ParentBackground = False
    TabOrder = 6
    Visible = False
    object lblGravando: TLabel
      Left = 2
      Top = 2
      Width = 792
      Height = 33
      Align = alClient
      AutoSize = False
      Caption = 'Aguarde... '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitWidth = 790
      ExplicitHeight = 35
    end
    object pgbProgresso: TcxProgressBar
      Left = 2
      Top = 56
      Align = alBottom
      ParentFont = False
      Position = 100.000000000000000000
      Properties.BarStyle = cxbsGradient
      Properties.BeginColor = clBlue
      Properties.EndColor = clBlue
      Properties.PeakValue = 100.000000000000000000
      Style.BorderStyle = ebsNone
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -9
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.TextStyle = []
      Style.IsFontAssigned = True
      StyleFocused.BorderStyle = ebsNone
      StyleFocused.TextStyle = []
      StyleHot.BorderStyle = ebsNone
      StyleHot.TextStyle = []
      TabOrder = 0
      Width = 792
    end
    object pgbOrcamentos: TcxProgressBar
      Left = 2
      Top = 35
      Align = alBottom
      ParentFont = False
      Position = 100.000000000000000000
      Properties.BarStyle = cxbsGradient
      Properties.BeginColor = clBlue
      Properties.EndColor = clBlue
      Properties.PeakValue = 100.000000000000000000
      Style.BorderStyle = ebsNone
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -9
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.TextStyle = []
      Style.IsFontAssigned = True
      StyleFocused.BorderStyle = ebsNone
      StyleFocused.TextStyle = []
      StyleHot.BorderStyle = ebsNone
      StyleHot.TextStyle = []
      TabOrder = 1
      Width = 792
    end
  end
  object pnlGrid: TPanel [6]
    Left = 0
    Top = 80
    Width = 796
    Height = 256
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object cxgOrcamentos: TcxGrid
      Left = 0
      Top = 0
      Width = 796
      Height = 256
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgOrcamentosView: TcxGridDBTableView
        OnKeyDown = cxgOrcamentosViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxgOrcamentosViewCellDblClick
        OnCustomDrawCell = cxgOrcamentosViewCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.GroupByBox = False
        object cxgOrcamentosViewColORCSEL: TcxGridDBColumn
          Caption = 'Gerar Pedido'
          DataBinding.FieldName = 'ORCSEL'
          Visible = False
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 89
        end
        object cxgOrcamentosViewColDTAENT: TcxGridDBColumn
          Caption = 'Dt.Emiss'#227'o'
          DataBinding.FieldName = 'DTAENT'
          Options.Editing = False
          Options.Filtering = False
          Width = 66
        end
        object cxgOrcamentosViewColPEDSIT: TcxGridDBColumn
          Caption = 'Ped.Site'
          DataBinding.FieldName = 'PEDSIT'
          Options.Editing = False
          Options.Filtering = False
          Width = 94
        end
        object cxgOrcamentosViewColNUMPOK: TcxGridDBColumn
          Caption = 'Ped.Pocket'
          DataBinding.FieldName = 'NUMPOK'
          Options.Editing = False
          Options.Filtering = False
          Width = 91
        end
        object cxgOrcamentosViewColDOCUME: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'DOCUME'
          Options.Editing = False
          Options.Filtering = False
          Width = 99
        end
        object cxgOrcamentosViewColCODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CODEMP'
          Options.Editing = False
          Options.Filtering = False
          Width = 29
        end
        object cxgOrcamentosViewColNOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'NOMCLI'
          Options.Editing = False
          Options.Filtering = False
          Width = 136
        end
        object cxgOrcamentosViewColVLRCON: TcxGridDBColumn
          Caption = 'Vr.Documento'
          DataBinding.FieldName = 'VLRCON'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Width = 74
        end
        object cxgOrcamentosViewColT1: TcxGridDBColumn
          DataBinding.FieldName = 'T1'
          RepositoryItem = imgcbxTravas
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 30
        end
        object cxgOrcamentosViewColT2: TcxGridDBColumn
          DataBinding.FieldName = 'T2'
          RepositoryItem = imgcbxTravas
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 30
        end
        object cxgOrcamentosViewColT3: TcxGridDBColumn
          DataBinding.FieldName = 'T3'
          RepositoryItem = imgcbxTravas
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 30
        end
        object cxgOrcamentosViewColT4: TcxGridDBColumn
          DataBinding.FieldName = 'T4'
          RepositoryItem = imgcbxTravas
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 30
        end
        object cxgOrcamentosViewColT5: TcxGridDBColumn
          DataBinding.FieldName = 'T5'
          RepositoryItem = imgcbxTravas
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 30
        end
        object cxgOrcamentosViewColTE: TcxGridDBColumn
          DataBinding.FieldName = 'TE'
          RepositoryItem = imgcbxTravas
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 30
        end
        object cxgOrcamentosViewColPEDEMI: TcxGridDBColumn
          Caption = 'Pedido Emitido'
          DataBinding.FieldName = 'PEDEMI'
          Options.Editing = False
          Options.Filtering = False
          Width = 102
        end
      end
      object cxgOrcamentosLevel: TcxGridLevel
        GridView = cxgOrcamentosView
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 796
    ExplicitTop = 555
    ExplicitWidth = 796
    inherited pnlNomeForm: TPanel
      Left = 514
      Width = 282
      ExplicitLeft = 514
      ExplicitWidth = 282
    end
    inherited pnlInfo: TPanel
      Width = 514
      ExplicitWidth = 514
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 152
  end
  object cxedtRepository: TcxEditRepository
    Left = 424
    Top = 152
    PixelsPerInch = 96
    object imgcbxTravas: TcxEditRepositoryImageComboBoxItem
      Properties.Images = cxmglst1
      Properties.Items = <
        item
          ImageIndex = 0
          Value = 'B'
        end
        item
          ImageIndex = 1
          Value = 'L'
        end>
    end
  end
  object cxmglst1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 9961928
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000006E0000006E00000000000000000000000000000000000000
          00000000000000006E0000006E00000000000000000000000000000000000000
          000000006E00001DE8000010DC0000006E000000000000000000000000000000
          000000006E000004E2000008E70000006E000000000000000000000000000000
          000000006E00001AE200001FEB000010D90000006E0000000000000000000000
          6E000005DF000009EB000003DB0000006E000000000000000000000000000000
          00000000000000006E00001ADF000020EB000013DC0000006E0000006E000005
          E200000BEB000004DA0000006E00000000000000000000000000000000000000
          0000000000000000000000006E00001BDF000022EB000012E6000008EA000009
          EB000004DF0000006E0000000000000000000000000000000000000000000000
          000000000000000000000000000000006E00001BE3000016EB000011EB00000A
          DF0000006E000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000006E000021E700001EEB00001AEB000017
          DF0000006E000000000000000000000000000000000000000000000000000000
          0000000000000000000000006E00062DE3000430EB000020E200001EE2000027
          EB000019DF0000006E0000000000000000000000000000000000000000000000
          00000000000000006E000C35E4000E3CEB00052BDC0000006E0000006E00001F
          DC00002AEB00001CDF0000006E00000000000000000000000000000000000000
          000000006E001442E4001645EB00092ED90000006E0000000000000000000000
          6E000020D900012CEB00001FE20000006E000000000000000000000000000000
          000000006E001C4BE7001037DB0000006E000000000000000000000000000000
          000000006E000022DC000027E40000006E000000000000000000000000000000
          00000000000000006E0000006E00000000000000000000000000000000000000
          00000000000000006E0000006E00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000E7E70000C3C30000C1830000E0070000F00F0000F81F
          0000F81F0000F00F0000E0070000C1830000C3C30000E7E70000FFFF0000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000066000000660000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000006600001EB231001FB13300006600000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000066000031C24F0022B738001AB02D0021B437000066
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000066000047D36D003BCB5E0025A83B00006600001BA92E001DB1
          3200006600000000000000000000000000000000000000000000000000000000
          0000006600004FD6790053DE7F0031B54D00006600000000000000660000179D
          27001EAE31000066000000000000000000000000000000000000000000000000
          0000000000000066000041C5630000660000CE6C6C00B73D3D00000000000000
          00000066000019AA2B0000660000000000000000000000000000000000000000
          000000000000B73D3D0000660000CF6F6F00CD696900CF6E6E00B73D3D000000
          00000000000000660000149D2100006600000000000000000000000000000000
          0000B73D3D00DA909000D7868600CD696900B73D3D00CC666600CE6B6B00B73D
          3D0000000000000000000000000000660000006600000000000000000000B73D
          3D00DC959500DE9B9B00D2777700B73D3D0000000000B73D3D00CA5F5F00CD69
          6900B73D3D000000000000000000000000000066000000660000000000000000
          0000B73D3D00D7868600B73D3D0000000000000000000000000000000000B73D
          3D00CC656500B73D3D0000000000000000000000000000000000000000000000
          000000000000B73D3D0000000000000000000000000000000000000000000000
          0000B73D3D00C95C5C00B73D3D00000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000B73D3D00B73D3D000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000B73D3D00B73D3D0000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000FFFF0000FCFF0000F87F0000F03F0000E01F0000C10F0000E0C7
          0000E0630000C0390000821C0000C78F0000EFC70000FFF30000FFF90000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0084B5
          840010731000187318001873180018731800187B1800187B1800107B1000107B
          1000087B0800087B0800007B0000007300007BB57B00FFFFFF00FFFFFF001084
          1000218C210029942900319431003194310029942900299C2900219C210018A5
          180018A5180010A5100008A5080000940000006B0000FFFFFF00FFFFFF00188C
          180029942900399C3900399C3900399C390039A53900A5D6A500FFFFFF0021AD
          210018AD180010B5100008AD0800009C0000007B0000FFFFFF00FFFFFF002194
          2100399C390042A542004AA54A0042A5420042A54200FFFFFF00FFFFFF00FFFF
          FF0021B5210018B5180010AD100008A50800087B0800FFFFFF00FFFFFF002994
          2900429C42004AA54A0052A552004AA54A0042A5420042AD4200FFFFFF00FFFF
          FF00FFFFFF0018B5180010AD100010A5100008840800FFFFFF00FFFFFF00319C
          31004AA54A0052A5520052A552004AA54A004AA54A0042A5420039AD3900FFFF
          FF00FFFFFF00FFFFFF0018AD180018A5180010841000FFFFFF00FFFFFF00429C
          420052A55200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00219C210018841800FFFFFF00FFFFFF0042A5
          42005AAD5A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00219C2100217B2100FFFFFF00FFFFFF0052A5
          520063AD630063AD63005AAD5A0052A552004AA54A00429C4200399C3900FFFF
          FF00FFFFFF00FFFFFF00299C290029942900217B2100FFFFFF00FFFFFF0052A5
          52006BB56B006BB56B005AAD5A0052A552004AA54A00429C4200FFFFFF00FFFF
          FF00FFFFFF00299429002994290029942900217B2100FFFFFF00FFFFFF005AAD
          5A007BBD7B0073BD730063AD63005AAD5A0052A55200FFFFFF00FFFFFF00FFFF
          FF00319C3100319C31003194310031943100217B2100FFFFFF00FFFFFF006BB5
          6B008CC68C007BBD7B006BB56B0063B5630063AD6300B5DEB500FFFFFF004AA5
          4A004AA54A0042A54200399C390031943100217B2100FFFFFF00FFFFFF0073BD
          73009CCE9C008CC68C007BBD7B0073BD73006BB56B0063B5630063AD63005AAD
          5A0052AD52004AA54A0042A542003194310018731800FFFFFF00FFFFFF00B5DE
          B50073BD730063B563005AAD5A0052A5520052A552004AA54A004AA54A0042A5
          4200429C4200399C390031943100218C21008CBD8C00FFFFFF0000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00800100000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000008001
          0000}
      end>
  end
end
