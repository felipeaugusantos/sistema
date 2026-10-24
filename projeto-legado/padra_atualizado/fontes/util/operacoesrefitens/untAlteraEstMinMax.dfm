inherited frmAlteraEstMinMax: TfrmAlteraEstMinMax
  Width = 800
  Height = 733
  Caption = 'Manuten'#231#227'o de Estoque M'#237'nimo e Estoque M'#225'ximo'
  WindowState = wsMaximized
  ExplicitWidth = 800
  ExplicitHeight = 733
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 650
    Width = 784
    ExplicitTop = 650
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Left = 120
      Width = 241
      Align = alLeft
      TabOrder = 1
      ExplicitLeft = 120
      ExplicitWidth = 241
    end
    inherited btnSair: TBitBtnLocked
      Left = 705
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 705
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnConfirmar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 118
      Height = 24
      Align = alLeft
      Caption = '[ F10 ] Confirmar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 678
    Width = 784
    ExplicitTop = 678
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
      object shpMultSel: TShape
        Left = 591
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Anchors = [akTop, akRight]
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited pnlHeader: TPanel
    Width = 784
    Height = 252
    ExplicitWidth = 784
    ExplicitHeight = 252
    object Label1: TLabel
      Left = 31
      Top = 11
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label2: TLabel
      Left = 47
      Top = 57
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 43
      Top = 78
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label4: TLabel
      Left = 459
      Top = 79
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label6: TLabel
      Left = 66
      Top = 100
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label8: TLabel
      Left = 40
      Top = 122
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lblCodEmp: TLabel
      Left = 50
      Top = 144
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label5: TLabel
      Left = 447
      Top = 149
      Width = 47
      Height = 14
      Caption = 'M'#234's/ano: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblPrdGru: TLabel
      Left = 26
      Top = 166
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Produto:'
    end
    object lblCodDep: TLabel
      Left = 29
      Top = 189
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento:'
    end
    object Label9: TLabel
      Left = 66
      Top = 33
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo'
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 101
      Top = 7
      Width = 67
      Height = 22
      CharCase = ecUpperCase
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 0
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 170
      Top = 7
      Width = 370
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 101
      Top = 53
      Width = 439
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Tag = 99
      Left = 101
      Top = 75
      Width = 351
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodUni: TEditFocus
      Tag = 99
      Left = 504
      Top = 75
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 6
      OnExit = edtCodUniExit
      OnKeyPress = edtCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 101
      Top = 97
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
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
      Left = 170
      Top = 97
      Width = 370
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
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
      Left = 101
      Top = 119
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 9
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
    object edtNomFor: TEditFocus
      Left = 170
      Top = 119
      Width = 370
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 101
      Top = 141
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 11
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 170
      Top = 141
      Width = 272
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskMesAno: TMaskEditFocus
      Tag = 99
      Left = 493
      Top = 141
      Width = 47
      Height = 22
      EditMask = '99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 13
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object rdgAtivo: TRadioGroup
      Left = 355
      Top = 208
      Width = 185
      Height = 41
      Caption = 'Ativo'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 19
      OnClick = rdgAtivoClick
      OnExit = rdgAtivoExit
    end
    object rdgMeses: TRadioGroup
      Left = 104
      Top = 208
      Width = 185
      Height = 41
      Caption = 'Quantidade de Meses para C'#225'lculo'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        '3'
        '6'
        '12')
      TabOrder = 18
      OnClick = rdgMesesClick
    end
    object edtPrdGru: TEditFocus
      Tag = 99
      Left = 101
      Top = 163
      Width = 69
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 14
      OnExit = edtPrdGruExit
      OnKeyPress = edtPrdGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesPrdGru: TEditFocus
      Left = 170
      Top = 163
      Width = 370
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 101
      Top = 185
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
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
      Left = 170
      Top = 185
      Width = 370
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 17
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
      Left = 101
      Top = 30
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
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
    object edtProdutos: TEditFocus
      Left = 170
      Top = 30
      Width = 370
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnCarregar: TBitBtnLocked
      Left = 547
      Top = 219
      Width = 99
      Height = 25
      Caption = '&Carregar'
      TabOrder = 20
      OnClick = btnCarregarClick
    end
  end
  inherited pnlTail: TPanel
    Top = 609
    Width = 784
    Height = 41
    Visible = True
    ExplicitTop = 609
    ExplicitWidth = 784
    ExplicitHeight = 41
    object Shape3: TShape
      Left = 113
      Top = 6
      Width = 15
      Height = 15
      Brush.Color = clRed
    end
    object Label7: TLabel
      Left = 134
      Top = 8
      Width = 115
      Height = 14
      Caption = 'Qtd M'#233'dia > Est. M'#225'x.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Shape1: TShape
      Left = 272
      Top = 6
      Width = 15
      Height = 15
      Brush.Color = clYellow
    end
    object Label10: TLabel
      Left = 292
      Top = 7
      Width = 256
      Height = 14
      Caption = 'Qtd M'#233'dia >= Est. Min. e Qtd M'#233'dia <= Est. M'#225'x. '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Shape2: TShape
      Left = 573
      Top = 6
      Width = 15
      Height = 15
      Brush.Color = clSkyBlue
    end
    object Label11: TLabel
      Left = 594
      Top = 8
      Width = 113
      Height = 14
      Caption = 'Qtd M'#233'dia < Est. Min.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Shape4: TShape
      Left = 11
      Top = 6
      Width = 15
      Height = 15
      Brush.Color = clAqua
    end
    object Label12: TLabel
      Left = 32
      Top = 8
      Width = 54
      Height = 14
      Caption = 'Alterados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object prgProgresso: TProgressBar
      Left = 0
      Top = 28
      Width = 784
      Height = 13
      Align = alBottom
      Smooth = True
      TabOrder = 0
      Visible = False
    end
  end
  inherited pnlPesquisa: TPanel
    Top = 252
    Width = 784
    Height = 39
    ExplicitTop = 252
    ExplicitWidth = 784
    ExplicitHeight = 39
    object lblPesquisa: TLabel
      Left = 8
      Top = 16
      Width = 70
      Height = 14
      Caption = '&Pesquisar por '
    end
    object lblNomeCampo: TLabel
      Left = 80
      Top = 16
      Width = 73
      Height = 14
      Caption = 'DET_MMMMMM'
    end
    object edtData: TMaskEditFocus
      Left = 160
      Top = 8
      Width = 73
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNumero: TEditFocus
      Left = 232
      Top = 8
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtString: TEditFocus
      Left = 304
      Top = 8
      Width = 329
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValor: TEditFocus
      Tag = 99
      Left = 632
      Top = 8
      Width = 77
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,####0.0000'
    end
  end
  inherited dbgConsulta: TcxGridCitel
    Top = 291
    Width = 784
    Height = 222
    ExplicitTop = 291
    ExplicitWidth = 784
    ExplicitHeight = 222
    inherited dbgConsultaDados: TcxGridDBTableViewCitel
      OnCustomDrawCell = dbgConsultaDadosCustomDrawCell
      OnEditKeyDown = dbgConsultaDBTableView1EditKeyDown
      OptionsView.GroupByBox = False
      object dbgConsultaALTERA: TcxGridDBColumn
        Caption = 'Alterado'
        DataBinding.FieldName = 'ALTERA'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taCenter
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
      end
      object dbgConsultaCODEMP: TcxGridDBColumn
        Caption = 'Emp'
        DataBinding.FieldName = 'CODEMP'
        Options.Editing = False
        Width = 35
      end
      object dbgConsultaCODITE: TcxGridDBColumn
        Caption = 'C'#243'd.Item'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 83
      end
      object dbgConsultaDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 196
      end
      object dbgConsultaREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Options.Editing = False
        Width = 101
      end
      object dbgConsultaSIGUNI: TcxGridDBColumn
        Caption = 'Unid.'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
      end
      object dbgConsultaSAIME0: TcxGridDBColumn
        Caption = 'M'#234's-01/00'
        DataBinding.FieldName = 'SAIME0'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME1: TcxGridDBColumn
        Caption = 'M'#234's-02/00'
        DataBinding.FieldName = 'SAIME1'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME2: TcxGridDBColumn
        Caption = 'M'#234's-03/00'
        DataBinding.FieldName = 'SAIME2'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME3: TcxGridDBColumn
        Caption = 'M'#234's-04/00'
        DataBinding.FieldName = 'SAIME3'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME4: TcxGridDBColumn
        Caption = 'M'#234's-05/00'
        DataBinding.FieldName = 'SAIME4'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME5: TcxGridDBColumn
        Caption = 'M'#234's-06/00'
        DataBinding.FieldName = 'SAIME5'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME6: TcxGridDBColumn
        Caption = 'M'#234's-07/00'
        DataBinding.FieldName = 'SAIME6'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME7: TcxGridDBColumn
        Caption = 'M'#234's-08/00'
        DataBinding.FieldName = 'SAIME7'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME8: TcxGridDBColumn
        Caption = 'M'#234's-09/00'
        DataBinding.FieldName = 'SAIME8'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME9: TcxGridDBColumn
        Caption = 'M'#234's-10/00'
        DataBinding.FieldName = 'SAIME9'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME10: TcxGridDBColumn
        Caption = 'M'#234's-11/00'
        DataBinding.FieldName = 'SAIME10'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME11: TcxGridDBColumn
        Caption = 'M'#234's-12/00'
        DataBinding.FieldName = 'SAIME11'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaSAIME12: TcxGridDBColumn
        Caption = 'M'#234's-13/00'
        DataBinding.FieldName = 'SAIME12'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object dbgConsultaMEDIAM: TcxGridDBColumn
        Caption = 'M'#233'dia'
        DataBinding.FieldName = 'MEDIAM'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 93
      end
      object dbgConsultaSALDOS: TcxGridDBColumn
        Caption = 'Saldo Estoq.'
        DataBinding.FieldName = 'SALDOS'
        Options.Editing = False
        Width = 78
      end
      object dbgConsultaMLTCOM: TcxGridDBColumn
        Caption = 'M'#250'lt.Compra'
        DataBinding.FieldName = 'MLTCOM'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 82
      end
      object dbgConsultaALTMIN: TcxGridDBColumn
        Caption = 'Est.M'#237'nimo'
        DataBinding.FieldName = 'ALTMIN'
        HeaderAlignmentHorz = taRightJustify
        Width = 91
      end
      object dbgConsultaALTMAX: TcxGridDBColumn
        Caption = 'Est.M'#225'ximo'
        DataBinding.FieldName = 'ALTMAX'
        HeaderAlignmentHorz = taRightJustify
        Width = 99
      end
      object dbgConsultaDadosPONEXP: TcxGridDBColumn
        Caption = 'Ponto Exposi'#231#227'o'
        DataBinding.FieldName = 'PONEXP'
        MinWidth = 93
        Width = 93
      end
      object dbgConsultaLOCALT: TcxGridDBColumn
        Caption = 'Loc. F'#237'sica'
        DataBinding.FieldName = 'LOCALT'
        Width = 142
      end
      object dbgConsultaSUPALT: TcxGridDBColumn
        Caption = 'Sup. Estoque'
        DataBinding.FieldName = 'SUPALT'
        Width = 122
      end
      object dbgConsultaFABALT: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'FABALT'
        Width = 117
      end
      object dbgConsultaMINDIG: TcxGridDBColumn
        Caption = 'Estoq. M'#237'n. Digitado'
        DataBinding.FieldName = 'MINDIG'
        Options.Editing = False
        Width = 109
      end
      object dbgConsultaMAXDIG: TcxGridDBColumn
        Caption = 'Estoq. M'#225'x. Digitado'
        DataBinding.FieldName = 'MAXDIG'
        Options.Editing = False
        Width = 109
      end
      object dbgConsultaPONPED: TcxGridDBColumn
        Caption = 'Ponto de Pedido'
        DataBinding.FieldName = 'PONPED'
        Options.Editing = False
        Width = 94
      end
      object dbgConsultaNIVGIR: TcxGridDBColumn
        Caption = 'N'#237'vel de Giro'
        DataBinding.FieldName = 'NIVGIR'
        Options.Editing = False
        Width = 88
      end
    end
  end
  object pnlAplicacao: TPanel [6]
    Left = 0
    Top = 513
    Width = 784
    Height = 96
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    Visible = False
    object pnlAplica: TPanel
      Left = 0
      Top = 0
      Width = 784
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Aplica'#231#227'o'
      TabOrder = 0
    end
    object mmoAplica: TDBMemoFocus
      Left = 0
      Top = 20
      Width = 784
      Height = 76
      Align = alBottom
      BorderStyle = bsNone
      DataField = 'APLICA'
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 392
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 304
  end
  inherited qryConsulta: TUniQuery
    Left = 160
    Top = 392
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 192
    Top = 392
  end
  inherited cdsConsulta: TUniClientDataSet
    BeforePost = cdsConsultaBeforePost
    Left = 224
    Top = 392
  end
  inherited dtsConsulta: TDataSource
    Left = 256
    Top = 392
  end
end
