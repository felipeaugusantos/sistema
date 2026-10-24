inherited frmAvisosPrevisionamentoCTP: TfrmAvisosPrevisionamentoCTP
  Width = 1051
  Height = 539
  Caption = 'Avisos de Previsionamento - Contas a Pagar'
  OnClose = FormClose
  ExplicitWidth = 1051
  ExplicitHeight = 539
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 456
    Width = 1035
    ExplicitTop = 456
    ExplicitWidth = 1035
    inherited FlwBotoes: TFlowPanel
      Width = 1031
      ExplicitWidth = 1031
      inherited btnMudaOrdem: TBitBtnLocked
        Visible = False
      end
      inherited btnPesquisar: TBitBtnLocked
        Visible = False
      end
      object btnExibirDados: TBitBtnLocked
        Left = 231
        Top = 0
        Width = 122
        Height = 22
        Align = alLeft
        Caption = '[F6] &Exibir Dados'
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
        OnClick = btnExibirDadosClick
      end
      object btnLidas: TBitBtnLocked
        Left = 353
        Top = 0
        Width = 137
        Height = 22
        Hint = 'Marcar mensagem(ns) como lida(s)'
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
        TabOrder = 3
        OnClick = btnLidasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 957
      ExplicitLeft = 957
    end
  end
  inherited pnlHeader: TPanel
    Width = 1035
    Visible = False
    ExplicitWidth = 1035
  end
  inherited pnlTail: TPanel
    Top = 431
    Width = 1035
    Height = 25
    ExplicitTop = 431
    ExplicitWidth = 1035
    ExplicitHeight = 25
  end
  inherited dbgConsulta: TDBGridCitel
    Width = 1035
    Height = 334
    Visible = False
  end
  inherited pnlPesquisa: TPanel
    Width = 1035
    ExplicitWidth = 1035
  end
  inherited pnlStatus: TPanel
    Top = 484
    Width = 1035
    ExplicitTop = 484
    ExplicitWidth = 1035
    inherited pnlNomeForm: TPanel
      Left = 782
      Width = 253
      ExplicitLeft = 782
      ExplicitWidth = 253
    end
    inherited pnlInfo: TPanel
      Width = 782
      ExplicitWidth = 782
    end
  end
  object dbgAvisosPrevisionamento: TcxGrid [7]
    Left = 0
    Top = 97
    Width = 1035
    Height = 334
    Align = alClient
    TabOrder = 7
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgAvisosPrevisionamentoDados: TcxGridDBTableView
      OnKeyDown = dbgAvisosPrevisionamentoDadosKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgAvisosPrevisionamentoDadosCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object dbgAvisosPrevisionamentoDadosNUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'NUMDUP'
        Width = 157
      end
      object dbgAvisosPrevisionamentoDadosPRE_CODFOR: TcxGridDBColumn
        Caption = 'C'#243'd. Fornecedor'
        DataBinding.FieldName = 'PRE_CODFOR'
        Options.AutoWidthSizable = False
        Width = 92
      end
      object dbgAvisosPrevisionamentoDadosFOR_NOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Options.AutoWidthSizable = False
        Width = 206
      end
      object dbgAvisosPrevisionamentoDadosPRE_DTAMSG: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'PRE_DTAMSG'
        Width = 113
      end
      object dbgAvisosPrevisionamentoDadosOPEENV: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'OPEENV'
        Options.AutoWidthSizable = False
        Width = 131
      end
      object dbgAvisosPrevisionamentoDadosPRE_ASSUNT: TcxGridDBColumn
        Caption = 'Assunto'
        DataBinding.FieldName = 'PRE_ASSUNT'
        Width = 205
      end
      object dbgAvisosPrevisionamentoDadosPRE_MOTIVO: TcxGridDBColumn
        Caption = 'Motivo'
        DataBinding.FieldName = 'PRE_MOTIVO'
        Width = 194
      end
      object dbgAvisosPrevisionamentoDadosPRE_MARDES: TcxGridDBColumn
        DataBinding.FieldName = 'PRE_MARDES'
        Visible = False
        IsCaptionAssigned = True
      end
    end
    object dbgAvisosPrevisionamentoLevel1: TcxGridLevel
      GridView = dbgAvisosPrevisionamentoDados
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 120
  end
  inherited qryConsulta: TUniQuery
    Left = 128
    Top = 120
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 160
    Top = 136
  end
  inherited cdsConsulta: TUniClientDataSet
    Top = 136
  end
  inherited dtsConsulta: TDataSource
    Top = 144
  end
end
