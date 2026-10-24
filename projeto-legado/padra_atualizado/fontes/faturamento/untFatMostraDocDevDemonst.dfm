inherited frmFatMostraDocDevDemonst: TfrmFatMostraDocDevDemonst
  Width = 832
  Caption = 'Documentos para Devolu'#231#227'o de Demonstra'#231#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 832
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 433
    Width = 826
    TabOrder = 4
    ExplicitTop = 433
    ExplicitWidth = 826
  end
  inherited pgcDados: TPageControl
    Top = 74
    Width = 571
    Height = 359
    ActivePage = nil
    TabOrder = 2
    ExplicitTop = 74
    ExplicitWidth = 571
    ExplicitHeight = 359
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 563
      ExplicitHeight = 349
    end
  end
  object dbgDocume: TDBGridCitel [3]
    Left = 0
    Top = 74
    Width = 571
    Height = 359
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgDocumeDrawColumnCell
    OnKeyDown = dbgDocumeKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DTAENT'
        Title.Alignment = taCenter
        Title.Caption = 'Data Emiss'#227'o'
        Width = 85
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CLAFIS'
        Title.Alignment = taCenter
        Title.Caption = 'C.F.O.P.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMCLI'
        Title.Caption = 'Cliente'
        Width = 316
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vlr.Total'
        Width = 67
        Visible = True
      end>
  end
  object pnlBotao: TPanel [4]
    Left = 0
    Top = 433
    Width = 826
    Height = 28
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object btnMarTud: TBitBtnLocked
      Left = 264
      Top = 2
      Width = 137
      Height = 22
      Caption = '[ F7 ] Marca Tudo'
      TabOrder = 2
      OnClick = btnMarTudClick
    end
    object btnDesTud: TBitBtnLocked
      Left = 402
      Top = 2
      Width = 137
      Height = 22
      Caption = '[ F8 ] Desmarca Tudo'
      TabOrder = 3
      OnClick = btnDesTudClick
    end
    object btnSelDoc: TBitBtnLocked
      Left = 111
      Top = 2
      Width = 153
      Height = 22
      Caption = '[ ENTER ] Marca / Desmarca'
      TabOrder = 1
      OnClick = btnSelDocClick
    end
    object btnSairConf: TBitBtnLocked
      Left = 707
      Top = 2
      Width = 111
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 4
      OnClick = btnSairConfClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 2
      Width = 107
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  object pnlInformativos: TPanel [5]
    Left = 571
    Top = 74
    Width = 255
    Height = 359
    Align = alRight
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object Label16: TLabel
      Left = 2
      Top = 2
      Width = 251
      Height = 19
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'SELECIONADO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 244
    end
    object Label6: TLabel
      Left = 18
      Top = 27
      Width = 94
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Documento(s):'
    end
    object Label12: TLabel
      Left = 58
      Top = 50
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total:'
    end
    object edtQtdDocSel: TEditFocus
      Left = 114
      Top = 23
      Width = 72
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotGerSel: TEditFocus
      Left = 114
      Top = 46
      Width = 72
      Height = 22
      TabStop = False
      Alignment = taRightJustify
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
    object GroupBox1: TGroupBox
      Left = 14
      Top = 73
      Width = 226
      Height = 52
      Caption = 'Legenda de cores'
      TabOrder = 2
      object Shape3: TShape
        Left = 8
        Top = 18
        Width = 14
        Height = 13
        Brush.Color = clBlue
        Pen.Color = clBlue
      end
      object Label10: TLabel
        Left = 26
        Top = 18
        Width = 127
        Height = 14
        Caption = 'Documentos selecionados'
      end
      object Shape4: TShape
        Left = 8
        Top = 33
        Width = 14
        Height = 13
        Brush.Color = clBlack
      end
      object Label13: TLabel
        Left = 26
        Top = 33
        Width = 148
        Height = 14
        Caption = 'Documentos n'#227'o selecionados'
      end
    end
  end
  object pnlFiltros: TPanel [6]
    Left = 0
    Top = 0
    Width = 826
    Height = 74
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label18: TLabel
      Left = 9
      Top = 34
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label19: TLabel
      Left = 90
      Top = 34
      Width = 21
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp:'
    end
    object Label15: TLabel
      Left = 131
      Top = 34
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 196
      Top = 50
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #225
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 219
      Top = 34
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 9
      Top = 0
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 7
      Top = 47
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 90
      Top = 47
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 129
      Top = 47
      Width = 71
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 218
      Top = 47
      Width = 72
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodCli: TEditFocus
      Left = 7
      Top = 13
      Width = 81
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomCli: TEditFocus
      Left = 90
      Top = 13
      Width = 481
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Width = 826
    TabOrder = 3
    ExplicitWidth = 826
    inherited pnlNomeForm: TPanel
      Left = 655
      ExplicitLeft = 655
    end
    inherited pnlInfo: TPanel
      Width = 655
      ExplicitWidth = 655
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 456
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 120
  end
  object dtsDocume: TDataSource
    Left = 352
    Top = 128
  end
end
