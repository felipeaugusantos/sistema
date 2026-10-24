inherited frmExpFunBosh: TfrmExpFunBosh
  Left = 312
  Top = 283
  Width = 398
  Height = 362
  Caption = 'Exporta'#231#227'o de Arquivo Fun BOSCH'
  OnDestroy = FormDestroy
  ExplicitWidth = 398
  ExplicitHeight = 362
  PixelsPerInch = 96
  TextHeight = 14
  object lblPathExp: TLabel [0]
    Left = 9
    Top = 4
    Width = 147
    Height = 14
    Caption = 'Path para gera'#231#227'o do Arquivo:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 46
    Width = 124
    Height = 14
    Caption = 'Nome do Arquivo Destino:'
  end
  object Label3: TLabel [2]
    Left = 8
    Top = 84
    Width = 117
    Height = 14
    Caption = 'Arquivo de Autoriza'#231#227'o:'
  end
  object Label4: TLabel [3]
    Left = 8
    Top = 222
    Width = 123
    Height = 14
    Caption = 'Linha / Grupo (Exclus'#227'o):'
  end
  inherited pnlBotoes: TPanel
    Top = 289
    Width = 392
    TabOrder = 9
    ExplicitTop = 289
    ExplicitWidth = 392
    DesignSize = (
      392
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 388
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 308
      ExplicitLeft = 308
    end
    object btnGravar: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Gerar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnGravarClick
    end
  end
  object grbPeridoBaixa: TGroupBox [6]
    Left = 7
    Top = 159
    Width = 182
    Height = 56
    Caption = 'Per'#237'odo de Emiss'#227'o'
    TabOrder = 4
    object Label1: TLabel
      Left = 85
      Top = 32
      Width = 6
      Height = 14
      Caption = #224
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 24
      Width = 76
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 95
      Top = 24
      Width = 78
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  object pgbProgresso: TProgressBar [7]
    Left = 0
    Top = 273
    Width = 392
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 8
  end
  object rgpPessoa: TRadioGroup [8]
    Left = 192
    Top = 159
    Width = 188
    Height = 56
    Caption = 'Pessoa'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Todos'
      'F'#237'sica'
      'Jur'#237'dica')
    TabOrder = 5
  end
  inline fraPatArq: TfraDirectoryEditFocus [9]
    Tag = 99
    Left = 8
    Top = 20
    Width = 372
    Height = 24
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 20
    ExplicitWidth = 372
    ExplicitHeight = 24
    inherited edtDirectory: TEditFocus
      Width = 347
      Height = 22
    end
    inherited btnOpenDirectory: TcxButton
      Left = 349
      Height = 24
    end
  end
  object edtArqAut: TFilenameEditFocus [10]
    Tag = 99
    Left = 8
    Top = 100
    Properties.Buttons = <
      item
        Default = True
        Glyph.SourceDPI = 96
        Glyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000004020FF406040FF406040FF4060
          40FF004020FF0000000000000000000000000000000000000000806040FFC080
          60FFC06060FFC0A080FFA4A0A0FF408060FF40A080FF40C080FF40C080FF40C0
          80FF40A060FF408060FF00000000000000000000000000000000C08060FFFFFF
          FFFFFFFFFFFFC0DCC0FF408060FF40C0A0FF40C0A0FF40A060FF408060FF40A0
          60FF40C0A0FF40C080FF408060FF000000000000000000000000C08060FFFFFF
          FFFFF0FBFFFF80A0A0FF40C0A0FF40E0A0FF40C0A0FF408060FFFFFFFFFF4080
          60FF40E0A0FF40C0A0FF40A080FF004040FF0000000000000000C08060FFFFFF
          FFFFF0FBFFFF40A080FF80E0C0FF40A080FF408060FF408060FFF0FBFFFF4080
          60FF408060FF40A080FF40C0A0FF408060FF0000000000000000C08060FFFFFF
          FFFFFFFFFFFF40A060FF80E0C0FF408060FFC0DCC0FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF408060FF40E0A0FF408060FF0000000000000000C08060FFFFFF
          FFFFFFFFFFFF40A080FFC0DCC0FF80A080FF408060FF408060FFFFFFFFFF4080
          60FF408060FF40A080FF80E0C0FF408060FF0000000000000000C08080FFFFFF
          FFFFFFFFFFFF80C0A0FF80C0C0FFF0FBFFFFF0FBFFFF40A080FFF0FBFFFF40A0
          80FFC0DCC0FFC0DCC0FF80C0A0FF406040FF0000000000000000C08080FFFFFF
          FFFFFFFFFFFFF0FBFFFF40A080FFC0DCC0FFF0FBFFFF80C0A0FF40A080FF80A0
          A0FFF0FBFFFFC0DCC0FF40A080FF000000000000000000000000C08080FFFFFF
          FFFFFFFFFFFFFFFFFFFFC0DCC0FF40A080FF80C0C0FFF0FBFFFFF0FBFFFFF0FB
          FFFF80C0C0FF40A080FF004020FF000000000000000000000000C08080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFF80C0C0FF40C080FF40A080FF40C0
          80FF80C0C0FFC0C0C0FF00000000000000000000000000000000C0A080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC0A080FF00000000000000000000000000000000C0A080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC08080FF00000000000000000000000000000000C0A080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC0A080FF00000000000000000000000000000000808060FFC0A0
          80FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A0
          80FFC0A080FF808060FF000000000000000000000000}
        Kind = bkGlyph
      end>
    StyleFocused.Color = clInfoBk
    TabOrder = 2
    Width = 372
  end
  inherited pnlStatus: TPanel [11]
    Top = 317
    Width = 392
    TabOrder = 10
    ExplicitTop = 317
    ExplicitWidth = 392
    inherited pnlNomeForm: TPanel
      Left = 221
      ExplicitLeft = 221
    end
    inherited pnlInfo: TPanel
      Width = 221
      ExplicitWidth = 221
    end
  end
  object edtNomArq: TEditFocus [12]
    Tag = 99
    Left = 8
    Top = 60
    Width = 372
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskLinGru: TMaskEditFocus [13]
    Tag = 99
    Left = 8
    Top = 239
    Width = 48
    Height = 22
    CharCase = ecUpperCase
    EditMask = '999.999;0;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    TabOrder = 6
    Text = ''
    OnExit = mskLinGruExit
    OnKeyPress = mskLinGruKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtDesGru: TEditFocus [14]
    Left = 59
    Top = 239
    Width = 321
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 7
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object chkIgnCnp: TCheckBox [15]
    Left = 4
    Top = 133
    Width = 373
    Height = 17
    Caption = 
      'Utilizar apenas a chave do arquivo de autoriza'#231#227'o, ignorando os ' +
      'CNPJS?'
    TabOrder = 3
  end
  inherited mnuAuxiliar: TPopupMenu [16]
    Left = 296
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents [17]
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade [18]
  end
end
