inherited frmCfgEveNec: TfrmCfgEveNec
  Left = 299
  Top = 188
  Width = 490
  Height = 437
  BorderIcons = [biSystemMenu]
  Caption = 'Eventos que n'#227'o ser'#227'o exportados para a Contabilidade'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 490
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 392
    Width = 484
    ExplicitTop = 392
    ExplicitWidth = 484
    inherited FlwBotoes: TFlowPanel
      Width = 480
      ExplicitTop = 2
      ExplicitWidth = 480
    end
  end
  inherited pgcDados: TPageControl
    Align = alNone
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  inherited pnlStatus: TPanel
    Top = 392
    Width = 484
    ExplicitTop = 392
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
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 484
    Height = 60
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
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
      TabOrder = 1
      OnClick = btnInserirClick
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 0
      Top = 4
      Width = 387
      Height = 46
      TabOrder = 0
      ExplicitTop = 4
      ExplicitWidth = 387
      ExplicitHeight = 46
      inherited lblEventos: TLabel
        Top = 3
        Width = 87
        Height = 14
        ExplicitTop = 3
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Left = 5
        Top = 20
        Height = 22
        OnExit = fraCentroCustoedtCodEveExit
        OnKeyPress = fraCentroCustoedtCodEveKeyPress
        ExplicitLeft = 5
        ExplicitTop = 20
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 61
        Top = 20
        Width = 321
        Height = 22
        ExplicitLeft = 61
        ExplicitTop = 20
        ExplicitWidth = 321
        ExplicitHeight = 22
      end
    end
  end
  object dbgEventos: TDBGridCitel [5]
    Left = 0
    Top = 60
    Width = 484
    Height = 332
    Align = alClient
    DataSource = dtsEveNec
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgEventosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ENE_CODEVE'
        Title.Caption = 'C'#243'digo'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EVE_DESEVE'
        Title.Caption = 'Centro de Custo'
        Width = 366
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 348
    Top = 20
  end
  object dtsEveNec: TDataSource
    Left = 256
    Top = 160
  end
end
