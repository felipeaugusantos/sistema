inherited frmCadComPes: TfrmCadComPes
  Left = 244
  Top = 135
  Width = 525
  Height = 512
  Caption = 'Faixa de pesos para comiss'#227'o de vendedores'
  OnDestroy = FormDestroy
  ExplicitWidth = 525
  ExplicitHeight = 512
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 441
    Width = 519
    Height = 26
    ExplicitTop = 441
    ExplicitWidth = 519
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 444
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 515
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 71
        ExplicitWidth = 71
      end
      inherited btnGravar: TBitBtnLocked
        Left = 71
        Width = 71
        ExplicitLeft = 71
        ExplicitWidth = 71
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 142
        Width = 71
        ExplicitLeft = 142
        ExplicitWidth = 71
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 213
        Width = 71
        ExplicitLeft = 213
        ExplicitWidth = 71
      end
      inherited btnCancela: TBitBtnLocked
        Left = 284
        Width = 74
        ExplicitLeft = 284
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 358
        Width = 75
        ExplicitLeft = 358
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      Width = 71
      Align = alRight
      ExplicitLeft = 446
      ExplicitWidth = 71
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 441
    ExplicitWidth = 519
    ExplicitHeight = 442
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 511
      ExplicitHeight = 410
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 441
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 517
      Height = 63
      Align = alTop
      Color = 16770261
      TabOrder = 0
      object Label1: TLabel
        Left = 10
        Top = 13
        Width = 36
        Height = 14
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 116
        Top = 13
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object Label3: TLabel
        Left = 111
        Top = 37
        Width = 57
        Height = 14
        Caption = 'Valor Inicial:'
      end
      object Label4: TLabel
        Left = 328
        Top = 37
        Width = 53
        Height = 14
        Caption = 'Valor Final:'
      end
      object dbeCodPes: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 9
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_CODTAB'
        DataSource = dtsComPes
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
        Left = 171
        Top = 9
        Width = 334
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_DESCRI'
        DataSource = dtsComPes
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeValIni: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 33
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_VALINI'
        DataSource = dtsComPes
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeValFin: TDBEditFocus
        Tag = 99
        Left = 384
        Top = 33
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_VALFIN'
        DataSource = dtsComPes
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
    object pnlGrid: TPanel
      Left = 1
      Top = 112
      Width = 517
      Height = 328
      Align = alBottom
      Color = 16770261
      TabOrder = 2
      ExplicitTop = 113
      object Label12: TLabel
        Left = 5
        Top = 310
        Width = 228
        Height = 14
        Caption = 'Pressione [DEL] para remover registros do Grid'
      end
      object dbgDados: TDBGridCitel
        Left = 1
        Top = 1
        Width = 515
        Height = 308
        Align = alTop
        DataSource = dtsDados
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_PESINI'
            Title.Alignment = taRightJustify
            Title.Caption = 'Peso Inicial'
            Width = 145
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_PESFIN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Peso Final'
            Width = 145
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
          end>
      end
    end
    object pnlCentro: TPanel
      Left = 1
      Top = 64
      Width = 517
      Height = 48
      Align = alClient
      Color = 16770261
      TabOrder = 1
      ExplicitTop = 65
      object Label5: TLabel
        Left = 6
        Top = 1
        Width = 53
        Height = 14
        Caption = 'Peso Inicial'
      end
      object Label6: TLabel
        Left = 150
        Top = 1
        Width = 49
        Height = 14
        Caption = 'Peso Final'
      end
      object Label7: TLabel
        Left = 294
        Top = 1
        Width = 60
        Height = 14
        Caption = '% Comiss'#227'o'
      end
      object edtPesIni: TEditFocus
        Tag = 99
        Left = 6
        Top = 16
        Width = 142
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 0
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
      object edtPesFin: TEditFocus
        Tag = 99
        Left = 150
        Top = 16
        Width = 142
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
      object edtPerCom: TEditFocus
        Tag = 99
        Left = 294
        Top = 16
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
        EditFormat = '#,##0.00'
      end
      object btnAdicionar: TBitBtnLocked
        Left = 397
        Top = 16
        Width = 108
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 467
    Width = 519
    ExplicitTop = 467
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 329
      Width = 190
      ExplicitLeft = 329
      ExplicitWidth = 190
    end
    inherited pnlInfo: TPanel
      Width = 329
      ExplicitWidth = 329
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
  object dtsComPes: TDataSource
    Left = 480
    Top = 120
  end
  object dtsDados: TDataSource
    Left = 481
    Top = 152
  end
end
