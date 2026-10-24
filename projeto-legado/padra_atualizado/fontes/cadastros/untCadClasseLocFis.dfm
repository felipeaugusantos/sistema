inherited frmCadClasseLocFis: TfrmCadClasseLocFis
  Width = 767
  Height = 416
  Caption = 'Classe de Localiza'#231#227'o F'#237'sica'
  OnDestroy = FormDestroy
  ExplicitWidth = 767
  ExplicitHeight = 416
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 8
    Top = 8
    Width = 23
    Height = 14
    Caption = 'Sigla'
  end
  object Bevel1: TBevel [1]
    Left = -3
    Top = 59
    Width = 763
    Height = 6
    Shape = bsTopLine
  end
  object Label5: TLabel [2]
    Left = 8
    Top = 71
    Width = 92
    Height = 14
    Caption = 'Localiza'#231#227'o Fisica:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel [3]
    Left = 531
    Top = 79
    Width = 214
    Height = 31
    AutoSize = False
    Caption = 
      'Pressione DELETE sobre uma localiza'#231#227'o f'#237'sica para remov'#234'-la da ' +
      'classe.'
    Layout = tlCenter
    WordWrap = True
  end
  inherited pnlBotoes: TPanel
    Top = 346
    Width = 761
    Height = 25
    TabOrder = 3
    ExplicitTop = 346
    ExplicitWidth = 761
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 680
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 680
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 79
        Height = 21
        Align = alLeft
        ExplicitWidth = 79
        ExplicitHeight = 21
      end
      object btnInclusaoEmMasa: TBitBtnLocked
        Left = 439
        Top = 0
        Width = 116
        Height = 21
        Align = alLeft
        Caption = 'Adicionar &V'#225'rios'
        Enabled = False
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          1800000000000006000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA67A75A67A75
          A67A75A67A75A67A75A67A75A67A75A67A75A67A75A67A75FF00FF0000000000
          00000000000000FF00FF83838383838383838383838383838383838383838383
          8383838383838383FF00FF3C3C3C3C3C3C3C3C3C3C3C3CFF00FFA67A75F1E1D6
          EEDBCDECD6C5EAD1BDE7CCB5E5C8ADE3C3A5E0BF9DA67A75FF00FF000000FF00
          FF0335FB000000FF00FF838383D9D9D9D3D3D3CECECEC9C9C9C4C4C4BFBFBFBA
          BABAB4B4B4838383FF00FF3C3C3CFF00FF7575753C3C3CFF00FFA67A75FCF7F2
          FAF1E7F9ECDCF7E7D2F5E2C8F4DDBEF3D8B4F1D4A9A67A75FF00FF0000000335
          FB0335FB000000FF00FF838383EDEDEDE6E6E6E0E0E0DADADAD4D4D4CFCFCFC9
          C9C9C3C3C3838383FF00FF3C3C3C7575757575753C3C3CFF00FFA67A75A67A75
          A67A75A67A75A67A75A67A75A67A75A67A75A67A75A67A75FF00FF0000000000
          000000000330E2FF00FF83838383838383838383838383838383838383838383
          8383838383838383FF00FF3C3C3C3C3C3C3C3C3C686868FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF757575A67A75A67A75
          A67A75A67A75A67A75A67A75A67A75A67A75A67A75A67A75FF00FF0000000000
          00000000000000FF00FF83838383838383838383838383838383838383838383
          8383838383838383FF00FF3C3C3C3C3C3C3C3C3C3C3C3CFF00FFA67A75F1E1D6
          EEDBCDECD6C5EAD1BDE7CCB5E5C8ADE3C3A5E0BF9DA67A75FF00FF000000FF00
          FF0335FB000000FF00FF838383D9D9D9D3D3D3CECECEC9C9C9C4C4C4BFBFBFBA
          BABAB4B4B4838383FF00FF3C3C3CFF00FF7575753C3C3CFF00FFA67A75FCF7F2
          FAF1E7F9ECDCF7E7D2F5E2C8F4DDBEF3D8B4F1D4A9A67A75FF00FF0000000335
          FB0335FB000000FF00FF838383EDEDEDE6E6E6E0E0E0DADADAD4D4D4CFCFCFC9
          C9C9C3C3C3838383FF00FF3C3C3C7575757575753C3C3CFF00FFA67A75A67A75
          A67A75A67A75A67A75A67A75A67A75A67A75A67A75A67A75FF00FF0000000000
          000000000330E2FF00FF83838383838383838383838383838383838383838383
          8383838383838383FF00FF3C3C3C3C3C3C3C3C3C686868FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF757575A67A75A67A75
          A67A75A67A75A67A75A67A75A67A75A67A75A67A75A67A75FF00FF0000000000
          00000000000000FF00FF83838383838383838383838383838383838383838383
          8383838383838383FF00FF3C3C3C3C3C3C3C3C3C3C3C3CFF00FFA67A75F1E1D6
          EEDBCDECD6C5EAD1BDE7CCB5E5C8ADE3C3A5E0BF9DA67A75FF00FF000000FF00
          FF0335FB000000FF00FF838383D9D9D9D3D3D3CECECEC9C9C9C4C4C4BFBFBFBA
          BABAB4B4B4838383FF00FF3C3C3CFF00FF7575753C3C3CFF00FFA67A75FCF7F2
          FAF1E7F9ECDCF7E7D2F5E2C8F4DDBEF3D8B4F1D4A9A67A75FF00FF0000000335
          FB0335FB000000FF00FF838383EDEDEDE6E6E6E0E0E0DADADAD4D4D4CFCFCFC9
          C9C9C3C3C3838383FF00FF3C3C3C7575757575753C3C3CFF00FFA67A75A67A75
          A67A75A67A75A67A75A67A75A67A75A67A75A67A75A67A75FF00FF0000000000
          000000000330E2FF00FF83838383838383838383838383838383838383838383
          8383838383838383FF00FF3C3C3C3C3C3C3C3C3C686868FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF757575}
        NumGlyphs = 2
        TabOrder = 6
        OnClick = btnInclusaoEmMasaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 682
      Height = 21
      Align = alRight
      ExplicitLeft = 682
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Left = 1292
    Top = 48
    Width = 10
    Height = 65
    Align = alNone
    TabOrder = 5
    ExplicitLeft = 1292
    ExplicitTop = 48
    ExplicitWidth = 10
    ExplicitHeight = 65
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 2
      ExplicitHeight = 33
    end
  end
  inherited pnlStatus: TPanel
    Top = 371
    Width = 761
    TabOrder = 4
    ExplicitTop = 371
    ExplicitWidth = 761
    inherited pnlNomeForm: TPanel
      Left = 414
      ExplicitLeft = 414
    end
    inherited pnlInfo: TPanel
      Width = 414
      ExplicitWidth = 414
    end
  end
  object dbeSigla: TDBEditFocus [8]
    Tag = 99
    Left = 8
    Top = 27
    Width = 105
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CLA_SIGLA_'
    DataSource = dtsTabela
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCodEmp: TDBEditFocus [9]
    Tag = 99
    Left = 119
    Top = 27
    Width = 105
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CLA_CODEMP'
    DataSource = dtsTabela
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 7
    Visible = False
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object cxgClaLoc: TcxGridCitel [10]
    Left = 8
    Top = 116
    Width = 744
    Height = 226
    TabOrder = 8
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgClaLocTableView: TcxGridDBTableViewCitel
      OnKeyUp = cxgClaLocTableViewKeyUp
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgClaLocTableViewLocalizacao: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o'
        DataBinding.FieldName = 'CLL_CODLOC'
        Options.Editing = False
        Options.Focusing = False
        Width = 129
      end
      object cxgClaLocTableViewDescricao: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        Options.Editing = False
        Options.Focusing = False
        Width = 132
      end
      object cxgClaLocTableViewAltura: TcxGridDBColumn
        Caption = 'Altura'
        DataBinding.FieldName = 'ALTURA'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxgClaLocTableViewLargura: TcxGridDBColumn
        Caption = 'Largura'
        DataBinding.FieldName = 'LARGUR'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxgClaLocTableViewProfundidade: TcxGridDBColumn
        Caption = 'Profundidade'
        DataBinding.FieldName = 'PROFUN'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxgClaLocTableViewCapacidade: TcxGridDBColumn
        Caption = 'Cap. M'#225'x'
        DataBinding.FieldName = 'CAPACI'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxgClaLocTableViewPicking: TcxGridDBColumn
        Caption = 'Picking'
        DataBinding.FieldName = 'PICKIN'
        OnGetDataText = cxgClaLocTableViewPickingGetDataText
        Options.Editing = False
        Options.Focusing = False
        Width = 67
      end
      object cxgClaLocTableViewPeso: TcxGridDBColumn
        Caption = 'Peso M'#225'x.'
        DataBinding.FieldName = 'PESMAX'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
    end
    object cxgClaLocLevel: TcxGridLevel
      GridView = cxgClaLocTableView
    end
  end
  object edtLocFis: TEditFocus [11]
    Tag = 99
    Left = 8
    Top = 88
    Width = 112
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
    MaxLength = 30
    ParentFont = False
    TabOrder = 1
    OnKeyPress = edtLocFisKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 10
    TipoTexto = ttAlfanumerico
  end
  object edtDescri: TEditFocus [12]
    Left = 121
    Top = 88
    Width = 310
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 9
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object btnAdicionar: TBitBtnLocked [13]
    Left = 437
    Top = 85
    Width = 88
    Height = 25
    Caption = 'A&dicionar'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000002000000070000
      000D0000000F0000000D00000007000000020000000000000000000000020000
      00090000000F00000010000000110000001100000014020101214C28168E8648
      27DAA55831FF854627DB4A28158C020100150000000400000000000000098B63
      56C1C18977FFC08976FFC08875FFC59584FFCFAFA3FFB0704EFFC07C4AFFDEA6
      69FFF4D3A1FFDEA76AFFBF7C4BFF844728D406030217000000020000000CC38E
      79FFFDFBFAFFFBF7F4FFFCF6F3FFF7F4F1FFC8A28CFFC48656FFEDBC7CFFEEBF
      7FFF83400EFFF2CC94FFEFC181FFC38657FF58321C93000000070000000DC591
      7EFFFDFCFBFFF8EFE8FFF7EEE8FFF2EDE9FFBA7D57FFE4B377FFF5D9ABFFF5DA
      AFFF8B4914FFF7E3BEFFF6DBB2FFE5B77FFF995C36E30000000B0000000CC794
      81FFFEFCFBFFF9F0EAFFF8F0EAFFF3EFECFFBC784FFFF1CE95FF995420FF9752
      1DFF934F1CFF904C19FF8D4917FFF5DBAEFFB16F45FA0000000B0000000BC997
      86FFFEFDFCFFF9F2EDFFF9F2EDFFF5F0EDFFC68C65FFEFDDB7FFF3CF98FFF5D5
      9FFF9B5622FFF7E0B2FFF5D7A4FFEFDDB8FFA46942E2000000080000000ACB9C
      8BFFFEFDFDFFFAF3EFFFFAF4EEFFF8F3F0FFDBB9A4FFD8AE86FFF9F3D1FFF8E1
      B5FFA35D28FFFAEAC6FFFAF6D5FFD8AF89FF5E3E29850000000400000009CFA0
      8DFFFEFEFDFFFBF5F1FFFBF5F0FFFAF4F1FFF6F2EFFFD5A785FFDCB48DFFF2E9
      CAFFFAFDE1FFF2E9CAFFDCB38CFF996B4AC80202010A0000000100000009D0A3
      93FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF6F2FFF8F4F0FFE4C9B4FFDAAF
      8AFFD8A578FFDBAE8AFFD7B098FF02020117000000010000000000000008D3A8
      97FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF5F4FFFAF6F3FFFAF6
      F3FFF8F6F3FFFBF9F8FFDAB9ADFF0000000E000000000000000000000007D3AB
      9AFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6
      F2FFFBF6F1FFFDFBF9FFD0A493FF0000000C000000000000000000000006D8AE
      9DFFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7F5FFFBF7
      F4FFFCF7F3FFFDFCFAFFD2A897FF0000000B000000000000000000000006D8B0
      A0FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8F6FFFBF7
      F6FFFCF7F5FFFEFCFCFFD5AA9AFF0000000B000000000000000000000005D9B3
      A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFEFEFFFEFE
      FEFFFEFEFEFFFEFEFDFFD7AE9EFF00000009000000000000000000000003A386
      7AC0DBB5A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3A2FFD9B2
      A2FFD8B2A2FFD8B1A1FFA08277C2000000060000000000000000}
    TabOrder = 2
    OnClick = btnAdicionarClick
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1112
    Top = 36
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1072
    Top = 36
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1228
    Top = 36
  end
  object dtsTabela: TDataSource
    Left = 388
    Top = 8
  end
end
