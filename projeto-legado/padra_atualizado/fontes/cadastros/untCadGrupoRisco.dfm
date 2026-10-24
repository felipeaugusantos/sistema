inherited frmCadGrupoRisco: TfrmCadGrupoRisco
  Width = 607
  Height = 151
  Caption = 'Cadastro de grupos de risco'
  ExplicitWidth = 607
  ExplicitHeight = 151
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 25
    Top = 12
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 9
    Top = 35
    Width = 52
    Height = 14
    Alignment = taRightJustify
    Caption = 'Descri'#231#227'o:'
  end
  object Label3: TLabel [2]
    Left = 23
    Top = 58
    Width = 230
    Height = 14
    Alignment = taRightJustify
    Caption = 'Quantidade de dias de atraso m'#225'ximo permitido:'
  end
  inherited pnlBotoes: TPanel
    Top = 81
    Width = 601
    Height = 25
    TabOrder = 3
    ExplicitTop = 81
    ExplicitWidth = 601
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 597
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 597
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
      object btnAcesso: TBitBtnLocked
        Left = 444
        Top = 0
        Width = 74
        Height = 20
        Caption = 'Ac&esso'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000040000000C0000000A0000000400000004000000070000000A0000
          000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
          00000000000B0B5D2FFF042D15AC0002011C32496397113866B70A3972D2093A
          76DB0A458BFF0A448AFF083873DC07346DD4052B5AB8041F4089000000070000
          000B00000016126737FF3CA885FF094321D47093ABFF8BB7DFFF4391D9FF2B85
          D7FF308FE4FF308FE4FF2A84D7FF2981D3FF2A7DCAFF0B488EFF13542FBD1875
          41FF187341FF177340FF2AC696FF24B07EFF196940FD74A0ABFFAAD2EDFF6DB6
          EEFF3F9EEBFF3F9EEBFF46A2ECFF56ADEDFF3B89CDFF0C447FDA20824BFF7AE4
          C9FF39CD9EFF37CC9DFF35CB9CFF33CA9BFF35C193FF278056FE518887FD7EBA
          E3FF51A5E2FF50A6E1FF58A6DFFF1A64A9FA0C3864A3020B1329258C53FFB5F2
          E4FFB5F2E4FFB3F2E4FF7DE6CAFF4AD2A8FF78DCC0FF3F9A6CFB133F2C89416E
          99E03E6C9DFF366596FF184F81DB02080E260000000500000002206F45C02B95
          5AFF299459FF299358FF9AECD6FF7DD6B9FF318D5CEC09201345000000194261
          88DC7DA4CDFF588BC1FF1C4070DE000000190000000000000000000000020000
          0003000000072D9B5FFF7ECEADFF257A4CCB040E092000000005020304205379
          ACF9BDE0F5FF8BC2EBFF335C95FD0103052D0000000300000000000000000000
          000000000002309F63FC1D5F3B9A0104020B000000010000000517335FC05C80
          B0FFCAE8F6FF94C6E9FF375D95FF102345AC0000000900000000000000000000
          0000000000000000000100000001000000000000000000000006205090F64F7C
          B1FF517CAFFF2C5088FF325D98FF183871F40000000B00000000000000000000
          0000000000000000000000000000000000000000000000000003255A9AE66C9D
          D0FE5C8CC1FF76A5D3FF5385BEFF1C427DF70000000700000000000000000000
          00000000000000000000000000000000000000000000000000010C1F3249255B
          92C22E6EB0E62F72B8FA204E82C80A192D590000000300000000000000000000
          0000000000000000000000000000000000000000000000000000000000010000
          0002000000030000000300000003000000020000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = btnAcessoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 520
      Width = 70
      Height = 20
      ExplicitLeft = 520
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 560
    Top = 500
    Align = alNone
    TabOrder = 5
    ExplicitLeft = 560
    ExplicitTop = 500
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object dbeCodGru: TDBEditFocus [6]
    Tag = 99
    Left = 64
    Top = 8
    Width = 70
    Height = 22
    CharCase = ecUpperCase
    DataField = 'GRR_CODIGO'
    DataSource = dtsCadGrr
    MaxLength = 3
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeDesGru: TDBEditFocus [7]
    Tag = 99
    Left = 64
    Top = 31
    Width = 529
    Height = 22
    CharCase = ecUpperCase
    DataField = 'GRR_DESCRI'
    DataSource = dtsCadGrr
    MaxLength = 40
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeAtrMax: TDBEditFocus [8]
    Tag = 99
    Left = 259
    Top = 54
    Width = 70
    Height = 22
    CharCase = ecUpperCase
    DataField = 'GRR_ATRMAX'
    DataSource = dtsCadGrr
    MaxLength = 5
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  inherited pnlStatus: TPanel
    Top = 106
    Width = 601
    TabOrder = 4
    ExplicitTop = 106
    ExplicitWidth = 601
    inherited pnlNomeForm: TPanel
      Left = 376
      Width = 225
      ExplicitLeft = 376
      ExplicitWidth = 225
    end
    inherited pnlInfo: TPanel
      Width = 376
      ExplicitWidth = 376
    end
  end
  object dtsCadGrr: TDataSource
    Left = 394
  end
end
