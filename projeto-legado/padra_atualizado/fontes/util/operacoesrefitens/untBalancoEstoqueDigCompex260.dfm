inherited frmBalancoEstoqueDigCompex260: TfrmBalancoEstoqueDigCompex260
  Width = 245
  Height = 280
  Caption = 'Balan'#231'o de Estoque - Digita'#231#227'o Manual'
  OnDestroy = FormDestroy
  ExplicitWidth = 245
  ExplicitHeight = 280
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 209
    Width = 239
    TabOrder = 3
    ExplicitTop = 209
    ExplicitWidth = 239
    inherited FlwBotoes: TFlowPanel
      Left = 144
      Width = 10
      TabOrder = 3
      ExplicitLeft = 144
      ExplicitWidth = 10
      inherited btnConfirma: TBitBtnLocked
        Width = 33
        Enabled = False
        Glyph.Data = {00000000}
        ModalResult = 0
        Visible = False
        ExplicitWidth = 33
      end
    end
    object btnEcxluir: TBitBtnLocked [1]
      Left = 85
      Top = 2
      Width = 59
      Height = 22
      Align = alLeft
      Caption = '[F8] Excluir'
      Enabled = False
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnEcxluirClick
    end
    object btnQuantidade: TBitBtnLocked [2]
      Left = 2
      Top = 2
      Width = 83
      Height = 22
      Align = alLeft
      Caption = '[F6] Quantidade'
      Enabled = False
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnQuantidadeClick
    end
    inherited btnSair: TBitBtnLocked
      Left = 154
      Top = 2
      Width = 83
      Align = alRight
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 2
      ExplicitLeft = 154
      ExplicitTop = 2
      ExplicitWidth = 83
    end
  end
  object pnlItens: TPanel [2]
    Left = 0
    Top = 29
    Width = 239
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    Enabled = False
    TabOrder = 1
    object Label1: TLabel
      Left = 100
      Top = 6
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label3: TLabel
      Left = 374
      Top = 76
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label4: TLabel
      Left = 9
      Top = 6
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantid.:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 142
      Top = 2
      Width = 87
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 20
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSldCon: TEditFocus
      Tag = 99
      Left = 54
      Top = 2
      Width = 42
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      MaxLength = 10
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '###0.000'
    end
  end
  object pnlDigitador: TPanel [3]
    Left = 0
    Top = 0
    Width = 239
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblDigita: TLabel
      Left = 7
      Top = 9
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
    end
    object edtSenDig: TEditFocus
      Tag = 99
      Left = 54
      Top = 5
      Width = 41
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 97
      Top = 5
      Width = 132
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
  object dbgConsulta: TDBGridCitel [4]
    Left = 0
    Top = 56
    Width = 239
    Height = 91
    Align = alClient
    DataSource = dtsConsulta
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgConsultaDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 55
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_SALCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Contagem'
        Width = 61
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 85
        Visible = True
      end>
  end
  object pnlTail: TPanel [5]
    Left = 0
    Top = 147
    Width = 239
    Height = 62
    Align = alBottom
    BevelOuter = bvNone
    Enabled = False
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object rdgMostrar: TRadioGroup
      Left = 4
      Top = 0
      Width = 225
      Height = 56
      Caption = 'Mostrar'
      ItemIndex = 1
      Items.Strings = (
        'todos com saldo de contagem '
        'apenas os digitados agora')
      TabOrder = 0
      OnClick = rdgMostrarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 235
    Width = 239
    TabOrder = 5
    Visible = False
    ExplicitTop = 235
    ExplicitWidth = 239
    inherited pnlNomeForm: TPanel
      Left = 68
      ExplicitLeft = 68
    end
    inherited pnlInfo: TPanel
      Width = 68
      ExplicitWidth = 68
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 96
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 16
    Top = 104
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 48
    Top = 104
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 80
    Top = 104
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 112
    Top = 104
  end
end
