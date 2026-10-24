inherited frmCadIdentificacaoImpressora: TfrmCadIdentificacaoImpressora
  Left = 299
  Top = 188
  Width = 869
  Height = 502
  BorderIcons = [biSystemMenu]
  Caption = 'Identifica'#231#227'o das Impressoras'
  Position = poMainFormCenter
  ExplicitWidth = 869
  ExplicitHeight = 502
  PixelsPerInch = 96
  TextHeight = 14
  object dbgIdeImp: TDBGridCitel [0]
    Left = 0
    Top = 44
    Width = 863
    Height = 308
    Align = alClient
    DataSource = dtsIdeImp
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgIdeImpKeyDown
    CorZebra = clMoneyGreen
    Zebra = True
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'IDE_EXPRES'
        Title.Caption = 'Express'#245'es para identifica'#231#227'o das impressoras'
        Width = 801
        Visible = True
      end>
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 0
    Width = 863
    Height = 44
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label3: TLabel
      Left = 10
      Top = 17
      Width = 155
      Height = 14
      Caption = '** Express'#227'o para Identifica'#231#227'o:'
    end
    object btnInserir: TBitBtnLocked
      Left = 623
      Top = 9
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
      TabOrder = 1
      OnClick = btnInserirClick
    end
    object edtExpressao: TEditFocus
      Tag = 99
      Left = 168
      Top = 11
      Width = 450
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 200
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlBotoes: TPanel
    Top = 352
    Width = 863
    ExplicitTop = 352
    ExplicitWidth = 863
    inherited FlwBotoes: TFlowPanel
      Width = 859
      ExplicitTop = 2
      ExplicitWidth = 859
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 5
    ActivePage = nil
    Align = alNone
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 5
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  inherited pnlStatus: TPanel
    Top = 457
    Width = 863
    ExplicitTop = 457
    ExplicitWidth = 863
    inherited pnlNomeForm: TPanel
      Left = 692
      ExplicitLeft = 692
    end
    inherited pnlInfo: TPanel
      Width = 692
      ExplicitWidth = 692
    end
  end
  object FlowPanel1: TFlowPanel [6]
    Left = 0
    Top = 352
    Width = 863
    Height = 105
    Align = alBottom
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 6
    StyleElements = []
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 323
      Height = 16
      Caption = '** Montar uma express'#227'o utilizando a palavra reservada '
    end
    object Label2: TLabel
      Left = 324
      Top = 1
      Width = 145
      Height = 16
      Caption = '"NOME_IMPRESSORA"'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 469
      Top = 1
      Width = 93
      Height = 16
      Caption = 'combinada com '
    end
    object Label5: TLabel
      Left = 562
      Top = 1
      Width = 25
      Height = 16
      Caption = '"%"'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 587
      Top = 1
      Width = 267
      Height = 16
      Caption = 'para criar formas de identificar as impressoras'
    end
    object Label7: TLabel
      Left = 1
      Top = 17
      Width = 593
      Height = 16
      Caption = 
        '    mesmo quando a mesma esteja em outra esta'#231#227'o de rede e/ou se' +
        'ja uma impressora redirecionada.'
    end
    object Label8: TLabel
      Left = 1
      Top = 33
      Width = 444
      Height = 16
      Caption = 
        '    Por exemplo, caso deseje imprimir em uma impressora cadastra' +
        'da como '
    end
    object Label9: TLabel
      Left = 445
      Top = 33
      Width = 98
      Height = 16
      Caption = '"IMP_PEDIDOS"'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 543
      Top = 33
      Width = 283
      Height = 16
      Caption = ' por'#233'm no windows o nome da impressora esteja'
    end
    object Label11: TLabel
      Left = 1
      Top = 49
      Width = 328
      Height = 16
      Caption = '    "IMP_PEDIDOS em estacao-caixa1 (2 redirecionada)"'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 329
      Top = 49
      Width = 165
      Height = 16
      Caption = ' podemos criar a express'#227'o '
    end
    object Label13: TLabel
      Left = 494
      Top = 49
      Width = 285
      Height = 16
      Caption = '"NOME_IMPRESSORA em % (% redirecionada)"'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 1
      Top = 65
      Width = 605
      Height = 16
      Caption = 
        '    que o sistema ser'#225' capaz de identificar esta impressora e ut' +
        'ilizar a mesma para realizar a impress'#227'o.'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 304
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 488
    Top = 336
  end
  object dtsIdeImp: TDataSource
    Left = 384
    Top = 336
  end
end
