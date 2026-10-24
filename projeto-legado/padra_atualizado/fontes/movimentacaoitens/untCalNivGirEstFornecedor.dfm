inherited frmCalNivGirEstFornecedor: TfrmCalNivGirEstFornecedor
  Width = 452
  Height = 485
  Caption = 'C'#225'lculo do N'#237'vel de Giro de Estoque por Fornecedor'
  ExplicitWidth = 452
  ExplicitHeight = 485
  PixelsPerInch = 96
  TextHeight = 14
  object Label5: TLabel [0]
    Left = 9
    Top = 7
    Width = 106
    Height = 14
    Caption = 'Data de Entrada Inicial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel [1]
    Left = 9
    Top = 42
    Width = 102
    Height = 14
    Caption = 'Data de Entrada Final'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object lblEmpresa: TLabel [2]
    Left = 9
    Top = 82
    Width = 42
    Height = 14
    Caption = 'Empresa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel [3]
    Left = 9
    Top = 124
    Width = 56
    Height = 14
    Caption = 'Fornecedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 414
    Width = 446
    TabOrder = 7
    ExplicitTop = 414
    ExplicitWidth = 446
    DesignSize = (
      446
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 442
      TabOrder = 1
      ExplicitWidth = 442
      inherited btnConfirma: TBitBtnLocked
        Width = 94
        Caption = 'NAO USAR'
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
        ModalResult = 0
        NumGlyphs = 1
        Visible = False
        ExplicitWidth = 94
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 363
      TabOrder = 2
      ExplicitLeft = 363
    end
    object btnGravar: TBitBtnLocked
      Left = 5
      Top = 1
      Width = 77
      Height = 22
      Caption = '&Calcular'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF5555555555555C055555
        55555555577FF55555555555CCC05555555555557777F55555555555CCC05555
        555555557777FF555555555CCCCC05555555555777777F55555555CCCCCC0555
        5555557777777FF5555557CC05CCC05555555777757777F555557C05555CC055
        55557775555777FF55555555555CCC05555555555557777F555555555555CC05
        555555555555777FF555555555555CC05555555555555777FF5555555555557C
        05555555555555777FF5555555555557C05555555555555777FF555555555555
        5CC0555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnGravarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 440
    Width = 446
    TabOrder = 8
    ExplicitTop = 440
    ExplicitWidth = 446
    inherited pnlNomeForm: TPanel
      Left = 275
      ExplicitLeft = 275
    end
    inherited pnlInfo: TPanel
      Width = 275
      ExplicitWidth = 275
      object shpMultSel: TShape
        Left = 259
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        Visible = False
      end
    end
  end
  object mskDtaIni: TMaskEditFocus [6]
    Tag = 99
    Left = 9
    Top = 21
    Width = 64
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
  object mskDtaFin: TMaskEditFocus [7]
    Tag = 99
    Left = 9
    Top = 56
    Width = 64
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
  object edtCodEmpresa: TEditFocus [8]
    Tag = 99
    Left = 8
    Top = 96
    Width = 65
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 3
    ParentFont = False
    TabOrder = 2
    OnKeyPress = edtCodEmpresaKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object GroupBox1: TGroupBox [9]
    Left = 8
    Top = 171
    Width = 431
    Height = 48
    Caption = 'Ordem'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object lblOrdemQtdValor: TColorLabel
      Left = 31
      Top = 20
      Width = 100
      Height = 14
      Caption = '(Q)uantidade (V)alor'
      CorDestaque = clRed
    end
    object edtOrdem: TEditFocus
      Tag = 99
      Left = 9
      Top = 17
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'V'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
  end
  object edtDesEmpresa: TEditFocus [10]
    Left = 74
    Top = 96
    Width = 365
    Height = 22
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
  object GroupBox2: TGroupBox [11]
    Left = 7
    Top = 225
    Width = 432
    Height = 94
    Caption = 'N'#237'veis'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 40
      Height = 14
      Caption = 'N'#237'vel A:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 277
      Top = 24
      Width = 81
      Height = 14
      Caption = '% da Curva ABC'
    end
    object Label4: TLabel
      Left = 52
      Top = 70
      Width = 174
      Height = 14
      Caption = 'Produtos que representam acima de'
    end
    object Label7: TLabel
      Left = 8
      Top = 47
      Width = 39
      Height = 14
      Caption = 'N'#237'vel B:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 52
      Top = 47
      Width = 143
      Height = 14
      Caption = 'Produtos que representam de'
    end
    object Label10: TLabel
      Left = 344
      Top = 47
      Width = 81
      Height = 14
      Caption = '% da Curva ABC'
    end
    object Label12: TLabel
      Left = 8
      Top = 70
      Width = 40
      Height = 14
      Caption = 'N'#237'vel C:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 52
      Top = 24
      Width = 146
      Height = 14
      Caption = 'Produtos que representam at'#233
    end
    object Label14: TLabel
      Left = 277
      Top = 70
      Width = 81
      Height = 14
      Caption = '% da Curva ABC'
    end
    object Label15: TLabel
      Left = 277
      Top = 47
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object ceValNiA: TCurrencyEditFocus
      Tag = 99
      Left = 229
      Top = 16
      Margins.Left = 4
      Margins.Top = 1
      AutoSize = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Height = 21
      Width = 44
    end
    object ceValNB1: TCurrencyEditFocus
      Tag = 99
      Left = 229
      Top = 39
      Margins.Left = 4
      Margins.Top = 1
      AutoSize = False
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Height = 21
      Width = 44
    end
    object ceValNiC: TCurrencyEditFocus
      Tag = 99
      Left = 229
      Top = 62
      Margins.Left = 4
      Margins.Top = 1
      AutoSize = False
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Height = 21
      Width = 44
    end
    object ceValNB2: TCurrencyEditFocus
      Tag = 99
      Left = 296
      Top = 39
      Margins.Left = 4
      Margins.Top = 1
      AutoSize = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Height = 21
      Width = 44
    end
  end
  object pgbStatus: TProgressBar [12]
    Left = 0
    Top = 404
    Width = 446
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 10
    Visible = False
  end
  object edtFornecedor: TEditFocus [13]
    Tag = 99
    Left = 9
    Top = 138
    Width = 64
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 3
    OnExit = edtFornecedorExit
    OnKeyPress = edtFornecedorKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttNumerico
  end
  object edtDesFornecedor: TEditFocus [14]
    Left = 74
    Top = 138
    Width = 365
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    TabOrder = 11
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object rdgGerNiv: TRadioGroup [15]
    Left = 8
    Top = 325
    Width = 431
    Height = 65
    Caption = 'Gera'#231#227'o do N'#237'vel'
    ItemIndex = 1
    Items.Strings = (
      'Gerar por fornecedor'
      'Gerar por fornecedor + grupo de produtos')
    TabOrder = 6
  end
end
