inherited frmLogDelecoes: TfrmLogDelecoes
  Left = 192
  Top = 236
  Width = 752
  Height = 490
  ActiveControl = mskDtaIni
  Caption = 'Log de Dele'#231#245'es'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 752
  ExplicitHeight = 490
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 418
    Width = 746
    ExplicitTop = 418
    ExplicitWidth = 746
    object Label2: TLabel [0]
      Left = 9
      Top = 9
      Width = 635
      Height = 14
      Caption = 
        'Clique no t'#237'tulo da coluna para ordenar,  F3 - Muda a ordena'#231#227'o ' +
        'para o pr'#243'ximo campo,   F5 - Abre o campo de busca para digita'#231#227 +
        'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited btnSair: TBitBtnLocked
      Left = 663
      ExplicitLeft = 663
    end
  end
  inherited pnlStatus: TPanel
    Top = 446
    Width = 746
    ExplicitTop = 446
    ExplicitWidth = 746
    inherited pnlNomeForm: TPanel
      Left = 575
      ExplicitLeft = 575
    end
    inherited pnlInfo: TPanel
      Width = 575
      ExplicitWidth = 575
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 746
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    object lblDtaDel: TLabel
      Left = 8
      Top = 16
      Width = 82
      Height = 14
      Caption = 'Data de Dele'#231#227'o:'
    end
    object Label1: TLabel
      Left = 170
      Top = 16
      Width = 6
      Height = 14
      Caption = #224
    end
    object Label3: TLabel
      Left = 260
      Top = 17
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object mskDtaIni: TMaskEditFocus
      Left = 92
      Top = 8
      Width = 73
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Left = 180
      Top = 8
      Width = 73
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodOpe: TEditFocus
      Left = 311
      Top = 8
      Width = 34
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
      OnExit = edtCodOpeExit
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesOpe: TEditFocus
      Left = 346
      Top = 8
      Width = 339
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
  object dbgLogErr: TDBGridCitel [3]
    Left = 0
    Top = 81
    Width = 746
    Height = 337
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgLogErrDrawColumnCell
    OnKeyDown = dbgLogErrKeyDown
    OnTitleClick = dbgLogErrTitleClick
  end
  object pnlPesquisa: TPanel [4]
    Left = 0
    Top = 41
    Width = 746
    Height = 40
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    Visible = False
    object lblPesquisa: TLabel
      Left = 8
      Top = 16
      Width = 70
      Height = 14
      Caption = '&Pesquisar por '
    end
    object lblNomeCampo: TLabel
      Left = 80
      Top = 16
      Width = 73
      Height = 14
      Caption = 'DET_MMMMMM'
    end
    object edtData: TMaskEditFocus
      Left = 160
      Top = 8
      Width = 73
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNumero: TEditFocus
      Left = 232
      Top = 8
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 1
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtString: TEditFocus
      Left = 304
      Top = 8
      Width = 329
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 2
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValor: TEditFocus
      Tag = 99
      Left = 632
      Top = 8
      Width = 77
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,####0.0000'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 288
    Top = 88
  end
end
