inherited frmEntPreNotaEntrada: TfrmEntPreNotaEntrada
  Left = 195
  Top = 179
  Width = 1128
  Height = 722
  Caption = 'Pr'#233'-Nota de Entrada'
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 1128
  ExplicitHeight = 722
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 300
    Width = 1112
    Height = 4
    Cursor = crVSplit
    Align = alTop
    Color = clYellow
    ParentColor = False
    ExplicitLeft = -8
    ExplicitTop = 306
  end
  inherited pnlBotoes: TPanel
    Top = 622
    Width = 1112
    Height = 45
    ExplicitTop = 622
    ExplicitWidth = 1112
    ExplicitHeight = 45
    DesignSize = (
      1112
      45)
    object Label1: TLabel [0]
      Left = 687
      Top = 3
      Width = 88
      Height = 14
      Anchors = [akLeft, akBottom]
      Caption = 'Diverg'#234'ncia Pre'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Shape1: TShape [1]
      Left = 671
      Top = 5
      Width = 12
      Height = 12
      Anchors = [akLeft, akBottom]
      Brush.Color = clRed
    end
    object Label2: TLabel [2]
      Left = 549
      Top = 3
      Width = 115
      Height = 14
      Anchors = [akLeft, akBottom]
      Caption = 'Diverg'#234'ncia Quantidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Shape2: TShape [3]
      Left = 532
      Top = 5
      Width = 12
      Height = 12
      Anchors = [akLeft, akBottom]
      Brush.Color = clYellow
    end
    object Label6: TLabel [4]
      Left = 8
      Top = 3
      Width = 395
      Height = 14
      Caption = 
        'Os valores de Impostos apresentados, s'#227'o referentes ao valor Uni' +
        't'#225'rio.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btnSair: TBitBtnLocked
      Left = 448
      Top = 19
      Width = 78
      Anchors = [akLeft, akBottom]
      TabOrder = 4
      ExplicitLeft = 448
      ExplicitTop = 19
      ExplicitWidth = 78
    end
    inherited btnPesquisar: TBitBtnLocked
      Left = 343
      Top = 19
      Width = 105
      Anchors = [akLeft, akBottom]
      TabOrder = 3
      ExplicitLeft = 343
      ExplicitTop = 19
      ExplicitWidth = 105
    end
    inherited btnMudaOrdem: TBitBtnLocked
      Left = 226
      Top = 19
      Width = 117
      Anchors = [akLeft, akBottom]
      TabOrder = 2
      ExplicitLeft = 226
      ExplicitTop = 19
      ExplicitWidth = 117
    end
    object btnCriticas: TBitBtnLocked
      Left = 115
      Top = 19
      Width = 111
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '[F9] Rel. Cr'#237'ticas'
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
      TabOrder = 1
      OnClick = btnCriticasClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 19
      Width = 112
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '[ F10 ] Confirma'
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
  end
  inherited pnlHeader: TPanel
    Width = 1112
    Height = 140
    TabOrder = 7
    ExplicitWidth = 1112
    ExplicitHeight = 140
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 1112
      Height = 31
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblNotEle: TLabel
        Left = 9
        Top = 9
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nota Eletr'#244'nica:'
      end
      object btnNotEle: TBitBtnLocked
        Left = 86
        Top = 5
        Width = 41
        Height = 22
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
          300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
          330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
          333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
          339977FF777777773377000BFB03333333337773FF733333333F333000333333
          3300333777333333337733333333333333003333333333333377333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnNotEleClick
        OnEnter = btnNotEleEnter
        OnExit = btnNotEleExit
      end
      object edtNotEle: TEditFocus
        Left = 128
        Top = 5
        Width = 505
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
    object Panel2: TPanel
      Left = 0
      Top = 91
      Width = 1112
      Height = 49
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object lblTipoDoc: TLabel
        Left = 9
        Top = 28
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pedido de Compra:'
      end
      object edtNumPed: TEditFocus
        Tag = 99
        Left = 105
        Top = 22
        Width = 88
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 0
        OnEnter = edtNumPedEnter
        OnKeyPress = edtNumPedKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtLisPed: TEditFocus
        Left = 195
        Top = 22
        Width = 439
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object chkOcultarItens: TCheckBox
        Left = 15
        Top = 1
        Width = 243
        Height = 17
        Caption = 'Ocultar itens que n'#227'o est'#227'o na nota eletr'#244'nica'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
    object pnlCnvEmb: TPanel
      Left = 0
      Top = 31
      Width = 1112
      Height = 60
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object rdgTipUni: TRadioGroup
        Left = 7
        Top = 0
        Width = 626
        Height = 54
        Caption = 'XML enviado em:'
        ItemIndex = 0
        Items.Strings = (
          
            'Unidade de Compra ( ser'#225' realizada convers'#227'o de quantidade pela ' +
            'embalagem na entrada de mercadorias )'
          
            'Unidade de Venda  ( n'#227'o ser'#225' realizada convers'#227'o de quantidade p' +
            'ela embalagem na entrada de mercadorias )')
        TabOrder = 0
      end
    end
  end
  inherited pnlTail: TPanel
    Top = 497
    Width = 1112
    Height = 0
    Enabled = False
    TabOrder = 2
    Visible = True
    ExplicitTop = 497
    ExplicitWidth = 1112
    ExplicitHeight = 0
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 304
    Width = 1112
    Height = 193
    TabOrder = 3
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 38
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODFAB'
        Title.Caption = 'C'#243'digo de F'#225'brica'
        Width = 111
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 182
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESUNI'
        Title.Caption = 'UN'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_QTDPED'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quant. Ped. (*)'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_QTDNFE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quant. NFE (*)'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_UNIPED'
        Title.Alignment = taRightJustify
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_UNINFE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vl. Unit. NFE'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_IPIPED'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vl. IPI Ped.'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_IPINFE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vl. IPI NFE'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SUBPED'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vl. Sub.T.  Ped.'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SUBNFE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vl. Sub.T.  NFE'
        Width = 80
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 260
    Width = 1112
    TabOrder = 4
    ExplicitTop = 260
    ExplicitWidth = 1112
  end
  object pnlTotais: TPanel [7]
    Left = 0
    Top = 593
    Width = 1112
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    object Label3: TLabel
      Left = 205
      Top = 11
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Frete da NFE:'
    end
    object Label4: TLabel
      Left = 373
      Top = 12
      Width = 93
      Height = 14
      Caption = 'Diferen'#231'a do Frete:'
    end
    object lblFrePed: TLabel
      Left = 20
      Top = 11
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Frete do Pedido:'
    end
    object lblLegendaCNVEMB: TLabel
      Left = 616
      Top = 8
      Width = 273
      Height = 14
      Caption = '(*) Quantidades convertidas em unidade de venda'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtDifFre: TEditFocus
      Left = 471
      Top = 3
      Width = 72
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
    object edtFreNfe: TEditFocus
      Left = 276
      Top = 4
      Width = 72
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
    object edtFrePed: TEditFocus
      Left = 98
      Top = 4
      Width = 72
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlConPag: TPanel [8]
    Left = 0
    Top = 140
    Width = 1112
    Height = 120
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 6
    object pnlConGerEle: TPanel
      Left = 0
      Top = 0
      Width = 1112
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        1112
        49)
      object lblConPagNot: TLabel
        Left = 8
        Top = 4
        Width = 236
        Height = 14
        Caption = 'Condi'#231#227'o de Pagamento da Nota Eletr'#244'nica:'
      end
      object Shape3: TShape
        Left = 9
        Top = 31
        Width = 12
        Height = 12
        Anchors = [akLeft, akBottom]
        Brush.Color = clRed
      end
      object Label5: TLabel
        Left = 25
        Top = 29
        Width = 207
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Prazo m'#233'dio do pedido maior que o da nota'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape4: TShape
        Left = 260
        Top = 31
        Width = 12
        Height = 12
        Anchors = [akLeft, akBottom]
        Brush.Color = clYellow
      end
      object Label8: TLabel
        Left = 276
        Top = 29
        Width = 211
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Prazo m'#233'dio do pedido menor que o da nota'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 727
        Top = 29
        Width = 270
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'CNPJ da Transportadora Divergente, porem base  iguais'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 529
        Top = 29
        Width = 172
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'CNPJ da Transportadora divergente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape5: TShape
        Left = 513
        Top = 31
        Width = 12
        Height = 12
        Anchors = [akLeft, akBottom]
        Brush.Color = clRed
      end
      object Shape6: TShape
        Left = 707
        Top = 31
        Width = 12
        Height = 12
        Anchors = [akLeft, akBottom]
        Brush.Color = clYellow
      end
    end
    object cxgPedidos: TcxGrid
      Left = 0
      Top = 49
      Width = 1112
      Height = 71
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgPedidosView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.GroupByBox = False
        object cxgPedidosNUMPED: TcxGridDBColumn
          Caption = 'Pedido'
          DataBinding.FieldName = 'NUMPED'
          HeaderAlignmentHorz = taCenter
          Width = 75
        end
        object cxgPedidosCODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CODEMP'
          HeaderAlignmentHorz = taCenter
          Width = 63
        end
        object cxgPedidosCONPAG: TcxGridDBColumn
          Caption = 'Condi'#231#227'o de Pagamento'
          DataBinding.FieldName = 'CONPAG'
          PropertiesClassName = 'TcxMaskEditProperties'
          Properties.EditMask = '(99)999.999.999.999.999.999.999.999.999.999.999.999'
          Width = 351
        end
        object cxgPedidosPRAMED: TcxGridDBColumn
          Caption = 'Prazo M'#233'dio'
          DataBinding.FieldName = 'PRAMED'
          OnCustomDrawCell = cxgPedidosPRAMEDCustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 70
        end
        object cxgPedidosTRAPED: TcxGridDBColumn
          Caption = 'Transportadora do Pedido'
          DataBinding.FieldName = 'TRAPED'
          OnCustomDrawCell = cxgPedidosTRAPEDCustomDrawCell
          OnGetDataText = cxgPedidosTRAPEDGetDataText
          Width = 139
        end
      end
      object cxgPedidosLevel1: TcxGridLevel
        GridView = cxgPedidosView
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 667
    Width = 1112
    ExplicitTop = 667
    ExplicitWidth = 1112
    inherited pnlNomeForm: TPanel
      Left = 941
      ExplicitLeft = 941
    end
    inherited pnlInfo: TPanel
      Width = 941
      ExplicitWidth = 941
    end
  end
  object pnlAplicacao: TPanel [10]
    Left = 0
    Top = 497
    Width = 1112
    Height = 96
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 9
    Visible = False
    object pnlAplica: TPanel
      Left = 0
      Top = 0
      Width = 1112
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Aplica'#231#227'o'
      TabOrder = 0
    end
    object mmoAplica: TDBMemoFocus
      Left = 0
      Top = 20
      Width = 1112
      Height = 76
      Align = alBottom
      BorderStyle = bsNone
      DataField = 'ITE_APLICA'
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
    Left = 400
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 560
    Top = 304
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 688
    Top = 304
  end
  inherited qryConsulta: TUniQuery
    Left = 128
    Top = 304
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 192
    Top = 296
  end
  inherited cdsConsulta: TUniClientDataSet
    DisableStringTrim = True
    AfterClose = cdsConsultaAfterClose
    Left = 264
    Top = 304
    object cdsConsultaITE_CODITE: TStringField
      FieldName = 'ITE_CODITE'
    end
    object cdsConsultaITE_DESITE: TStringField
      FieldName = 'ITE_DESITE'
    end
    object cdsConsultaITE_APLICA: TMemoField
      FieldName = 'ITE_APLICA'
      BlobType = ftMemo
    end
    object cdsConsultaITE_CODBAR: TStringField
      FieldName = 'ITE_CODBAR'
    end
    object cdsConsultaITE_REFERE: TStringField
      FieldName = 'ITE_REFERE'
    end
    object cdsConsultaITE_DESUNI: TStringField
      FieldName = 'ITE_DESUNI'
    end
    object cdsConsultaITE_CODFAB: TStringField
      FieldName = 'ITE_CODFAB'
      Size = 50
    end
    object cdsConsultaITE_LOCFIS: TStringField
      FieldName = 'ITE_LOCFIS'
      Size = 50
    end
    object cdsConsultaITE_SALDOS: TFloatField
      FieldName = 'ITE_SALDOS'
    end
    object cdsConsultaPCG_CODEMP: TStringField
      FieldName = 'PCG_CODEMP'
      Size = 3
    end
    object cdsConsultaITE_QTDPED: TFloatField
      DisplayLabel = 'Quant. Pedido(s)'
      FieldName = 'ITE_QTDPED'
    end
    object cdsConsultaITE_QTDNFE: TFloatField
      DisplayLabel = 'Quant. Entrada'
      FieldName = 'ITE_QTDNFE'
    end
    object cdsConsultaITE_UNIPED: TFloatField
      DisplayLabel = 'Vl. Unit Ped.'
      FieldName = 'ITE_UNIPED'
    end
    object cdsConsultaITE_UNINFE: TFloatField
      DisplayLabel = 'Vl. Unit. Nota'
      FieldName = 'ITE_UNINFE'
    end
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsConsultaITE_IPIPED: TFloatField
      FieldName = 'ITE_IPIPED'
    end
    object cdsConsultaITE_IPINFE: TFloatField
      FieldName = 'ITE_IPINFE'
    end
    object cdsConsultaITE_SUBPED: TFloatField
      FieldName = 'ITE_SUBPED'
    end
    object cdsConsultaITE_SUBNFE: TFloatField
      FieldName = 'ITE_SUBNFE'
    end
    object cdsConsultaITE_NFEEAN: TStringField
      FieldName = 'ITE_NFEEAN'
      Size = 25
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 328
    Top = 312
  end
  object cdsCriticas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 296
    object cdsCriticasCODITE: TStringField
      FieldName = 'CODITE'
      Size = 30
    end
    object cdsCriticasDESITE: TStringField
      FieldName = 'DESITE'
      Size = 120
    end
    object cdsCriticasSIGUNI: TStringField
      FieldName = 'DESUNI'
      Size = 6
    end
    object cdsCriticasQTDPED: TFloatField
      FieldName = 'QTDPED'
    end
    object cdsCriticasQTDNFE: TFloatField
      FieldName = 'QTDNFE'
    end
    object cdsCriticasCODFAB: TStringField
      FieldName = 'CODFAB'
    end
    object cdsCriticasLOCFIS: TStringField
      FieldName = 'LOCFIS'
    end
    object cdsCriticasSALDOS: TFloatField
      FieldName = 'SALDOS'
    end
    object cdsCriticasUNIPED: TFloatField
      FieldName = 'UNIPED'
    end
    object cdsCriticasUNINFE: TFloatField
      FieldName = 'UNINFE'
    end
    object cdsCriticasINFADI: TStringField
      FieldName = 'INFADI'
      Size = 255
    end
    object cdsCriticasIPIPED: TFloatField
      FieldName = 'IPIPED'
    end
    object cdsCriticasIPINFE: TFloatField
      FieldName = 'IPINFE'
    end
    object cdsCriticasSUBPED: TFloatField
      FieldName = 'SUBPED'
    end
    object cdsCriticasSUBNFE: TFloatField
      FieldName = 'SUBNFE'
    end
    object cdsCriticasFREPED: TFloatField
      FieldName = 'FREPED'
    end
    object cdsCriticasFRENFE: TFloatField
      FieldName = 'FRENFE'
    end
    object cdsCriticasNFEEAN: TStringField
      FieldName = 'NFEEAN'
      Size = 25
    end
    object cdsCriticasCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 25
    end
    object cdsCriticasTRAPED: TStringField
      FieldName = 'TRAPED'
      Size = 18
    end
    object cdsCriticasTRAXML: TStringField
      FieldName = 'TRAXML'
      Size = 18
    end
    object cdsCriticasAUTNFE: TStringField
      FieldName = 'AUTNFE'
    end
  end
end
