inherited frmCadSinaleiroFaturamento: TfrmCadSinaleiroFaturamento
  Height = 500
  Caption = 'Sinaleiro de Faturamento - Faixa de Margem/Markup x Vendedor'
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    TabOrder = 2
    ExplicitTop = 427
    inherited FlwBotoes: TFlowPanel
      TabOrder = 1
      ExplicitTop = 2
      inherited btnPesquisa: TBitBtnLocked
        Width = 85
        ExplicitWidth = 85
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 498
      TabOrder = 0
      ExplicitLeft = 498
    end
  end
  inherited pgcDados: TPageControl
    Top = 61
    Height = 366
    TabOrder = 1
    StyleElements = []
    ExplicitTop = 61
    ExplicitHeight = 366
    inherited tbsGeral: TTabSheet
      Caption = '&1 - Faixa de Margem'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 334
      object lblMarIni: TLabel
        Left = 2
        Top = 7
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = '% Margem Inicial:'
      end
      object lblMarFin: TLabel
        Left = 203
        Top = 7
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = '% Margem Final:'
      end
      object lblCorSinaleiro: TLabel
        Left = 67
        Top = 29
        Width = 79
        Height = 14
        Cursor = crHandPoint
        Alignment = taRightJustify
        Caption = 'Cor do Sinaleiro:'
        FocusControl = edtCorSinaleiro
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lblCorSinaleiroClick
      end
      object dbgFaixaDeMargem: TDBGridCitel
        Left = 0
        Top = 54
        Width = 577
        Height = 280
        Align = alBottom
        DataSource = dscFAIPER
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 4
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDrawColumnCell = dbgFaixaDeMargemDrawColumnCell
        OnKeyDown = dbgFaixaDeMargemKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'FAI_MARINI'
            Title.Alignment = taRightJustify
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FAI_MARFIN'
            Title.Alignment = taRightJustify
            Width = 100
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'FAI_CORFAI'
            Title.Alignment = taCenter
            Visible = True
          end>
      end
      object btnAdicionarFaixaDeMargem: TBitBtnLocked
        Left = 300
        Top = 26
        Width = 84
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
        OnClick = btnAdicionarFaixaDeMargemClick
      end
      object edtMarIni: TEditFocus
        Tag = 99
        Left = 87
        Top = 3
        Width = 100
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object edtMarFin: TEditFocus
        Tag = 99
        Left = 284
        Top = 3
        Width = 100
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object edtCorSinaleiro: TEditFocus
        Tag = 99
        Left = 150
        Top = 26
        Width = 37
        Height = 22
        Alignment = taCenter
        CharCase = ecUpperCase
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = False
        TabOrder = 2
        OnChange = edtCorSinaleiroChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object tbsVendedores: TTabSheet
      Caption = '&2 - Vendedores'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblVendedor: TLabel
        Left = 14
        Top = 8
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object dbgVendedores: TDBGridCitel
        Left = 0
        Top = 54
        Width = 577
        Height = 280
        Align = alBottom
        DataSource = dscFAIVEN
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 3
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgVendedoresKeyDown
        CorZebra = clMoneyGreen
        Zebra = True
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO_NOME'
            Width = 539
            Visible = True
          end>
      end
      object btnAdicionarVendedores: TBitBtnLocked
        Left = 481
        Top = 26
        Width = 84
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
        TabOrder = 2
        OnClick = btnAdicionarVendedoresClick
      end
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 66
        Top = 4
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 0
        OnExit = edtCodVenExit
        OnKeyPress = edtCodVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomVen: TEditFocus
        Left = 132
        Top = 4
        Width = 433
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  inherited pnlStatus: TPanel
    Top = 455
    TabOrder = 3
    ExplicitTop = 455
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 585
    Height = 61
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblCodigo: TLabel
      Left = 45
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblDescricao: TLabel
      Left = 29
      Top = 35
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodFai: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 8
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FAI_CODFAI'
      DataSource = dscFAIMAR
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesFai: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 31
      Width = 447
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FAI_DESFAI'
      DataSource = dscFAIMAR
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 484
    Top = 220
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 452
    Top = 220
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 420
    Top = 220
  end
  object cdsFAIPER: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'FAI_MARINI;FAI_MARFIN'
    Params = <>
    Left = 456
    Top = 268
    object cdsFAIPERAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsFAIPERFAI_CODFAI: TStringField
      FieldName = 'FAI_CODFAI'
      Size = 6
    end
    object cdsFAIPERFAI_MARINI: TFloatField
      DisplayLabel = '% Margem Inicial'
      FieldName = 'FAI_MARINI'
      DisplayFormat = '#,##0.00'
    end
    object cdsFAIPERFAI_MARFIN: TFloatField
      DisplayLabel = '% Margem Final'
      FieldName = 'FAI_MARFIN'
      DisplayFormat = '#,##0.00'
    end
    object cdsFAIPERFAI_CORFAI: TStringField
      DisplayLabel = 'Cor'
      FieldName = 'FAI_CORFAI'
      Size = 10
    end
  end
  object cdsFAIVEN: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'FAI_CODVEN'
    Params = <>
    Left = 516
    Top = 268
    object cdsFAIVENAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsFAIVENFAI_CODFAI: TStringField
      FieldName = 'FAI_CODFAI'
      Size = 6
    end
    object cdsFAIVENFAI_CODVEN: TStringField
      FieldName = 'FAI_CODVEN'
      Size = 3
    end
    object cdsFAIVENCODIGO_NOME: TStringField
      DisplayLabel = 'Vendedor'
      FieldName = 'CODIGO_NOME'
      Size = 100
    end
  end
  object dscFAIPER: TDataSource
    DataSet = cdsFAIPER
    Left = 456
    Top = 312
  end
  object dscFAIVEN: TDataSource
    DataSet = cdsFAIVEN
    Left = 516
    Top = 312
  end
  object cldCores: TColorDialog
    Left = 514
    Top = 220
  end
  object dscFAIMAR: TDataSource
    Left = 356
    Top = 220
  end
end
