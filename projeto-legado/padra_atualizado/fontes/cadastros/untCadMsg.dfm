inherited frmCadMsg: TfrmCadMsg
  Left = 225
  Top = 253
  Width = 870
  Height = 422
  Caption = 'Mensagens Recebidas'
  ExplicitWidth = 870
  ExplicitHeight = 422
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 341
    Width = 854
    Height = 26
    ExplicitTop = 341
    ExplicitWidth = 854
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 773
      Height = 22
      ExplicitWidth = 773
      ExplicitHeight = 22
      inherited btnMudaOrdem: TBitBtnLocked
        Align = alLeft
      end
      inherited btnPesquisar: TBitBtnLocked
        Width = 105
        Align = alLeft
        ExplicitWidth = 105
      end
      object btnAbrir: TBitBtnLocked
        Left = 223
        Top = 0
        Width = 82
        Height = 22
        Align = alLeft
        Caption = '[F6] &Abrir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
          CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
          A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
          820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
          860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
          C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
          D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
          9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnAbrirClick
      end
      object btnNova: TBitBtnLocked
        Left = 305
        Top = 0
        Width = 82
        Height = 22
        Align = alLeft
        Caption = '[F7] &Nova'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
          000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
          00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
          F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
          0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
          FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
          FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
          0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
          00333377737FFFFF773333303300000003333337337777777333}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnNovaClick
      end
      object btnResponder: TBitBtnLocked
        Left = 387
        Top = 0
        Width = 82
        Height = 22
        Align = alLeft
        Caption = '[F9] &Resp.'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003333330B7FFF
          FFB0333333777F3333773333330B7FFFFFB0333333777F3333773333330B7FFF
          FFB0333333777F3333773333330B7FFFFFB03FFFFF777FFFFF77000000000077
          007077777777777777770FFFFFFFF00077B07F33333337FFFF770FFFFFFFF000
          7BB07F3FF3FFF77FF7770F00F000F00090077F77377737777F770FFFFFFFF039
          99337F3FFFF3F7F777FF0F0000F0F09999937F7777373777777F0FFFFFFFF999
          99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
          99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
          93337FFFF7737777733300000033333333337777773333333333}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnNovaClick
      end
      object btnLidas: TBitBtnLocked
        Left = 469
        Top = 0
        Width = 137
        Height = 22
        Align = alLeft
        Caption = '[F10] &Marcar como lida'
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
        TabOrder = 5
        OnClick = btnLidasClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 606
        Top = 0
        Width = 97
        Height = 22
        Align = alLeft
        Caption = '[ F8 ] Imprimir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
          8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
          93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
          9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
          678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
          8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
          E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
          8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
          EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
          C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
          C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
          D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
          9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
          B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
          BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
          C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
          C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
          AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 6
        OnClick = btnImprimirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 775
      Top = 2
      Align = alRight
      ExplicitLeft = 775
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 367
    Width = 854
    ExplicitTop = 367
    ExplicitWidth = 854
    inherited pnlNomeForm: TPanel
      Left = 683
      ExplicitLeft = 683
    end
    inherited pnlInfo: TPanel
      Width = 683
      ExplicitWidth = 683
    end
  end
  inherited pnlHeader: TPanel
    Width = 854
    Visible = False
    ExplicitWidth = 854
  end
  inherited pnlTail: TPanel
    Top = 318
    Width = 854
    Height = 23
    ExplicitTop = 318
    ExplicitWidth = 854
    ExplicitHeight = 23
    object pnlLegenda: TPanel
      Left = 0
      Top = 0
      Width = 193
      Height = 23
      Align = alLeft
      BevelOuter = bvNone
      BorderWidth = 4
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 0
      Visible = False
      object shp3: TShape
        Left = 4
        Top = 4
        Width = 14
        Height = 15
        Align = alLeft
        Brush.Color = clGreen
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitHeight = 14
      end
      object lbl3: TLabel
        Left = 18
        Top = 4
        Width = 160
        Height = 15
        Align = alLeft
        Caption = ' Solicita'#231#245'es j'#225' sendo analisadas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 14
      end
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 94
    Width = 854
    Height = 3
    Align = alNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    Visible = False
    Columns = <
      item
        Expanded = False
        FieldName = 'MSG_EMPENV'
        Title.Caption = 'Empresa'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MSG_DTAENV'
        Title.Caption = 'Data de Envio'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MSG_HORENV'
        Title.Caption = 'Hora de Envio'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MSG_OPEENV'
        Title.Caption = 'C'#243'd. Rem.'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPE_OPEENV'
        Title.Caption = 'Remetente'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MSG_TITULO'
        Title.Caption = 'Assunto'
        Width = 230
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MSG_LIBERA'
        Title.Caption = 'Libera'#231#227'o'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'OPE_OPELIB'
        Title.Caption = 'Operador Analisando'
        Width = 142
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Width = 854
    ExplicitWidth = 854
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtValor: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
  end
  object dbgMensagens: TcxGrid [6]
    Left = 0
    Top = 97
    Width = 854
    Height = 221
    Align = alClient
    TabOrder = 6
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgMensagensDB: TcxGridDBTableView
      OnKeyDown = dbgMensagensDBKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = dbgMensagensDBCellDblClick
      OnCustomDrawCell = dbgMensagensDBCustomDrawCell
      DataController.DataSource = dtsConsulta
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.GroupByBox = False
      OnColumnHeaderClick = dbgMensagensDBColumnHeaderClick
      object dbgMensagensMSG_EMPENV: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'MSG_EMPENV'
        SortIndex = 0
        SortOrder = soAscending
        Width = 58
      end
      object dbgMensagensMSG_DTAENV: TcxGridDBColumn
        Caption = 'Data de Envio'
        DataBinding.FieldName = 'MSG_DTAENV'
        Width = 81
      end
      object dbgMensagensMSG_HORENV: TcxGridDBColumn
        Caption = 'Hora de Envio'
        DataBinding.FieldName = 'MSG_HORENV'
        Width = 82
      end
      object dbgMensagensMSG_OPEENV: TcxGridDBColumn
        Caption = 'C'#243'd. Rem.'
        DataBinding.FieldName = 'MSG_OPEENV'
        Width = 61
      end
      object dbgMensagensOPE_OPEENV: TcxGridDBColumn
        Caption = 'Remetente'
        DataBinding.FieldName = 'OPE_OPEENV'
        Width = 150
      end
      object dbgMensagensMSG_TITULO: TcxGridDBColumn
        Caption = 'Assunto'
        DataBinding.FieldName = 'MSG_TITULO'
        Width = 230
      end
      object dbgMensagensMSG_LIBERA: TcxGridDBColumn
        Caption = 'Libera'#231#227'o'
        DataBinding.FieldName = 'MSG_LIBERA'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object dbgMensagensMSG_ABREVI: TcxGridDBColumn
        Caption = 'Mensagem'
        DataBinding.FieldName = 'MSG_ABREVI'
        Width = 240
      end
      object dbgMensagensMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object dbgMensagensOPE_OPELIB: TcxGridDBColumn
        Caption = 'Operador Analisando'
        DataBinding.FieldName = 'OPE_OPELIB'
        HeaderAlignmentHorz = taRightJustify
        Width = 142
      end
    end
    object dbgMensagensLevel1: TcxGridLevel
      GridView = dbgMensagensDB
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 144
  end
  inherited qryConsulta: TUniQuery
    Top = 144
  end
  inherited dspConsulta: TUniDataSetProvider
    Top = 144
  end
  inherited cdsConsulta: TUniClientDataSet
    Top = 144
  end
  inherited dtsConsulta: TDataSource
    Top = 144
  end
end
