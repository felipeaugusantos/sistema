inherited frmImpEtiqNotaEntradaItens: TfrmImpEtiqNotaEntradaItens
  Width = 1016
  Height = 330
  Caption = 'frmImpEtiqNotaEntradaItens'
  ExplicitWidth = 1016
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 224
    Width = 1000
    Height = 51
    ExplicitTop = 224
    ExplicitWidth = 1000
    ExplicitHeight = 51
    inherited FlwBotoes: TFlowPanel
      Top = 24
      Width = 733
      Height = 25
      Align = alLeft
      FlowStyle = fsRightLeftTopBottom
      TabOrder = 4
      ExplicitTop = 24
      ExplicitWidth = 733
      ExplicitHeight = 25
      inherited btnMudaOrdem: TBitBtnLocked
        Left = 618
        Width = 115
        Height = 25
        Align = alLeft
        TabOrder = 1
        ExplicitLeft = 618
        ExplicitWidth = 115
        ExplicitHeight = 25
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 505
        Height = 25
        Align = alLeft
        TabOrder = 0
        ExplicitLeft = 505
        ExplicitHeight = 25
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 907
      Top = 24
      Width = 91
      Height = 25
      Align = alRight
      TabOrder = 5
      ExplicitLeft = 907
      ExplicitTop = 24
      ExplicitWidth = 91
      ExplicitHeight = 25
    end
    object btnImprime: TBitBtnLocked
      Left = 3
      Top = 24
      Width = 88
      Height = 25
      Caption = '[F10] &Imprime'
      TabOrder = 0
      OnClick = btnImprimeClick
    end
    object btnMarca: TBitBtnLocked
      Left = 245
      Top = 24
      Width = 120
      Height = 25
      Caption = '[ F7 ] Marcar todos'
      Glyph.Data = {
        F2010000424DF201000000000000F20000002800000010000000100000000100
        08000000000000010000340B0000340B00002F0000002F000000EA8F3100B66A
        5000AB735800C07B5800EAA15800FFB65800AB6A6000B67B6000C08460006A6A
        6A00A16A6A00A1736A00C0846A006AFF6A00A17B7300B68F7B00F4C07B00B68F
        8400F4C08400F4CA8400B6988F00C0988F00F4CA8F00B6AB9800F4CA9800D4AB
        A100D4B6A100E0B6A100EAB6A100EAC0A100F4D4A100FFD4A100EAC0AB00F4D4
        AB00F4E0B600E0C0C000E0CAC000E0CACA00F4E0CA00FFEACA00FFEAD400FFF4
        E000FFF4EA00FFF4F400FFFFF400FF00FF00FFFFFF002D2D0A0A0A0A0A0A0A0A
        0A0A0A0A0A2D2D2D112722211E181612101010130A2D2D2D1127090909090909
        090909120A2D2D2D14290D0D0D0D0D0D0D0D0D120A2D2D2D14290D0D0D0D0D0D
        0D0D0D100A2D2D2D142C090909090909090909120A2D2D2D1A2E0D0D0D0D0D0D
        0D0D0D0D0A2D2D2D1A2E0D0D0D0D0D0D0D0D0D0D0A2D2D2D1A2E090909090909
        0909091E0A2D2D2D192E0D0D0D0D0D0D0D0D0D1E0A2D2D2D1A2E0D0D0D0D0D0D
        0D0D0D170A2D2D2D1B2E09090909092A260F0E0B0A2D2D2D1B2E0D0D0D0D0D0D
        23020400012D2D2D202E0D0D0D0D0D0D240705032D2D2D2D1B2B2A2A2A2A2A2A
        23070C2D2D2D2D2D1B1D1D1D1D1B1B1D19062D2D2D2D}
      TabOrder = 2
      OnClick = btnMarcaClick
    end
    object btnDesmarca: TBitBtnLocked
      Left = 365
      Top = 24
      Width = 141
      Height = 25
      Caption = '[ F8 ] Desmarcar todos'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADAD7000007
        DADAADAD019999910DADDAD09999999990DAAD0999999999990DD71999999999
        9917A0999FF999FF9990D09999FF9FF99990A099999FFF999990D099999FFF99
        9990A09999FF9FF99990D7199FF999FF9917AD0999999999990DDAD099999999
        90DAADAD019999910DADDADAD7000007DADAADADADADADADADAD}
      TabOrder = 3
      OnClick = btnDesmarcaClick
    end
    object btnMarDes: TBitBtnLocked
      Left = 90
      Top = 24
      Width = 154
      Height = 25
      Caption = '[ENTER] Marca/Desmarca'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnMarDesClick
    end
    object pnlLegenda: TPanel
      Left = 2
      Top = 2
      Width = 996
      Height = 22
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 6
      object lbl3: TLabel
        Left = 30
        Top = 3
        Width = 132
        Height = 14
        Caption = 'Produtos fora de promo'#231#227'o'
      end
      object shp2: TShape
        Left = 14
        Top = 5
        Width = 12
        Height = 12
        Brush.Color = clBlack
      end
      object shp3: TShape
        Left = 239
        Top = 5
        Width = 12
        Height = 12
        Brush.Color = clGreen
      end
      object lbl4: TLabel
        Left = 257
        Top = 3
        Width = 111
        Height = 14
        Caption = 'Produtos em Promo'#231#227'o'
      end
      object lblDefinitQtde: TLabel
        Left = 788
        Top = 2
        Width = 197
        Height = 14
        Cursor = crHandPoint
        Caption = '[ F4 ]Definir quantidade 1 para todos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        OnClick = lblDefinitQtdeClick
      end
      object lblDefinirQuantidadeOriginal: TLabel
        Left = 548
        Top = 2
        Width = 232
        Height = 14
        Cursor = crHandPoint
        Caption = '[ F6 ] Definir quantidade Original do Pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Visible = False
        OnClick = lblDefinirQuantidadeOriginalClick
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 275
    Width = 1000
    ExplicitTop = 275
    ExplicitWidth = 1000
    inherited pnlNomeForm: TPanel
      Left = 829
      ExplicitLeft = 829
    end
    inherited pnlInfo: TPanel
      Width = 829
      ExplicitWidth = 829
    end
  end
  inherited pnlHeader: TPanel
    Width = 1000
    Height = 25
    Visible = False
    ExplicitWidth = 1000
    ExplicitHeight = 25
  end
  inherited pnlTail: TPanel
    Top = 222
    Width = 1000
    Height = 2
    ExplicitTop = 222
    ExplicitWidth = 1000
    ExplicitHeight = 2
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 65
    Width = 1000
    Height = 157
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 431
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOCFIS'
        ReadOnly = True
        Title.Caption = 'Loc. F'#237'sica'
        Width = 145
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REFERE'
        ReadOnly = True
        Title.Caption = 'Refer'#234'ncia'
        Width = 145
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGUNI'
        ReadOnly = True
        Title.Caption = 'Unidade'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PROMOC'
        ReadOnly = True
        Title.Caption = 'Promoc.'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GRUPO'
        ReadOnly = True
        Title.Caption = 'Grupo'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ORIGEM'
        ReadOnly = True
        Title.Caption = 'Origem'
        Visible = False
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 25
    Width = 1000
    ExplicitTop = 25
    ExplicitWidth = 1000
  end
end
