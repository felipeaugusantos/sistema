inherited frmManClubeFidelidade: TfrmManClubeFidelidade
  Left = 331
  Top = 287
  Width = 541
  Height = 385
  Caption = 'Manuten'#231#227'o de Clube Fidelidade'
  ExplicitWidth = 541
  ExplicitHeight = 385
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 296
    Width = 517
    Height = 44
    TabOrder = 1
    ExplicitTop = 296
    ExplicitWidth = 517
    ExplicitHeight = 44
    inherited FlwBotoes: TFlowPanel
      Width = 438
      Height = 40
      ExplicitTop = 2
      ExplicitWidth = 438
      ExplicitHeight = 40
      inherited btnIncluir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnGravar: TBitBtnLocked
        Align = alLeft
      end
      inherited btnAlterar: TBitBtnLocked
        Align = alLeft
      end
      inherited btnExcluir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnCancela: TBitBtnLocked
        Width = 74
        Align = alLeft
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 362
        Width = 75
        Align = alLeft
        ExplicitLeft = 362
        ExplicitWidth = 75
      end
      object btnBaixar: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 72
        Height = 20
        Align = alLeft
        Caption = '&Baixar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          000A0000000F0000001000000010000000100000001100000011000000110000
          0011000000100000000B00000003000000000000000000000000000000094633
          2CC160453BFF644A41FFB87D4EFFB97A4AFFB47444FFB06C3DFFA76436FF593E
          37FF5C4037FF3B2823C20000000A0000000000000000000000000000000D6F53
          47FF947869FF6A4F46FFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A66DFF5F44
          3CFF694C42FF553A32FF0000000E0000000000000000000000000000000C7357
          4AFF987D6EFF70564BFFFFFFFFFFF6EFEAFFF6EFE9FFF6EEE9FFF5EEE9FF644A
          41FF72544AFF583D34FF01010116020202100101010B000000030000000B785C
          4EFF9D8273FF765C50FFFFFFFFFFF7F0EBFFF7F0EBFFF7EFEBFFF6EFEAFF6A50
          46FF73554BFF5B4037FF2B201E786C534BFF483832C20101010A0000000A7C60
          50FFA28777FF7B6154FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F56
          4BFF74584EFF5E4339FF352A2678785E55FF664D46FF0101010E000000097F63
          54FFA78E7DFF977A6AFF967969FF957967FF84695CFF785D53FF775C51FF775C
          51FF775A50FF62463CFF362A277780655CFF685048FF0101010E000000088367
          57FFAB9382FF634A41FF614740FF5E463DFF5C443CFF5B433BFF594139FF5840
          37FF795C52FF654A3FFF372C287781665DFF6B534BFF0101010D00000007866A
          59FFAF9788FF674E44FFF3EAE4FFE7D5C8FFE7D4C6FFE6D3C5FFE6D3C5FF5B43
          3AFF7A5F54FF694E42FF382D297682685FFF6E554CFF0101010C00000006886D
          5CFFB39C8CFF6B5248FFF4ECE6FFE9D9CDFFE8D7CAFFE7D5C8FFE6D4C6FF5E46
          3EFF7C6156FF6C5145FF382E2A75846A61FF71584FFF0101010B000000058B70
          5EFFB7A091FF70564DFFF6EFEAFFF5EDE8FFF4ECE6FFF4EBE4FFF3EAE3FF634A
          41FF7E6358FF715549FF3A302B75866C63FF745C52FF0101010A000000036954
          47C08C715FFF755A50FF8D766CFF897369FF856D65FF81695FFF7C645BFF674D
          45FF775B4DFF644E43DC3B312C73876F65FF785F55FF01010109000000010000
          0002000000040000000740362F73514842734B4139744A4038744A3F3874493E
          3774463B35743C322E733D322E72897067FF7A6257FF01010108000000000000
          00000000000000000005967E6EFFBEA99CFFAE9685FFAD9584FFAC9583FFAB92
          83FFAA9182FF947B70FF8C7369FF8B7268FF7F665BFF01010107000000000000
          00000000000000000003725F53C0977F6FFF967D6EFF957C6DFF947A6BFF9279
          6AFF907868FF8E7667FF8C7365FF846B5EFF614E46C100000004000000000000
          0000000000000000000100000002000000040000000400000004000000040000
          0005000000050000000500000005000000050000000300000001}
        TabOrder = 6
        OnClick = btnBaixarClick
      end
      object btnCancelaBaixa: TBitBtnLocked
        Left = 72
        Top = 20
        Width = 144
        Height = 20
        Align = alLeft
        Caption = '&Cancelar Baixa'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          000A0000000F0000001000000010000000100000001100000011000000110000
          001100000011000000100000000B000000030000000000000000000000094633
          2CC160453BFF644A41FFB87D4EFFB97A4AFFB47444FFB06C3DFFA76436FFA764
          36FF583D36FF5B3E37FF3B2821C20000000A00000000000000000000000D6F53
          47FF947869FF6A4F46FFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A66DFFD4A5
          6AFF5D413AFF684B41FF543931FF0000000E00000000000000000000000C7357
          4AFF987D6EFF70564BFFFFFFFFFFF6EFEAFFF6EFE9FFF6EEE9FFF5EEE9FFF6EE
          E8FF62473FFF715348FF573B33FF0000000F00000000000000000000000B785C
          4EFF9D8273FF765C50FFFFFFFFFFF7F0EBFFF7F0EBFFF7EFEBFFF6EFEAFFF6EF
          EAFF684E44FF72554BFF593E35FF0000000E00000000000000000000000A7C60
          50FFA28777FF7B6154FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6E5349FF74574CFF5C4138FF0000000C0000000000000000000000097F63
          54FFA78E7DFF977A6AFF967969FF957967FF82685BFF6B5145FF6F564BFF6E55
          4BFF6E534AFF6D5249FF584035FF0000001C0000000C00000003000000088367
          57FFAB9382FF634A41FF614740FF5E463DFF584139FF3A2774FF33218EFF3320
          8DFF33208DFF331F8DFF331F8CFF2816A0FF1C1073C40000000B00000007866A
          59FFAF9788FF674E44FFF3EAE4FFE7D5C8FFD9C8BAFF3021A8FF2637D4FF1B2B
          D0FF1B2AD0FF1A29D0FF1A2ACFFF1929CFFF2D1DA5FF0000001000000006886D
          5CFFB39C8CFF6B5248FFF4ECE6FFE9D9CDFFDBCBBFFF372AAEFF3546D8FFF9F4
          EFFF5662DAFF5561D9FFF8F3EDFF2131D2FF3426AAFF00000010000000058B70
          5EFFB7A091FF70564DFFF6EFEAFFECDDD3FFDECFC5FF4035B4FF4557DEFF6E75
          D9FFFAF5F1FFF9F5F0FF6C74D9FF2B3CD6FF3C30B1FF0000000F000000048E72
          60FFBBA595FF755A50FFF7F1ECFFF6F0EBFFE9E3DEFF483EBBFF5566E2FF7781
          E2FFFBF7F4FFFAF7F3FF747FE0FF3748D9FF4439B7FF0000000D000000026A56
          49BF8F7361FF795E54FF765D52FF745A50FF6E554BFF5048C2FF6779E6FFFCFA
          F7FF7C84DEFF7B84DEFFFBF8F5FF4356DDFF4C43BEFF0000000C000000010000
          0002000000030000000300000003000000040000000C605DCBFF98ADF1FF899C
          E8FF8EA2EDFF899DECFF7D8EE4FF8397ECFF5953C6FF0000000A000000000000
          000000000000000000000000000000000000000000054C4B9AC26766D0FF6564
          D0FF6663D0FF6362CFFF6460CFFF625FCDFF474597C200000006000000000000
          0000000000000000000000000000000000000000000100000004000000060000
          0007000000070000000700000007000000070000000500000001}
        TabOrder = 7
        OnClick = btnCancelaBaixaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 440
      Width = 75
      Height = 40
      Align = alRight
      ExplicitLeft = 440
      ExplicitWidth = 75
      ExplicitHeight = 40
    end
  end
  inherited pnlStatus: TPanel
    Top = 340
    Width = 517
    TabOrder = 3
    ExplicitTop = 340
    ExplicitWidth = 517
    inherited pnlNomeForm: TPanel
      Left = 272
      Width = 245
      ExplicitLeft = 272
      ExplicitWidth = 245
    end
    inherited pnlInfo: TPanel
      Width = 272
      ExplicitWidth = 272
    end
  end
  inherited pgcDados: TPageControl
    Width = 517
    Height = 296
    ExplicitWidth = 517
    ExplicitHeight = 296
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 509
      ExplicitHeight = 264
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 517
    Height = 296
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object bvlLinha: TBevel
      Left = 2
      Top = 2
      Width = 513
      Height = 55
      Align = alTop
      Shape = bsBottomLine
      ExplicitWidth = 521
    end
    object lblCodigo: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      FocusControl = dbeCodFid
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDtaCad: TLabel
      Left = 66
      Top = 8
      Width = 84
      Height = 14
      Caption = 'Data de Cadastro'
      FocusControl = dbeDtaCad
    end
    object lblCliente: TLabel
      Left = 30
      Top = 91
      Width = 35
      Height = 14
      Caption = 'Cliente:'
      FocusControl = dbeCodCli
    end
    object Label1: TLabel
      Left = 8
      Top = 68
      Width = 57
      Height = 14
      Caption = 'Documento:'
      FocusControl = dbeNumDoc
    end
    object Label2: TLabel
      Left = 179
      Top = 68
      Width = 41
      Height = 14
      Caption = 'Esp'#233'cie:'
      FocusControl = dbeEspDoc
    end
    object Label3: TLabel
      Left = 259
      Top = 68
      Width = 45
      Height = 14
      Caption = 'Empresa:'
      FocusControl = dbeCodEmp
    end
    object ColorLabel1: TColorLabel
      Left = 99
      Top = 114
      Width = 89
      Height = 14
      Caption = '(C)r'#233'dito / (D)'#233'bito'
      FocusControl = dbeCreDeb
      CorDestaque = clRed
    end
    object Label4: TLabel
      Left = 355
      Top = 114
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd Pontos:'
      FocusControl = dbeQtdPto
    end
    object Label5: TLabel
      Left = 23
      Top = 134
      Width = 41
      Height = 14
      Caption = 'Observ.:'
      FocusControl = dbeObserv001
    end
    object dbeCodFid: TDBEditFocus
      Left = 8
      Top = 23
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FID_CODFID'
      DataSource = dtsCluFid
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDtaCad: TDBEditFocus
      Left = 66
      Top = 23
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FID_DTACAD'
      DataSource = dtsCluFid
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodCli: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 87
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FID_CODCLI'
      DataSource = dtsCluFid
      MaxLength = 8
      TabOrder = 5
      OnKeyPress = dbeCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 134
      Top = 87
      Width = 382
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeNumDoc: TDBEditFocus
      Left = 68
      Top = 64
      Width = 104
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'FID_NUMDOC'
      DataSource = dtsCluFid
      Enabled = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeEspDoc: TDBEditFocus
      Left = 223
      Top = 64
      Width = 30
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'FID_ESPDOC'
      DataSource = dtsCluFid
      Enabled = False
      MaxLength = 2
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfabetico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 307
      Top = 64
      Width = 39
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FID_CODEMP'
      DataSource = dtsCluFid
      MaxLength = 3
      TabOrder = 4
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 347
      Top = 64
      Width = 169
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
      ParentFont = False
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCreDeb: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 110
      Width = 29
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FID_CREDEB'
      DataSource = dtsCluFid
      MaxLength = 1
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeQtdPto: TDBEditFocus
      Tag = 99
      Left = 414
      Top = 110
      Width = 102
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FID_QTDPTO'
      DataSource = dtsCluFid
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeObserv001: TDBMemoFocus
      Left = 68
      Top = 133
      Width = 448
      Height = 89
      DataField = 'FID_OBS001'
      DataSource = dtsCluFid
      TabOrder = 8
      OnKeyPress = dbeObserv001KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object grpDadosBaixa: TGroupBox
      Left = 66
      Top = 228
      Width = 450
      Height = 61
      Caption = 'Dados da Baixa:'
      TabOrder = 11
      object Label6: TLabel
        Left = 8
        Top = 16
        Width = 67
        Height = 14
        Caption = 'Data da Baixa'
        FocusControl = dbeDtaBai
      end
      object Label7: TLabel
        Left = 101
        Top = 16
        Width = 68
        Height = 14
        Caption = 'Hora da Baixa'
        FocusControl = dbeHraBai
      end
      object Label8: TLabel
        Left = 194
        Top = 16
        Width = 46
        Height = 14
        Caption = 'Operador'
        FocusControl = dbeCodOpe
      end
      object dbeDtaBai: TDBEditFocus
        Left = 8
        Top = 31
        Width = 87
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FID_DTABAI'
        DataSource = dtsCluFid
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeHraBai: TDBEditFocus
        Left = 101
        Top = 31
        Width = 87
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FID_HRABAI'
        DataSource = dtsCluFid
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeCodOpe: TDBEditFocus
        Left = 194
        Top = 31
        Width = 46
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FID_CODOPE'
        DataSource = dtsCluFid
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object edtNomeOperador: TEditFocus
        Left = 241
        Top = 31
        Width = 206
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
        ParentFont = False
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
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 0
  end
  object dtsCluFid: TDataSource
    Left = 640
    Top = 8
  end
end
