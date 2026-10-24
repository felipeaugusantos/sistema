inherited frmConfiguracaoPlanoContasJurosDetalheCTP: TfrmConfiguracaoPlanoContasJurosDetalheCTP
  Width = 621
  Height = 416
  Caption = 'Configura'#231#227'o Plano Contas Juros Detalhe CTP'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 621
  ExplicitHeight = 416
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 343
    Width = 615
    Visible = False
    inherited FlwBotoes: TFlowPanel
      Width = 611
    end
    inherited btnSair: TBitBtnLocked
      Left = 535
    end
  end
  inherited pnlStatus: TPanel
    Top = 371
    Width = 615
    inherited pnlNomeForm: TPanel
      Left = 444
    end
    inherited pnlInfo: TPanel
      Width = 444
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 615
    Height = 60
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    ExplicitLeft = -20
    ExplicitWidth = 484
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 63
      Height = 14
      Caption = 'Plano Contas'
    end
    object btnInserir: TBitBtnLocked
      Left = 473
      Top = 20
      Width = 75
      Height = 25
      Caption = '&Inserir'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnInserirClick
    end
    object edtDesCta: TEditFocus
      Tag = 99
      Left = 66
      Top = 23
      Width = 255
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      MaxLength = 200
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCta: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 23
      Width = 56
      Height = 22
      EditMask = '99.99.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 0
      Text = ''
      OnExit = edtCodCtaExit
      OnKeyPress = edtCodCtaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object rgConsiderar: TRadioGroup
      Left = 322
      Top = 13
      Width = 150
      Height = 32
      Caption = 'Considerar?'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Cadastro'
        'Baixa')
      TabOrder = 2
    end
  end
  object dbgPlanoContas: TDBGridCitel [3]
    Left = 0
    Top = 60
    Width = 615
    Height = 283
    Align = alClient
    DataSource = ds
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgPlanoContasKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'JDT_CODCTA'
        Title.Caption = 'C'#243'digo'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTA_DESCTA'
        Title.Caption = 'Plano Contas'
        Width = 366
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JDT_TPCDPG'
        Title.Caption = 'Considerar?'
        Visible = True
      end>
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 184
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 136
    Top = 120
  end
  object ds: TDataSource
    AutoEdit = False
    Left = 240
    Top = 184
  end
end
