inherited frmPedeDadosInterfaceAutomatico: TfrmPedeDadosInterfaceAutomatico
  Width = 891
  Height = 725
  BorderStyle = bsSizeable
  Caption = 'Defini'#231#227'o do Par'#226'metro'
  ExplicitWidth = 891
  ExplicitHeight = 725
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 644
    Width = 875
    ExplicitTop = 644
    ExplicitWidth = 875
    inherited FlwBotoes: TFlowPanel
      Width = 871
      ExplicitWidth = 871
    end
    inherited btnSair: TBitBtnLocked
      Left = 795
      ExplicitLeft = 795
    end
  end
  inherited pnlStatus: TPanel
    Top = 670
    Width = 875
    ExplicitTop = 670
    ExplicitWidth = 875
    inherited pnlNomeForm: TPanel
      Left = 704
      ExplicitLeft = 704
    end
    inherited pnlInfo: TPanel
      Width = 704
      ExplicitWidth = 704
    end
  end
  object pnlDadosGerais: TPanel [2]
    Left = 0
    Top = 42
    Width = 875
    Height = 103
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 875
      Height = 648
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 10
        Width = 49
        Height = 14
        Caption = 'Par'#226'metro'
      end
      object Label2: TLabel
        Left = 198
        Top = 10
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
      end
      object lblExpImp: TLabel
        Left = 16
        Top = 52
        Width = 526
        Height = 14
        Caption = 
          'Express'#227'o que torna a impress'#227'o do filtro vis'#237'vel (para configur' +
          'a'#231#245'es, use o padr'#227'o: fCfgSis('#39'XXXXXX'#39') = '#39'X'#39
      end
      object dbeNomPar: TDBEditFocus
        Left = 16
        Top = 24
        Width = 176
        Height = 22
        TabStop = False
        DataField = 'PAR_NOMPAR'
        DataSource = dtsCadPar
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesPar: TDBEditFocus
        Left = 198
        Top = 24
        Width = 571
        Height = 22
        DataField = 'PAR_DESPAR'
        DataSource = dtsCadPar
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object btnPrior: TBitBtnLocked
        Left = 772
        Top = 24
        Width = 25
        Height = 23
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000003827
          174D000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000003827174DB882
          4DFF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000003827174DB8824DFFB882
          4DFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000003827174DB8824DFFB8824DFFB882
          4DFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFFB882
          4DFF000000000000000000000000000000000000000000000000000000000000
          000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
          4DFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFFB882
          4DFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000003827174DB8824DFFB8824DFFB882
          4DFF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000003827174DB8824DFFB882
          4DFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000003827174DB882
          4DFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000003827
          174D000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 2
        OnClick = btnPriorClick
      end
      object btnNext: TBitBtnLocked
        Left = 796
        Top = 24
        Width = 25
        Height = 23
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000003827174D00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFF3827174D000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFF3827174D0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFFB8824DFF3827
          174D000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
          4DFF3827174D0000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
          4DFF3827174D0000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFFB8824DFF3827
          174D000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFF3827174D0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFF3827174D000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000003827174D00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 3
        OnClick = btnNextClick
      end
      object dbeEXPIMP: TDBMemoFocus
        Left = 16
        Top = 67
        Width = 617
        Height = 22
        DataField = 'PAR_EXPIMP'
        DataSource = dtsCadPar
        ScrollBars = ssVertical
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
  end
  object pnlVisible: TPanel [3]
    Left = 0
    Top = 145
    Width = 875
    Height = 499
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 3
    ExplicitTop = 107
    ExplicitHeight = 537
    object Panel3: TPanel
      Left = 1
      Top = 170
      Width = 873
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 
        'Express'#227'o que torna o par'#226'metro vis'#237'vel (definir uma express'#227'o q' +
        'ue retorne TRUE ou FALSE baseada em outros par'#226'metros)'
      TabOrder = 0
    end
    object bceSQLVIS: TBCEditor
      Left = 1
      Top = 26
      Width = 873
      Height = 144
      Cursor = crIBeam
      ActiveLine.Indicator.Visible = False
      Align = alTop
      BorderStyle = bsNone
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
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 873
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 
        'Express'#227'o que torna o par'#226'metro vis'#237'vel (defnir um SQL que retor' +
        'na TRUE ou FALSE)'
      TabOrder = 2
    end
    object dbeExpVis: TDBMemoFocus
      Left = 1
      Top = 195
      Width = 873
      Height = 303
      Align = alClient
      DataField = 'PAR_EXPVIS'
      DataSource = dtsCadPar
      ScrollBars = ssVertical
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
      ExplicitHeight = 341
    end
  end
  object pnlNomPar: TPanel [4]
    Left = 0
    Top = 0
    Width = 875
    Height = 42
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 4
    object Label3: TLabel
      Left = 16
      Top = 3
      Width = 71
      Height = 14
      Caption = 'Grupo de Filtro'
    end
    object dbeGruFil: TDBEditFocus
      Left = 16
      Top = 17
      Width = 361
      Height = 22
      TabStop = False
      DataField = 'PAR_GRUFIL'
      DataSource = dtsCadPar
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 168
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 176
    Top = 128
  end
  object dtsCadPar: TDataSource
    Left = 672
    Top = 369
  end
end
