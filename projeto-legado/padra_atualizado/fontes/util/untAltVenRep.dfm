inherited frmAltVenRep: TfrmAltVenRep
  Left = 246
  Top = 224
  Width = 610
  Height = 399
  BorderIcons = [biSystemMenu]
  Caption = 'Troca de Vendedores / Representante'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 610
  ExplicitHeight = 399
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 328
    Width = 604
    Height = 26
    TabOrder = 1
    ExplicitTop = 328
    ExplicitWidth = 604
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 78
      Width = 447
      Height = 22
      TabOrder = 2
      ExplicitLeft = 78
      ExplicitWidth = 447
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 525
      Top = 2
      Align = alRight
      ExplicitLeft = 525
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 76
      Height = 22
      Align = alLeft
      Caption = '&Confirma'
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
    Top = 354
    Width = 604
    TabOrder = 2
    ExplicitTop = 354
    ExplicitWidth = 604
    inherited pnlNomeForm: TPanel
      Left = 433
      ExplicitLeft = 433
    end
    inherited pnlInfo: TPanel
      Width = 433
      ExplicitWidth = 433
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 604
    Height = 328
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 79
      Top = 15
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label3: TLabel
      Left = 78
      Top = 63
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label5: TLabel
      Left = 516
      Top = 63
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object Label6: TLabel
      Left = 327
      Top = 249
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Status:'
    end
    object ColorLabel1: TColorLabel
      Left = 391
      Top = 249
      Width = 116
      Height = 14
      Caption = '(A)tivo (I)nativo (T)odos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label7: TLabel
      Left = 66
      Top = 111
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade:'
    end
    object Label10: TLabel
      Left = 115
      Top = 249
      Width = 131
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#227'o contactados acima de:'
    end
    object Label11: TLabel
      Left = 287
      Top = 249
      Width = 23
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'dias'
    end
    object Label4: TLabel
      Left = 17
      Top = 274
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vend / Rep Anterior:'
    end
    object Label2: TLabel
      Left = 30
      Top = 298
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vend / Rep Novo:'
    end
    object lblRegiao: TLabel
      Left = 78
      Top = 87
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regi'#227'o:'
    end
    object Label9: TLabel
      Left = 42
      Top = 39
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rede de Lojas:'
    end
    object Label27: TLabel
      Left = 469
      Top = 111
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela de Pre'#231'o:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 115
      Top = 11
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 0
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
      Left = 182
      Top = 11
      Width = 410
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 115
      Top = 59
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 2
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
      Left = 182
      Top = 59
      Width = 327
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Left = 554
      Top = 59
      Width = 38
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtStatus: TEditFocus
      Tag = 99
      Left = 363
      Top = 245
      Width = 24
      Height = 22
      Alignment = taCenter
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 8
      Text = 'T'
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 115
      Top = 107
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 4
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAti: TEditFocus
      Left = 157
      Top = 107
      Width = 306
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtDiaCon: TEditFocus
      Tag = 99
      Left = 248
      Top = 245
      Width = 40
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 7
      Text = '0'
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtCodVe1: TEditFocus
      Tag = 99
      Left = 115
      Top = 270
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 9
      OnKeyPress = edtCodVe1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVe1: TEditFocus
      Left = 157
      Top = 270
      Width = 435
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVe2: TEditFocus
      Tag = 99
      Left = 115
      Top = 294
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 10
      OnKeyPress = edtCodVe2KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVe2: TEditFocus
      Left = 157
      Top = 294
      Width = 435
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pgbStatus: TProgressBar
      Left = 0
      Top = 320
      Width = 604
      Height = 8
      Align = alBottom
      Smooth = True
      TabOrder = 18
      Visible = False
    end
    object grpModoConsidVendaCli: TGroupBox
      Left = 114
      Top = 131
      Width = 480
      Height = 111
      Caption = '   Modo de considerar as vendas do cliente   '
      TabOrder = 6
      object grpPeriodoVendas: TGroupBox
        Left = 190
        Top = 16
        Width = 288
        Height = 93
        Align = alClient
        Caption = '                                     '
        TabOrder = 1
        object lblVlrMinFat: TLabel
          Left = 5
          Top = 69
          Width = 139
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor m'#237'nimo de faturamento:'
        end
        object lblQtdMinDocVen: TLabel
          Left = 5
          Top = 45
          Width = 218
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade m'#237'nima de documentos de venda:'
        end
        object lblPeriodoFat: TLabel
          Left = 5
          Top = 21
          Width = 117
          Height = 14
          Alignment = taRightJustify
          Caption = 'Per'#237'odo de Faturamento:'
        end
        object Label8: TLabel
          Left = 188
          Top = 21
          Width = 23
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'at'#233
        end
        object chkPeriodoVendas: TCheckBox
          Left = 9
          Top = 0
          Width = 114
          Height = 17
          Caption = 'Per'#237'odo de vendas'
          TabOrder = 0
          OnClick = chkPeriodoVendasClick
        end
        object edtVlrMinFat: TEditFocus
          Tag = 99
          Left = 148
          Top = 66
          Width = 117
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 4
          Text = '0,00'
          OnKeyPress = edtCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtQtdMinDocVen: TEditFocus
          Tag = 99
          Left = 225
          Top = 42
          Width = 40
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 3
          Text = '0'
          OnKeyPress = edtCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttInteiro
        end
        object mskDtaIni: TMaskEditFocus
          Tag = 99
          Left = 125
          Top = 18
          Width = 62
          Height = 22
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object mskDtaFin: TMaskEditFocus
          Tag = 99
          Left = 213
          Top = 17
          Width = 62
          Height = 22
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 2
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
      object grpDiasNaoCompra: TGroupBox
        Left = 2
        Top = 16
        Width = 188
        Height = 93
        Align = alLeft
        Caption = '                                          '
        TabOrder = 0
        object lblNaoCompraAcima: TLabel
          Left = 7
          Top = 21
          Width = 107
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#227'o compra acima de:'
        end
        object lblDias: TLabel
          Left = 158
          Top = 21
          Width = 23
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'dias'
        end
        object edtNaoCompraAcima: TEditFocus
          Tag = 99
          Left = 116
          Top = 18
          Width = 40
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 1
          Text = '0'
          OnKeyPress = edtCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttInteiro
        end
        object chkDiasNaoCompra: TCheckBox
          Left = 9
          Top = 0
          Width = 125
          Height = 17
          Caption = 'Dias que n'#227'o compra'
          TabOrder = 0
          OnClick = chkDiasNaoCompraClick
        end
        object chkNuncaComprou: TCheckBox
          Left = 9
          Top = 46
          Width = 125
          Height = 17
          Caption = 'Nunca Comprou'
          TabOrder = 2
          OnClick = chkNuncaComprouClick
        end
      end
    end
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 115
      Top = 83
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 3
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
      Left = 182
      Top = 83
      Width = 410
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRed: TEditFocus
      Tag = 99
      Left = 115
      Top = 35
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 1
      OnKeyPress = edtCodRedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesRed: TEditFocus
      Left = 182
      Top = 35
      Width = 410
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object cmbTabPre: TComboBoxFocus
      Left = 554
      Top = 107
      Width = 38
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 5
      Items.Strings = (
        ''
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 216
  end
end
