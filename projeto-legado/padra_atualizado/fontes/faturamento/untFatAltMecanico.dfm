inherited frmFatAltMecanico: TfrmFatAltMecanico
  Width = 585
  Height = 530
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o de Mec'#226'nico do Documento de Venda'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 585
  ExplicitHeight = 530
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 328
    Width = 579
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 180
  end
  inherited pnlBotoes: TPanel
    Top = 438
    Width = 579
    ExplicitTop = 438
    ExplicitWidth = 579
    inherited FlwBotoes: TFlowPanel
      Width = 575
    end
  end
  inherited pgcDados: TPageControl
    Left = 760
    Top = 8
    Width = 65
    Height = 29
    Align = alNone
    Visible = False
    ExplicitLeft = 760
    ExplicitTop = 8
    ExplicitWidth = 65
    ExplicitHeight = 29
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 57
      ExplicitHeight = 19
    end
  end
  object pnlTopo: TPanel [4]
    Left = 0
    Top = 0
    Width = 579
    Height = 172
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 6
      Top = 3
      Width = 54
      Height = 14
      Caption = 'Documento'
    end
    object Label4: TLabel
      Left = 97
      Top = 3
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
    end
    object lblEmpresa: TLabel
      Left = 141
      Top = 3
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
    object Bevel1: TBevel
      Left = 0
      Top = 38
      Width = 633
      Height = 10
      Shape = bsBottomLine
    end
    object Label2: TLabel
      Left = 6
      Top = 51
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 6
      Top = 91
      Width = 80
      Height = 14
      Caption = 'Data de emiss'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 103
      Top = 91
      Width = 116
      Height = 14
      Caption = 'Condi'#231#227'o de Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 6
      Top = 131
      Width = 47
      Height = 14
      Caption = 'Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 6
      Top = 17
      Width = 89
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
      Left = 97
      Top = 17
      Width = 42
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
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 141
      Top = 17
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 183
      Top = 17
      Width = 385
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCliente: TEditFocus
      Left = 6
      Top = 65
      Width = 562
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDtaEmi: TEditFocus
      Left = 6
      Top = 105
      Width = 91
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCndPag: TEditFocus
      Left = 103
      Top = 105
      Width = 465
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtVendedor: TEditFocus
      Left = 6
      Top = 145
      Width = 562
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgItens: TDBGridCitel [5]
    Left = 0
    Top = 172
    Width = 579
    Height = 156
    Align = alTop
    BorderStyle = bsNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnMouseMove = dbgItensMouseMove
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DET_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 395
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNI_SIGUNI'
        Title.Caption = 'Un.'
        Width = 29
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_QTDITE'
        Title.Caption = 'Qtde.'
        Width = 74
        Visible = True
      end>
  end
  object pnlBotton: TPanel [6]
    Left = 0
    Top = 438
    Width = 579
    Height = 47
    Align = alBottom
    BevelOuter = bvNone
    Color = 11579568
    ParentBackground = False
    TabOrder = 5
    DesignSize = (
      579
      47)
    object Label7: TLabel
      Left = 6
      Top = 16
      Width = 441
      Height = 14
      Caption = 
        'Pressione [ENTER] para Alterar um mec'#226'nico, [INSERT] para inclui' +
        'r ou [DELETE] para excluir.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 6
      Top = 2
      Width = 284
      Height = 14
      Caption = 'Pressione [Ctrl+1] ou [Ctrl + 2] para Alternar entre os Grids.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 6
      Top = 31
      Width = 425
      Height = 14
      Caption = 
        'Pressione [Ctrl + ENTER] para deixar todos os produtos com os me' +
        'c'#226'nicos do item atual.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnConfirma: TBitBtnLocked
      Left = 484
      Top = 23
      Width = 88
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Confirma'
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
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  object dbgMec: TDBGridCitel [7]
    Left = 0
    Top = 331
    Width = 579
    Height = 107
    Align = alClient
    BorderStyle = bsNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 6
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnMouseMove = dbgItensMouseMove
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DET_CODMEC'
        Title.Caption = 'C'#243'digo'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPE_NOMOPE'
        Title.Caption = 'Mec'#226'nico'
        Width = 505
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 485
    Width = 579
    ExplicitTop = 485
    ExplicitWidth = 579
    inherited pnlNomeForm: TPanel
      Left = 408
      ExplicitLeft = 408
    end
    inherited pnlInfo: TPanel
      Width = 408
      ExplicitWidth = 408
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 864
    Top = 65512
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 832
    Top = 65512
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 800
    Top = 65512
  end
end
