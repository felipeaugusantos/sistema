inherited frmFatExpedicaoBusca: TfrmFatExpedicaoBusca
  Width = 539
  Height = 907
  BorderIcons = [biSystemMenu]
  Caption = 'Expedi'#231#227'o - Busca'
  Position = poScreenCenter
  ExplicitWidth = 539
  ExplicitHeight = 907
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 834
    Width = 533
    TabOrder = 1
    ExplicitTop = 834
    ExplicitWidth = 533
    inherited FlwBotoes: TFlowPanel
      Width = 529
      TabOrder = 2
      ExplicitWidth = 529
    end
    inherited btnSair: TBitBtnLocked
      Left = 452
      ExplicitLeft = 452
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirmar'
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
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 862
    Width = 533
    ParentColor = True
    TabOrder = 2
    ExplicitTop = 862
    ExplicitWidth = 533
    inherited pnlNomeForm: TPanel
      Left = 362
      ExplicitLeft = 362
    end
    inherited pnlInfo: TPanel
      Width = 362
      ExplicitWidth = 362
      object shpMultSel: TShape
        Left = 344
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 310
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 81
    Width = 533
    Height = 753
    Align = alClient
    ParentColor = True
    TabOrder = 0
    object pnlFiltros: TPanel
      Left = 1
      Top = 191
      Width = 531
      Height = 561
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 3
      object pnlSomenteCliFil: TPanel
        Left = 0
        Top = 522
        Width = 531
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 11
        object chkSomenteCliFil: TCheckBox
          Tag = 99
          Left = 107
          Top = 2
          Width = 272
          Height = 19
          Caption = 'Somente documentos de cliente filial'
          TabOrder = 0
          WordWrap = True
        end
      end
      object pnlTopo: TPanel
        Left = 0
        Top = 25
        Width = 531
        Height = 138
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 1
        object lblVendedor: TLabel
          Left = 56
          Top = 4
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vendedor:'
        end
        object lblPedido: TLabel
          Left = 71
          Top = 73
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pedido:'
        end
        object Label4: TLabel
          Left = 71
          Top = 96
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente:'
        end
        object lblEspecie: TLabel
          Left = 188
          Top = 73
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'Especie:'
        end
        object lblSepImp: TLabel
          Left = 282
          Top = 73
          Width = 103
          Height = 14
          Alignment = taRightJustify
          Caption = 'Separa'#231#227'o Impressa:'
        end
        object ColorLabel13: TColorLabel
          Left = 418
          Top = 73
          Width = 102
          Height = 14
          Caption = '(S)im (N)'#227'o (T)odos  '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object lblDeptoVendedor: TLabel
          Left = 7
          Top = 27
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Depto. do Vendedor:'
        end
        object lblTransp: TLabel
          Left = 28
          Top = 119
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Transportadora:'
        end
        object lblEmp: TLabel
          Left = 61
          Top = 50
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object edtCodVen: TEditFocus
          Tag = 99
          Left = 107
          Top = 0
          Width = 79
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 0
          OnEnter = edtNumLotEnter
          OnExit = edtCodVenExit
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtNumPed: TEditFocus
          Tag = 99
          Left = 107
          Top = 69
          Width = 79
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 12
          TabOrder = 1
          OnEnter = edtNumLotEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttNumerico
        end
        object edtCodCli: TEditFocus
          Tag = 99
          Left = 107
          Top = 92
          Width = 79
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 8
          TabOrder = 8
          OnEnter = edtNumLotEnter
          OnExit = edtCodCliExit
          OnKeyPress = edtCodCliKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomCli: TEditFocus
          Left = 187
          Top = 92
          Width = 333
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtNomVen: TEditFocus
          Left = 187
          Top = 0
          Width = 333
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEspecie: TEditFocus
          Tag = 99
          Left = 242
          Top = 69
          Width = 25
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 2
          TabOrder = 6
          OnEnter = edtNumLotEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object edtSepImp: TEditFocus
          Tag = 99
          Left = 387
          Top = 69
          Width = 23
          Height = 22
          Alignment = taCenter
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 7
          OnEnter = edtNumLotEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object edtCodDep: TEditFocus
          Tag = 99
          Left = 107
          Top = 23
          Width = 79
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 2
          OnEnter = edtNumLotEnter
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
        object edtNomDep: TEditFocus
          Left = 187
          Top = 23
          Width = 333
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtCodTra: TEditFocus
          Tag = 99
          Left = 107
          Top = 115
          Width = 79
          Height = 23
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 15
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          TabOrder = 11
          OnEnter = edtNumLotEnter
          OnExit = edtCodTraExit
          OnKeyPress = edtCodTraKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomTra: TEditFocus
          Left = 187
          Top = 115
          Width = 333
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 107
          Top = 46
          Width = 79
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 3
          TabOrder = 4
          OnEnter = edtCodEmpEnter
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
          Left = 187
          Top = 46
          Width = 333
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlOpeDes: TPanel
        Left = 0
        Top = 348
        Width = 531
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 10
        object lbl8: TLabel
          Left = 4
          Top = 4
          Width = 102
          Height = 14
          Caption = 'Operador designado:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodOpe: TEditFocus
          Tag = 99
          Left = 107
          Top = 1
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 0
          OnEnter = edtNumLotEnter
          OnExit = edtCodOpeExit
          OnKeyPress = edtCodOpeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtNomOpe: TEditFocus
          Left = 163
          Top = 1
          Width = 357
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlTopo2: TPanel
        Left = 0
        Top = 371
        Width = 531
        Height = 105
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 7
        object Label2: TLabel
          Left = 52
          Top = 41
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Inicial:'
        end
        object lbl1: TLabel
          Left = 182
          Top = 41
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Final:'
        end
        object Label3: TLabel
          Left = 70
          Top = 64
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Regi'#227'o:'
        end
        object Label6: TLabel
          Left = 345
          Top = 41
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'Urgente:'
        end
        object ColorLabel1: TColorLabel
          Left = 422
          Top = 41
          Width = 102
          Height = 14
          Caption = '(S)im (N)'#227'o (T)odos  '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label21: TLabel
          Left = 70
          Top = 87
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object mskDtaIni: TMaskEditFocus
          Tag = 99
          Left = 107
          Top = 37
          Width = 69
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          OnEnter = edtNumLotEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object rdgDatas: TRadioGroup
          Left = 106
          Top = 1
          Width = 414
          Height = 34
          Columns = 3
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ItemIndex = 0
          Items.Strings = (
            '(DATA DE ENTRADA)'
            '(DATA DE PREVIS'#195'O)'
            '(DATA DE ENTREGA)')
          ParentFont = False
          TabOrder = 0
        end
        object mskDtaFin: TMaskEditFocus
          Tag = 99
          Left = 240
          Top = 37
          Width = 71
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 2
          Text = '  /  /    '
          OnEnter = edtNumLotEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtCodReg: TEditFocus
          Tag = 99
          Left = 107
          Top = 60
          Width = 79
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 4
          OnEnter = edtNumLotEnter
          OnExit = edtCodRegExit
          OnKeyPress = edtCodRegKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesReg: TEditFocus
          Left = 188
          Top = 60
          Width = 332
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtUrgente: TEditFocus
          Tag = 99
          Left = 392
          Top = 37
          Width = 23
          Height = 22
          Alignment = taCenter
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 3
          OnEnter = edtNumLotEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object edtCodCid: TEditFocus
          Tag = 99
          Left = 107
          Top = 83
          Width = 79
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 6
          OnEnter = edtNumLotEnter
          OnExit = edtCodCidExit
          OnKeyPress = edtCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomCid: TEditFocus
          Left = 188
          Top = 83
          Width = 332
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlBarDoc: TPanel
        Left = 0
        Top = 0
        Width = 531
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object Label5: TLabel
          Left = 9
          Top = 8
          Width = 92
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'd. Barras Docto:'
        end
        object lblSeqOnd: TLabel
          Left = 312
          Top = 8
          Width = 119
          Height = 14
          Alignment = taRightJustify
          Caption = 'Remessa de Separa'#231#227'o:'
        end
        object edtBarDoc: TEditFocus
          Tag = 99
          Left = 107
          Top = 2
          Width = 122
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 18
          TabOrder = 0
          OnEnter = edtNumLotEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 18
          TipoTexto = ttInteiro
        end
        object edtSeqOnd: TEditFocus
          Tag = 99
          Left = 435
          Top = 2
          Width = 85
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 12
          TabOrder = 1
          OnEnter = edtNumLotEnter
          OnKeyPress = edtSeqOndKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttInteiro
        end
      end
      object pnlOrigem: TPanel
        Left = 0
        Top = 278
        Width = 531
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 4
        object Label7: TLabel
          Left = 69
          Top = 5
          Width = 37
          Height = 14
          Alignment = taRightJustify
          Caption = 'Origem:'
        end
        object Label10: TLabel
          Left = 269
          Top = 4
          Width = 163
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade de Produto no Pedido:'
        end
        object cmbOrigem: TComboBoxFocus
          Tag = 99
          Left = 107
          Top = 0
          Width = 154
          Height = 22
          Style = csDropDownList
          TabOrder = 0
          Items.Strings = (
            'TODAS'
            'BALC'#195'O'
            'POCKET'
            'SITE')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtQtdPro: TEditFocus
          Tag = 99
          Left = 435
          Top = 1
          Width = 36
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 1
          OnEnter = edtNumLotEnter
          OnExit = edtQtdProExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttInteiro
        end
      end
      object pnlProduto: TPanel
        Left = 0
        Top = 163
        Width = 531
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 2
        object Label15: TLabel
          Left = 9
          Top = 4
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Produto:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodIte: TEditFocus
          Tag = 99
          Left = 107
          Top = 1
          Width = 79
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnEnter = edtNumLotEnter
          OnExit = edtCodIteExit
          OnKeyPress = edtCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtDesIte: TEditFocus
          Left = 187
          Top = 1
          Width = 333
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlRomaneio: TPanel
        Left = 0
        Top = 324
        Width = 531
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 6
        object pnlRota: TPanel
          Left = 0
          Top = 0
          Width = 335
          Height = 24
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object lblDtaRot: TLabel
            Left = 26
            Top = 4
            Width = 80
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data da Entrega:'
          end
          object Label12: TLabel
            Left = 193
            Top = 4
            Width = 50
            Height = 14
            Caption = 'Seq. Rota:'
          end
          object mskDtaRot: TMaskEditFocus
            Tag = 99
            Left = 107
            Top = 1
            Width = 79
            Height = 22
            EditMask = '99/99/9999'
            MaxLength = 10
            TabOrder = 0
            Text = '  /  /    '
            OnEnter = edtNumLotEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtSeqRot: TEditFocus
            Tag = 99
            Left = 245
            Top = 1
            Width = 77
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 8
            TabOrder = 1
            OnEnter = edtNumLotEnter
            OnExit = edtSeqRotExit
            OnKeyPress = edtSeqRotKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
        end
        object pnlNumRom: TPanel
          Left = 335
          Top = 0
          Width = 185
          Height = 24
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object lblRomaneio: TLabel
            Left = 56
            Top = 4
            Width = 50
            Height = 14
            Caption = 'Romaneio:'
          end
          object edtRomaneio: TEditFocus
            Tag = 99
            Left = 107
            Top = 1
            Width = 77
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 6
            TabOrder = 0
            OnKeyPress = edtRomaneioKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 6
            TipoTexto = ttNumerico
          end
        end
      end
      object pnlEntRet: TPanel
        Left = 0
        Top = 301
        Width = 531
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 5
        object lblEntRet: TLabel
          Left = 67
          Top = 5
          Width = 39
          Height = 14
          Alignment = taRightJustify
          Caption = 'Destino:'
        end
        object cmbEntRet: TComboBoxFocus
          Tag = 99
          Left = 107
          Top = 0
          Width = 154
          Height = 22
          Style = csDropDownList
          Color = clBtnFace
          ItemIndex = 2
          TabOrder = 0
          Text = 'TODAS'
          OnChange = cmbEntRetChange
          Items.Strings = (
            'RETIRA'
            'ENTREGA'
            'TODAS')
          NormalColor = clBtnFace
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object pnlLocFis: TPanel
        Left = 0
        Top = 186
        Width = 531
        Height = 92
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 3
        object lblLocFis: TLabel
          Left = 51
          Top = 4
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Loc. Fisica:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtLocFis: TEditFocus
          Tag = 99
          Left = 107
          Top = 1
          Width = 413
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
          ParentFont = False
          TabOrder = 0
          OnEnter = edtNumLotEnter
          OnKeyPress = edtLocFisKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object gbSuperEstoque: TGroupBox
          Tag = 99
          Left = 277
          Top = 23
          Width = 243
          Height = 66
          Caption = 'Super Estoque'
          TabOrder = 2
          object Label16: TLabel
            Left = 10
            Top = 44
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'Loc. Fisica Inicial:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label17: TLabel
            Left = 14
            Top = 23
            Width = 80
            Height = 14
            Alignment = taRightJustify
            Caption = 'Loc. Fisica Final:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtLocFinSup: TEditFocus
            Tag = 99
            Left = 96
            Top = 38
            Width = 137
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 1
            OnEnter = edtNumLotEnter
            OnKeyPress = edtLocFinSupKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtLocIniSup: TEditFocus
            Tag = 99
            Left = 96
            Top = 15
            Width = 137
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
            ParentFont = False
            TabOrder = 0
            OnChange = edtLocIniSupChange
            OnEnter = edtNumLotEnter
            OnKeyPress = edtLocIniSupKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object gb1: TGroupBox
          Tag = 99
          Left = 9
          Top = 23
          Width = 252
          Height = 66
          Caption = 'Estoque'
          TabOrder = 1
          object Label18: TLabel
            Left = 13
            Top = 23
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'Loc. Fisica Inicial:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 17
            Top = 44
            Width = 80
            Height = 14
            Alignment = taRightJustify
            Caption = 'Loc. Fisica Final:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtLocFin: TEditFocus
            Tag = 99
            Left = 98
            Top = 39
            Width = 142
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 1
            OnEnter = edtNumLotEnter
            OnKeyPress = edtLocFinKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtLocIni: TEditFocus
            Tag = 99
            Left = 98
            Top = 16
            Width = 142
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
            ParentFont = False
            TabOrder = 0
            OnChange = edtLocIniChange
            OnEnter = edtNumLotEnter
            OnKeyPress = edtLocIniKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlTipAte: TPanel
        Left = 0
        Top = 476
        Width = 531
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 8
        object Label14: TLabel
          Left = 5
          Top = 4
          Width = 100
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Atendimento:'
        end
        object edtCodTpa: TEditFocus
          Tag = 99
          Left = 107
          Top = 1
          Width = 79
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 0
          OnEnter = edtNumLotEnter
          OnExit = edtCodTpaExit
          OnKeyPress = edtCodTpaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesTpa: TEditFocus
          Left = 188
          Top = 1
          Width = 332
          Height = 22
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
      end
      object Panel1: TPanel
        Left = 0
        Top = 499
        Width = 531
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 9
        object Label22: TLabel
          Left = 16
          Top = 4
          Width = 90
          Height = 14
          Alignment = taRightJustify
          Caption = 'Mensagem Pedido:'
        end
        object edtMsgPed: TEditFocus
          Tag = 99
          Left = 107
          Top = 1
          Width = 413
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 0
          OnEnter = edtNumLotEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlLocalDeArmazenamento: TPanel
        Left = 0
        Top = 546
        Width = 531
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 13
        object lblLocalArmazenamento: TLabel
          Left = 6
          Top = 5
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Local de Armazena.:'
        end
        object edtCodLar: TEditFocus
          Tag = 99
          Left = 107
          Top = 1
          Width = 79
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 0
          OnEnter = edtCodLarEnter
          OnExit = edtCodLarExit
          OnKeyPress = edtCodLarKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesLar: TEditFocus
          Left = 188
          Top = 1
          Width = 332
          Height = 22
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
      end
      object pnlFaturamentoTotal: TPanel
        Left = 0
        Top = 569
        Width = 531
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 12
        object lblFatTot: TLabel
          Left = 5
          Top = 6
          Width = 143
          Height = 14
          Alignment = taRightJustify
          Caption = 'Obrigat'#243'rio faturamento total?'
        end
        object cllFatTot: TColorLabel
          Left = 185
          Top = 5
          Width = 102
          Height = 14
          Caption = '(S)im (N)'#227'o (T)odos  '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtFatTot: TEditFocus
          Tag = 99
          Left = 154
          Top = 2
          Width = 23
          Height = 22
          Alignment = taCenter
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 0
          OnEnter = edtNumLotEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
      end
    end
    object pnlSeqSep: TPanel
      Left = 1
      Top = 26
      Width = 531
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      object lblSeqSep: TLabel
        Left = 10
        Top = 4
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Seq. de Separa'#231#227'o:'
      end
      object edtSeqSep: TEditFocus
        Tag = 99
        Left = 107
        Top = 1
        Width = 122
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 12
        TabOrder = 0
        OnEnter = edtNumLotEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 12
        TipoTexto = ttInteiro
      end
    end
    object pnlComanda: TPanel
      Left = 1
      Top = 1
      Width = 531
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object lblComanda: TLabel
        Left = 56
        Top = 5
        Width = 48
        Height = 14
        Caption = 'Comanda:'
      end
      object edtBarCom: TEditFocus
        Tag = 99
        Left = 107
        Top = 2
        Width = 148
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnEnter = edtNumLotEnter
        OnKeyPress = edtBarComKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 13
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlOndaSeparacao: TPanel
      Left = 1
      Top = 51
      Width = 531
      Height = 140
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 1
      object NBOndaSeparacao: TNotebook
        Left = 0
        Top = 53
        Width = 531
        Height = 87
        Align = alClient
        TabOrder = 1
        object TPage
          Left = 0
          Top = 0
          Caption = 'SELECAO'
          object lblQtdPedOnda: TLabel
            Left = 81
            Top = 56
            Width = 160
            Height = 14
            Alignment = taRightJustify
            Caption = 'Quantidade de pedidos por onda:'
          end
          object lblProdutosAte: TLabel
            Left = 141
            Top = 26
            Width = 15
            Height = 14
            Alignment = taRightJustify
            Caption = 'at'#233
          end
          object lblProdutosAte2: TLabel
            Left = 208
            Top = 26
            Width = 51
            Height = 14
            Alignment = taRightJustify
            Caption = 'produto(s)'
          end
          object lblMaxPedidos: TLabel
            Left = 106
            Top = 71
            Width = 106
            Height = 14
            Alignment = taRightJustify
            Caption = '(M'#225'ximo 500 pedidos)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblPesoOndaAte: TLabel
            Left = 450
            Top = 26
            Width = 15
            Height = 14
            Alignment = taRightJustify
            Caption = 'at'#233
          end
          object chkOndaSeparacaoUnicoProduto: TCheckBox
            Tag = 99
            Left = 8
            Top = 4
            Width = 206
            Height = 17
            Caption = 'Pedidos com apenas um '#250'nico produto'
            TabOrder = 0
            OnClick = chkOndaSeparacaoUnicoProdutoClick
          end
          object chkSemSeqSep: TCheckBox
            Tag = 99
            Left = 8
            Top = 67
            Width = 71
            Height = 17
            Caption = 'Sem SEQ.'
            Checked = True
            State = cbChecked
            TabOrder = 11
            Visible = False
            OnClick = chkSemSeqSepClick
          end
          object edtQtdPedOnda: TEditFocus
            Tag = 99
            Left = 245
            Top = 53
            Width = 50
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
          object chkSelPedOndaAut: TCheckBox
            Tag = 99
            Left = 301
            Top = 49
            Width = 103
            Height = 30
            Caption = 'Selecionar Automaticamente'
            TabOrder = 9
            WordWrap = True
          end
          object chkExclusivamentePedidosKits: TCheckBox
            Tag = 99
            Left = 411
            Top = 49
            Width = 103
            Height = 30
            Caption = 'Exclusivamente pedidos de Kits'
            TabOrder = 10
            WordWrap = True
            OnClick = chkExclusivamentePedidosKitsClick
          end
          object chkOndaSeparacaoVariosProdutos: TCheckBox
            Tag = 99
            Left = 8
            Top = 26
            Width = 83
            Height = 17
            Caption = 'Pedidos com '
            TabOrder = 2
            OnClick = chkOndaSeparacaoVariosProdutosClick
          end
          object edtQtdProOndaDe: TEditFocus
            Tag = 99
            Left = 94
            Top = 23
            Width = 42
            Height = 22
            Alignment = taCenter
            CharCase = ecUpperCase
            MaxLength = 6
            TabOrder = 3
            Text = '2'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
          object edtQtdProOnda: TEditFocus
            Tag = 99
            Left = 161
            Top = 23
            Width = 42
            Height = 22
            Alignment = taCenter
            CharCase = ecUpperCase
            MaxLength = 6
            TabOrder = 4
            Text = '999999'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
          object chkOndaSeparacaoPorPeso: TCheckBox
            Tag = 99
            Left = 278
            Top = 26
            Width = 124
            Height = 17
            Caption = 'Pedidos com peso de '
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 5
            OnClick = chkOndaSeparacaoPorPesoClick
          end
          object edtPesoOndaDe: TEditFocus
            Tag = 99
            Left = 405
            Top = 23
            Width = 40
            Height = 22
            Alignment = taCenter
            CharCase = ecUpperCase
            Enabled = False
            MaxLength = 4
            TabOrder = 6
            Text = '0'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
          object edtPesoOndaAte: TEditFocus
            Tag = 99
            Left = 470
            Top = 23
            Width = 40
            Height = 22
            Alignment = taCenter
            CharCase = ecUpperCase
            Enabled = False
            MaxLength = 4
            TabOrder = 7
            Text = '9999'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
          object chkOndaSeparacaoApenasFaturadorAutomatico: TCheckBox
            Left = 265
            Top = 4
            Width = 250
            Height = 17
            Caption = 'Apenas Pedidos com Faturamento Autom'#225'tico'
            TabOrder = 1
            WordWrap = True
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'FATURAMENTO'
          object lblNumeroOnda: TLabel
            Left = 38
            Top = 34
            Width = 110
            Height = 14
            Alignment = taRightJustify
            Caption = 'Seq. Onda Separa'#231#227'o:'
          end
          object edtNumeroOnda: TEditFocus
            Tag = 99
            Left = 154
            Top = 30
            Width = 122
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 12
            TabOrder = 0
            OnKeyPress = edtNumeroOndaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 12
            TipoTexto = ttInteiro
          end
          object chkSolicitaTelaDeVolume: TCheckBox
            Left = 285
            Top = 35
            Width = 137
            Height = 17
            Caption = 'Solicita tela de volume?'
            TabOrder = 1
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'NAO_UTILIZAR_ONDA'
        end
      end
      object rdgOndaSeparacao: TRadioGroup
        Left = 0
        Top = 0
        Width = 531
        Height = 53
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Onda de Separa'#231#227'o'
        Columns = 2
        ItemIndex = 2
        Items.Strings = (
          'Sele'#231#227'o de pedidos para gera'#231#227'o de onda'
          'Faturamento de onda'
          'N'#227'o utilizar onda de separa'#231#227'o')
        TabOrder = 0
        OnClick = rdgOndaSeparacaoClick
      end
    end
  end
  object pnlLoteSep: TPanel [3]
    Left = 0
    Top = 0
    Width = 533
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    object Label13: TLabel
      Left = 9
      Top = 6
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lote de Separa'#231#227'o:'
    end
    object lblEmpLote: TLabel
      Left = 181
      Top = 6
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emp. Lote:'
    end
    object Label23: TLabel
      Left = 9
      Top = 53
      Width = 50
      Height = 14
      Caption = 'Romaneio:'
    end
    object lblEmpresa: TLabel
      Left = 141
      Top = 53
      Width = 76
      Height = 14
      Caption = 'Emp. Romaneio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtNumLot: TEditFocus
      Tag = 99
      Left = 108
      Top = 2
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 1
      OnEnter = edtNumLotEnter
      OnKeyPress = edtNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodEmpLote: TEditFocus
      Tag = 99
      Left = 233
      Top = 2
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnEnter = edtNumLotEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpLote: TEditFocus
      Left = 289
      Top = 2
      Width = 232
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object ckbSelPedAut: TCheckBox
      Left = 9
      Top = 27
      Width = 239
      Height = 17
      Caption = 'Selecionar pedidos do lote automaticamente'
      TabOrder = 0
    end
    object edtNumRom: TEditFocus
      Tag = 99
      Left = 65
      Top = 50
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
      MaxLength = 6
      ParentFont = False
      TabOrder = 4
      OnEnter = edtNumLotEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtCodEmpRom: TEditFocus
      Tag = 99
      Left = 218
      Top = 50
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
      TabOrder = 5
      OnEnter = edtCodEmpRomEnter
      OnExit = edtCodEmpRomExit
      OnKeyPress = edtCodEmpRomKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpRom: TEditFocus
      Left = 289
      Top = 50
      Width = 232
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 656
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 624
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 104
  end
end
