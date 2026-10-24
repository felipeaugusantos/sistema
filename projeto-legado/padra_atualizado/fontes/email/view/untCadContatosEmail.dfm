inherited frmCadContatosEmail: TfrmCadContatosEmail
  Width = 576
  Height = 600
  Caption = 'Cadastro de Contatos de Operadores'
  Color = clCream
  ExplicitWidth = 576
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 530
    Width = 570
    Height = 25
    TabOrder = 3
    ExplicitTop = 530
    ExplicitWidth = 570
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 498
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 498
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 80
        Spacing = 2
        ExplicitWidth = 80
      end
      inherited btnGravar: TBitBtnLocked
        Left = 80
        Width = 80
        Spacing = 2
        ExplicitLeft = 80
        ExplicitWidth = 80
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 160
        Width = 80
        Spacing = 2
        ExplicitLeft = 160
        ExplicitWidth = 80
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 240
        Width = 80
        Spacing = 2
        ExplicitLeft = 240
        ExplicitWidth = 80
      end
      inherited btnCancela: TBitBtnLocked
        Left = 320
        Width = 81
        Spacing = 2
        ExplicitLeft = 320
        ExplicitWidth = 81
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 401
        Width = 81
        Spacing = 2
        ExplicitLeft = 401
        ExplicitWidth = 81
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 500
      Width = 68
      Height = 21
      Align = alRight
      ExplicitLeft = 500
      ExplicitWidth = 68
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Left = 855
    Top = 431
    Width = 73
    Height = 83
    Align = alNone
    TabOrder = 5
    Visible = False
    ExplicitLeft = 855
    ExplicitTop = 431
    ExplicitWidth = 73
    ExplicitHeight = 83
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 51
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 570
    TabOrder = 4
    ExplicitTop = 555
    ExplicitWidth = 570
    inherited pnlNomeForm: TPanel
      Left = 352
      Width = 218
      ExplicitLeft = 352
      ExplicitWidth = 218
    end
    inherited pnlInfo: TPanel
      Width = 352
      ExplicitWidth = 352
    end
  end
  object grbDadosContato: TGroupBox [4]
    Left = 0
    Top = 0
    Width = 570
    Height = 95
    Align = alTop
    Caption = 'Dados do Contato '
    TabOrder = 1
    object lblNomCon: TLabel
      Left = 36
      Top = 21
      Width = 30
      Height = 14
      Caption = 'Nome:'
    end
    object dbeAutInc: TDBEditFocus
      Tag = 99
      Left = 711
      Top = 20
      Width = 109
      Height = 22
      BevelKind = bkFlat
      BorderStyle = bsNone
      CharCase = ecUpperCase
      DataField = 'AUTOINCREM'
      DataSource = dtsConOpe
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object grbTelefones: TGroupBox
      Left = 2
      Top = 45
      Width = 566
      Height = 48
      Align = alBottom
      Caption = 'Telefones '
      TabOrder = 1
      object lblTelRes: TLabel
        Left = 7
        Top = 21
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Residencial:'
      end
      object lblTelCom: TLabel
        Left = 197
        Top = 21
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Comercial:'
      end
      object lblCelula: TLabel
        Left = 399
        Top = 21
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Celular:'
      end
      object dbeTelRes: TDBEditFocus
        Tag = 99
        Left = 71
        Top = 18
        Width = 109
        Height = 22
        BevelKind = bkFlat
        BorderStyle = bsNone
        CharCase = ecUpperCase
        DataField = 'CON_TELRES'
        DataSource = dtsConOpe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeTelCom: TDBEditFocus
        Tag = 99
        Left = 253
        Top = 18
        Width = 109
        Height = 22
        BevelKind = bkFlat
        BorderStyle = bsNone
        CharCase = ecUpperCase
        DataField = 'CON_TELCOM'
        DataSource = dtsConOpe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeCelula: TDBEditFocus
        Tag = 99
        Left = 441
        Top = 18
        Width = 109
        Height = 22
        BevelKind = bkFlat
        BorderStyle = bsNone
        CharCase = ecUpperCase
        DataField = 'CON_CELULA'
        DataSource = dtsConOpe
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        OnExit = dbeCelulaExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
  end
  object pgcEmail: TPageControl [5]
    Left = 0
    Top = 95
    Width = 570
    Height = 435
    ActivePage = tbsEmail
    Align = alClient
    TabOrder = 2
    object tbsEmail: TTabSheet
      Caption = 'e-Mails do Contato'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 562
        Height = 43
        Align = alTop
        BevelKind = bkFlat
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          558
          39)
        object lblEmail: TLabel
          Left = 5
          Top = 13
          Width = 31
          Height = 14
          Caption = 'e-Mail:'
        end
        object btnAdicionar: TSpeedButton
          Left = 490
          Top = 9
          Width = 22
          Height = 22
          Anchors = [akTop, akRight]
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000020000000A170D0738542D1894814626D193502AEA924F2AE87F45
            25D0522C17931209053000000009000000010000000000000000000000000000
            00030201011159311B97A96239FAC58957FFD6A36DFFDDAF75FFDDAF74FFD6A4
            6BFFC58956FFA46137F53C2112730000000F0000000300000000000000020201
            0110744226B9BC7C4DFFDDAE77FFDEB076FFE2B782FFE3BB87FFE3BC86FFE1B7
            82FFDEAF74FFDBAB72FFBD7E4EFF6F3E24B50000001000000002000000085C36
            2095BE8053FFE0B37CFFDFB076FFDEB177FFB78254FFAA7144FFAB7245FFBC88
            59FFDFB279FFDFB277FFDEB077FFC08253FF55321D920000000A190F0932B070
            47FADFB27DFFDFB27AFFE0B37BFFE0B57DFFA56B3FFFF5EFEAFFF8F3EEFFAB72
            45FFE2B67EFFE0B47CFFE0B47BFFDEB079FFB3734AFB130B072F613C2795CD9B
            6FFFE2B780FFE5BD89FFE7C291FFE8C393FFA56B3FFFF1E6DEFFF9F5F1FFAA71
            44FFE8C494FFE8C393FFE5BF8CFFE1B77FFFD09C6EFF5434218B935E3DD2DCB3
            83FFE3B781FFBA8659FFA97043FFAB7245FFAC7346FFF5EDE6FFFAF6F3FFAD75
            47FFB0784AFFB17A4BFFC29162FFE4B983FFDEB17EFF8E5B3BD0B0744CF2E3BF
            8FFFE4BB84FFA56B3FFFF3EBE6FFFAF6F3FFF6EFE8FFF7F0EAFFFBF7F5FFFAF7
            F4FFFAF7F3FFFAF6F2FFAB7245FFE5BD87FFE5BE8BFFAB714CEEAE764FECE9C9
            A0FFE5BE89FFA56B3FFFE0D2CAFFE1D3CCFFE3D5CFFFF2EAE4FFF8F3EFFFEADF
            D9FFE6DAD4FFE9DED9FFAA7144FFE7C08CFFEACA9DFFAE764FEE9A6A49D0E9CD
            ACFFEAC796FFB78456FFA56B3FFFA56B3FFFA56B3FFFF1EAE5FFFAF6F3FFA56B
            3FFFA56B3FFFA56B3FFFB78457FFEACA99FFEBD1ADFF996A49D46E4E3697DDBB
            9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFA56B3FFFF0EAE7FFFDFCFBFFA56B
            3FFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FF6246318F1C140E2BC794
            6CFCF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFA56B3FFFDECFC9FFDFD1CBFFA56B
            3FFFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFC69470FA1A120D2E000000036F52
            3C92D7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFB98A5FFFA56B3FFFA56B3FFFBA8A
            5FFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FF664B368C00000006000000010202
            0107906C4EB8D9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
            CAFFF8EED0FFF4E8CDFFD7AF8BFF88664AB30202010B00000001000000000000
            00010202010770543F8FCFA078FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
            B9FFE3C5A3FFC59973F24C392A67000000060000000100000000000000000000
            000000000001000000022019122C6C543E89A47E5FCCC59770F1C19570EEA47E
            60CD6C543F8B16110D2200000003000000010000000000000000}
          OnClick = btnAdicionarClick
        end
        object btnRemover: TSpeedButton
          Left = 511
          Top = 9
          Width = 22
          Height = 22
          Anchors = [akTop, akRight]
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000020000000A170D0738542D1894814626D193502AEA924F2AE87F45
            25D0522C17931209053000000009000000010000000000000000000000000000
            00030201011159311B97A96239FAC58957FFD6A36DFFDDAF75FFDDAF74FFD6A4
            6BFFC58956FFA46137F53C2112730000000F0000000300000000000000020201
            0110744226B9BC7C4DFFDDAE77FFDEB076FFDEAF75FFDEAF75FFDEB074FFDDAF
            75FFDEAF74FFDBAB72FFBD7E4EFF6F3E24B50000001000000002000000085C36
            2095BE8053FFE0B37CFFDFB076FFDEB177FFDFB279FFE0B379FFE0B27AFFE0B2
            79FFDFB279FFDFB277FFDEB077FFC08253FF55321D920000000A190F0932B070
            47FADFB27DFFDFB27AFFE0B37BFFE0B57DFFE1B67EFFE2B67FFFE2B77FFFE2B7
            7FFFE2B67EFFE0B47CFFE0B47BFFDEB079FFB3734AFB130B072F613C2795CD9B
            6FFFE2B780FFE5BD89FFE7C291FFE8C393FFE8C494FFE8C594FFE8C495FFE8C4
            95FFE8C494FFE8C393FFE5BF8CFFE1B77FFFD09C6EFF5434218B935E3DD2DCB3
            83FFE3B781FFBA8659FFA97043FFAB7245FFAC7346FFB0794AFFAB7245FFAD75
            47FFB0784AFFB17A4BFFC29162FFE4B983FFDEB17EFF8E5B3BD0B0744CF2E3BF
            8FFFE4BB84FFA56B3FFFF5EEE9FFFAF6F3FFFAF7F3FFFBF7F4FFFBF7F5FFFAF7
            F4FFFAF7F3FFFAF6F2FFAB7245FFE5BD87FFE5BE8BFFAB714CEEAE764FECE9C9
            A0FFE5BE89FFA56B3FFFE6D9D2FFE7DBD4FFE9DED7FFEAE0D9FFEAE0DAFFEBE1
            DBFFEBE0DBFFEEE5E1FFAA7144FFE7C08CFFEACA9DFFAE764FEE9A6A49D0E9CD
            ACFFEAC796FFB78456FFA56B3FFFA56B3FFFA56B3FFFA56B3FFFA56B3FFFA56B
            3FFFA56B3FFFA56B3FFFB78457FFEACA99FFEBD1ADFF996A49D46E4E3697DDBB
            9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFF1D7ABFFF1D8ADFFF1D8ADFFF1D8
            ADFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FF6246318F1C140E2BC794
            6CFCF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFF3DCB3FFF3DEB4FFF3DEB4FFF3DE
            B4FFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFC69470FA1A120D2E000000036F52
            3C92D7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFF4E1B9FFF5E3BBFFF5E2BBFFF5E2
            BBFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FF664B368C00000006000000010202
            0107906C4EB8D9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
            CAFFF8EED0FFF4E8CDFFD7AF8BFF88664AB30202010B00000001000000000000
            00010202010770543F8FCFA078FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
            B9FFE3C5A3FFC59973F24C392A67000000060000000100000000000000000000
            000000000001000000022019122C6C543E89A47E5FCCC59770F1C19570EEA47E
            60CD6C543F8B16110D2200000003000000010000000000000000}
          OnClick = btnRemoverClick
        end
        object edtEmail: TEditFocus
          Tag = 99
          Left = 37
          Top = 9
          Width = 447
          Height = 22
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
          BevelKind = bkFlat
          BorderStyle = bsNone
          CharCase = ecLowerCase
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object lsbEmail: TListBox
        Tag = 99
        Left = 0
        Top = 43
        Width = 562
        Height = 363
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        Sorted = True
        TabOrder = 1
        OnDblClick = lsbEmailDblClick
      end
    end
  end
  object dbeNomCon: TDBEditFocus [6]
    Tag = 99
    Left = 73
    Top = 18
    Width = 479
    Height = 22
    BevelKind = bkFlat
    BorderStyle = bsNone
    CharCase = ecUpperCase
    DataField = 'CON_NOMCON'
    DataSource = dtsConOpe
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 120
    ParentFont = False
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dtsConOpe: TDataSource
    Left = 388
    Top = 256
  end
end
