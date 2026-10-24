inherited frmFatEfetivarItensOrcamentoEmPedido: TfrmFatEfetivarItensOrcamentoEmPedido
  Left = 482
  Top = 194
  Width = 861
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Efetivar Or'#231'amento em Pedido'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 861
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlStatus: TPanel [0]
    Top = 555
    Width = 855
    TabOrder = 4
    ExplicitTop = 555
    ExplicitWidth = 855
    inherited pnlInfo: TPanel [0]
      Width = 601
      ExplicitWidth = 601
    end
    inherited pnlNomeForm: TPanel [1]
      Left = 601
      Width = 254
      ExplicitLeft = 601
      ExplicitWidth = 254
    end
  end
  object pnlBusca: TPanel [1]
    Left = 0
    Top = 0
    Width = 855
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object lbl1: TLabel
      Left = 13
      Top = 9
      Width = 57
      Height = 14
      Caption = 'Documento:'
    end
    object lbl2: TLabel
      Left = 130
      Top = 7
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 13
      Top = 24
      Width = 87
      Height = 22
      Alignment = taLeftJustify
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtNumDocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 130
      Top = 24
      Width = 53
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 2
      Text = '001'
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 100
      Top = 24
      Width = 28
      Height = 22
      Alignment = taCenter
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 2
      ReadOnly = True
      TabOrder = 1
      Text = 'OR'
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtDesEmp: TEditFocus
      Left = 183
      Top = 24
      Width = 577
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 57
    Width = 855
    Height = 218
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 3
    object pnlForPagAtu: TPanel
      Left = 2
      Top = 166
      Width = 851
      Height = 45
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object lbl7: TLabel
        Left = 11
        Top = 1
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Form. Pagto:'
      end
      object edtForPagAtu: TEditFocus
        Tag = 99
        Left = 11
        Top = 16
        Width = 65
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesFpgAtu: TEditFocus
        Left = 77
        Top = 16
        Width = 681
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
    end
    object pnl2: TPanel
      Left = 2
      Top = 125
      Width = 851
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lbl8: TLabel
        Left = 11
        Top = 1
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cond. Pagto:'
      end
      object edtCodCndAtu: TEditFocus
        Tag = 99
        Left = 11
        Top = 16
        Width = 65
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object mskCndPagAtu: TMaskEditFocus
        Tag = 99
        Left = 77
        Top = 16
        Width = 536
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        EditMask = 
          '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
          '99.999.999.999.999.999.999.999.999;0;'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 98
        ReadOnly = True
        TabOrder = 2
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesCndAtu: TEditFocus
        Left = 614
        Top = 16
        Width = 144
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
    end
    object pnl3: TPanel
      Left = 2
      Top = 2
      Width = 851
      Height = 123
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object lbl4: TLabel
        Left = 11
        Top = 7
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object lbl5: TLabel
        Left = 442
        Top = 7
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data:'
      end
      object lbl6: TLabel
        Left = 442
        Top = 87
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr.Cont'#225'bil:'
      end
      object lbl3: TLabel
        Left = 551
        Top = 7
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object Label1: TLabel
        Left = 11
        Top = 47
        Width = 60
        Height = 14
        Caption = 'Vr.Produtos:'
      end
      object Label2: TLabel
        Left = 119
        Top = 47
        Width = 74
        Height = 14
        Caption = 'Desc. Especial:'
      end
      object Label3: TLabel
        Left = 227
        Top = 47
        Width = 31
        Height = 14
        Caption = 'VR.IPI:'
      end
      object Label4: TLabel
        Left = 334
        Top = 47
        Width = 60
        Height = 14
        Caption = 'Vr.Sub.Trib.:'
      end
      object Label5: TLabel
        Left = 442
        Top = 47
        Width = 99
        Height = 14
        Caption = 'VR.Desp.Acess'#243'ria:'
      end
      object Label6: TLabel
        Left = 11
        Top = 87
        Width = 46
        Height = 14
        Caption = 'VR.Frete:'
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 11
        Top = 21
        Width = 65
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 5
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDtaEnt: TEditFocus
        Tag = 99
        Left = 442
        Top = 21
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 3
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesCli: TEditFocus
        Left = 77
        Top = 21
        Width = 357
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
      object edtVlrCon: TEditFocus
        Tag = 2
        Left = 442
        Top = 101
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 550
        Top = 21
        Width = 208
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 5
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtTotPro: TEditFocus
        Tag = 2
        Left = 11
        Top = 61
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
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
      object edtDesEsp: TEditFocus
        Tag = 2
        Left = 119
        Top = 61
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        ReadOnly = True
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotIpi: TEditFocus
        Tag = 2
        Left = 227
        Top = 61
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        ReadOnly = True
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotRet: TEditFocus
        Tag = 2
        Left = 334
        Top = 61
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        ReadOnly = True
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesAce: TEditFocus
        Tag = 2
        Left = 442
        Top = 61
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        ReadOnly = True
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotFre: TEditFocus
        Tag = 2
        Left = 11
        Top = 101
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        ReadOnly = True
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object lblTotCBS: TLabel
        Left = 119
        Top = 87
        Width = 37
        Height = 14
        Caption = 'Vr.CBS:'
      end
      object edtTotCBS: TEditFocus
        Tag = 2
        Left = 119
        Top = 101
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        ReadOnly = True
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object lblTotIBS: TLabel
        Left = 227
        Top = 87
        Width = 35
        Height = 14
        Caption = 'Vr.IBS:'
      end
      object edtTotIBS: TEditFocus
        Tag = 2
        Left = 227
        Top = 101
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        ReadOnly = True
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object lblTotIS: TLabel
        Left = 334
        Top = 87
        Width = 30
        Height = 14
        Caption = 'Vr.IS:'
      end
      object edtTotIS: TEditFocus
        Tag = 2
        Left = 334
        Top = 101
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        ReadOnly = True
        TabOrder = 13
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
  object pnlItens: TPanel [3]
    Left = 0
    Top = 275
    Width = 855
    Height = 252
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    object Label7: TLabel
      Left = 0
      Top = 278
      Width = 855
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 'Pressione [ENTER] para marcar/desmarcar o produto'
      Color = clWhite
      ParentColor = False
      Layout = tlCenter
      ExplicitWidth = 255
    end
    object dbgItens: TcxGridCitel
      Left = 0
      Top = 0
      Width = 855
      Height = 278
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgItensDBTableView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgItensDBTableViewCustomDrawCell
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object ITE_CODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'ITE_CODITE'
          Width = 50
        end
        object ITE_DESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'ITE_DESITE'
          Width = 404
        end
        object ITE_SIGUNI: TcxGridDBColumn
          Caption = 'Unid.'
          DataBinding.FieldName = 'ITE_SIGUNI'
          Width = 33
        end
        object ITE_QTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'ITE_QTDITE'
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 85
        end
        object ITE_UNITAR: TcxGridDBColumn
          Caption = 'Vr. Unit'#225'rio'
          DataBinding.FieldName = 'ITE_UNITAR'
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 85
        end
        object ITE_TOTITE: TcxGridDBColumn
          Caption = 'Vr. Total'
          DataBinding.FieldName = 'ITE_TOTITE'
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 82
        end
        object ITE_CODFAB: TcxGridDBColumn
          Caption = 'C'#243'd. F'#225'brica'
          DataBinding.FieldName = 'ITE_CODFAB'
          Width = 85
        end
        object ITE_SEQDET: TcxGridDBColumn
          DataBinding.FieldName = 'ITE_SEQDET'
          Visible = False
        end
      end
      object dbgItensLevel1: TcxGridLevel
        GridView = dbgItensDBTableView
      end
    end
  end
  inherited pnlBotoes: TPanel [4]
    Top = 527
    Width = 855
    BevelInner = bvNone
    BorderWidth = 2
    TabOrder = 2
    ExplicitTop = 527
    ExplicitWidth = 855
    inherited FlwBotoes: TFlowPanel
      Left = 403
      Top = 3
      Width = 372
      Height = 22
      TabOrder = 4
      ExplicitLeft = 403
      ExplicitTop = 3
      ExplicitWidth = 372
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 775
      Align = alRight
      TabOrder = 3
      ExplicitLeft = 775
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 111
      Height = 22
      Align = alLeft
      Caption = '[F10] &Confirma'
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
      OnErro = btnConfirmaErro
    end
    object btnMarcar: TBitBtnLocked
      Left = 114
      Top = 3
      Width = 135
      Height = 22
      Align = alLeft
      Caption = '[ F6 ] Marcar Todos'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
        83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
        DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
        AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
        00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
        E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
        0066000066000066000066000066000066000066000066000066000066000066
        00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
        3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
        0066000066000066000066000066000066000066000066000066000066000066
        00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
        ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
        CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
        00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
        F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
        0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
        D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
        2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
        43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
        DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
        FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
        0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
        82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnMarcarClick
    end
    object btnDesmarcar: TBitBtnLocked
      Left = 249
      Top = 3
      Width = 154
      Height = 22
      Align = alLeft
      Caption = '[ F7 ] Desmarcar Todos'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
        83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
        DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
        AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
        00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
        E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF00009A
        00009A00009A00009A00009A00009A00009A00009A00009A00009A00009A0000
        9A00009A00009A00009AFF00FF00009ABB8E80FAF0DF00009AF9ECD6F9E9D100
        009A00009A00009A00009A00009A00009AF4DAB2B3897B00009AFF00FF00009A
        00009A00009A00009A00009A00009A00009A00009A00009A00009A00009A0000
        9A00009A00009A00009AFF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
        ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
        CB9C86FCF7EE006600FBF3E6FAF1E19933009933009933009933009933009933
        00F6E2C1B3897BFF00FFFF00FFFF00FFCFA089FDF9F2FDF7EEFBF5EBFCF4E6FB
        F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
        9F7B67BEBBB8BEBBB6BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
        D1F7E6CCB3897BFF00FF00009A00009A00009A00009A00009A00009A00009A73
        2600993300993300993300993300993300F8E9D2B3897BFF00FF00009A4A79FF
        2F62FF0D43FF002BF6021AD100009ABEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
        DCF9EBD7B3897BFF00FF00009A00009A00009A00009A00009A00009A00009AFD
        FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
        DEAD8EDAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA4
        82DAA482DAA482FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnDesmarcarClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 296
    Top = 8
  end
end
