inherited frmCadComFatVend: TfrmCadComFatVend
  Left = 244
  Top = 135
  Width = 779
  Height = 518
  Caption = 'Faixa de Faturamento para Comiss'#227'o de Vendedores'
  ExplicitWidth = 779
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 447
    Width = 773
    Height = 26
    ExplicitTop = 447
    ExplicitWidth = 773
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 692
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 769
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 74
        Height = 22
        Spacing = 2
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 694
      Align = alRight
      ExplicitLeft = 694
    end
  end
  inherited pgcDados: TPageControl
    Width = 773
    Height = 447
    ExplicitWidth = 773
    ExplicitHeight = 445
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 765
      ExplicitHeight = 413
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 773
    Height = 447
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 445
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 771
      Height = 40
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label1: TLabel
        Left = 45
        Top = 8
        Width = 36
        Height = 14
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 150
        Top = 9
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object dbeCodPes: TDBEditFocus
        Tag = 99
        Left = 83
        Top = 5
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_CODTAB'
        DataSource = dtsComFat
        TabOrder = 0
        OnExit = dbeCodPesExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDescricao: TDBEditFocus
        Tag = 99
        Left = 205
        Top = 5
        Width = 344
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_DESCRI'
        DataSource = dtsComFat
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlGrid: TPanel
      Left = 1
      Top = 92
      Width = 771
      Height = 354
      Align = alBottom
      Color = 16770261
      TabOrder = 2
      ExplicitTop = 90
      object Label12: TLabel
        Left = 3
        Top = 338
        Width = 228
        Height = 14
        Caption = 'Pressione [DEL] para remover registros do Grid'
      end
      object dbgDados: TDBGridCitel
        Left = 1
        Top = 1
        Width = 769
        Height = 331
        Align = alTop
        DataSource = dtsDados
        Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDblClick = dbgDadosDblClick
        OnKeyDown = dbgDadosKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'COM_CODGAT'
            Title.Caption = 'Grupo Ativ.'
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_MARINI'
            Title.Caption = '% Margem Inicial'
            Width = 90
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_MARFIN'
            Title.Alignment = taRightJustify
            Title.Caption = '% Margem Final'
            Width = 90
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_FATINI'
            Title.Alignment = taRightJustify
            Title.Caption = 'Faturamento Inicial'
            Width = 140
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_FATFIN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Faturamento Final'
            Width = 140
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_PERCOM'
            Title.Alignment = taRightJustify
            Title.Caption = '% Comiss'#227'o'
            Width = 100
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_PERBON'
            Title.Alignment = taRightJustify
            Title.Caption = '% Bonifica'#231#227'o'
            Width = 100
            Visible = True
          end>
      end
    end
    object pnlCentro: TPanel
      Left = 1
      Top = 41
      Width = 771
      Height = 51
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      ExplicitHeight = 49
      object lblFatIni: TLabel
        Left = 278
        Top = 4
        Width = 89
        Height = 14
        Caption = 'Faturamento Inicial'
      end
      object lblFatFin: TLabel
        Left = 377
        Top = 4
        Width = 85
        Height = 14
        Caption = 'Faturamento Final'
      end
      object lblPerCom: TLabel
        Left = 484
        Top = 4
        Width = 60
        Height = 14
        Caption = '% Comiss'#227'o'
      end
      object lblMarIni: TLabel
        Left = 89
        Top = 3
        Width = 83
        Height = 14
        Caption = '% Margem Inicial:'
      end
      object lblMarFin: TLabel
        Left = 176
        Top = 3
        Width = 79
        Height = 14
        Caption = '% Margem Final:'
      end
      object bvlFatIni: TBevel
        Left = 269
        Top = 7
        Width = 2
        Height = 34
      end
      object bvlPerCom: TBevel
        Left = 475
        Top = 7
        Width = 2
        Height = 34
      end
      object lblCodGat: TLabel
        Left = 10
        Top = 3
        Width = 53
        Height = 14
        Caption = 'Grupo Ativ.'
      end
      object bvlCodGat: TBevel
        Left = 74
        Top = 7
        Width = 2
        Height = 34
      end
      object bvlBonificacao: TBevel
        Left = 563
        Top = 7
        Width = 2
        Height = 34
      end
      object lblPercentualBonificacao: TLabel
        Left = 571
        Top = 4
        Width = 70
        Height = 14
        Caption = '% Bonifica'#231#227'o'
      end
      object edtFatIni: TEditFocus
        Tag = 99
        Left = 278
        Top = 18
        Width = 95
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 3
        Text = '0,000'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object edtFatFin: TEditFocus
        Tag = 99
        Left = 377
        Top = 18
        Width = 90
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 4
        Text = '0,000'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object edtPerCom: TEditFocus
        Tag = 99
        Left = 484
        Top = 18
        Width = 73
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 5
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object btnAdicionar: TBitBtnLocked
        Left = 652
        Top = 20
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
        TabOrder = 7
        OnClick = btnAdicionarClick
      end
      object dbeMarIni: TEditFocus
        Tag = 99
        Left = 83
        Top = 18
        Width = 89
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 1
        Text = '0,000'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object dbeMarFin: TEditFocus
        Tag = 99
        Left = 176
        Top = 18
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 2
        Text = '0,000'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object dbeCodGat: TEditFocus
        Tag = 99
        Left = 9
        Top = 18
        Width = 58
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = dbeCodGatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.000'
      end
      object edtPerBonificacao: TEditFocus
        Tag = 99
        Left = 571
        Top = 18
        Width = 73
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 6
        Text = '0,00'
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
  end
  inherited pnlStatus: TPanel
    Top = 473
    Width = 773
    ExplicitTop = 473
    ExplicitWidth = 773
    inherited pnlNomeForm: TPanel
      Left = 426
      ExplicitLeft = 426
    end
    inherited pnlInfo: TPanel
      Width = 426
      ExplicitWidth = 426
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 832
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 800
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 136
    Top = 152
  end
  object dtsComFat: TDataSource
    Left = 480
    Top = 120
  end
  object dtsDados: TDataSource
    Left = 481
    Top = 168
  end
end
