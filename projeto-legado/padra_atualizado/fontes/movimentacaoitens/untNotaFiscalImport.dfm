inherited frmNotaFiscalImport: TfrmNotaFiscalImport
  Left = 258
  Top = 152
  Width = 915
  Height = 643
  Caption = 'Emiss'#227'o de Nota Fiscal de Importa'#231#227'o'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 915
  ExplicitHeight = 643
  PixelsPerInch = 96
  TextHeight = 14
  object Label9: TLabel [0]
    Left = 95
    Top = 50
    Width = 35
    Height = 14
    Alignment = taRightJustify
    Caption = 'Pedido:'
  end
  inherited pnlBotoes: TPanel
    Top = 572
    Width = 909
    Height = 26
    BevelInner = bvNone
    BevelOuter = bvRaised
    BorderWidth = 1
    TabOrder = 4
    ExplicitTop = 572
    ExplicitWidth = 909
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 825
      Height = 22
      ExplicitWidth = 825
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 143
        Height = 21
        Align = alLeft
        Caption = '[ F10 ] Emite Nota Fiscal'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnRatDesAdu: TBitBtnLocked
        Left = 143
        Top = 0
        Width = 202
        Height = 21
        Align = alLeft
        Caption = '[ F8 ] Distribuir Despesas Aduaneiras'
        TabOrder = 1
        OnClick = btnRatDesAduClick
      end
      object btnDadosDI: TBitBtnLocked
        Left = 345
        Top = 0
        Width = 217
        Height = 21
        Align = alLeft
        Caption = '[ F9 ] Copiar dados DI para todos os itens'
        TabOrder = 2
        OnClick = btnDadosDIClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 827
      Top = 2
      Width = 80
      Align = alRight
      ExplicitLeft = 827
      ExplicitTop = 2
      ExplicitWidth = 80
    end
  end
  inherited pnlStatus: TPanel
    Top = 598
    Width = 909
    TabOrder = 5
    ExplicitTop = 598
    ExplicitWidth = 909
    inherited pnlNomeForm: TPanel
      Left = 738
      ExplicitLeft = 738
    end
    inherited pnlInfo: TPanel
      Width = 738
      ExplicitWidth = 738
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 37
    Width = 909
    Height = 164
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 87
      Top = 55
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pedido:'
    end
    object Label2: TLabel
      Left = 210
      Top = 77
      Width = 61
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Fornecedor:'
    end
    object Label3: TLabel
      Left = 57
      Top = 77
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Entrega:'
    end
    object Label4: TLabel
      Left = 66
      Top = 99
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comprador:'
    end
    object Label5: TLabel
      Left = 50
      Top = 121
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Condi'#231#227'o Pgto:'
    end
    object Label6: TLabel
      Left = 49
      Top = 143
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dolar Fechado:'
    end
    object Label22: TLabel
      Left = 227
      Top = 143
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'UF Desembara'#231'o:'
    end
    object lblArqXML: TLabel
      Left = 57
      Top = 32
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Arquivo XML:'
      Visible = False
    end
    object lblCodFor: TLabel
      Left = 41
      Top = 9
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd.Forcededor:'
      Visible = False
    end
    object lblImpFre: TLabel
      Left = 17
      Top = 55
      Width = 233
      Height = 14
      Alignment = taRightJustify
      Caption = 'Importar valor de frete e seus dados cadastrais:'
      Visible = False
    end
    object clbImpFre: TColorLabel
      Left = 295
      Top = 55
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      CorDestaque = clRed
    end
    object lblPerfilAduaneiro: TLabel
      Left = 373
      Top = 57
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Perfil Aduaneiro:'
      Visible = False
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 125
      Top = 51
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      OnKeyPress = edtNumPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtNumCtn: TEditFocus
      Tag = 99
      Left = 207
      Top = 51
      Width = 26
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtForPed: TEditFocus
      Left = 274
      Top = 73
      Width = 487
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDtaEnt: TEditFocus
      Left = 125
      Top = 73
      Width = 76
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
    object edtCompra: TEditFocus
      Left = 125
      Top = 95
      Width = 636
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
    object edtCndPag: TEditFocus
      Left = 125
      Top = 117
      Width = 528
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
    object edtDolFec: TEditFocus
      Tag = 99
      Left = 125
      Top = 139
      Width = 94
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.000'
    end
    object btnConfPed: TBitBtnLocked
      Left = 528
      Top = 140
      Width = 111
      Height = 23
      Caption = 'Confirma Pedido'
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
      TabOrder = 13
      OnClick = btnConfPedClick
    end
    object btnCancPed: TBitBtnLocked
      Left = 642
      Top = 140
      Width = 120
      Height = 23
      Caption = 'Cancela Pedido'
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
      TabOrder = 14
      OnClick = btnCancPedClick
    end
    object edtUfDese: TEditFocus
      Tag = 99
      Left = 316
      Top = 139
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtArqXML: TFilenameEditFocus
      Tag = 99
      Left = 125
      Top = 27
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E0000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000004080FF4060A0FF4060
            A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060
            A0FF4060A0FF4060A0FF004080FF00000000000000004060A0FF4060A0FF80A0
            E0FF80C0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0
            E0FF40A0E0FF40A0E0FF4080C0FF002040FF000000004060A0FF4080C0FF4080
            C0FF80E0E0FF80C0E0FF40C0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0
            E0FF40A0E0FF40A0E0FF40A0E0FF004080FF000000004060C0FF80A0E0FF4080
            C0FF80E0E0FF80E0E0FF80C0E0FF80C0E0FF80C0E0FF40C0E0FF40C0E0FF40C0
            E0FF40C0E0FF40A0E0FF40A0E0FF4060C0FF000000004080C0FF80C0E0FF40A0
            E0FF80C0E0FFF0FBFFFF80C0E0FF80C0E0FF80C0E0FF80C0E0FF80C0E0FF80C0
            E0FF80C0E0FF80C0E0FF80C0E0FF4080C0FF002040FF4080C0FF80E0E0FF80C0
            E0FF40A0E0FFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FB
            FFFFF0FBFFFFF0FBFFFFF0FBFFFF80C0E0FF406080FF4080C0FFF0FBFFFF80E0
            E0FF80C0E0FF40A0E0FF40A0E0FF40A0E0FF40A0C0FF40A0C0FF40A0C0FF40A0
            C0FF40A0C0FF4080C0FF4080C0FF4080C0FF4060A0FF4080C0FFF0FBFFFF80E0
            E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0
            E0FF80E0E0FF4060C0FF0000000000000000000000004080C0FFF0FBFFFF80E0
            E0FF80E0E0FF80E0E0FF80E0E0FFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FB
            FFFFF0FBFFFF4080C0FF00000000000000000000000040A0C0FFF0FBFFFFF0FB
            FFFFF0FBFFFFF0FBFFFFF0FBFFFF40A0C0FF4080C0FF4080C0FF4080C0FF4080
            C0FF4080C0FF4060A0FF00000000000000000000000040A0C0FFF0FBFFFFF0FB
            FFFFF0FBFFFFF0FBFFFF4080C0FF000000000000000000000000000000000000
            000000000000000000000000000000000000000000004080A0FF40A0E0FF40A0
            E0FF40A0E0FF40A0C0FF004040FF000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000}
          Kind = bkGlyph
        end>
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      Visible = False
      Width = 636
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 125
      Top = 5
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      Visible = False
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFor: TEditFocus
      Left = 207
      Top = 5
      Width = 554
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 15
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 125
      Top = 117
      Width = 636
      Height = 22
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      TabOrder = 10
      Text = ''
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtImpFre: TEditFocus
      Tag = 99
      Left = 254
      Top = 51
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 4
      Text = 'S'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodPerfil: TEditFocus
      Tag = 99
      Left = 458
      Top = 51
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
      Visible = False
      OnKeyPress = edtCodPerfilKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDescPerfil: TEditFocus
      Left = 498
      Top = 51
      Width = 263
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgItens: TDBGridCitel [4]
    Left = 0
    Top = 453
    Width = 909
    Height = 81
    Align = alClient
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'PCD_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODFAB'
        Title.Caption = 'C'#243'd. F'#225'brica'
        Width = 128
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 255
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODUNI'
        Title.Caption = 'UN.'
        Width = 45
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCD_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd.'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCD_UNITAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Unit'#225'rio'
        Width = 79
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCD_TOTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_SITTRI'
        Title.Caption = 'Sit. Trib.'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCD_ALQICM'
        Title.Alignment = taRightJustify
        Title.Caption = '% ICMS'
        Width = 50
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCD_PERIPI'
        Title.Alignment = taRightJustify
        Title.Caption = '% IPI'
        Visible = True
      end>
  end
  object pnlTotais: TPanel [5]
    Left = 0
    Top = 544
    Width = 909
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 3
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label32: TLabel
      Left = 741
      Top = 3
      Width = 85
      Height = 22
      Align = alRight
      Alignment = taRightJustify
      Caption = 'Total dos Itens:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object edtTotGer: TEditFocus
      Left = 826
      Top = 3
      Width = 80
      Height = 22
      TabStop = False
      Align = alRight
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
      ExplicitHeight = 23
    end
  end
  object pnlItens: TPanel [6]
    Left = 0
    Top = 201
    Width = 909
    Height = 252
    Align = alTop
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 1
    object Label7: TLabel
      Left = 100
      Top = 11
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label8: TLabel
      Left = 64
      Top = 32
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label19: TLabel
      Left = 235
      Top = 32
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Unit'#225'rio:'
    end
    object Label20: TLabel
      Left = 419
      Top = 32
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total:'
    end
    object Label17: TLabel
      Left = 213
      Top = 60
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero DI/DSI/DA:'
    end
    object Label18: TLabel
      Left = 48
      Top = 60
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data DI/DSI/DA:'
    end
    object Label21: TLabel
      Left = 203
      Top = 84
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = 'Local Desembara'#231'o:'
    end
    object Label23: TLabel
      Left = 27
      Top = 84
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Desembara'#231'o:'
    end
    object lblEntRet: TLabel
      Left = 32
      Top = 108
      Width = 90
      Height = 28
      Alignment = taRightJustify
      Caption = 'Via de Transporte Internacional:'
      WordWrap = True
    end
    object Label24: TLabel
      Left = 380
      Top = 118
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor da AFRMM:'
    end
    object Label29: TLabel
      Left = 7
      Top = 143
      Width = 115
      Height = 28
      Alignment = taRightJustify
      Caption = 'Forma de Importa'#231#227'o quanto a intermedia'#231#227'o:'
      WordWrap = True
    end
    object Label30: TLabel
      Left = 362
      Top = 143
      Width = 100
      Height = 28
      Alignment = taRightJustify
      Caption = 'UF do adquirente ou do encomendante:'
      WordWrap = True
    end
    object Label31: TLabel
      Left = 524
      Top = 143
      Width = 104
      Height = 28
      Alignment = taRightJustify
      Caption = 'CNPJ do adquirente ou do encomendante:'
      WordWrap = True
    end
    object lblAdicao: TLabel
      Left = 591
      Top = 118
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Adi'#231#227'o:'
    end
    object lblSiscomex: TLabel
      Left = 435
      Top = 59
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Taxa Siscomex:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 125
      Top = 5
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 195
      Top = 5
      Width = 348
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 125
      Top = 28
      Width = 69
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object GroupBox1: TGroupBox
      Left = 465
      Top = 178
      Width = 128
      Height = 68
      Caption = 'Situa'#231#227'o Tribut'#225'ria:'
      TabOrder = 16
      object edtSitTri: TEditFocus
        Tag = 99
        Left = 8
        Top = 16
        Width = 69
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnKeyPress = edtSitTriKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object chkTodosTrib: TCheckBox
        Left = 8
        Top = 43
        Width = 109
        Height = 17
        Caption = 'Alterar para todos'
        TabOrder = 1
      end
    end
    object edtUnitar: TEditFocus
      Tag = 99
      Left = 304
      Top = 28
      Width = 69
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnExit = edtUnitarExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.0000'
    end
    object edtTotIte: TEditFocus
      Tag = 99
      Left = 474
      Top = 28
      Width = 69
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtNumDi: TEditFocus
      Tag = 99
      Left = 304
      Top = 56
      Width = 125
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 15
      TipoTexto = ttAlfanumerico
    end
    object mskDtaDi: TMaskEditFocus
      Tag = 99
      Left = 125
      Top = 56
      Width = 69
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 5
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtLcDese: TEditFocus
      Tag = 99
      Left = 304
      Top = 80
      Width = 278
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtDese: TMaskEditFocus
      Tag = 99
      Left = 125
      Top = 80
      Width = 69
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 7
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object GroupBox2: TGroupBox
      Left = 20
      Top = 178
      Width = 439
      Height = 68
      Caption = 'Imposto de Importa'#231#227'o:'
      TabOrder = 15
      object Label25: TLabel
        Left = 11
        Top = 22
        Width = 91
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Base de C'#225'lculo:'
      end
      object Label26: TLabel
        Left = 225
        Top = 22
        Width = 118
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Despesas Aduaneiras:'
      end
      object Label27: TLabel
        Left = 11
        Top = 46
        Width = 91
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor do Imposto:'
      end
      object Label28: TLabel
        Left = 225
        Top = 46
        Width = 118
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor IOF:'
      end
      object edtBaseCalculo: TEditFocus
        Tag = 99
        Left = 105
        Top = 16
        Width = 75
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDespAduaneiras: TEditFocus
        Tag = 99
        Left = 346
        Top = 16
        Width = 75
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtImpostoImportacao: TEditFocus
        Tag = 99
        Left = 105
        Top = 40
        Width = 75
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValorIOF: TEditFocus
        Tag = 99
        Left = 346
        Top = 40
        Width = 75
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 634
      Top = 218
      Width = 127
      Height = 22
      Caption = 'Cancela Item'
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
      TabOrder = 18
      OnClick = btnCancelaItemClick
    end
    object btnConfirmaItem: TBitBtnLocked
      Left = 634
      Top = 195
      Width = 127
      Height = 22
      Caption = 'Confirma Item'
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
      TabOrder = 17
      OnClick = btnConfirmaItemClick
    end
    object cmbVTrInt: TComboBoxFocus
      Tag = 99
      Left = 125
      Top = 113
      Width = 234
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 9
      OnChange = cmbVTrIntChange
      Items.Strings = (
        '1 '#8211' MAR'#205'TIMA'
        '2 '#8211' FLUVIAL'
        '3 '#8211' LACUSTRE'
        '4 '#8211' A'#201'REA'
        '5 '#8211' POSTAL'
        '6 '#8211' FERROVI'#193'RIA'
        '7 '#8211' RODOVI'#193'RIA'
        '8 '#8211' CONDUTO / REDE TRANSMISS'#195'O'
        '9 '#8211' MEIOS PR'#211'PRIOS'
        '10 '#8211' ENTRADA / SA'#205'DA FICTA')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtVAFrMM: TEditFocus
      Tag = 99
      Left = 465
      Top = 113
      Width = 78
      Height = 22
      Hint = 'SER'#193' ADICIONAL AO FRETE PARA RENOVA'#199#195'O DA MARINHA MERCANTE '
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object cmbForImp: TComboBoxFocus
      Tag = 99
      Left = 125
      Top = 147
      Width = 234
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 12
      OnChange = cmbForImpChange
      Items.Strings = (
        '1 '#8211' IMPORTA'#199#195'O POR CONTA PR'#211'PRIA'
        '2 '#8211' IMPORTA'#199#195'O POR CONTA E ORDEM'
        '3 '#8211' IMPORTA'#199#195'O POR ENCOMENDA')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtUF_Adq: TEditFocus
      Tag = 99
      Left = 465
      Top = 147
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object mskCgcAdq: TMaskEditFocus
      Tag = 99
      Left = 631
      Top = 147
      Width = 130
      Height = 22
      EditMask = '>aa\.aaa\.aaa/aaaa-99;0;'
      MaxLength = 18
      TabOrder = 14
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtAdicao: TEditFocus
      Tag = 99
      Left = 631
      Top = 113
      Width = 78
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentShowHint = False
      ShowHint = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtSiscomex: TEditFocus
      Tag = 99
      Left = 513
      Top = 56
      Width = 69
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 19
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtCodFab: TEditFocus
      Tag = 99
      Left = 549
      Top = 5
      Width = 212
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ReadOnly = True
      TabOrder = 20
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
  end
  object pbProgresso: TProgressBar [7]
    Left = 0
    Top = 534
    Width = 909
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 6
    Visible = False
  end
  object pnlTipoImportacao: TPanel [8]
    Left = 0
    Top = 0
    Width = 909
    Height = 37
    Align = alTop
    TabOrder = 7
    object rdgTipoImportacao: TRadioGroup
      Left = 1
      Top = 1
      Width = 907
      Height = 35
      Align = alClient
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Pedido de compra de importa'#231#227'o'
        'Importar XML da DI')
      TabOrder = 0
      OnClick = rdgTipoImportacaoClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 664
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 632
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 696
    Top = 16
  end
  object cdsXML: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsXMLAfterScroll
    Left = 672
    Top = 224
    object cdsXMLPCD_CODITE: TStringField
      FieldName = 'PCD_CODITE'
      Size = 5
    end
    object cdsXMLPCD_DESITE: TStringField
      FieldName = 'PCD_DESITE'
      Size = 70
    end
    object cdsXMLITE_CODUNI: TStringField
      FieldName = 'ITE_CODUNI'
      Size = 2
    end
    object cdsXMLPCD_QTDITE: TFloatField
      FieldName = 'PCD_QTDITE'
      DisplayFormat = '#,##0.0000'
    end
    object cdsXMLPCD_UNITAR: TFloatField
      FieldName = 'PCD_UNITAR'
      DisplayFormat = '#,##0.00'
    end
    object cdsXMLPCD_TOTITE: TFloatField
      FieldName = 'PCD_TOTITE'
      DisplayFormat = '#,##0.00'
    end
    object cdsXMLPCD_SITTRI: TStringField
      FieldName = 'PCD_SITTRI'
      Size = 3
    end
    object cdsXMLPCD_ALQICM: TFloatField
      FieldName = 'PCD_ALQICM'
      DisplayFormat = '#,##0.00'
    end
    object cdsXMLPCD_PERIPI: TFloatField
      FieldName = 'PCD_PERIPI'
      DisplayFormat = '#,##0.00'
    end
    object cdsXMLXML_VAFRMM: TFloatField
      FieldName = 'XML_VAFRMM'
      DisplayFormat = '#,##0.00'
    end
    object cdsXMLXML_NUMEDI: TStringField
      FieldName = 'XML_NUMEDI'
      Size = 30
    end
    object cdsXMLXML_LOCDES: TStringField
      FieldName = 'XML_LOCDES'
      Size = 60
    end
    object cdsXMLXML_UFTERC: TStringField
      FieldName = 'XML_UFTERC'
      Size = 2
    end
    object cdsXMLXML_CNPJTE: TStringField
      FieldName = 'XML_CNPJTE'
      Size = 14
    end
    object cdsXMLXML_DATADI: TDateField
      FieldName = 'XML_DATADI'
    end
    object cdsXMLXML_DTDESE: TDateField
      FieldName = 'XML_DTDESE'
    end
    object cdsXMLXML_ADICAO: TFloatField
      FieldName = 'XML_ADICAO'
    end
    object cdsXMLXML_II_VBC: TFloatField
      FieldName = 'XML_II_VBC'
      DisplayFormat = '#,##0.00'
    end
    object cdsXMLXML_II_DPA: TFloatField
      FieldName = 'XML_II_DPA'
      DisplayFormat = '#,##0.00'
    end
    object cdsXMLXML_II_VII: TFloatField
      FieldName = 'XML_II_VII'
      DisplayFormat = '#,##0.00'
    end
    object cdsXMLXML_II_IOF: TFloatField
      FieldName = 'XML_II_IOF'
      DisplayFormat = '#,##0.00'
    end
    object cdsXMLXML_UFDESE: TStringField
      FieldName = 'XML_UFDESE'
      Size = 2
    end
    object cdsXMLXML_VIATRA: TStringField
      FieldName = 'XML_VIATRA'
      Size = 2
    end
    object cdsXMLXML_TPINTE: TStringField
      FieldName = 'XML_TPINTE'
      Size = 1
    end
    object cdsXMLXML_SISCOM: TFloatField
      FieldName = 'XML_SISCOM'
      DisplayFormat = '#,##0.00'
    end
    object cdsXMLPCD_BASICM: TFloatField
      FieldName = 'PCD_BASICM'
    end
    object cdsXMLPCD_VALICM: TFloatField
      FieldName = 'PCD_VALICM'
    end
    object cdsXMLPCD_BASIPI: TFloatField
      FieldName = 'PCD_BASIPI'
    end
    object cdsXMLPCD_TOTIPI: TFloatField
      FieldName = 'PCD_TOTIPI'
    end
    object cdsXMLPCD_BASPIS: TFloatField
      FieldName = 'PCD_BASPIS'
    end
    object cdsXMLPCD_ALQPIS: TFloatField
      FieldName = 'PCD_ALQPIS'
    end
    object cdsXMLPCD_VALPIS: TFloatField
      FieldName = 'PCD_VALPIS'
    end
    object cdsXMLPCD_BASCOF: TFloatField
      FieldName = 'PCD_BASCOF'
    end
    object cdsXMLPCD_ALQCOF: TFloatField
      FieldName = 'PCD_ALQCOF'
    end
    object cdsXMLPCD_VALCOF: TFloatField
      FieldName = 'PCD_VALCOF'
    end
    object cdsXMLPCD_BASRET: TFloatField
      FieldName = 'PCD_BASRET'
    end
    object cdsXMLPCD_VALRET: TFloatField
      FieldName = 'PCD_VALRET'
    end
    object cdsXMLITE_CODFAB: TStringField
      FieldName = 'ITE_CODFAB'
      Size = 30
    end
    object cdsXMLXML_CFORDI: TStringField
      FieldName = 'XML_CFORDI'
    end
    object cdsXMLITE_VALFRE: TFloatField
      FieldName = 'ITE_VALFRE'
    end
    object cdsXMLITE_DESACE: TFloatField
      FieldName = 'ITE_DESACE'
    end
    object cdsXMLITE_OUTROS: TFloatField
      FieldName = 'ITE_OUTROS'
    end
    object cdsXMLXML_INDEX_: TIntegerField
      FieldName = 'XML_INDEX_'
    end
    object cdsXMLXML_NUMCMP: TStringField
      FieldName = 'XML_NUMCMP'
      Size = 15
    end
    object cdsXMLXML_NITCMP: TIntegerField
      FieldName = 'XML_NITCMP'
    end
    object cdsXMLPCD_TOTITE_ORI: TFloatField
      FieldName = 'PCD_TOTITE_ORI'
    end
    object cdsXMLXML_II_VII_ORI: TFloatField
      FieldName = 'XML_II_VII_ORI'
    end
    object cdsXMLPCD_TOTIPI_ORI: TFloatField
      FieldName = 'PCD_TOTIPI_ORI'
    end
    object cdsXMLPCD_VALPIS_ORI: TFloatField
      FieldName = 'PCD_VALPIS_ORI'
    end
    object cdsXMLPCD_VALCOF_ORI: TFloatField
      FieldName = 'PCD_VALCOF_ORI'
    end
    object cdsXMLXML_VAFRMM_ORI: TFloatField
      FieldName = 'XML_VAFRMM_ORI'
    end
    object cdsXMLPCD_VALICM_ORI: TFloatField
      FieldName = 'PCD_VALICM_ORI'
    end
    object cdsXMLITE_VALSEG: TFloatField
      FieldName = 'ITE_VALSEG'
    end
  end
end
