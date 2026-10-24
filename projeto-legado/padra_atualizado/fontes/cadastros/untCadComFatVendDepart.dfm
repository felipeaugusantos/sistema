inherited frmCadComFatVendDepart: TfrmCadComFatVendDepart
  Width = 525
  Height = 400
  Caption = 'Faixa de Faturamento Geral do Vendedor X Departamento'
  ExplicitWidth = 525
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 330
    Width = 519
    Height = 25
    ExplicitTop = 330
    ExplicitWidth = 519
    ExplicitHeight = 25
    DesignSize = (
      519
      25)
    inherited FlwBotoes: TFlowPanel
      Width = 515
      Height = 21
      ExplicitWidth = 515
      ExplicitHeight = 21
    end
    inherited btnSair: TBitBtnLocked
      Left = 441
      Width = 68
      ExplicitLeft = 441
      ExplicitWidth = 68
    end
    inherited btnIncluir: TBitBtnLocked
      Width = 73
      ExplicitWidth = 73
    end
    inherited btnGravar: TBitBtnLocked
      Left = 73
      Width = 73
      ExplicitLeft = 73
      ExplicitWidth = 73
    end
    inherited btnCancela: TBitBtnLocked
      Left = 292
      Width = 73
      ExplicitLeft = 292
      ExplicitWidth = 73
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 219
      Width = 73
      ExplicitLeft = 219
      ExplicitWidth = 73
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 365
      Width = 73
      ExplicitLeft = 365
      ExplicitWidth = 73
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 146
      Width = 73
      ExplicitLeft = 146
      ExplicitWidth = 73
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 330
    ExplicitWidth = 519
    ExplicitHeight = 330
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 511
      ExplicitHeight = 298
    end
  end
  object pnl1: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 330
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 519
      Height = 112
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object lbl1: TLabel
        Left = 8
        Top = 13
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object lbl2: TLabel
        Left = 116
        Top = 13
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object lbl3: TLabel
        Left = 76
        Top = 37
        Width = 92
        Height = 14
        Alignment = taRightJustify
        Caption = 'Faturamento Inicial:'
      end
      object lbl4: TLabel
        Left = 299
        Top = 37
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Faturamento Final:'
      end
      object lblDesIni: TLabel
        Left = 97
        Top = 63
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = '% Desc. In'#237'cio:'
      end
      object lblDesFin: TLabel
        Left = 324
        Top = 63
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = '% Desc. Fim:'
      end
      object lblMarIni: TLabel
        Left = 84
        Top = 87
        Width = 84
        Height = 14
        Alignment = taRightJustify
        Caption = '% Margem. In'#237'cio:'
      end
      object lblMarFin: TLabel
        Left = 311
        Top = 87
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = '% Margem. Fim:'
      end
      object dbeCodTab: TDBEditFocus
        Tag = 99
        Left = 45
        Top = 9
        Width = 62
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_CODTAB'
        DataSource = dtsTabela
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDesTab: TDBEditFocus
        Tag = 99
        Left = 169
        Top = 9
        Width = 340
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_DESCRI'
        DataSource = dtsTabela
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeFatIni: TDBEditFocus
        Tag = 99
        Left = 169
        Top = 33
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_FATINI'
        DataSource = dtsTabela
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeFatFin: TDBEditFocus
        Tag = 99
        Left = 388
        Top = 33
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_FATFIN'
        DataSource = dtsTabela
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeDesIni: TDBEditFocus
        Tag = 99
        Left = 169
        Top = 57
        Width = 80
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_DESINI'
        DataSource = dtsTabela
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeDesFin: TDBEditFocus
        Tag = 99
        Left = 388
        Top = 57
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_DESFIN'
        DataSource = dtsTabela
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeMarIni: TDBEditFocus
        Tag = 99
        Left = 169
        Top = 81
        Width = 80
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_MARINI'
        DataSource = dtsTabela
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeMarFin: TDBEditFocus
        Tag = 99
        Left = 388
        Top = 81
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_MARFIN'
        DataSource = dtsTabela
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
    object pnlComDep: TPanel
      Left = 0
      Top = 112
      Width = 519
      Height = 54
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      ExplicitTop = 88
      object lbl7: TLabel
        Left = 373
        Top = 8
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = '% Comiss'#227'o'
      end
      object lblCodDep: TLabel
        Left = 8
        Top = 8
        Width = 67
        Height = 14
        Caption = 'Departamento'
      end
      object edtPerCom: TEditFocus
        Tag = 99
        Left = 333
        Top = 22
        Width = 100
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 2
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.00'
      end
      object edtDesDep: TEditFocus
        Left = 70
        Top = 22
        Width = 261
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodDep: TEditFocus
        Tag = 99
        Left = 8
        Top = 22
        Width = 62
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodDepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object btnAdicionar: TBitBtnLocked
        Left = 437
        Top = 23
        Width = 72
        Height = 20
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
        OnClick = btnAdicionarClick
      end
    end
    object grdComDep: TDBGridCitel
      Left = 0
      Top = 166
      Width = 519
      Height = 164
      Align = alClient
      DataSource = dtsComDep
      FixedColor = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 2
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = grdComDepKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'NOMDEP'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Title.Caption = 'Departamento'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWhite
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = [fsBold]
          Width = 398
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PERCOM'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Title.Alignment = taRightJustify
          Title.Caption = '% Comiss'#227'o'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWhite
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end>
    end
  end
  inherited pnlStatus: TPanel
    Top = 355
    Width = 519
    ExplicitTop = 355
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 360
      Width = 159
      ExplicitLeft = 360
      ExplicitWidth = 159
    end
    inherited pnlInfo: TPanel
      Width = 360
      ExplicitWidth = 360
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 158
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 158
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 24
    Top = 32
  end
  object dtsComDep: TDataSource
    DataSet = cdsComDep
    Left = 368
    Top = 158
  end
  object dtsTabela: TDataSource
    Left = 337
    Top = 158
  end
  object cdsComDep: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 306
    Top = 158
    object cdsComDepAUTOIN: TStringField
      FieldName = 'AUTOIN'
    end
    object cdsComDepSEQCOM: TStringField
      FieldName = 'SEQCOM'
    end
    object cdsComDepCODDEP: TStringField
      FieldName = 'CODDEP'
      Size = 3
    end
    object cdsComDepNOMDEP: TStringField
      FieldName = 'NOMDEP'
      Size = 45
    end
    object cdsComDepPERCOM: TFloatField
      FieldName = 'PERCOM'
      DisplayFormat = ',0.00'
    end
  end
end
