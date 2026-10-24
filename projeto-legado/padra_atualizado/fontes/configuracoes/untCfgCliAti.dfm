inherited frmCfgCliAti: TfrmCfgCliAti
  Left = 299
  Top = 188
  Width = 490
  Height = 437
  BorderIcons = [biSystemMenu]
  Caption = 'Atividades para Cliente Construtora'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 490
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 393
    Width = 484
    ExplicitTop = 393
    ExplicitWidth = 484
  end
  inherited pgcDados: TPageControl
    Width = 651
    Height = 1
    ActivePage = nil
    Align = alNone
    Visible = False
    ExplicitWidth = 651
    ExplicitHeight = 1
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 643
      ExplicitHeight = 429
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 484
    Height = 60
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 45
      Height = 14
      Caption = 'Atividade'
    end
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 8
      Top = 23
      Width = 52
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object btnInserir: TBitBtnLocked
      Left = 393
      Top = 22
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
      TabOrder = 2
      OnClick = btnInserirClick
    end
    object edtDesAti: TEditFocus
      Tag = 99
      Left = 66
      Top = 23
      Width = 321
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
  end
  object dbgAtivid: TDBGridCitel [4]
    Left = 0
    Top = 60
    Width = 484
    Height = 333
    Align = alClient
    DataSource = dtsCliAti
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgAtividKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ATI_CODATI'
        Title.Caption = 'C'#243'digo'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'objCadAti.ATI_DESATI'
        Title.Caption = 'Atividade'
        Width = 366
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 393
    Width = 484
    ExplicitTop = 393
    ExplicitWidth = 484
    inherited pnlNomeForm: TPanel
      Left = 313
      ExplicitLeft = 313
    end
    inherited pnlInfo: TPanel
      Width = 313
      ExplicitWidth = 313
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 384
    Top = 136
  end
  object dtsCliAti: TDataSource
    Left = 256
    Top = 160
  end
end
