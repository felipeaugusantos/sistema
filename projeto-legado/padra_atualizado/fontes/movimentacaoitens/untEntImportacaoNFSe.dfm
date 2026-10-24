inherited frmEntImpNFSe: TfrmEntImpNFSe
  Width = 1024
  Height = 605
  Caption = 'Importa'#231#227'o de NFS-e'
  Padding.Top = 5
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 605
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 343
    Width = 1018
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = -7
    ExplicitTop = 324
    ExplicitWidth = 931
  end
  inherited pgcDados: TPageControl [1]
    Left = -1
    Top = 471
    Height = 19
    Align = alNone
    TabOrder = 2
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
  object pnlTail: TPanel [2]
    Left = 0
    Top = 5
    Width = 1018
    Height = 140
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label3: TLabel
      Left = 46
      Top = 88
      Width = 59
      Height = 14
      Hint = '999'
      Alignment = taRightJustify
      Caption = 'Dta Entrada:'
    end
    object Label1: TLabel
      Left = 18
      Top = 110
      Width = 87
      Height = 14
      Hint = '999'
      Caption = 'Importar da Pasta:'
    end
    object lblCndPag: TLabel
      Left = 445
      Top = 87
      Width = 43
      Height = 14
      Hint = '999'
      Alignment = taRightJustify
      Caption = 'Cnd.Pag.'
    end
    object Label2: TLabel
      Left = 61
      Top = 18
      Width = 44
      Height = 14
      Hint = '888'
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblEventos: TLabel
      Left = 18
      Top = 63
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Centro de Custos:'
    end
    object lblMenConPag: TLabel
      Left = 496
      Top = 51
      Width = 487
      Height = 28
      Caption = 
        'Esta condi'#231#227'o de pagamento ser'#225' utilizada apenas para documentos' +
        ' sem data de vencimento e sem condi'#231#227'o de pagamento definida no ' +
        'cadastro de fornecedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object mskDtaEnt: TMaskEditFocus
      Tag = 99
      Left = 109
      Top = 82
      Width = 69
      Height = 22
      Hint = '999'
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 5
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskConPag: TMaskEditFocus
      Tag = 99
      Left = 493
      Top = 82
      Width = 513
      Height = 22
      Hint = '999'
      AutoSize = False
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;'
      MaxLength = 98
      TabOrder = 6
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 109
      Top = 13
      Width = 69
      Height = 22
      Hint = '888'
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPor: TEditFocus
      Left = 180
      Top = 13
      Width = 310
      Height = 22
      Hint = '888'
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
    inline dirPasta: TfraDirectoryEditFocus
      Tag = 99
      Left = 108
      Top = 104
      Width = 684
      Height = 24
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 7
      ExplicitLeft = 108
      ExplicitTop = 104
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
    object edtCodEve: TEditFocus
      Tag = 99
      Left = 109
      Top = 59
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 3
      OnKeyPress = edtCodEveKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesEve: TEditFocus
      Left = 180
      Top = 59
      Width = 310
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    inline fraPlanoDeContasPga: TfraPlanoDeContasMskEdit
      Left = 4
      Top = 36
      Width = 525
      Height = 22
      TabOrder = 2
      ExplicitLeft = 4
      ExplicitTop = 36
      ExplicitWidth = 525
      ExplicitHeight = 22
      inherited lblPlaContas: TLabel
        Left = 1
        Top = 3
        Width = 100
        Height = 14
        Caption = 'Pl. Contas (A pagar):'
        ExplicitLeft = 1
        ExplicitTop = 3
        ExplicitWidth = 100
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 176
        Width = 310
        Height = 22
        ExplicitLeft = 176
        ExplicitWidth = 310
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 105
        Width = 69
        Height = 22
        OnKeyPress = fraPlanoDeContasPgaMskCodCtaKeyPress
        ExplicitLeft = 105
        ExplicitWidth = 69
        ExplicitHeight = 22
      end
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 145
    Width = 1018
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Selecione os arquivos para importa'#231#227'o:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 5
  end
  object Panel3: TPanel [4]
    Left = 0
    Top = 346
    Width = 1018
    Height = 169
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel3'
    ParentColor = True
    TabOrder = 3
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
      TabOrder = 0
    end
    object dbmLOGIMP: TDBMemoFocus
      Left = 0
      Top = 24
      Width = 802
      Height = 145
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
      TabOrder = 1
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
      Height = 145
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
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
      object Label6: TLabel
        Left = 49
        Top = 28
        Width = 110
        Height = 14
        Caption = 'Erro ao gravar registro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clPurple
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 49
        Top = 48
        Width = 97
        Height = 14
        Caption = 'Documento j'#225' existe'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
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
        Brush.Color = clYellow
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
      object chkErroGravarRegistro: TCheckBox
        Left = 12
        Top = 27
        Width = 16
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = selecionaFiltroLegenda
      end
      object chkDocumentoJaExiste: TCheckBox
        Left = 12
        Top = 46
        Width = 16
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = selecionaFiltroLegenda
      end
    end
  end
  object prgProgresso: TProgressBar [5]
    Left = 0
    Top = 515
    Width = 1018
    Height = 17
    Align = alBottom
    Smooth = True
    TabOrder = 6
    Visible = False
  end
  object cxgArquivos: TcxGrid [6]
    Left = 0
    Top = 164
    Width = 1018
    Height = 179
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgArquivosView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCanFocusRecord = cxgArquivosViewCanFocusRecord
      OnCustomDrawCell = cxgArquivosViewCustomDrawCell
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
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
        Caption = 'Importar'
        DataBinding.FieldName = 'IMPORT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 46
      end
      object cxgArquivosNOMARQ: TcxGridDBColumn
        Caption = 'Nome do Arquivo'
        DataBinding.FieldName = 'NOMARQ'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 190
      end
      object cxgArquivosSTATUS: TcxGridDBColumn
        DataBinding.FieldName = 'STATUS'
        Visible = False
        Options.Editing = False
      end
      object cxgArquivosNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Options.Editing = False
        Width = 71
      end
      object cxgArquivosESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'ESPDOC'
        Options.Editing = False
        Width = 27
      end
      object cxgArquivosViewColumn1: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'SERIE_'
      end
      object cxgArquivosCGCTRA: TcxGridDBColumn
        Caption = 'CNPJ'
        DataBinding.FieldName = 'CGCFOR'
        Options.Editing = False
        Width = 92
      end
      object cxgArquivosCODTRA: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODFOR'
        Options.Editing = False
        Width = 60
      end
      object cxgArquivosNOMTRA: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'NOMFOR'
        Options.Editing = False
        Width = 106
      end
      object cxgArquivosDTADOC: TcxGridDBColumn
        Caption = 'Dt. Emiss'#227'o '
        DataBinding.FieldName = 'DTADOC'
        Width = 67
      end
      object cxgArquivosCNDPAG: TcxGridDBColumn
        Caption = 'Cond.Pagto'
        DataBinding.FieldName = 'CNDPAG'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.EditMask = '(99)999.999.999.999.999.999.999.999.999.999.999.999;0;_'
        Properties.OnValidate = cxgArquivosCNDPAGPropertiesValidate
        OnGetDisplayText = cxgArquivosCNDPAGGetDisplayText
        Width = 64
      end
      object cxgArquivosVALTOT: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'VALDOC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 58
      end
      object cxgArquivosCFOP: TcxGridDBColumn
        Caption = 'CFOP'
        DataBinding.FieldName = 'CLAFI1'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxgArquivosCFOPPropertiesValidate
        Width = 60
      end
      object cxgArquivosABRPIS: TcxGridDBColumn
        Caption = 'Alq. PIS'
        DataBinding.FieldName = 'ALQPIS'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsOnly
        Properties.OnButtonClick = cxgArquivosABRPISPropertiesButtonClick
        HeaderAlignmentHorz = taCenter
        Width = 56
      end
      object cxgArquivosABRCOF: TcxGridDBColumn
        Caption = 'Alq. COFINS'
        DataBinding.FieldName = 'ALQCOF'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsButtonsOnly
        Properties.OnButtonClick = cxgArquivosABRCOFPropertiesButtonClick
        Width = 55
      end
      object cxgArquivosAUTCOF: TcxGridDBColumn
        DataBinding.FieldName = 'AUTCOF'
        Visible = False
      end
      object cxgArquivosAUTPIS: TcxGridDBColumn
        DataBinding.FieldName = 'AUTPIS'
        Visible = False
      end
      object cxgArquivosCNDXML: TcxGridDBColumn
        Caption = 'Condi'#231#227'o Pag XML'
        DataBinding.FieldName = 'CNDXML'
        Visible = False
      end
      object cxgArquivosCODTRAN: TcxGridDBColumn
        DataBinding.FieldName = 'CODTRA'
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
    TabOrder = 4
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
  inherited pnlBotoes: TPanel [8]
    Top = 532
    Width = 1018
    Height = 28
    Enabled = True
    TabOrder = 8
    Visible = True
    ExplicitTop = 532
    ExplicitWidth = 1018
    ExplicitHeight = 28
    inherited FlwBotoes: TFlowPanel
      Width = 946
      Height = 24
      Alignment = taRightJustify
      ExplicitWidth = 946
      ExplicitHeight = 24
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
      object btnEditorLayout: TBitBtnLocked
        Left = 409
        Top = 0
        Width = 139
        Height = 22
        Caption = '[ F4 ] Editor de Layout'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          001200000012000000110000000C000000030000000000000000000000087B50
          43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
          59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
          5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
          ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
          62FFFDFBFAFFF7EDE6FF5B524CFF4E443EFF4C413AFF484038FF463D36FF443A
          33FF413731FF3F362FFF3E352DFF3C312BFF393129FF382F27FF0000000BB079
          66FFFDFBFBFFF8EEE8FF5D544DFFFAF8F7FF4D433DFFF9F6F5FF473E37FFF9F4
          F2FF433932FFF7F1EFFF3F362FFFF7F0EDFFF7EEECFF393029FF0000000AB37C
          69FFFEFCFBFFF8F0EAFF5F564FFFFAF8F7FF4E443EFFF9F6F5FF494038FFF8F5
          F3FF453A35FFF7F3F0FF403730FFF7F0EEFF3C322CFF3A312BFF00000009B67F
          6CFFFEFDFCFFF9F0EBFF625952FF88817BFFFAF8F7FF857E78FF4B4139FFF9F6
          F3FF463D36FFF8F2F0FF413831FFF7F1EEFF3E332CFF3C312BFF00000009B983
          71FFFEFDFCFFFAF3EEFF645B55FFFAF9F8FF514740FFFAF8F6FF4D433CFFF9F6
          F5FFF9F5F2FFF9F3F2FF433932FFF7F2EFFF3F352DFF3D322CFF00000008BC88
          77FFFEFEFDFFFBF4EFFF675C56FFFBF9F8FF524841FFFAF8F7FF4E443EFFF9F7
          F5FF493F38FFF9F5F3FF443A33FFF8F2EFFF403630FF3E352DFF00000007BF8C
          7AFFFEFEFDFFFBF6F1FF685E59FF665C55FF635853FF5F564FFF5D524CFF594F
          49FF564B44FF524941FF4E453EFF4B413AFF493F38FF463D35FF00000006C18F
          7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
          82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
          85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
          89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
          67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
          87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
          0002000000030000000400000004000000050000000500000005000000060000
          0006000000060000000600000005000000010000000000000000}
        TabOrder = 3
        OnClick = btnEditorLayoutClick
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
  object chkGravaFinanceiro: TCheckBox [9]
    Left = 109
    Top = 2
    Width = 465
    Height = 15
    Caption = 'Grava financeiro e plano de contas na importa'#231#227'o.'
    Checked = True
    State = cbChecked
    TabOrder = 7
    StyleElements = [seFont, seBorder]
    OnClick = chkGravaFinanceiroClick
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
