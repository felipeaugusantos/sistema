inherited frmCadInstrucoes: TfrmCadInstrucoes
  Width = 1024
  Height = 700
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Cadastro de Instru'#231#245'es (SQL)'
  WindowState = wsMaximized
  ExplicitLeft = -3
  ExplicitTop = -284
  ExplicitWidth = 1024
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 617
    Width = 1008
    ExplicitTop = 617
    ExplicitWidth = 1008
    object Label13: TLabel [0]
      Left = 602
      Top = 7
      Width = 147
      Height = 14
      Caption = '< Alt + / > Busca Instru'#231#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitTop = 2
      ExplicitWidth = 1004
    end
    inherited btnSair: TBitBtnLocked
      Left = 932
      TabOrder = 2
      ExplicitLeft = 932
    end
    object btnUtiRel: TBitBtnLocked
      Left = 441
      Top = 4
      Width = 155
      Height = 20
      Caption = 'Utilizado nos Relat'#243'rios...'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000002000000090000000C0000000C0000000C0000
        000D0000000D0000000D0000000C000000070000000200000000000000000000
        0000000000000000000000000008975B36FF975B36FF975B36FF975B36FF1563
        40FF156340FF156340FF156340FF0B32208E0000000600000000000000020000
        00090000000E0000000F00000017A96F46FFE9BC7EFFE9BC7EFFC99562FF1D78
        52FF3DD4A3FF3DD4A3FF2DA67AFF1D7852FF0000001200000006000000087C53
        45C0AD725EFFAC725DFFD0B3A9FFA96F46FFE9BC7EFFE9BC7EFFC99562FF1D78
        52FF3DD4A3FF3DD4A3FF2DA67AFF1D7852FF184994FF0C254B8C0000000BAF74
        62FFFDFBF9FFFBF6F2FFF8F5F4FFA96F46FFFFF4C9FFFFF4C9FFEAD3A9FF1D78
        52FFA0FFECFFA0FFECFF80DEC6FF1D7852FF5FB7E5FF215CA7FF0000000BB179
        64FFFDFBFAFFF7EEE7FFFAF4F1FFD5B7A1FFB88158FFB88158FFB88158FF7390
        66FF2CA074FF2CA074FF2CA074FF2CA074FF5FB7E5FF215CA7FF0000000BB37C
        69FFFDFCFBFFF8EFE8FFF9F2EEFFF9F5F2FFF6F1EDFF6A7DDAFFA4BFFFFFA4BF
        FFFF89A4F7FF215CA7FFA8EFFFFFA8EFFFFF84D3F2FF215CA7FF0000000AB57F
        6CFFFEFCFBFFF9F0EAFFF8F0EAFFF8EFE9FFFAF5F2FFB0B8E4FF6A7EDAFF6A7E
        DAFF6A7EDAFF5384D1FF3B8BC7FF3B8BC7FF3B8BC7FF3B8BC7FF00000008BB87
        75FFFEFDFDFFFAF3EFFFFAF4EEFFFAF3EEFFFBF4F1FFFBF7F4FFFCFAF8FFD8BE
        B4FFF2EDEAFFFAF7F5FFD9C0B6FF01010113000000040000000300000007BF8B
        78FFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFFCF9F7FFBA84
        71FFECE4DDFFFBF5F2FFBB8876FF0101010E000000000000000000000006C493
        82FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFDFBF9FFBF8C
        7CFFEFE8E3FFFCF8F5FFBF8E7CFF0101010D000000000000000000000005C497
        85FFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFDFDFFFEFDFCFFC290
        7FFFF0EBE6FFFCF9F7FFC29180FF0101010C0000000000000000000000039672
        65C0C89988FFC99887FFC79887FFC59786FFC79785FFC79784FFC59683FFCDA7
        9AFFF4EFEAFFFDFAF8FFC49686FF0101010B0000000000000000000000010000
        0003000000040000000BD8BBB0FFF8F8F8FFF5F0EFFFF5F0EFFFF5EFEDFFF7F0
        EEFFFAF4F1FFFDFBF9FFC7998AFF0000000A0000000000000000000000000000
        00000000000000000005CCA392FFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFD
        FDFFFEFDFDFFFEFDFCFFCA9D8DFF000000090000000000000000000000000000
        000000000000000000039A7B6FC0CEA495FFCFA494FFCDA494FFCDA392FFCDA3
        91FFCCA291FFCCA290FF97776BC2000000060000000000000000}
      TabOrder = 1
      OnClick = btnUtiRelClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 1008
    Height = 617
    ExplicitWidth = 1008
    ExplicitHeight = 617
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1000
      ExplicitHeight = 585
    end
  end
  inherited pnlStatus: TPanel
    Top = 645
    Width = 1008
    ExplicitTop = 645
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 661
      ExplicitLeft = 661
    end
    inherited pnlInfo: TPanel
      Width = 661
      ExplicitWidth = 661
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 0
    Width = 1008
    Height = 617
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object SpeedButton1: TSpeedButton
      Left = 272
      Top = 216
      Width = 23
      Height = 22
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 1008
      Height = 89
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 0
      object Label1: TLabel
        Left = 22
        Top = 15
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'd.Rel:'
      end
      object Label2: TLabel
        Left = 11
        Top = 39
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object lblSimbol: TLabel
        Left = 22
        Top = 63
        Width = 40
        Height = 14
        Caption = 'S'#237'mbolo:'
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 65
        Top = 35
        Width = 704
        Height = 22
        DataField = 'INS_DESCRI'
        DataSource = dtsRelIns
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSimbol: TDBEditFocus
        Tag = 99
        Left = 65
        Top = 59
        Width = 434
        Height = 22
        CharCase = ecUpperCase
        DataField = 'INS_SIMBOL'
        DataSource = dtsRelIns
        TabOrder = 3
        OnKeyPress = dbeSimbolKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtDesRel: TEditFocus
        Left = 130
        Top = 11
        Width = 412
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodRel: TEditFocus
        Left = 65
        Top = 11
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 0
        OnExit = edtCodRelExit
        OnKeyPress = edtCodRelKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object dbeCodRel: TDBEditFocus
        Tag = 99
        Left = 681
        Top = 11
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'INS_CODREL'
        DataSource = dtsRelIns
        TabOrder = 4
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 89
      Width = 1008
      Height = 41
      Align = alTop
      BevelOuter = bvLowered
      Caption = 'Instru'#231#227'o SQL'
      TabOrder = 2
    end
    object bceINSSQL: TBCEditor
      Left = 0
      Top = 130
      Width = 1008
      Height = 487
      Cursor = crIBeam
      ActiveLine.Indicator.Visible = False
      Align = alClient
      Caret.Options = []
      CodeFolding.Hint.Font.Charset = DEFAULT_CHARSET
      CodeFolding.Hint.Font.Color = clWindowText
      CodeFolding.Hint.Font.Height = -11
      CodeFolding.Hint.Font.Name = 'Courier New'
      CodeFolding.Hint.Font.Style = []
      CodeFolding.Hint.Indicator.Glyph.Visible = False
      CompletionProposal.CloseChars = '()[]. '
      CompletionProposal.Columns = <
        item
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Items = <>
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Courier New'
          Title.Font.Style = []
        end>
      CompletionProposal.SecondaryShortCut = 0
      CompletionProposal.ShortCut = 16416
      CompletionProposal.Trigger.Chars = '.'
      CompletionProposal.Trigger.Enabled = False
      Directories.Colors = 'Colors'
      Directories.Highlighters = 'Highlighters'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      LeftMargin.Font.Charset = DEFAULT_CHARSET
      LeftMargin.Font.Color = 13408665
      LeftMargin.Font.Height = -11
      LeftMargin.Font.Name = 'Courier New'
      LeftMargin.Font.Style = []
      Lines.Strings = (
        '')
      LineSpacing = 0
      MatchingPair.Enabled = True
      Minimap.Font.Charset = DEFAULT_CHARSET
      Minimap.Font.Color = clWindowText
      Minimap.Font.Height = -1
      Minimap.Font.Name = 'Courier New'
      Minimap.Font.Style = []
      OnKeyDown = bceINSSQLKeyDown
      SpecialChars.Style = scsDot
      SyncEdit.ShortCut = 24650
      TabOrder = 1
      TokenInfo.Font.Charset = DEFAULT_CHARSET
      TokenInfo.Font.Color = clWindowText
      TokenInfo.Font.Height = -11
      TokenInfo.Font.Name = 'Courier New'
      TokenInfo.Font.Style = []
      TokenInfo.Title.Font.Charset = DEFAULT_CHARSET
      TokenInfo.Title.Font.Color = clWindowText
      TokenInfo.Title.Font.Height = -11
      TokenInfo.Title.Font.Name = 'Courier New'
      TokenInfo.Title.Font.Style = []
      UndoOptions = [uoGroupUndo]
      WordWrap.Indicator.Bitmap.Data = {
        02020000424D020200000000000042000000280000000F0000000E0000000100
        100003000000C001000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001F7C1F7C
        1F7C1F7C00001F7C1F7C0000000000001F7C1F7C1F7C1F7C100010001F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001000100010001000
        1F7C1F7C00001F7C1F7C0000000000001F7C1F7C1F7C1F7C100010001F7C1F7C
        10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001F7C1F7C
        10001F7C00001F7C1F7C000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C
        10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        10001F7C00001F7C1F7C1F7C1F7C1F7C1F7C1000100010001000100010001000
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C0000}
      WordWrap.Indicator.MaskColor = clFuchsia
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 288
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 816
    Top = 272
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
    Top = 280
  end
  object dtsRelIns: TDataSource
    Left = 760
    Top = 176
  end
  object dtsUtiRel: TDataSource
    Left = 952
    Top = 160
  end
  object dtsUtiTem: TDataSource
    Left = 952
    Top = 232
  end
  object dtsUtiIns: TDataSource
    Left = 952
    Top = 304
  end
end
