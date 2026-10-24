inherited frmBalancoEstoqueZerarSaldo: TfrmBalancoEstoqueZerarSaldo
  Left = 240
  Top = 118
  Width = 924
  Height = 602
  BorderStyle = bsSingle
  Caption = 'Balan'#231'o de Estoque - Zerar Contagem'
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 924
  ExplicitHeight = 602
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 547
    Width = 918
    TabOrder = 2
    ExplicitTop = 547
    ExplicitWidth = 918
    inherited FlwBotoes: TFlowPanel
      Width = 914
      ExplicitWidth = 914
      inherited btnConfirma: TBitBtnLocked
        Width = 141
        Caption = '[F10] &Confirma'
        ExplicitWidth = 141
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 835
      ExplicitLeft = 835
    end
  end
  inherited pnlStatus: TPanel
    Top = 531
    Width = 918
    TabOrder = 3
    ExplicitTop = 531
    ExplicitWidth = 918
    inherited pnlNomeForm: TPanel
      Left = 747
      ExplicitLeft = 747
    end
    inherited pnlInfo: TPanel
      Width = 747
      ExplicitWidth = 747
    end
    inherited pnlBotoesTrace: TPanel
      inherited btnPausarTrace: TSpeedButton
        ExplicitHeight = 12
      end
      inherited btnSalvarTrace: TSpeedButton
        ExplicitHeight = 12
      end
      inherited btnViewerTrace: TSpeedButton
        ExplicitHeight = 12
      end
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 918
    Height = 343
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 14
      Top = 155
      Width = 87
      Height = 14
      Caption = 'Localiza'#231#227'o Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 224
      Top = 154
      Width = 83
      Height = 14
      Caption = 'Localiza'#231#227'o Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 14
      Top = 77
      Width = 59
      Height = 14
      Caption = 'Linha/Grupo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 14
      Top = 192
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 14
      Top = 229
      Width = 30
      Height = 14
      Caption = 'Marca'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 15
      Top = 116
      Width = 14
      Height = 14
      Caption = 'UN'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 14
      Top = 5
      Width = 37
      Height = 14
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 14
      Top = 40
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDepartamento: TLabel
      Left = 14
      Top = 264
      Width = 67
      Height = 14
      Caption = 'Departamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblGrupo: TLabel
      Left = 14
      Top = 299
      Width = 30
      Height = 14
      Caption = 'Grupo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 439
      Top = 5
      Width = 27
      Height = 14
      Caption = 'Saldo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtLocIni: TEditFocus
      Tag = 99
      Left = 14
      Top = 171
      Width = 200
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnExit = edtLocIniExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocFin: TEditFocus
      Tag = 99
      Left = 224
      Top = 171
      Width = 200
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 91
      Width = 55
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 74
      Top = 91
      Width = 350
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
      ParentFont = False
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 91
      Top = 206
      Width = 333
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
      ParentFont = False
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 14
      Top = 206
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 6
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 14
      Top = 243
      Width = 51
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
      TabOrder = 7
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMar: TEditFocus
      Left = 68
      Top = 243
      Width = 356
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
      ParentFont = False
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodUni: TEditFocus
      Tag = 99
      Left = 15
      Top = 130
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 3
      OnExit = edtCodUniExit
      OnKeyPress = edtCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object edtDesUni: TEditFocus
      Left = 60
      Top = 130
      Width = 364
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
      ParentFont = False
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 74
      Top = 19
      Width = 350
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 10
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
      Left = 14
      Top = 19
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      OnEnter = edtCodIteEnter
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
    object edtDescricao: TEditFocus
      Left = 14
      Top = 56
      Width = 410
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 14
      Top = 278
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 8
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDep: TEditFocus
      Left = 87
      Top = 278
      Width = 337
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
      ParentFont = False
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodGrupo: TEditFocus
      Tag = 99
      Left = 14
      Top = 313
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 9
      OnExit = edtCodGrupoExit
      OnKeyPress = edtCodGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object EdtDesGru: TEditFocus
      Left = 87
      Top = 313
      Width = 337
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
      ParentFont = False
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cmbSaldo: TComboBoxFocus
      Tag = 99
      Left = 439
      Top = 19
      Width = 80
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 2
      TabOrder = 17
      Text = 'TODOS'
      Items.Strings = (
        'POSITIVO'
        'NEGATIVO'
        'TODOS')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object btnFiltrosLocalizacao: TBitBtnLocked
      Left = 426
      Top = 170
      Width = 220
      Height = 23
      Caption = '[F9] Importar Filtros Localiza'#231#227'o'
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
      TabOrder = 18
      OnClick = btnFiltrosLocalizacaoClick
    end
    object btnHlpImp: TBitBtnLocked
      Left = 649
      Top = 170
      Width = 24
      Height = 22
      Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000800000010000000100000
        0008000000010000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
        0B60000000070000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
        27EA0000000E0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
        30EC0000000D0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
        1A51000000050000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000600000011000000140000
        000A000000020000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000670503AA999532EFF4528
        187A000000070000000100000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
        4AF724150D490000000800000002000000000000000000000000000000000000
        0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
        9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
        000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
        AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
        00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
        76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
        000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
        70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
        000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
        C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
        0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
        77E570533B9A17100A2500000002000000000000000000000000000000000000
        0000000000000000000000000000000000010000000100000002000000030000
        0002000000020000000100000000000000000000000000000000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 19
      OnClick = btnHlpImpClick
    end
  end
  object cxgDados: TcxGridCitel [3]
    Left = 0
    Top = 343
    Width = 918
    Height = 188
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDadosDBTableViewCitel: TcxGridDBTableViewCitel
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
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDadosDBTableViewCitelITE_CODGRU: TcxGridDBColumn
        Caption = 'Lin/Grupo'
        DataBinding.FieldName = 'ITE_CODGRU'
        Options.Focusing = False
      end
      object cxgDadosDBTableViewCitelITE_CODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        Options.Focusing = False
        Width = 48
      end
      object cxgDadosDBTableViewCitelITE_DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Focusing = False
        Width = 237
      end
      object cxgDadosDBTableViewCitelITE_NUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'ITE_NUMLOT'
        Options.Focusing = False
        Width = 86
      end
      object cxgDadosDBTableViewCitelITE_SALCON: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'ITE_SALCON'
        Options.Focusing = False
        Width = 73
      end
      object cxgDadosDBTableViewCitelUNI_SIGUNI: TcxGridDBColumn
        Caption = 'Unid.'
        DataBinding.FieldName = 'UNI_SIGUNI'
        Options.Focusing = False
        Width = 38
      end
      object cxgDadosDBTableViewCitelITE_LOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o'
        DataBinding.FieldName = 'ITE_LOCFIS'
        Options.Focusing = False
        Width = 120
      end
      object cxgDadosDBTableViewCitelITE_ITEATI: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'ITE_ITEATI'
        Options.Focusing = False
      end
    end
    object cxgDadosLevel1: TcxGridLevel
      GridView = cxgDadosDBTableViewCitel
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 12
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 208
  end
  object odgSelectFile: TOpenDialog
    Filter = 'Planilhas|*.xls;*.xlsx;*.csv'
    Left = 464
    Top = 128
  end
end
