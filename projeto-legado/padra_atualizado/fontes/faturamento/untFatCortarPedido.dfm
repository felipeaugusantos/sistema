inherited frmFatCortarPedido: TfrmFatCortarPedido
  Left = 482
  Top = 194
  Width = 1024
  Height = 668
  Caption = 'Cortar Or'#231'amento / Pedido de Venda'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 668
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlStatus: TPanel [0]
    Top = 623
    Width = 1018
    TabOrder = 4
    ExplicitTop = 623
    ExplicitWidth = 1018
    inherited pnlInfo: TPanel [0]
      Width = 847
      ExplicitWidth = 847
    end
    inherited pnlNomeForm: TPanel [1]
      Left = 847
      ExplicitLeft = 847
    end
  end
  object pnlBusca: TPanel [1]
    Left = 0
    Top = 0
    Width = 1018
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
      NormalColor = clWindow
      FocusColor = clInfoBk
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
      MaxLength = 2
      TabOrder = 1
      Text = 'OR'
      NormalColor = clWindow
      FocusColor = clInfoBk
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
    Width = 1018
    Height = 218
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 5
    object pnlForPagAtu: TPanel
      Left = 2
      Top = 166
      Width = 1014
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
      Width = 1014
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
        TipoTexto = ttNumerico
      end
      object mskCndPagAtu: TMaskEditFocus
        Tag = 99
        Left = 77
        Top = 16
        Width = 524
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        EditMask = 
          '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
          '99.999.999.999.999.999.999.999.999;0;_'
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
        Left = 604
        Top = 16
        Width = 154
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
      Width = 1014
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
    Width = 1018
    Height = 322
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    object dbgItens: TDBGridCitel
      Left = 0
      Top = 0
      Width = 1018
      Height = 362
      TabStop = False
      Align = alClient
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnColEnter = dbgItensColEnter
      OnDrawColumnCell = dbgItensDrawColumnCell
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'ITE_CODITE'
          ReadOnly = True
          Title.Caption = 'C'#243'digo'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_DESITE'
          ReadOnly = True
          Title.Caption = 'Descri'#231#227'o'
          Width = 390
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_SIGUNI'
          ReadOnly = True
          Title.Caption = 'Unid.'
          Width = 33
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_QTDORI'
          ReadOnly = True
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtde. Original'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_QTDITE'
          Title.Caption = 'Qtde. Pendente'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_UNITAR'
          ReadOnly = True
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr. Unit'#225'rio'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_TOTITE'
          ReadOnly = True
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr. Total'
          Width = 80
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_SALDOS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Saldo'
          Visible = False
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_SALDIS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Saldo Dispon'#237'vel'
          Width = 90
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_QTDBAI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtde. a Cortar'
          Width = 85
          Visible = True
        end>
    end
  end
  inherited pnlBotoes: TPanel
    Top = 597
    Width = 1018
    Height = 26
    BevelInner = bvNone
    TabOrder = 2
    ExplicitTop = 597
    ExplicitWidth = 1018
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 3
      Top = 3
      Width = 0
      Height = 0
      Align = alNone
      TabOrder = 3
      ExplicitLeft = 3
      ExplicitTop = 3
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    inherited btnSair: TBitBtnLocked
      Left = 940
      Top = 1
      Height = 24
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 940
      ExplicitTop = 1
      ExplicitHeight = 24
    end
    object btnCopiarQtd: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 185
      Height = 24
      Align = alLeft
      Caption = '[F3] C&opiar Quantidade Pendente'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0002000000090000000E0000000F0000000F0000001000000010000000110000
        0011000000100000000B00000003000000000000000000000000000000000000
        00087C5345C0AD725EFFAC725DFFAC715DFFAC6F5BFFAB705CFFAB705CFFAB6E
        5CFFAB6E5AFF7A4E41C30000000B000000000000000000000000000000000000
        000BAF7462FFFDFBF9FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
        EEFFFAF2ECFFAC715DFF0000000F000000000000000000000000000000000000
        000BB17964FFFDFBFAFFF7EEE7FFF8EDE7FFF7EDE7FFF7EDE6FFF6ECE5FFF6EC
        E5FFFAF2EEFFAE7260FF01010120010101100101010B00000003000000000000
        000BB37C69FFFDFCFBFFF8EFE8FFF7EEE8FFF7EEE8FFF8EEE7FFF7EEE7FFF7EC
        E6FFFAF3EFFFB07863FFC19D92FFB57D6AFF815A4EC30101010B000000000000
        000AB57F6CFFFEFCFBFFF9F0EAFFF8F0EAFFF8EFE9FFF8EFE8FFF8EEE9FFF8EE
        E7FFFBF5F1FFB27A66FFEBE6E2FFFAF3EDFFB6806DFF0101010F000000000000
        0009B98270FFFEFDFCFFF9F2EDFFF9F2EDFFF9F0EBFFF9F0EAFFF8F0EAFFF8F0
        E9FFFBF6F3FFB37D6AFFE9E1DAFFFAF3EFFFB88170FF01010110000000000000
        0008BB8775FFFEFDFDFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF9F1EBFFF9F0
        EBFFFCF8F5FFB6806DFFEAE1DBFFFAF4F0FFB98673FF0101010F000000000000
        0007BF8B78FFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF9F3
        EDFFFCF9F7FFBA8471FFECE4DDFFFBF5F2FFBB8876FF0101010E000000000000
        0007C18E7EFFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
        EFFFFDFAF8FFBC8978FFEDE7E0FFFBF6F4FFBC8B7AFF0101010D000000000000
        0006C49382FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
        F1FFFDFBF9FFBF8C7CFFEFE8E3FFFCF8F5FFBF8E7CFF0101010D000000000000
        0005C49785FFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFDFDFFFEFD
        FDFFFEFDFCFFC2907FFFF0EBE6FFFCF9F7FFC29180FF0101010C000000000000
        0003967265C0C89988FFC99887FFC79887FFC59786FFC79785FFC79784FFC596
        84FFC59683FFCDA79AFFF4EFEAFFFDFAF8FFC49686FF0101010B000000000000
        000100000003000000040000000BD8BBB0FFF8F8F8FFF5F0EFFFF5F0EFFFF5EF
        EDFFF5EFEDFFF7F0EEFFFAF4F1FFFDFBF9FFC7998AFF0000000A000000000000
        0000000000000000000000000005CCA392FFFFFEFEFFFEFEFEFFFEFEFEFFFEFE
        FEFFFEFEFDFFFEFDFDFFFEFDFDFFFEFDFCFFCA9D8DFF00000009000000000000
        00000000000000000000000000039A7B6FC0CEA495FFCFA494FFCDA494FFCCA3
        93FFCDA392FFCDA391FFCCA291FFCCA290FF97776BC200000006}
      TabOrder = 0
      OnClick = btnCopiarQtdClick
      OnErro = btnConfirmaErro
    end
    object btnConfirma: TBitBtnLocked
      Left = 186
      Top = 1
      Width = 111
      Height = 24
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
      TabOrder = 1
      OnClick = btnConfirmaClick
      OnErro = btnConfirmaErro
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
