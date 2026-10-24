inherited frmEntConferenciaCompexPM260: TfrmEntConferenciaCompexPM260
  Width = 246
  Height = 280
  Caption = 'Confer'#234'ncia de Entrada'
  OnDestroy = FormDestroy
  ExplicitWidth = 246
  ExplicitHeight = 280
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 207
    Width = 240
    TabOrder = 4
    ExplicitTop = 207
    ExplicitWidth = 238
    inherited FlwBotoes: TFlowPanel
      Width = 201
      TabOrder = 4
    end
    inherited btnSair: TBitBtnLocked
      Left = 203
      Top = 2
      Width = 35
      Height = 24
      Align = alRight
      Caption = '&Sair'
      Glyph.Data = {00000000}
      ModalResult = 0
      TabOrder = 3
      ExplicitLeft = 195
      ExplicitWidth = 35
    end
    object btnExcluir: TBitBtnLocked
      Left = 131
      Top = 3
      Width = 63
      Height = 22
      Caption = '[F8] Excluir'
      Enabled = False
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnExcluirClick
    end
    object btnQuantidade: TBitBtnLocked
      Left = 74
      Top = 3
      Width = 55
      Height = 22
      Caption = '[F6] Qtd'
      Enabled = False
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnQuantidadeClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 3
      Width = 71
      Height = 22
      Caption = '[F10] Finaliza'
      Enabled = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  object pnlDigitador: TPanel [2]
    Left = 0
    Top = 0
    Width = 240
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 238
    object lblDigita: TLabel
      Left = 16
      Top = 9
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digit:'
    end
    object edtSenDig: TEditFocus
      Tag = 99
      Left = 42
      Top = 5
      Width = 57
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
      Left = 101
      Top = 5
      Width = 128
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
  object pnlItens: TPanel [3]
    Left = 0
    Top = 63
    Width = 240
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    Enabled = False
    TabOrder = 2
    ExplicitWidth = 238
    object Label1: TLabel
      Left = 90
      Top = 4
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Prod:'
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
      Left = 6
      Top = 4
      Width = 20
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 119
      Top = 0
      Width = 110
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
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 29
      Top = 0
      Width = 57
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      MaxLength = 10
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
  object pnlPedido: TPanel [4]
    Left = 0
    Top = 30
    Width = 240
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    ExplicitWidth = 238
    object lblTipoDoc: TLabel
      Left = 5
      Top = 14
      Width = 21
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ped:'
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 29
      Top = 6
      Width = 78
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnEnter = edtNumPedEnter
      OnKeyPress = edtNumPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtLisPed: TEditFocus
      Left = 109
      Top = 6
      Width = 120
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
  object dbgConsulta: TDBGridCitel [5]
    Left = 0
    Top = 90
    Width = 240
    Height = 117
    Align = alClient
    DataSource = dtsConsulta
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
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
        FieldName = 'ITE_QTDCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 80
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 235
    Width = 240
    TabOrder = 5
    Visible = False
    ExplicitTop = 235
    ExplicitWidth = 238
    inherited pnlNomeForm: TPanel
      Left = 69
      ExplicitLeft = 67
    end
    inherited pnlInfo: TPanel
      Width = 69
      ExplicitWidth = 67
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 16
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 72
    Top = 136
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 80
    Top = 168
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 112
    Top = 168
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    AfterClose = cdsConsultaAfterClose
    AfterScroll = cdsConsultaAfterScroll
    Left = 144
    Top = 168
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 176
    Top = 168
  end
end
