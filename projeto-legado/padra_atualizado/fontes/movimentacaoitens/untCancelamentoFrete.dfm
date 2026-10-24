inherited frmCancelamentoFrete: TfrmCancelamentoFrete
  Width = 1024
  Height = 605
  Caption = 'Cancelamento de Conhecimento de Frete'
  Padding.Top = 5
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 605
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 400
    Width = 1018
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  inherited pgcDados: TPageControl [1]
    Left = -1
    Top = 471
    Height = 19
    Align = alNone
    TabOrder = 1
    Visible = False
    ExplicitLeft = -1
    ExplicitTop = 471
    ExplicitHeight = 19
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 9
    end
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 33
    Width = 1018
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Selecione os arquivos para cancelamento:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 4
  end
  object Panel3: TPanel [3]
    Left = 0
    Top = 403
    Width = 1018
    Height = 112
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel3'
    ParentColor = True
    TabOrder = 2
    object dbmLOGIMP: TDBMemoFocus
      AlignWithMargins = True
      Left = 3
      Top = 27
      Width = 796
      Height = 82
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      DataField = 'LOGIMP'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object Panel5: TPanel
      Left = 802
      Top = 24
      Width = 216
      Height = 88
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Shape1: TShape
        Left = 30
        Top = 8
        Width = 14
        Height = 14
        Brush.Color = clRed
      end
      object Label5: TLabel
        Left = 49
        Top = 8
        Width = 84
        Height = 14
        Caption = 'Arquivo com erro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape2: TShape
        Left = 30
        Top = 28
        Width = 14
        Height = 14
        Brush.Color = clPurple
      end
      object lblDocumentoCancelado: TLabel
        Left = 49
        Top = 28
        Width = 83
        Height = 14
        Caption = 'Doc j'#225' cancelado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clPurple
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblDocumentoNaoEncontrado: TLabel
        Left = 49
        Top = 48
        Width = 98
        Height = 14
        Caption = 'CTE n'#227'o encontrado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clTeal
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape3: TShape
        Left = 30
        Top = 48
        Width = 14
        Height = 14
        Brush.Color = clTeal
      end
      object shpSemNota: TShape
        Left = 30
        Top = 67
        Width = 14
        Height = 14
        Brush.Color = 36095
      end
      object lblDocumentoPago: TLabel
        Left = 49
        Top = 67
        Width = 132
        Height = 14
        Caption = 'Pagamento CTE ja efetuado'
        Font.Charset = ANSI_CHARSET
        Font.Color = 36095
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object chkArquivoComErro: TCheckBox
        Left = 12
        Top = 6
        Width = 16
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = selecionaFiltroLegenda
      end
      object chkDocumentoCancelado: TCheckBox
        Left = 12
        Top = 27
        Width = 16
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = selecionaFiltroLegenda
      end
      object chkDocumentoNaoExiste: TCheckBox
        Left = 12
        Top = 46
        Width = 16
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = selecionaFiltroLegenda
      end
      object chkDocumentoPago: TCheckBox
        Left = 12
        Top = 66
        Width = 16
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = selecionaFiltroLegenda
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 1018
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Status de Importa'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 2
    end
  end
  object prgProgresso: TProgressBar [4]
    Left = 0
    Top = 515
    Width = 1018
    Height = 17
    Align = alBottom
    Smooth = True
    TabOrder = 5
    Visible = False
  end
  object cxgArquivos: TcxGrid [5]
    Left = 0
    Top = 52
    Width = 1018
    Height = 348
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgArquivosView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgArquivosViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxgArquivosIMPORT: TcxGridDBColumn
        Caption = 'Cancelar'
        DataBinding.FieldName = 'IMPORT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 49
      end
      object cxgArquivosNOMARQ: TcxGridDBColumn
        Caption = 'Nome do Arquivo'
        DataBinding.FieldName = 'NOMARQ'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 357
      end
      object cxgArquivosCGCTRA: TcxGridDBColumn
        Caption = 'CNPJ Transport.'
        DataBinding.FieldName = 'CGCTRA'
        Options.Editing = False
        Width = 173
      end
      object cxgArquivosNOMTRA: TcxGridDBColumn
        Caption = 'Nome da Transport.'
        DataBinding.FieldName = 'NOMTRA'
        Options.Editing = False
        Width = 199
      end
      object cxgArquivosCHAVE: TcxGridDBColumn
        Caption = 'Chave de Acesso'
        DataBinding.FieldName = 'ACESSO'
        Width = 113
      end
      object cxgArquivosDTADOC: TcxGridDBColumn
        Caption = 'Dt. Emiss'#227'o '
        DataBinding.FieldName = 'DTADOC'
        Width = 125
      end
      object cxgArquivosSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        Visible = False
      end
    end
    object cxgArquivosLevel1: TcxGridLevel
      GridView = cxgArquivosView
    end
  end
  inherited pnlStatus: TPanel
    Top = 560
    Width = 1018
    TabOrder = 3
    ExplicitTop = 560
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  inherited pnlBotoes: TPanel [7]
    Top = 532
    Width = 1018
    Height = 28
    Enabled = True
    TabOrder = 6
    Visible = True
    ExplicitTop = 532
    ExplicitWidth = 1018
    ExplicitHeight = 28
    inherited FlwBotoes: TFlowPanel
      Width = 946
      Alignment = taRightJustify
      ExplicitWidth = 946
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 135
        Height = 22
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
      object btnMarcaTodos: TBitBtnLocked
        Left = 135
        Top = 0
        Width = 135
        Height = 22
        Caption = '[ F6 ] Marca Todos'
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
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 270
        Top = 0
        Width = 139
        Height = 22
        Caption = '[ F7 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Top = -20
      TabStop = False
      ExplicitTop = -20
    end
    object BitBtnLocked1: TBitBtnLocked
      Left = 948
      Top = 2
      Width = 68
      Height = 24
      Align = alRight
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 2
      OnClick = btnSairClick
    end
  end
  object pnlTail: TPanel [8]
    Left = 0
    Top = 5
    Width = 1018
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 7
    object Label1: TLabel
      Left = 18
      Top = 7
      Width = 87
      Height = 14
      Hint = '999'
      Caption = 'Importar da Pasta:'
    end
    inline dirPasta: TfraDirectoryEditFocus
      Tag = 99
      Left = 108
      Top = 3
      Width = 684
      Height = 24
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 108
      ExplicitTop = 3
      ExplicitWidth = 684
      ExplicitHeight = 24
      inherited edtDirectory: TEditFocus
        Width = 659
        Height = 22
        ExplicitWidth = 659
        ExplicitHeight = 22
      end
      inherited btnOpenDirectory: TcxButton
        Left = 661
        Height = 24
        ExplicitLeft = 661
        ExplicitHeight = 24
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 680
    Top = 272
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
    Top = 256
  end
  object PopupMenu1: TPopupMenu
    Left = 272
    Top = 208
    object MenuItem1: TMenuItem
      Caption = 'Configurar Relat'#243'rio'
      OnClick = mnuConfigurarRelClick
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 168
    Top = 216
  end
end
