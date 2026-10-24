inherited frmFatConfOrcamentos: TfrmFatConfOrcamentos
  Left = 220
  Top = 102
  Width = 810
  Height = 743
  BorderIcons = [biSystemMenu]
  Caption = 'Confirma'#231#227'o de Or'#231'amentos'
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 810
  ExplicitHeight = 743
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 659
    Width = 804
    Height = 39
    TabOrder = 5
    ExplicitTop = 659
    ExplicitWidth = 804
    ExplicitHeight = 39
    inherited FlwBotoes: TFlowPanel
      Width = 744
      Height = 35
      ExplicitWidth = 744
      ExplicitHeight = 35
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 35
        Caption = '[F10] Confirma'
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
        WordWrap = True
        OnClick = btnConfirmaClick
      end
      object btnEndEnt: TBitBtnLocked
        Left = 100
        Top = 0
        Width = 67
        Height = 35
        Caption = '[F2] End. Entrega'
        TabOrder = 1
        Visible = False
        WordWrap = True
        OnClick = btnEndEntClick
      end
      object btnAdicionarItens: TBitBtnLocked
        Left = 167
        Top = 0
        Width = 80
        Height = 35
        Caption = '[F3] Checkout'
        TabOrder = 2
        WordWrap = True
        OnClick = btnAdicionarItensClick
      end
      object btnEdiMod: TBitBtnLocked
        Left = 247
        Top = 0
        Width = 80
        Height = 35
        Caption = '[F5] Editar Modalidades'
        TabOrder = 3
        WordWrap = True
        OnClick = btnEdiModClick
      end
      object btnMsgNot: TBitBtnLocked
        Left = 327
        Top = 0
        Width = 56
        Height = 35
        Caption = '[F6] Msg Nota'
        TabOrder = 4
        Visible = False
        WordWrap = True
        OnClick = btnMsgNotClick
      end
      object btnAltCnd: TBitBtnLocked
        Left = 383
        Top = 0
        Width = 80
        Height = 35
        Caption = '[F7] Alt.Cnd.Pagto'
        TabOrder = 5
        WordWrap = True
        OnClick = btnAltCndClick
      end
      object btnGerarPDF: TBitBtnLocked
        Left = 463
        Top = 0
        Width = 56
        Height = 35
        Align = alLeft
        Caption = '[F8] Gerar PDF'
        TabOrder = 6
        WordWrap = True
        OnClick = btnGerarPDFClick
      end
      object btnConfRetiraCaixa: TBitBtnLocked
        Left = 519
        Top = 0
        Width = 80
        Height = 35
        Hint = 'Expedi'#231#227'o - Confer'#234'ncia de Produtos Retira Caixa'
        Align = alLeft
        Caption = '[F9] Conf. Retira Cx.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        Visible = False
        WordWrap = True
        OnClick = btnConfRetiraCaixaClick
      end
      object btnNumSeries: TBitBtnLocked
        Left = 599
        Top = 0
        Width = 80
        Height = 35
        Caption = '[Ctrl+F3] N'#250'm. S'#233'ries'
        TabOrder = 8
        Visible = False
        WordWrap = True
        OnClick = btnNumSeriesClick
      end
      object btnLerPinPad: TBitBtnLocked
        Left = 679
        Top = 0
        Width = 56
        Height = 35
        Caption = '[F11] Ler PinPad'
        TabOrder = 9
        TabStop = False
        Visible = False
        WordWrap = True
        OnClick = btnLerPinPadClick
      end
      object btnFatorServico: TBitBtnLocked
        Left = 0
        Top = 35
        Width = 67
        Height = 35
        Caption = '[F12] Fator Servi'#231'o'
        TabOrder = 10
        TabStop = False
        WordWrap = True
        OnClick = btnFatorServicoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 746
      Top = 2
      Width = 56
      Height = 33
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 2
      Align = alRight
      ExplicitLeft = 746
      ExplicitTop = 2
      ExplicitWidth = 56
      ExplicitHeight = 33
    end
  end
  inherited pnlStatus: TPanel
    Top = 698
    Width = 804
    TabOrder = 6
    ExplicitTop = 698
    ExplicitWidth = 804
    inherited pnlNomeForm: TPanel
      Left = 633
      ExplicitLeft = 633
    end
    inherited pnlInfo: TPanel
      Width = 633
      ExplicitWidth = 633
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 76
    Width = 804
    Height = 115
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      804
      115)
    object lblTipDoc: TLabel
      Left = 20
      Top = 12
      Width = 82
      Height = 18
      Alignment = taRightJustify
      Caption = 'Or'#231'amento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotIte: TLabel
      Left = 511
      Top = 38
      Width = 108
      Height = 18
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Total dos Itens:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 384
    end
    object lblEntRet: TLabel
      Left = 339
      Top = 10
      Width = 79
      Height = 19
      Caption = 'ENTREGA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 6
      Top = 38
      Width = 97
      Height = 18
      Alignment = taRightJustify
      Caption = 'Forma Pagto.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCreditos: TLabel
      Left = 634
      Top = 2
      Width = 143
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Cliente possui cr'#233'ditos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      ExplicitLeft = 507
    end
    object lblCadPag: TLabel
      Left = 7
      Top = 64
      Width = 95
      Height = 18
      Alignment = taRightJustify
      Caption = 'Cond. Pagto.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNumParcelas: TLabel
      Left = 634
      Top = 91
      Width = 127
      Height = 18
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'N'#250'm. de Parcelas:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 507
    end
    object edtNumOrc: TEditFocus
      Tag = 99
      Left = 104
      Top = 9
      Width = 102
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 18
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtNumOrcKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtTotGer: TEditFocus
      Left = 622
      Top = 20
      Width = 172
      Height = 20
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
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
    object edtCodFpg: TEditFocus
      Left = 104
      Top = 35
      Width = 229
      Height = 25
      TabStop = False
      Alignment = taLeftJustify
      AutoSize = False
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
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
      Left = 207
      Top = 9
      Width = 35
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnExit = edtCodEmpExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodPag: TEditFocus
      Left = 104
      Top = 61
      Width = 38
      Height = 25
      TabStop = False
      Alignment = taLeftJustify
      AutoSize = False
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
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
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 143
      Top = 61
      Width = 651
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesPag: TEditFocus
      Left = 104
      Top = 87
      Width = 520
      Height = 25
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
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
    object btnAgruparPedidos: TBitBtnLocked
      Left = 242
      Top = 8
      Width = 91
      Height = 27
      Caption = 'Agrupar Pedidos'
      TabOrder = 7
      OnClick = btnAgruparPedidosClick
    end
    object edtNumParcelas: TEditFocus
      Left = 766
      Top = 87
      Width = 28
      Height = 25
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
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
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 191
    Width = 804
    Height = 188
    Align = alClient
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      804
      188)
    object Label2: TLabel
      Left = 8
      Top = 1
      Width = 75
      Height = 16
      Caption = 'Modalidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 41
      Width = 33
      Height = 16
      Caption = 'Valor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 8
      Top = 86
      Width = 190
      Height = 92
    end
    object Label4: TLabel
      Left = 16
      Top = 87
      Width = 90
      Height = 16
      Caption = 'Valor Digitado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 16
      Top = 130
      Width = 35
      Height = 16
      Caption = 'Troco'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnDuplicatas: TSpeedButton
      Left = 359
      Top = -2
      Width = 361
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 
        'Pressione [F1] ou Clique aqui para visualizar as duplicatas orig' +
        'inais ...'
      Flat = True
      Glyph.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D0020000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        9E9E9EADADADAFAFAFABAAABACAFABB2AEAEA5AAACB2AEAFB2AFB0A8ACABA4A6
        A5FFFFFFFFFFFF000000FFFFFFF2F2F2A0A0A0BFBFBFAFAFAFD2CFD0B1B6B5B0
        ADAFD8D8D5C5AA9ECCA294E3D1CBA3A1A2FFFEFEFFFFFF000000FFFFFFF3F3F3
        A2A2A2A4A4A4939393BFBEBC989B9E949298CFCAC3B6866EBB8062D3BAADA4A4
        A6FFFEFFFFFFFF000000FFFFFFF4F4F49F9F9FC4C4C4B5B5B5D2D2D1BDBBBDB7
        B4B9DEDCD4BC8871BB8565D1BEACA2A7A5FEFEFFFFFFFF000000FFFFFFF4F4F4
        A4A4A49B9B9B8A8A89B6B7B79791918B898AC3C5BDB5826FBA7A5DD6BAAAA6A5
        A1FFFEFFFFFFFF000000FFFFFFF4F4F49E9E9ECFCFCFC2C2C2DAD6D8CDCAC4B9
        C3C6E0DED699BFF582B9F7C4DDF1A49FA3FDFFFFFFFFFF000000FFFFFFF4F4F4
        A3A3A39A9A9A8A8A8AB6B9B6909195918787B8BFC70974ED0064FF70AEF1ACA3
        A5FFFFFEFFFFFF000000FFFFFFF4F4F4A0A0A0CCCBCBBDBEBED4D6D9CCC6BFBC
        BEBED5DBDFA6BEDA9BB7D6CDDBE5AAA1A0FFFFFFFFFFFF000000FFFFFFF4F4F4
        A3A2A39A999A888788B6B4BD8E9193818986BFC0BB99908E8C8885B5BDC0A4A1
        A8FEFFFFFFFFFF000000FFFFFFF4F4F49F9F9FE2E2E3D5D4D6E6E4E1D6D5D9D9
        D2D5E4E4E8D4D4D3D6D1CFE8ECEBA8A09FFFFFFFFFFFFF000000FFFFFFF5F5F6
        9A9E974C741B598E2B5E8E2965952F6B9937709C4378A15179A85960813DABAA
        AAFFFEFFFFFFFF000000FFFFFFF6F5F7949891648F298ACA3983CB498BD44E92
        DA579ADF61A4E971BFFA89799F56A4A3AFFFFFFFFFFFFF000000FFFFFFF4F4F5
        9FA29B5A7537567D23587B20577C1E577C1D577B1D557A1D4C781863803CAEAF
        A8FFFEFFFFFFFF000000FFFFFFFBFBFB757775B6B9B5AFB2AFB0B0B5B0B1B3B0
        B1B4B0B2B1B0B2B2AFAEB5B8B7B3837F7FFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFBFAFBFBFAFCFBFBFBFBFAFBFBFAFBFBFBFBFBFBFBFBFAFBFAF9FBFFFF
        FFFFFFFFFFFFFF000000}
      OnClick = btnDuplicatasClick
      ExplicitLeft = 268
    end
    object lblSomentePos: TLabel
      Left = 82
      Top = 1
      Width = 158
      Height = 16
      Caption = ' - Cart'#245'es, somente POS.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object cbxModalidades: TComboBoxFocus
      Tag = 99
      Left = 8
      Top = 17
      Width = 343
      Height = 24
      BevelInner = bvLowered
      BevelKind = bkFlat
      Style = csOwnerDrawVariable
      Anchors = [akLeft, akTop, akRight]
      Color = 16316664
      Ctl3D = False
      DropDownCount = 15
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 18
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnChange = cbxModalidadesChange
      OnEnter = cbxModalidadesEnter
      OnExit = cbxModalidadesExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtValor: TCurrencyEditFocus
      Tag = 99
      Left = 8
      Top = 57
      Margins.Left = 7
      Margins.Top = 2
      AutoSize = False
      ParentFont = False
      Properties.DisplayFormat = '#,##0.00'
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -19
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.IsFontAssigned = True
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Height = 27
      Width = 190
    end
    object dbgModalidades: TDBGridCitel
      Left = 358
      Top = 19
      Width = 436
      Height = 160
      Anchors = [akTop, akRight]
      Color = 16316664
      Ctl3D = False
      DataSource = dtsModalidades
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -16
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = [fsBold]
      OnKeyDown = dbgModalidadesKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DESMOD'
          Title.Color = 13750737
          Width = 270
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Title.Alignment = taRightJustify
          Title.Color = 13750737
          Width = 130
          Visible = True
        end>
    end
    object edtValDig: TCurrencyEditFocus
      Left = 16
      Top = 102
      Margins.Left = 8
      Margins.Top = 2
      TabStop = False
      AutoSize = False
      ParentFont = False
      Properties.DisplayFormat = '#,##0.00'
      Properties.ReadOnly = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -21
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.IsFontAssigned = True
      StyleFocused.Color = clInfoBk
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Height = 29
      Width = 175
    end
    object edtValTro: TCurrencyEditFocus
      Left = 16
      Top = 145
      Margins.Left = 8
      Margins.Top = 2
      TabStop = False
      AutoSize = False
      ParentFont = False
      Properties.DisplayFormat = '#,##0.00'
      Properties.ReadOnly = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clRed
      Style.Font.Height = -21
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      StyleFocused.Color = clInfoBk
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Height = 29
      Width = 175
    end
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 379
    Width = 804
    Height = 280
    Align = alBottom
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 4
    DesignSize = (
      804
      280)
    object Label6: TLabel
      Left = 42
      Top = 56
      Width = 49
      Height = 16
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 223
      Top = 109
      Width = 60
      Height = 16
      Alignment = taRightJustify
      Caption = 'End. Ent.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 3
      Width = 161
      Height = 16
      Caption = 'Esp'#233'cie para fechamento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCpfCgc: TLabel
      Left = 1
      Top = 82
      Width = 90
      Height = 16
      Alignment = taRightJustify
      Caption = '1-CNPJ/2-CPF:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 20
      Top = 134
      Width = 71
      Height = 16
      Alignment = taRightJustify
      Caption = 'Bairro Ent.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 33
      Top = 108
      Width = 58
      Height = 16
      Alignment = taRightJustify
      Caption = 'CEP Ent.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 38
      Top = 160
      Width = 53
      Height = 16
      Alignment = taRightJustify
      Caption = 'Cid. Ent:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblRG_IES: TLabel
      Left = 398
      Top = 82
      Width = 23
      Height = 16
      Alignment = taRightJustify
      Caption = 'RG:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 41
      Top = 186
      Width = 50
      Height = 16
      Alignment = taRightJustify
      Caption = 'Transp.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label16: TLabel
      Left = 533
      Top = 186
      Width = 69
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Tipo Frete:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 406
    end
    object lblValAnt: TLabel
      Left = 326
      Top = 1
      Width = 161
      Height = 19
      Caption = 'Pgto. Antecipado R$:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblDesVend: TLabel
      Left = 304
      Top = 21
      Width = 68
      Height = 18
      Caption = 'Vendedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblVendedor: TLabel
      Left = 304
      Top = 33
      Width = 288
      Height = 16
      AutoSize = False
      Caption = 'Vendedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblVolume: TLabel
      Left = 39
      Top = 238
      Width = 52
      Height = 16
      Alignment = taRightJustify
      Caption = 'Volume:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 230
      Top = 238
      Width = 53
      Height = 16
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblUF: TLabel
      Left = 736
      Top = 160
      Width = 21
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'UF:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 609
    end
    object lblEmail: TLabel
      Left = 47
      Top = 212
      Width = 44
      Height = 16
      Alignment = taRightJustify
      Caption = 'E-mail:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblUtiNps: TLabel
      Left = 686
      Top = 34
      Width = 87
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Deseja Netpoints?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      ExplicitLeft = 559
    end
    object lblTipoFaturamento: TLabel
      Left = 201
      Top = 21
      Width = 78
      Height = 18
      Caption = 'Nota Fiscal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object shpRetISS: TShape
      Left = 390
      Top = 229
      Width = 407
      Height = 32
      Anchors = [akLeft, akTop, akRight]
      Brush.Color = clYellow
      Visible = False
      ExplicitWidth = 280
    end
    object lblRetISS: TLabel
      Left = 443
      Top = 236
      Width = 213
      Height = 19
      Caption = 'Cliente sem reten'#231#227'o de ISS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblNotPau: TLabel
      Left = 595
      Top = 11
      Width = 97
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Nota Fiscal Paulista?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      ExplicitLeft = 585
    end
    object lblPlaFat: TLabel
      Left = 390
      Top = 186
      Width = 40
      Height = 16
      Alignment = taRightJustify
      Caption = 'Placa:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtNomCli: TEditFocus
      Left = 167
      Top = 52
      Width = 500
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 92
      Top = 52
      Width = 74
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object mskCgcCpf: TMaskEditFocus
      Tag = 99
      Left = 133
      Top = 78
      Width = 252
      Height = 25
      AutoSize = False
      Ctl3D = False
      EditMask = '999.999.999-99;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 7
      Text = ''
      OnChange = mskCgcCpfChange
      OnExit = mskCgcCpfExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtEndEnt: TEditFocus
      Tag = 99
      Left = 285
      Top = 104
      Width = 509
      Height = 25
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBaiEnt: TEditFocus
      Tag = 99
      Left = 92
      Top = 130
      Width = 702
      Height = 25
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskCepEnt: TMaskEditFocus
      Tag = 99
      Left = 92
      Top = 104
      Width = 114
      Height = 25
      AutoSize = False
      Ctl3D = False
      EditMask = '99999-999;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 9
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCidEnt: TEditFocus
      Tag = 99
      Left = 92
      Top = 156
      Width = 48
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 12
      OnKeyPress = edtCidEntKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomCid: TEditFocus
      Left = 141
      Top = 156
      Width = 589
      Height = 25
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
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
    object mskNumR_G: TMaskEditFocus
      Tag = 99
      Left = 423
      Top = 78
      Width = 371
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 8
      Text = ''
      OnChange = mskCgcCpfChange
      OnExit = mskNumR_GExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodTra: TEditFocus
      Tag = 99
      Left = 92
      Top = 182
      Width = 48
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 15
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
      Left = 141
      Top = 182
      Width = 244
      Height = 25
      TabStop = False
      Alignment = taLeftJustify
      AutoSize = False
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
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
    object chkEndEnt: TCheckBox
      Left = 533
      Top = 207
      Width = 212
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Imprimir endere'#231'o de entrega'
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 20
      Visible = False
    end
    object edtTipFat: TEditFocus
      Tag = 99
      Left = 8
      Top = 19
      Width = 171
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnChange = edtTipFatChange
      OnEnter = edtTipFatEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object spnTipFat: TSpinButton
      Left = 179
      Top = 20
      Width = 20
      Height = 25
      Ctl3D = False
      DownGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000000000000080800000808000008080000080
        8000008080000080800000808000000000000000000000000000008080000080
        8000008080000080800000808000000000000000000000000000000000000000
        0000008080000080800000808000000000000000000000000000000000000000
        0000000000000000000000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      ParentCtl3D = False
      PopupMenu = mnuAuxiliar
      TabOrder = 1
      UpGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000000000000000000080
        8000008080000080800000000000000000000000000000000000000000000080
        8000008080000080800000808000008080000000000000000000000000000080
        8000008080000080800000808000008080000080800000808000000000000080
        8000008080000080800000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      OnDownClick = spnTipFatDownClick
      OnUpClick = spnTipFatUpClick
    end
    object edtVolume: TEditFocus
      Left = 92
      Top = 234
      Width = 60
      Height = 25
      Alignment = taRightJustify
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 21
      Text = '0'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object edtEspVol: TEditFocus
      Left = 285
      Top = 234
      Width = 100
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 22
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCgcCpf: TEditFocus
      Tag = 99
      Left = 92
      Top = 78
      Width = 40
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 6
      OnChange = edtCgcCpfChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttNumerico
    end
    object edtUF: TEditFocus
      Left = 759
      Top = 156
      Width = 35
      Height = 25
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 14
      OnChange = mskCgcCpfChange
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cmbTipFre: TcxComboBox
      Tag = 99
      Left = 608
      Top = 181
      Anchors = [akTop, akRight]
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Style.BorderStyle = ebsSingle
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.IsFontAssigned = True
      StyleFocused.BorderStyle = ebsSingle
      StyleHot.BorderStyle = ebsSingle
      TabOrder = 18
      Width = 186
    end
    object edtEmail: TEditFocus
      Tag = 99
      Left = 92
      Top = 208
      Width = 293
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecLowerCase
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 19
      OnExit = edtEmailExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNpsS_N: TEditFocus
      Tag = 99
      Left = 776
      Top = 29
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 3
      OnExit = edtNpsS_NExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtNotPau: TEditFocus
      Tag = 99
      Left = 695
      Top = 6
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 2
      Text = 'S'
      OnExit = edtNpsS_NExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object mskPlaFat: TMaskEditFocus
      Tag = 99
      Left = 433
      Top = 182
      Width = 88
      Height = 25
      AutoSize = False
      CharCase = ecUpperCase
      Ctl3D = False
      EditMask = 'aaa-9a99;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 17
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pnlComanda: TPanel [5]
    Left = 0
    Top = 47
    Width = 804
    Height = 29
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 32
      Top = 5
      Width = 70
      Height = 18
      Alignment = taRightJustify
      Caption = 'Comanda:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtBarCom: TEditFocus
      Tag = 99
      Left = 104
      Top = 2
      Width = 138
      Height = 25
      Alignment = taLeftJustify
      AutoSize = False
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 13
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 13
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlOpcaoEmiFatOuAdto: TPanel [6]
    Left = 0
    Top = 0
    Width = 804
    Height = 47
    Align = alTop
    BorderWidth = 3
    Color = clBlue
    ParentBackground = False
    TabOrder = 0
    StyleElements = []
    object rdgOpcaoEmiFatOuAdto: TGroupBox
      Left = 4
      Top = 4
      Width = 796
      Height = 39
      Align = alClient
      Caption = 'Realizar:'
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      StyleElements = []
      object rdbAdiantamentoPedido: TRadioButton
        Left = 262
        Top = 19
        Width = 209
        Height = 17
        Caption = '&Adiantamento de pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = rdbEmissaoFaturamentoClick
      end
      object rdbEmissaoFaturamento: TRadioButton
        Left = 17
        Top = 19
        Width = 209
        Height = 17
        Caption = '&Emiss'#227'o de Faturamento'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        TabStop = True
        OnClick = rdbEmissaoFaturamentoClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 152
  end
  object cdsModalidades: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'IDX'
        Fields = 'ORDEM;ECF_CODMOD'
      end>
    IndexName = 'IDX'
    Params = <>
    StoreDefs = True
    AfterPost = cdsModalidadesAfterPost
    AfterDelete = cdsModalidadesAfterDelete
    Left = 424
    Top = 152
    object cdsModalidadesVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = '#,##0.00'
    end
    object cdsModalidadesTROCO: TFloatField
      FieldName = 'TROCO'
      DisplayFormat = '#,##0.00'
    end
    object cdsModalidadesRESTANTE: TFloatField
      FieldName = 'RESTANTE'
      DisplayFormat = '#,##0.00'
    end
    object cdsModalidadesDESMOD: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESMOD'
      Size = 30
    end
    object cdsModalidadesECF_CODMOD: TStringField
      FieldName = 'ECF_CODMOD'
      Size = 2
    end
    object cdsModalidadesECF_IDENTI: TStringField
      FieldName = 'ECF_IDENTI'
      Size = 1
    end
    object cdsModalidadesCALC_RESTANTE: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'CALC_RESTANTE'
      DisplayFormat = '#,##0.00'
    end
    object cdsModalidadesARQUIVOTEF: TStringField
      DisplayWidth = 50
      FieldName = 'ARQUIVOTEF'
      Size = 50
    end
    object cdsModalidadesECF_INFADI: TStringField
      FieldName = 'ECF_INFADI'
      Size = 1
    end
    object cdsModalidadesCODFPG: TStringField
      FieldName = 'CODFPG'
      Size = 3
    end
    object cdsModalidadesIDXCRT: TIntegerField
      FieldName = 'IDXCRT'
    end
    object cdsModalidadesECF_DESMOD: TStringField
      FieldName = 'ECF_DESMOD'
      Size = 30
    end
    object cdsModalidadesORDEM: TIntegerField
      FieldName = 'ORDEM'
    end
    object cdsModalidadesSESSAO_TEF: TStringField
      FieldName = 'SESSAO_TEF'
      Size = 50
    end
    object cdsModalidadesPORTADOR_ORDPAG: TStringField
      FieldName = 'PORTADOR_ORDPAG'
      Size = 5
    end
    object cdsModalidadesPIX_AVULSO: TStringField
      FieldName = 'PIX_AVULSO'
      Size = 1
    end
    object cdsModalidadesAGG_PAGO: TAggregateField
      Alignment = taRightJustify
      FieldName = 'AGG_PAGO'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(VALOR)'
    end
  end
  object dtsModalidades: TDataSource
    DataSet = cdsModalidades
    Left = 457
    Top = 152
  end
  object tmrReload: TTimer
    Enabled = False
    Interval = 200
    OnTimer = tmrReloadTimer
    Left = 488
    Top = 152
  end
end
