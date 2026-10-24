inherited frmCfgAdquirentesUsaNsuHost: TfrmCfgAdquirentesUsaNsuHost
  Width = 326
  Height = 349
  Caption = 'Adquirentes que Usam NSU Host'
  OnDestroy = FormDestroy
  ExplicitWidth = 326
  ExplicitHeight = 349
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 304
    Width = 320
    ExplicitTop = 304
    ExplicitWidth = 320
    inherited FlwBotoes: TFlowPanel
      Width = 316
      ExplicitTop = 2
      ExplicitWidth = 316
    end
  end
  inherited pgcDados: TPageControl
    Top = 60
    Width = 320
    Height = 244
    Visible = False
    ExplicitTop = 60
    ExplicitWidth = 320
    ExplicitHeight = 244
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 312
      ExplicitHeight = 212
    end
  end
  inherited pnlStatus: TPanel
    Top = 304
    Width = 320
    ExplicitTop = 304
    ExplicitWidth = 320
    inherited pnlNomeForm: TPanel
      Left = 149
      ExplicitLeft = 149
    end
    inherited pnlInfo: TPanel
      Width = 149
      ExplicitWidth = 149
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 320
    Height = 60
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 55
      Height = 14
      Caption = 'Adiquirente'
    end
    object btnInserir: TBitBtnLocked
      Left = 234
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
      TabOrder = 1
      OnClick = btnInserirClick
    end
    object edtAdquir: TEditFocus
      Tag = 99
      Left = 8
      Top = 23
      Width = 225
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
  object dbgAdquirentes: TDBGridCitel [5]
    Left = 0
    Top = 60
    Width = 320
    Height = 244
    Align = alClient
    DataSource = dtsAdqNsu
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgAdquirentesKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ANS_ADQUIR'
        Title.Caption = 'Adquirentes'
        Width = 272
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 148
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 72
    Top = 196
  end
  object dtsAdqNsu: TDataSource
    Left = 256
    Top = 160
  end
end
