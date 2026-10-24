inherited frmCadComFatDepart: TfrmCadComFatDepart
  Width = 525
  Height = 474
  Caption = 'Faixa de Desconto por Departamento'
  ExplicitWidth = 525
  ExplicitHeight = 474
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 404
    Width = 519
    Height = 25
    ExplicitTop = 404
    ExplicitWidth = 519
    ExplicitHeight = 25
    DesignSize = (
      519
      25)
    inherited FlwBotoes: TFlowPanel
      Width = 515
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 515
      ExplicitHeight = 21
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
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 441
      Width = 69
      Height = 20
      ExplicitLeft = 441
      ExplicitWidth = 69
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 404
    ExplicitWidth = 519
    ExplicitHeight = 404
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 511
      ExplicitHeight = 372
    end
  end
  object pnl1: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 404
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 519
      Height = 89
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object lbl1: TLabel
        Left = 54
        Top = 13
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object lbl2: TLabel
        Left = 38
        Top = 36
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object lblCodDep: TLabel
        Left = 20
        Top = 59
        Width = 70
        Height = 14
        Caption = 'Departamento:'
      end
      object dbeCodTab: TDBEditFocus
        Tag = 99
        Left = 91
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
        Left = 91
        Top = 32
        Width = 337
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
      object edtDesDep: TEditFocus
        Left = 153
        Top = 55
        Width = 275
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtCodDep: TDBEditFocus
        Tag = 99
        Left = 91
        Top = 55
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_CODDEP'
        DataSource = dtsTabela
        MaxLength = 3
        TabOrder = 2
        OnKeyPress = edtCodDepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
    end
    object pnlComDep: TPanel
      Left = 0
      Top = 89
      Width = 519
      Height = 158
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      object lbl7: TLabel
        Left = 277
        Top = 4
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = '% Comiss'#227'o'
      end
      object Label1: TLabel
        Left = 29
        Top = 4
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = '% Desconto Inicial'
      end
      object Label2: TLabel
        Left = 144
        Top = 4
        Width = 84
        Height = 14
        Alignment = taRightJustify
        Caption = '% Desconto Final'
      end
      object edtPerCom: TEditFocus
        Tag = 99
        Left = 237
        Top = 17
        Width = 100
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 2
        Text = '0,0000'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.0000'
      end
      object edtDesIni: TEditFocus
        Tag = 99
        Left = 18
        Top = 17
        Width = 100
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 0
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
      object edtDesFin: TEditFocus
        Tag = 99
        Left = 128
        Top = 17
        Width = 100
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 1
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
      object btnAdicionar: TBitBtnLocked
        Left = 343
        Top = 17
        Width = 72
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
        OnClick = btnAdicionarClick
      end
      object grdComDep: TDBGridCitel
        Left = 2
        Top = 43
        Width = 515
        Height = 113
        Align = alBottom
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
        TabOrder = 4
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
            FieldName = 'DESINI'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Title.Alignment = taRightJustify
            Title.Caption = '% Desconto Inicial'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = [fsBold]
            Width = 113
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESFIN'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Title.Alignment = taRightJustify
            Title.Caption = '% Desconto Final'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = [fsBold]
            Width = 116
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
    object pnlComCnd: TPanel
      Left = 0
      Top = 247
      Width = 519
      Height = 146
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 2
      object lblCndPag: TLabel
        Left = 6
        Top = 9
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cond. Pagto:'
      end
      object btnAdicionarCnd: TBitBtnLocked
        Left = 438
        Top = 5
        Width = 72
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
        OnClick = btnAdicionarCndClick
      end
      object grdComCnd: TDBGridCitel
        Left = 2
        Top = 31
        Width = 515
        Height = 113
        Align = alBottom
        DataSource = dtsComCnd
        FixedColor = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 3
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = grdComCndKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'CODCND'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Title.Caption = 'C'#243'digo'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CNDPAG'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Title.Caption = 'Condi'#231#227'o de Pagamento'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = [fsBold]
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRI'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Title.Caption = 'Descri'#231#227'o'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = [fsBold]
            Width = 200
            Visible = True
          end>
      end
      object edtCodCnd: TEditFocus
        Tag = 99
        Left = 69
        Top = 5
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        OnExit = edtCodCndExit
        OnKeyPress = edtCodCndKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesCndPag: TEditFocus
        Left = 140
        Top = 5
        Width = 292
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
    Top = 429
    Width = 519
    ExplicitTop = 429
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 344
      Width = 175
      ExplicitLeft = 344
      ExplicitWidth = 175
    end
    inherited pnlInfo: TPanel
      Width = 344
      ExplicitWidth = 344
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
    Left = 216
    Top = 88
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
    object cdsComDepDESINI: TFloatField
      FieldName = 'DESINI'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsComDepDESFIN: TFloatField
      FieldName = 'DESFIN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsComDepPERCOM: TFloatField
      FieldName = 'PERCOM'
      DisplayFormat = '#,##0.0000'
      EditFormat = '#,##0.0000'
    end
  end
  object cdsComCnd: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 306
    Top = 206
    object cdsComCndAUTOIN: TStringField
      FieldName = 'AUTOIN'
    end
    object cdsComCndSEQCOM: TStringField
      FieldName = 'SEQCOM'
    end
    object cdsComCndCODCND: TStringField
      FieldName = 'CODCND'
      Size = 3
    end
    object cdsComCndDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 70
    end
    object cdsComCndCNDPAG: TStringField
      FieldName = 'CNDPAG'
      OnGetText = cdsComCndCNDPAGGetText
      Size = 74
    end
  end
  object dtsComCnd: TDataSource
    DataSet = cdsComCnd
    Left = 337
    Top = 206
  end
end
