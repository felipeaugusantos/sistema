inherited frmEntPreNotaEntradaCx: TfrmEntPreNotaEntradaCx
  Width = 1321
  Height = 780
  BorderStyle = bsSizeable
  Caption = 'Pr'#233'-Nota de Entrada'
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 1321
  ExplicitHeight = 780
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 425
    Width = 1305
    Height = 4
    Cursor = crVSplit
    Align = alTop
    Color = clYellow
    ParentColor = False
    ExplicitTop = 260
    ExplicitWidth = 1120
  end
  inherited pnlBotoes: TPanel
    Top = 698
    Width = 1305
    Height = 27
    ExplicitTop = 698
    ExplicitWidth = 1305
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Width = 1301
      Height = 23
      ExplicitWidth = 1301
      ExplicitHeight = 23
      object btnCriticas: TBitBtnLocked
        Left = 0
        Top = 0
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
        TabOrder = 0
        OnClick = btnCriticasClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 111
        Top = 0
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
        TabOrder = 1
        OnClick = btnConfirmaClick
      end
      object Panel3: TPanel
        Left = 223
        Top = 0
        Width = 722
        Height = 23
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        DesignSize = (
          722
          23)
        object Label1: TLabel
          Left = 474
          Top = 5
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
          ExplicitTop = 18
        end
        object Label10: TLabel
          Left = 244
          Top = 5
          Width = 205
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'Quantidade na NFE menor que a do Pedido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ExplicitTop = 18
        end
        object Label2: TLabel
          Left = 20
          Top = 5
          Width = 201
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'Quantidade na NFE maior que a do Pedido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ExplicitTop = 18
        end
        object lblNFEPed: TLabel
          Left = 588
          Top = 4
          Width = 107
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'Diverg'#234'ncia de Pedido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ExplicitTop = 17
        end
        object shaNFEPed: TShape
          Left = 572
          Top = 6
          Width = 12
          Height = 12
          Anchors = [akLeft, akBottom]
          Brush.Color = clSkyBlue
          ExplicitTop = 19
        end
        object Shape1: TShape
          Left = 458
          Top = 6
          Width = 12
          Height = 12
          Anchors = [akLeft, akBottom]
          Brush.Color = clRed
          ExplicitTop = 19
        end
        object Shape2: TShape
          Left = 5
          Top = 6
          Width = 12
          Height = 12
          Anchors = [akLeft, akBottom]
          Brush.Color = clYellow
          ExplicitTop = 19
        end
        object Shape7: TShape
          Left = 229
          Top = 7
          Width = 12
          Height = 12
          Anchors = [akLeft, akBottom]
          Brush.Color = clAqua
          ExplicitTop = 20
        end
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1222
      Top = 2
      ExplicitLeft = 1222
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 725
    Width = 1305
    ExplicitTop = 725
    ExplicitWidth = 1305
    inherited pnlNomeForm: TPanel
      Left = 1134
      ExplicitLeft = 1134
    end
    inherited pnlInfo: TPanel
      Width = 1134
      ExplicitWidth = 1134
    end
  end
  object pnlHeader: TPanel [3]
    Left = 0
    Top = 0
    Width = 1305
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object Panel1: TPanel
      Left = 0
      Top = 60
      Width = 1305
      Height = 31
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      DesignSize = (
        1305
        31)
      object lblNotEle: TLabel
        Left = 333
        Top = 9
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nota Eletr'#244'nica:'
      end
      object btnNotEle: TBitBtnLocked
        Left = 411
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
        TabOrder = 1
        OnClick = btnNotEleClick
        OnEnter = btnNotEleEnter
        OnExit = btnNotEleExit
      end
      object edtNotEle: TEditFocus
        Left = 452
        Top = 5
        Width = 354
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object chkOcultarItens: TCheckBox
        Left = 9
        Top = 8
        Width = 312
        Height = 17
        Caption = 'Ocultar itens dos pedidos que n'#227'o est'#227'o na nota eletr'#244'nica'
        TabOrder = 0
      end
      object btnPedPre: TBitBtnLocked
        Left = 843
        Top = 5
        Width = 145
        Height = 22
        Hint = 'Pedidos do Fornecedor da NFE em Pr'#233'-Nota'
        Anchors = [akLeft, akBottom]
        Caption = '[F8] Pedidos em Pr'#233'-Nota'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btnPedPreClick
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 91
      Width = 1305
      Height = 30
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object lblTipoDoc: TLabel
        Left = 9
        Top = 8
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pedido de Compra:'
      end
      object lblCotDol: TLabel
        Left = 812
        Top = 10
        Width = 86
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cota'#231#227'o do D'#243'lar:'
      end
      object edtNumPed: TEditFocus
        Tag = 99
        Left = 101
        Top = 2
        Width = 88
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
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
        Left = 191
        Top = 2
        Width = 615
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
      object edtCotDol: TEditFocus
        Tag = 99
        Left = 900
        Top = 2
        Width = 88
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 12
        TipoTexto = ttNumerico
      end
    end
    object pnlCnvEmb: TPanel
      Left = 0
      Top = 0
      Width = 1305
      Height = 60
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object rdgTipUni: TRadioGroup
        Left = 7
        Top = 2
        Width = 801
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
  object pnlConPag: TPanel [4]
    Left = 0
    Top = 121
    Width = 1305
    Height = 304
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object pnlConGerEle: TPanel
      Left = 0
      Top = 0
      Width = 1305
      Height = 70
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        1305
        70)
      object lblConPagNot: TLabel
        Left = 9
        Top = 14
        Width = 236
        Height = 14
        Caption = 'Condi'#231#227'o de Pagamento da Nota Eletr'#244'nica:'
      end
      object Shape3: TShape
        Left = 9
        Top = 52
        Width = 12
        Height = 12
        Anchors = [akLeft, akBottom]
        Brush.Color = clRed
        ExplicitTop = 31
      end
      object lblPrazoMedioMaior: TLabel
        Left = 25
        Top = 51
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
        ExplicitTop = 38
      end
      object Shape4: TShape
        Left = 238
        Top = 52
        Width = 12
        Height = 12
        Anchors = [akLeft, akBottom]
        Brush.Color = clYellow
        ExplicitTop = 39
      end
      object lblPrazoMedioMenor: TLabel
        Left = 256
        Top = 50
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
        ExplicitTop = 37
      end
      object lblCNPJTransportadoraDivergenteBaseIgual: TLabel
        Left = 687
        Top = 51
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
        ExplicitTop = 38
      end
      object lblCNPJTransportadoraDivergente: TLabel
        Left = 491
        Top = 51
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
        ExplicitTop = 38
      end
      object Shape5: TShape
        Left = 473
        Top = 52
        Width = 12
        Height = 12
        Anchors = [akLeft, akBottom]
        Brush.Color = clRed
        ExplicitTop = 39
      end
      object Shape6: TShape
        Left = 669
        Top = 52
        Width = 12
        Height = 12
        Anchors = [akLeft, akBottom]
        Brush.Color = clYellow
        ExplicitTop = 39
      end
      object lblTranspNota: TLabel
        Left = 9
        Top = 30
        Width = 294
        Height = 14
        Caption = 'Transportadora da Nota Eletr'#244'nica: %s   Tipo Frete: %s'
        Visible = False
      end
      object Shape8: TShape
        Left = 969
        Top = 52
        Width = 12
        Height = 12
        Anchors = [akLeft, akBottom]
        Brush.Color = clRed
        ExplicitTop = 39
      end
      object lblCondicaoPagamento: TLabel
        Left = 987
        Top = 51
        Width = 170
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Condi'#231#227'o de Pagamento divergente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ExplicitTop = 38
      end
      object lblDataNota: TLabel
        Left = 9
        Top = -1
        Width = 193
        Height = 14
        Caption = 'Data de Emiss'#227'o da Nota Eletr'#244'nica:'
      end
    end
    object cxgPedidos: TcxGrid
      Left = 0
      Top = 70
      Width = 1305
      Height = 234
      Align = alClient
      TabOrder = 1
      object cxgPedidosView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgPedidosViewCustomDrawCell
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
          Width = 103
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
          Properties.EditMask = 
            '(99)999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.' +
            '999.999.999.999.999.999.999.999.999'
          OnCustomDrawCell = cxgPedidosCONPAGCustomDrawCell
          Width = 320
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
          Width = 133
        end
        object cxgPedidosTIPFRE: TcxGridDBColumn
          Caption = 'Tipo Frete'
          DataBinding.FieldName = 'TIPFRE'
          Width = 116
        end
        object cxgPedidosDTAPREV: TcxGridDBColumn
          Caption = 'Dt. Faturam. Previ.'
          DataBinding.FieldName = 'DTAPRE'
          Width = 110
        end
        object cxgPedidosDIVPREV: TcxGridDBColumn
          Caption = 'Dias Divergencia'
          DataBinding.FieldName = 'DIVPRE'
          Width = 138
        end
      end
      object cxgPedidosLevel1: TcxGridLevel
        GridView = cxgPedidosView
      end
    end
  end
  object pnlTotais: TPanel [5]
    Left = 0
    Top = 668
    Width = 1305
    Height = 30
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label3: TLabel
      Left = 149
      Top = 11
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Frete NFE:'
    end
    object Label4: TLabel
      Left = 279
      Top = 11
      Width = 78
      Height = 14
      Caption = 'Diferen'#231'a Frete:'
    end
    object lblFrePed: TLabel
      Left = 6
      Top = 11
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Frete Pedido:'
    end
    object lblLegendaCNVEMB: TLabel
      Left = 438
      Top = 2
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
    object Label6: TLabel
      Left = 602
      Top = 14
      Width = 392
      Height = 14
      Caption = 
        'Os valores de Impostos apresentados s'#227'o referentes ao valor Unit' +
        #225'rio.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtDifFre: TEditFocus
      Left = 360
      Top = 4
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
      Left = 200
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
      Left = 69
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
  object cxgItens: TcxGrid [6]
    Left = 0
    Top = 429
    Width = 1305
    Height = 143
    Align = alClient
    TabOrder = 6
    object cxvItens: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '0.0000;-0.0000'
          Kind = skSum
          Position = spFooter
          Column = cxvItensSELPED
        end
        item
          Format = '0.0000;-0.0000'
          Kind = skSum
          Position = spFooter
          FieldName = 'QTDNFE_UNI'
          Column = cxvItensQTDNFE
        end
        item
          Format = '0.0000;-0.0000'
          Kind = skSum
          Position = spFooter
          FieldName = 'TOTPED'
          Column = cxvItensRESPED
        end>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum item selecionado>'
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfAlwaysVisible
      Bands = <
        item
          Caption = 'Dados do Produto'
          Width = 351
        end
        item
          AlternateCaption = '75'
          Caption = 'Pedido'
          Width = 210
        end
        item
          Caption = 'Quantidade (*)'
          Width = 270
        end
        item
          Caption = 'Valor unit'#225'rio'
          Width = 140
        end
        item
          Caption = 'Valor do IPI'
          Width = 140
        end
        item
          Caption = 'Valor da Substitui'#231#227'o'
          Width = 140
        end
        item
          Caption = 'Dados da '#218'tilma Compra'
        end>
      object cxvItensNUMPED: TcxGridDBBandedColumn
        Caption = 'N'#250'mero'
        DataBinding.FieldName = 'NUMPED'
        OnCustomDrawCell = cxvItensNUMPEDCustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensQTDPED: TcxGridDBBandedColumn
        Caption = 'Em aberto Pedido'
        DataBinding.FieldName = 'QTDPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000;-0.0000'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Width = 90
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensSELPED: TcxGridDBBandedColumn
        AlternateCaption = 'cxvItensDSEL'
        Caption = 'A ser baixada PD'
        DataBinding.FieldName = 'SELPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000;-0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
        Position.BandIndex = 2
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvItensQTDNFE: TcxGridDBBandedColumn
        Caption = 'NFE'
        DataBinding.FieldName = 'QTDNFE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000;-0.0000'
        OnCustomDrawCell = cxvItensSELPEDCustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 90
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensUNIPED: TcxGridDBBandedColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'UNIPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        OnCustomDrawCell = cxvItensUNIPEDCustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensUNINFE: TcxGridDBBandedColumn
        Caption = 'NFE'
        DataBinding.FieldName = 'UNINFE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        OnCustomDrawCell = cxvItensUNIPEDCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensIPIPED: TcxGridDBBandedColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'IPIPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        OnCustomDrawCell = cxvItensIPIPEDCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensIPINFE: TcxGridDBBandedColumn
        Caption = 'NFE'
        DataBinding.FieldName = 'IPINFE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        OnCustomDrawCell = cxvItensIPIPEDCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensSUBPED: TcxGridDBBandedColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'SUBPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        OnCustomDrawCell = cxvItensSUBPEDCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensSUBNFE: TcxGridDBBandedColumn
        Caption = 'NFE'
        DataBinding.FieldName = 'SUBNFE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        OnCustomDrawCell = cxvItensSUBPEDCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 5
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensCODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Visible = False
        OnGetDisplayText = cxvItensCODITEGetDisplayText
        GroupIndex = 0
        Width = 55
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensDESITE: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Visible = False
        Width = 400
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensCODFAB: TcxGridDBBandedColumn
        Caption = 'C'#243'd. F'#225'b. Forn.'
        DataBinding.FieldName = 'CODFAB'
        Width = 76
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvItensREFERE: TcxGridDBBandedColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Width = 52
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvItensSIGUNI: TcxGridDBBandedColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        HeaderAlignmentHorz = taCenter
        Width = 44
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvItensQTDRES: TcxGridDBBandedColumn
        Caption = 'Restante NFE'
        DataBinding.FieldName = 'QTDRES'
        Visible = False
        Width = 90
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensNROITE: TcxGridDBBandedColumn
        Caption = 'Nro. Item'
        DataBinding.FieldName = 'NROITE'
        HeaderAlignmentHorz = taCenter
        Options.CellMerging = True
        Width = 36
        OnHeaderClick = cxvItensNROITEHeaderClick
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensCODITE2: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        Width = 41
        OnHeaderClick = cxvItensCODITE2HeaderClick
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensQTDNFE_UNI: TcxGridDBBandedColumn
        DataBinding.FieldName = 'QTDNFE_UNI'
        Visible = False
        Position.BandIndex = 2
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvItensPEDNFE: TcxGridDBBandedColumn
        Caption = 'Pedido na NFE'
        DataBinding.FieldName = 'PEDNFE'
        OnCustomDrawCell = cxvItensNUMPEDCustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensRESPED: TcxGridDBBandedColumn
        Caption = 'Dispon'#237'vel Pedido'
        DataBinding.FieldName = 'RESPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000;-0.0000'
        OnCustomDrawCell = cxvItensSELPEDCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 90
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensCFABIT: TcxGridDBBandedColumn
        Caption = 'C'#243'd. F'#225'b. Prin.'
        DataBinding.FieldName = 'CFBITE'
        Options.Editing = False
        Width = 87
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvItensIMPULT: TcxGridDBBandedColumn
        Caption = 'Pr. '#218'lt. Compra + Imp.'
        DataBinding.FieldName = 'ITE_IMPULT'
        Width = 107
        Position.BandIndex = 6
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensDTAULT: TcxGridDBBandedColumn
        Caption = 'Dt. '#218'lt. Compra'
        DataBinding.FieldName = 'ITE_DTAULT'
        Width = 89
        Position.BandIndex = 6
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensFORULT: TcxGridDBBandedColumn
        Caption = #218'lt. Fornec.'
        DataBinding.FieldName = 'ITE_FORULT'
        Width = 81
        Position.BandIndex = 6
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensNOTULT: TcxGridDBBandedColumn
        Caption = #218'lt. Documento'
        DataBinding.FieldName = 'ITE_NOTULT'
        Width = 117
        Position.BandIndex = 6
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  object pnlAplicacao: TPanel [7]
    Left = 0
    Top = 572
    Width = 1305
    Height = 96
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object pnlAplica: TPanel
      Left = 0
      Top = 0
      Width = 1305
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Aplica'#231#227'o'
      TabOrder = 0
    end
    object mmoAplica: TDBMemoFocus
      Left = 0
      Top = 20
      Width = 1305
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
    Left = 368
    Top = 480
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 384
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 128
    Top = 480
  end
end
