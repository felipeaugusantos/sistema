inherited frmCtpReprogVen: TfrmCtpReprogVen
  Width = 752
  Height = 567
  Caption = 'Reprograma'#231#227'o de Vencimentos'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 752
  ExplicitHeight = 567
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 494
    Width = 746
    ExplicitTop = 494
    ExplicitWidth = 746
    inherited FlwBotoes: TFlowPanel
      Width = 665
      ExplicitTop = 2
      ExplicitWidth = 665
      ExplicitHeight = 24
      object btnMarTodas: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 127
        Height = 23
        Align = alLeft
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 0
        OnClick = btnMarTodasClick
      end
      object btnDesTodas: TBitBtnLocked
        Left = 127
        Top = 0
        Width = 127
        Height = 23
        Align = alLeft
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 1
        OnClick = btnDesTodasClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 254
        Top = 0
        Width = 127
        Height = 23
        Align = alLeft
        Caption = '[ F10 ] Confirma'
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnHistDocumentos: TBitBtnLocked
        Left = 381
        Top = 0
        Width = 111
        Height = 23
        Align = alLeft
        Caption = '&Hist. Documentos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD4C00BD4C00
          BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C
          00BD4C00BD4C00BD4C00BD4C00FFF2E2FFEFDDFEEBD8811E00FEE6CBFEE2C6FE
          E0C0E3B08AFEDAB5FED8B0FFD5ABE3A97AFED1A3FECF9EBD4C00BD4C00FFF3E6
          FFF0E1FEEEDC811E00FEE9CFFFE5CAFEE2C4E3B18EFEDDB8FFD9B2FFD8AFE3AB
          7EFED3A5FED0A0BD4C00BD4C00FEF4EBFEF3E6FFF0E1811E00FEEAD4FFE6CEFE
          E3C9E5B490FEDEBCFFDAB7FED8B1E3AB80FED4A7FED1A3BD4C00BD4C00811E00
          811E00811E00811E00E5BDA3E5BCA0E3BA9EE3B899E5B695E5B590E3B28BE5B0
          88E3AD83E3AC81BD4C00BD4C00FFF8F2FFF7EEFFF3E7811E00FFEEDCFFEBD7FE
          E9D0E3B696FEE2C4FEE0BFFEDCB8E3AD86FFD8AFFED5AABD4C00BD4C00FFFBF4
          FFF8F0FEF6EB811E00FFF0E1FFEDDCFEEAD5E5B899FFE5C9FEE2C2FFE0BDE3B0
          88FED9B2FFD7ADBD4C00BD4C00FFFCF8FFFAF4FFF7EF811E00FFF3E5FFEFE0FE
          EDD9E5BA9DFFE7CEFFE3C7FFE1C1E3B18BFEDCB5FED8B1BD4C00BD4C00811E00
          811E00811E00811E00811E00811E00811E00811E00811E00811E00811E00811E
          00811E00811E00BD4C00BD4C00FFFFFEFFFCFAFFFBF6811E00FFF6EDFFF4E6FF
          F2E1811E00FFEBD7FFE9D0FEE6CA811E00FEE0BFFEDDB7BD4C00BD4C00FFFFFF
          FFFEFCFFFCF8811E00FFF8EFFFF4EAFEF3E5811E00FEEEDAFFEAD4FFE7CE811E
          00FFE1C2FEDEBCBD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD
          4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 3
        OnClick = btnHistDocumentosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 667
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 667
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 746
    Height = 169
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 91
      Top = 10
      Width = 54
      Height = 14
      Caption = 'Data Inicial:'
    end
    object Label2: TLabel
      Left = 291
      Top = 10
      Width = 50
      Height = 14
      Caption = 'Data Final:'
    end
    object Label3: TLabel
      Left = 191
      Top = 29
      Width = 78
      Height = 14
      Caption = '(VENCIMENTO)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 394
      Top = 29
      Width = 78
      Height = 14
      Caption = '(VENCIMENTO)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 31
      Top = 52
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel
      Left = 45
      Top = 122
      Width = 45
      Height = 14
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblPortador: TLabel
      Left = 46
      Top = 145
      Width = 44
      Height = 14
      Caption = 'Portador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 91
      Top = 25
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000018744558745469746C6500546F6461793B43616C656E6461723B4461
        79DFD0E0E20000022B49444154785E85533D6B1451143D932CC1C2B5F0276815
        DD28422C2C92C6D5E04722F10315C19F606561AA58AC8895A59FE5AA58ACA218
        35A01626984870936C0411B49744D14D369BDD99FBDE78DE7D8F59D4C2650EE7
        BEFBEE3DF7637622000EDD4417C22FF890E15F7F4A5842722EF9EDA9E1D75418
        B4D6C2DA148E53C210EA33DE4E1D1B1F138B4C9D999D2BAA402EC260EFE821EA
        FA64660086B60893681346C88415772F9879FA6A40730144364D35B0F5E5B317
        30BE2A7D046DCF99DDBD39CF5A7EA49C0EE4DA8E63185751B47DB2091CC41C6C
        F025E4D46602D1E2F112F69DDE8D3C85E09E08CA20A7A114E12F227F7EF67001
        78DF1F75B9301155D3E0AFD72EA376FE04E6CF8DA27A76049FC62FC115BB7D7F
        16DF565671B33CA34B4C12A31D0401D192F463F5630D2671CB13180AAF7C9883
        A1F091FD3B94870FEC24670270023C584DD6654A02630C0AE527B0148A375AEA
        7F3CB9A49D549ED760ADE67476908884570888F885554F1E66501BED769B82C0
        48B1A0958F0DF58511A43342121BDD99E1454F6F01EB8D26EAF59FF855AF23BF
        67AF765079B948761D2C8411A4D3010F4E4095B78F95B00D7AA73EDF192B1FEC
        43EA786817ACC19F3B887960902ADF7DF00ECB3F1AB8736F1ACBDFD770AB4CE6
        F9D1C4BCC65426AADA91841D4400B65C187F51BF3A5644A3A9A3E8BBF6062933
        3343A974FD0D6E5C39BAD58D20CDE6DAD4C5D2E400A37D4C08ECFCAB327F66C7
        ADF5694751186313D1F3D7671CFDE7738E898DDFA483B27117D9EAF600000000
        49454E44AE426082}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      Width = 97
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 291
      Top = 25
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000018744558745469746C6500546F6461793B43616C656E6461723B4461
        79DFD0E0E20000022B49444154785E85533D6B1451143D932CC1C2B5F0276815
        DD28422C2C92C6D5E04722F10315C19F606561AA58AC8895A59FE5AA58ACA218
        35A01626984870936C0411B49744D14D369BDD99FBDE78DE7D8F59D4C2650EE7
        BEFBEE3DF7637622000EDD4417C22FF890E15F7F4A5842722EF9EDA9E1D75418
        B4D6C2DA148E53C210EA33DE4E1D1B1F138B4C9D999D2BAA402EC260EFE821EA
        FA64660086B60893681346C88415772F9879FA6A40730144364D35B0F5E5B317
        30BE2A7D046DCF99DDBD39CF5A7EA49C0EE4DA8E63185751B47DB2091CC41C6C
        F025E4D46602D1E2F112F69DDE8D3C85E09E08CA20A7A114E12F227F7EF67001
        78DF1F75B9301155D3E0AFD72EA376FE04E6CF8DA27A76049FC62FC115BB7D7F
        16DF565671B33CA34B4C12A31D0401D192F463F5630D2671CB13180AAF7C9883
        A1F091FD3B94870FEC24670270023C584DD6654A02630C0AE527B0148A375AEA
        7F3CB9A49D549ED760ADE67476908884570888F885554F1E66501BED769B82C0
        48B1A0958F0DF58511A43342121BDD99E1454F6F01EB8D26EAF59FF855AF23BF
        67AF765079B948761D2C8411A4D3010F4E4095B78F95B00D7AA73EDF192B1FEC
        43EA786817ACC19F3B887960902ADF7DF00ECB3F1AB8736F1ACBDFD770AB4CE6
        F9D1C4BCC65426AADA91841D4400B65C187F51BF3A5644A3A9A3E8BBF6062933
        3343A974FD0D6E5C39BAD58D20CDE6DAD4C5D2E400A37D4C08ECFCAB327F66C7
        ADF5694751186313D1F3D7671CFDE7738E898DDFA483B27117D9EAF600000000
        49454E44AE426082}
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      Width = 97
    end
    object edtCodFornecedor: TEditFocus
      Left = 91
      Top = 50
      Width = 70
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodFornecedorExit
      OnKeyPress = edtCodFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 162
      Top = 50
      Width = 310
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 91
      Top = 119
      Width = 70
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 6
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 162
      Top = 119
      Width = 310
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesPortador: TEditFocus
      Left = 162
      Top = 142
      Width = 310
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 91
      Top = 142
      Width = 70
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 8
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object btnConsultar: TBitBtnLocked
      Left = 478
      Top = 142
      Width = 106
      Height = 21
      Caption = '&Carregar T'#237'tulos'
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
      TabOrder = 10
      OnClick = btnConsultarClick
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = -3
      Top = 73
      Width = 483
      Height = 22
      TabOrder = 4
      ExplicitLeft = -3
      ExplicitTop = 73
      ExplicitWidth = 483
      inherited lblEventos: TLabel
        Left = 6
        Width = 87
        Height = 14
        ExplicitLeft = 6
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Width = 70
        Height = 22
        OnExit = fraCentroCustoedtCodEveExit
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 165
        Width = 310
        Height = 22
        ExplicitLeft = 165
        ExplicitWidth = 310
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 6
      Top = 96
      Width = 475
      Height = 22
      TabOrder = 5
      ExplicitLeft = 6
      ExplicitTop = 96
      ExplicitWidth = 475
      inherited lblPlaContas: TLabel
        Left = 4
        Width = 81
        Height = 14
        ExplicitLeft = 4
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 156
        Width = 310
        Height = 22
        ExplicitLeft = 156
        ExplicitWidth = 310
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Width = 70
        Height = 22
        OnExit = fraPlanoDeContasMskCodCtaExit
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
    end
  end
  object cxDados: TcxGrid [3]
    Left = 0
    Top = 169
    Width = 746
    Height = 325
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxDadosView: TcxGridDBTableView
      OnDblClick = cxDadosViewDblClick
      OnKeyDown = cxDadosViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxDadosViewCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibi'#231#227'o>'
      OptionsView.GroupByBox = False
      object colNUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'NUMDUP'
        Options.Editing = False
        Width = 101
      end
      object colPARCEL: TcxGridDBColumn
        Caption = 'Parcela'
        DataBinding.FieldName = 'PARCEL'
        Options.Editing = False
        Width = 45
      end
      object colCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        Options.Editing = False
        Width = 51
      end
      object colNOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Options.Editing = False
        Width = 295
      end
      object colDTAVEN: TcxGridDBColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'DTAVEN'
        Options.Editing = False
        Width = 71
      end
      object colVALDUP: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'VALDUP'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 82
      end
      object colMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object cxDadosLevel1: TcxGridLevel
      GridView = cxDadosView
    end
  end
  inherited pnlStatus: TPanel
    Top = 522
    Width = 746
    ExplicitTop = 522
    ExplicitWidth = 746
    inherited pnlNomeForm: TPanel
      Left = 575
      ExplicitLeft = 575
    end
    inherited pnlInfo: TPanel
      Width = 575
      Font.Color = clRed
      ParentFont = False
      ExplicitWidth = 575
      object shpMultSel: TShape
        Left = 557
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 229
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 688
    Top = 296
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 688
    Top = 264
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 688
    Top = 336
  end
  object dtsDados: TDataSource
    Left = 640
    Top = 8
  end
end
