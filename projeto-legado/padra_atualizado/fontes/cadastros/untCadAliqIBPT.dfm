inherited frmCadAliqIBPT: TfrmCadAliqIBPT
  Width = 537
  Height = 223
  Caption = 'Cadastro de Al'#237'quotas IBPT - Lei 12741'
  ExplicitWidth = 537
  ExplicitHeight = 223
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 134
    Width = 531
    Height = 44
    ExplicitTop = 149
    ExplicitWidth = 531
    ExplicitHeight = 44
    inherited FlwBotoes: TFlowPanel
      Width = 527
      Height = 40
      ExplicitLeft = 6
      ExplicitTop = -14
      ExplicitWidth = 527
      ExplicitHeight = 40
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
      object btnImportarPlanilha: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 148
        Height = 20
        Anchors = [akRight, akBottom]
        Caption = 'I&mportar de Planilha    '
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
          00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000097A7
          76FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A7
          76FF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
          76FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFFFFFFFFFFFFFF97A776FFFFFF
          FFFFFFFFFFFFC1CAADFF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
          76FFFFFFFFFFC1CAADFFFFFFFFFF97A776FFFFFFFFFF97A776FF97A776FF97A7
          76FF97A776FFFFFFFFFF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
          76FFC1CAADFFFFFFFFFFC1CAADFF97A776FFFFFFFFFF97A776FF97A776FFC1CA
          ADFFFFFFFFFFC1CAADFF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
          76FFFFFFFFFFC1CAADFFFFFFFFFF97A776FFFFFFFFFF97A776FF97A776FFFFFF
          FFFF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
          76FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FF97A776FFC1CA
          ADFFFFFFFFFFFFFFFFFF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
          76FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A7
          76FF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF000000000000
          00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
          00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF}
        TabOrder = 6
        OnClick = btnImportarPlanilhaClick
        ExplicitLeft = 444
        ExplicitTop = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 447
      Width = 70
      Height = 20
      ExplicitLeft = 447
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 178
    Width = 531
    ExplicitTop = 135
    ExplicitWidth = 531
    inherited pnlNomeForm: TPanel
      Left = 363
      Width = 168
      ExplicitLeft = 363
      ExplicitWidth = 168
    end
    inherited pnlInfo: TPanel
      Width = 363
      ExplicitWidth = 363
    end
  end
  inherited pgcDados: TPageControl
    Width = 531
    Height = 134
    ExplicitWidth = 531
    ExplicitHeight = 110
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 523
      ExplicitHeight = 78
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 531
    Height = 134
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    ExplicitLeft = -8
    ExplicitTop = -24
    object Label1: TLabel
      Left = 16
      Top = 35
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'NCM:'
    end
    object Label18: TLabel
      Left = 244
      Top = 11
      Width = 189
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tributa'#231#227'o Federal para Nacionais (%):'
    end
    object Label2: TLabel
      Left = 238
      Top = 35
      Width = 195
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tributa'#231#227'o Federal para Importados (%):'
    end
    object Label3: TLabel
      Left = 25
      Top = 11
      Width = 16
      Height = 14
      Alignment = taRightJustify
      Caption = 'UF:'
    end
    object Label4: TLabel
      Left = 25
      Top = 59
      Width = 16
      Height = 14
      Alignment = taRightJustify
      Caption = 'EX:'
    end
    object Label5: TLabel
      Left = 314
      Top = 59
      Width = 119
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tributa'#231#227'o Estadual (%):'
    end
    object Label6: TLabel
      Left = 311
      Top = 83
      Width = 122
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tributa'#231#227'o Municipal (%):'
    end
    object dbeNCM: TDBEditFocus
      Tag = 99
      Left = 43
      Top = 32
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IBP_N_C_M_'
      DataSource = dtsCadIBP
      TabOrder = 1
      OnKeyPress = dbeNCMKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeAlqNac: TDBEditFocus
      Tag = 99
      Left = 439
      Top = 8
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IBP_ALQNAC'
      DataSource = dtsCadIBP
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeAlqImp: TDBEditFocus
      Tag = 99
      Left = 439
      Top = 32
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IBP_ALQIMP'
      DataSource = dtsCadIBP
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeEstado: TDBEditFocus
      Tag = 99
      Left = 43
      Top = 8
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IBP_ESTADO'
      DataSource = dtsCadIBP
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbee_x___: TDBEditFocus
      Tag = 99
      Left = 43
      Top = 55
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IBP_E_X___'
      DataSource = dtsCadIBP
      MaxLength = 3
      TabOrder = 2
      OnExit = dbee_x___Exit
      OnKeyPress = dbee_x___KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeAlqEst: TDBEditFocus
      Tag = 99
      Left = 439
      Top = 56
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IBP_ALQEST'
      DataSource = dtsCadIBP
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeAlqMun: TDBEditFocus
      Tag = 99
      Left = 439
      Top = 80
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IBP_ALQMUN'
      DataSource = dtsCadIBP
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 168
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 136
    Top = 65528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 65528
  end
  object dtsCadIBP: TDataSource
    Left = 200
    Top = 65528
  end
end
