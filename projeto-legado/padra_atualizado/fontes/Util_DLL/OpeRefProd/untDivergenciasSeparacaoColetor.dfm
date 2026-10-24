inherited frmDivergenciasSeparacaoColetor: TfrmDivergenciasSeparacaoColetor
  Width = 1113
  Height = 598
  Caption = 'Diverg'#234'ncias Separa'#231#227'o - Coletor'
  Position = poScreenCenter
  ExplicitWidth = 1113
  ExplicitHeight = 598
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 525
    Width = 1107
    ExplicitTop = 525
    ExplicitWidth = 1107
    inherited FlwBotoes: TFlowPanel
      Width = 1103
      ExplicitWidth = 1103
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 169
        Height = 22
        Caption = '&Gravar Ajuste de Estoque'
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
      object btnMovimentacao: TBitBtnLocked
        Left = 169
        Top = 0
        Width = 120
        Height = 22
        Caption = '&Movimenta'#231#227'o'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000936E4DB7CB9767FFC99465FFC89162FFC78F5FFF8D6542B7000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000C19369ECD09D70FFCE9C6DFFCC996AFFCB9668FFB9875BEC000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000080000
          000F000000130000001600000017000000110000000400000000000000000000
          0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF0C498EBF1165
          C6FF0F63C5FF0E61C4FF0D60C3FF09448BC80000001100000000552D12810000
          00009B7754BDD09D70FFCE9C6DFFCC996AFFCB9668FF956D4ABD1268C8FFA3DA
          FFFF59BCFFFF56BBFFFF53BAFFFF0E60C3FF0000001700000000A95A25FF552D
          12810000000000000000000000000000000000000000000000001369C9FFB5E1
          FFFF5BBDFFFF59BBFFFF56BAFFFF0F61C3FFAD5E2AFFAC5D28FFAA5B27FFAA59
          24FF2C1709420000000000000000000000000000000000000000146ACAFFC6E8
          FFFFB7E2FFFFA7DCFFFF97D5FFFF0F63C5FF0000001200000000AC5D28FF542D
          137E0000000000000000000000000000000000000000000000000F5097BF136A
          CAFF1368C9FF1267C7FF1065C6FF0C4A93C60000000A00000000552F157E0000
          0000936E4DB7CB9767FFC99465FFC89162FFC78F5FFF8D6542B7000000010000
          0003000000050000000700000008000000070000000200000000000000000000
          0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00009B7754BDD09D70FFCE9C6DFFCC996AFFCB9668FF956D4ABD000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 1
        OnClick = btnMovimentacaoClick
      end
      object btnExcel: TBitBtnLocked
        Left = 289
        Top = 0
        Width = 142
        Height = 22
        Caption = 'Exportar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          001200000012000000110000000C000000030000000000000000000000087B50
          43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
          59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
          5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
          ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
          62FFFDFBFAFFF7EDE6FF53A46CFF058131FF048030FF047F30FF037E2FFF037D
          2EFF027C2EFF027B2DFF02792CFF01792CFF00782BFF00511DAD0000000BB079
          66FFFDFBFBFFF8EEE8FF068332FFFAF6F6FF058131FFF9F5F3FF047F2FFFF8F2
          F1FFF7F2EFFF7DB68EFFF7EFEDFFF6EEEBFF7BB48BFF01782BFF0000000AB37C
          69FFFEFCFBFFF8F0EAFF068433FFFBF7F6FF058231FFF9F5F4FF048030FFF8F4
          F2FF037E2FFF037D2FFF027C2EFF7DB68DFFF6EEEBFF01792CFF00000009B67F
          6CFFFEFDFCFFF9F0EBFF078533FF81BE95FFFBF7F6FF80BD94FF048131FFF9F5
          F2FF047F30FF037E2FFF7EB88FFFF6F1EEFF037B2DFF017A2DFF00000009B983
          71FFFEFDFCFFFAF3EEFF068634FFFCF8F8FF068433FFFBF7F6FF068231FFFAF5
          F3FF048030FF047F30FFF8F3F0FF037D2EFF027C2EFF027A2DFF00000008BC88
          77FFFEFEFDFFFBF4EFFF078634FFFBFAF9FF078533FFFAF8F7FF068333FFFAF7
          F5FF058131FF058030FF7EB991FFF8F2F0FFF7F2EFFF027C2DFF00000007BF8C
          7AFFFEFEFDFFFBF6F1FF55AA71FF078634FF078534FF068534FF068433FF0683
          32FF058332FF058131FF058030FF047F30FF037E2FFF025420AD00000006C18F
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
        TabOrder = 2
        OnClick = btnExcelClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Tag = 1
        Left = 431
        Top = 0
        Width = 128
        Height = 22
        Align = alLeft
        Caption = '[ F8 ] Marcar Todos'
        TabOrder = 3
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 559
        Top = 0
        Width = 128
        Height = 22
        Align = alLeft
        Caption = '[ F9 ] Desmarcar Todos'
        TabOrder = 4
        OnClick = btnDesmarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1027
      ExplicitLeft = 1027
    end
  end
  inherited pnlStatus: TPanel
    Top = 553
    Width = 1107
    ExplicitTop = 553
    ExplicitWidth = 1107
    inherited pnlNomeForm: TPanel
      Left = 936
      ExplicitLeft = 936
    end
    inherited pnlInfo: TPanel
      Width = 936
      ExplicitWidth = 936
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 1107
    Height = 86
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      1107
      86)
    object Label12: TLabel
      Left = 9
      Top = 6
      Width = 22
      Height = 14
      Caption = 'Data'
    end
    object Label11: TLabel
      Left = 143
      Top = 6
      Width = 77
      Height = 14
      Caption = 'Ope. Separador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCodIte: TLabel
      Left = 10
      Top = 44
      Width = 19
      Height = 14
      Caption = 'Item'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumLot: TLabel
      Left = 548
      Top = 44
      Width = 24
      Height = 14
      Caption = 'Lote:'
    end
    object lblLocFis: TLabel
      Left = 436
      Top = 44
      Width = 55
      Height = 14
      Caption = 'Loc. F'#237'sica:'
    end
    object Label1: TLabel
      Left = 80
      Top = 6
      Width = 23
      Height = 14
      Caption = 'Hora'
    end
    object mskDtaMov: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 20
      Width = 68
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 143
      Top = 20
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomOpe: TEditFocus
      Left = 209
      Top = 20
      Width = 554
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 9
      Top = 58
      Width = 74
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 86
      Top = 58
      Width = 347
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumLot: TEditFocus
      Tag = 99
      Left = 548
      Top = 58
      Width = 120
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 7
      OnExit = edtNumLotExit
      OnKeyPress = edtNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocFis: TEditFocus
      Tag = 99
      Left = 436
      Top = 58
      Width = 109
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 6
      OnKeyPress = edtLocFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnPesquisar: TBitBtnLocked
      Left = 671
      Top = 58
      Width = 90
      Height = 22
      Caption = '&Pesquisar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 8
      OnClick = btnPesquisarClick
    end
    object btnLimpar: TBitBtnLocked
      Left = 764
      Top = 58
      Width = 90
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '&Limpar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 9
      OnClick = btnLimparClick
    end
    object mskHorMov: TMaskEditFocus
      Tag = 99
      Left = 80
      Top = 20
      Width = 60
      Height = 22
      EditMask = '!99:99;1;_'
      MaxLength = 5
      TabOrder = 1
      Text = '  :  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 86
    Width = 1107
    Height = 417
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitHeight = 418
    object cxgItensView: TcxGridDBBandedTableViewCitel
      OnDblClick = cxgItensViewDblClick
      OnKeyDown = cxgItensViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.DataSource = dtsDivergencias
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.BandsQuickCustomization = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsSelection.CheckBoxPosition = cbpIndicator
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      Bands = <
        item
          Caption = 'Separador - Coletor'
          Width = 969
        end
        item
          Caption = 'Controladoria'
          Width = 103
        end>
      Zebra = True
      Destaque = False
      DestacarRegistro = False
      CorZebra = clMoneyGreen
      object cxgItensDTACAD: TcxGridDBBandedColumn
        Caption = 'Data'
        DataBinding.FieldName = 'SIN_DTACAD'
        MinWidth = 100
        Options.Editing = False
        Options.Focusing = False
        Width = 100
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensOPESEP: TcxGridDBBandedColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'SIN_OPESEP'
        Options.Editing = False
        Width = 51
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensCODITE: TcxGridDBBandedColumn
        Caption = 'Item'
        DataBinding.FieldName = 'ITE_CODDES'
        Options.Editing = False
        Width = 292
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensLOCFIS: TcxGridDBBandedColumn
        Caption = 'Localiza'#231#227'o'
        DataBinding.FieldName = 'SIN_LOCFIS'
        Options.Editing = False
        Options.Focusing = False
        Width = 96
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensNUMLOT: TcxGridDBBandedColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'LOT_NUMLOT'
        MinWidth = 120
        Options.Editing = False
        Options.Focusing = False
        Width = 120
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensQTDSEP: TcxGridDBBandedColumn
        Caption = 'Qtd. Separa'#231#227'o'
        DataBinding.FieldName = 'SIN_QTDSEP'
        MinWidth = 90
        Options.Editing = False
        Options.Focusing = False
        Width = 90
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensSALINF: TcxGridDBBandedColumn
        Caption = 'Saldo Restante Inf.'
        DataBinding.FieldName = 'SIN_SALINF'
        MinWidth = 100
        Options.Editing = False
        Options.Focusing = False
        Width = 100
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensSALSIS: TcxGridDBBandedColumn
        Caption = 'Saldo Sistema'
        DataBinding.FieldName = 'SIN_SALSIS'
        Options.Editing = False
        Width = 58
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgItensDIVERG: TcxGridDBBandedColumn
        Caption = 'Diverg'#234'ncia'
        DataBinding.FieldName = 'SIN_DIVERG'
        Options.Editing = False
        Width = 62
        Position.BandIndex = 0
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgItensAJUSTE: TcxGridDBBandedColumn
        Caption = 'Ajuste Estoque'
        DataBinding.FieldName = 'SIN_AJUSTE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        FooterAlignmentHorz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 90
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensSELECT: TcxGridDBBandedColumn
        Caption = 'Selecionado'
        DataBinding.FieldName = 'ITE_SELECT'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pgbItens: TcxProgressBar [4]
    Left = 0
    Top = 503
    Align = alBottom
    TabOrder = 4
    Visible = False
    ExplicitTop = 504
    Width = 1107
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 784
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 880
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 832
    Top = 65528
  end
  object dtsDivergencias: TDataSource
    Left = 424
    Top = 224
  end
  object SaveDialog: TSaveDialog
    Left = 672
    Top = 352
  end
  object mnuExportar: TPopupMenu
    Left = 344
    Top = 480
    object mnuExpExcel: TMenuItem
      Caption = 'Excel'
      OnClick = mnuExpExcelClick
    end
    object mnuExpPDF: TMenuItem
      Caption = 'PDF'
      OnClick = mnuExpPDFClick
    end
    object mnuExpCSV: TMenuItem
      Caption = 'CSV'
      OnClick = mnuExpCSVClick
    end
  end
  object frxRelPDF: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42333.440664919000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 176
    Top = 392
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'NOMEMP'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 14.362204724409450000
        ParentFont = False
        Top = 177.637910000000000000
        Width = 1065.827460000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1065.827460000000000000
          Height = 14.362204724409450000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object mmoTipoOcorrencia: TfrxMemoView
          Left = 1.889763780000000000
          Width = 88.818902520000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIN_DTACAD"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo10: TfrxMemoView
          Left = 152.149606300000000000
          Width = 302.362260870000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODDES"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 458.362204720000000000
          Width = 109.606321180000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIN_LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 572.866420000000000000
          Width = 113.385900000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOT_NUMLOT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 691.472790000000000000
          Width = 64.252010000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SIN_QTDSEP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 94.795275590000000000
          Width = 52.913393150000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIN_OPESEP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 762.504330000000000000
          Width = 79.370130000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SIN_SALINF"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 845.874460000000000000
          Width = 68.031540000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SIN_SALSIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 918.614720000000000000
          Width = 71.811070000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SIN_DIVERG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 995.016390000000000000
          Width = 52.913420000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SIN_AJUSTE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.661410000000000000
        ParentFont = False
        Top = 253.228510000000000000
        Width = 1065.827460000000000000
        object rllNomeForm: TfrxMemoView
          Align = baLeft
          Top = 5.661410000000000000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'frmDivergenciasSeparacaoColetor.frxRelPDF')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baRight
          Left = 710.627460000000000000
          Top = 5.661410000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 1065.827460000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 136.063080000000000000
        Width = 1065.827460000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1065.827460000000000000
          Height = 17.000000000000000000
          Fill.BackColor = clSilver
        end
        object rllData: TfrxMemoView
          Left = 1.889763780000000000
          Width = 88.818902520000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data / Hora')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 94.929190000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Operador')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 152.283550000000000000
          Width = 302.362400000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Item')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 458.496290000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Localiza'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 572.866420000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Lote')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 690.472790000000000000
          Top = 1.000000000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Qtd. Sep.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 761.504330000000000000
          Top = 1.000000000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sal. Res. Inf.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 844.874460000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sal. Sistema')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 917.614720000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Diverg'#234'ncia')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 994.016390000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Ajuste')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 54.747990000000000000
        Top = 18.897650000000000000
        Width = 1065.827460000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 274.885375000000000000
          Top = 21.102350000000000000
          Width = 516.056710000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Diverg'#234'ncias de Separa'#231#227'o - Coletor')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 950.627460000000000000
          Top = 15.102350000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Align = baRight
          Left = 998.627460000000000000
          Top = 32.102350000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Align = baRight
          Left = 907.843230000000000000
          Top = 32.102350000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 49.692950000000000000
          Width = 1065.827460000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 168.113730000000000000
          Top = 0.102350000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 176
    Top = 344
  end
  object frxExpPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 176
    Top = 288
  end
end
