inherited frmGeracaoPedidoTransferenciaAberturaNovaEmpresa: TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa
  Left = 150
  Top = 89
  Width = 588
  Height = 523
  BorderIcons = [biSystemMenu]
  Caption = 'Gera'#231#227'o de Pedido de Transfer'#234'ncia para Abertura de Nova Empresa'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 588
  ExplicitHeight = 523
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 454
    Width = 582
    TabOrder = 5
    ExplicitTop = 454
    ExplicitWidth = 582
    DesignSize = (
      582
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 578
      ExplicitWidth = 578
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 478
    Width = 582
    TabOrder = 4
    ExplicitTop = 478
    ExplicitWidth = 582
    inherited pnlNomeForm: TPanel
      Left = 296
      Width = 286
      ExplicitLeft = 296
      ExplicitWidth = 286
    end
    inherited pnlInfo: TPanel
      Width = 296
      ExplicitWidth = 296
    end
  end
  inherited pgcDados: TPageControl
    Top = 115
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 3
    Visible = False
    ExplicitTop = 115
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 43
    Width = 582
    Height = 115
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object Label20: TLabel
      Left = 18
      Top = 12
      Width = 98
      Height = 14
      Caption = 'Empresa de destino:'
    end
    object Label1: TLabel
      Left = 332
      Top = 65
      Width = 153
      Height = 14
      Caption = 'Quantidade de itens por pedido:'
    end
    object Label2: TLabel
      Left = 25
      Top = 65
      Width = 91
      Height = 14
      Caption = 'Somente produtos:'
    end
    object Label3: TLabel
      Left = 43
      Top = 91
      Width = 73
      Height = 14
      Caption = 'Pre'#231'o utilizado:'
    end
    object Label4: TLabel
      Left = 386
      Top = 91
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fator sobre o pre'#231'o:'
    end
    object Label5: TLabel
      Left = 57
      Top = 37
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object edtNomEmp: TEditFocus
      Left = 191
      Top = 6
      Width = 362
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 118
      Top = 6
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object spnQuantidadeItens: TSpinEdit
      Tag = 99
      Left = 488
      Top = 58
      Width = 65
      Height = 23
      MaxValue = 300
      MinValue = 1
      TabOrder = 3
      Value = 250
      OnExit = spnQuantidadeItensExit
      OnKeyDown = spnQuantidadeItensKeyDown
      OnKeyPress = spnQuantidadeItensKeyPress
    end
    object cmbFiltroSaldo: TComboBoxFocus
      Tag = 99
      Left = 118
      Top = 58
      Width = 199
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 2
      Text = 'com saldo f'#237'sico'
      Items.Strings = (
        'com saldo f'#237'sico'
        'com saldo dispon'#237'vel')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbPrecoUtilizado: TComboBoxFocus
      Tag = 99
      Left = 118
      Top = 84
      Width = 199
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtFatorPreco: TEditFocus
      Tag = 99
      Left = 488
      Top = 84
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      Text = '1,000'
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.000'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 118
      Top = 32
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 1
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
      Left = 191
      Top = 32
      Width = 362
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  object pnlBotoesBaixa: TPanel [4]
    Left = 0
    Top = 454
    Width = 582
    Height = 24
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 112
      Height = 20
      Align = alLeft
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
    object btnSairAgrup: TBitBtnLocked
      Left = 469
      Top = 2
      Width = 111
      Height = 20
      Align = alRight
      Caption = '[ Esc ] Sair'
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
      TabOrder = 1
      OnClick = btnSairAgrupClick
    end
  end
  object pnl2: TPanel [5]
    Left = 0
    Top = 158
    Width = 582
    Height = 296
    Align = alClient
    ParentColor = True
    TabOrder = 6
    object mmoLogImp: TMemo
      Left = 1
      Top = 19
      Width = 580
      Height = 229
      Align = alClient
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object pnl4: TPanel
      Left = 1
      Top = 1
      Width = 580
      Height = 18
      Align = alTop
      Caption = 'Informa'#231#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
    end
    object pnlProgressoGeral: TPanel
      Left = 1
      Top = 248
      Width = 580
      Height = 47
      Align = alBottom
      ParentColor = True
      TabOrder = 2
      object lblProgressoGeral: TLabel
        Left = 1
        Top = 1
        Width = 578
        Height = 23
        Align = alClient
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 21
        ExplicitHeight = 14
      end
      object pgbProgressoGeral: TcxProgressBar
        Left = 1
        Top = 24
        Align = alBottom
        Properties.PeakValue = 100.000000000000000000
        TabOrder = 0
        ExplicitTop = 25
        Width = 578
      end
    end
  end
  object pnlArquivo: TPanel [6]
    Left = 0
    Top = 0
    Width = 582
    Height = 43
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    Visible = False
    object Label6: TLabel
      Left = 75
      Top = 16
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Arquivo:'
    end
    object btnOpenDirectory: TcxButton
      Left = 531
      Top = 11
      Width = 23
      Height = 22
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000002B744558745469746C65004F70656E3B466F6C6465723B426172733B
        526962626F6E3B5374616E646172643B4C6F6164F1C3C4630000022249444154
        785EA593BD6B545110C57F6FF3242AA9B412144B3FB1500CA20663FC032C6C44
        B0B010041194147616366295805A88A058898D8D106C444D6C44123426120959
        36B8316FD9F8F2B15F6FDFBD7746B9EFAD82019B1CB81C6698397366E006AACA
        461000859CC959F327FC079DC1E1C4C381D785807EB21815A827E642DF8DB1E7
        E30F4E8BA2A0CA1F12A5F7FA281D8488F61FBAFC940C8A6DD5987A76F3DE9D4B
        FB468F5C7D53653D0470B94B426704DC2AA4DF517184380E9EBBB6DD99E1F2A9
        03DB4072BB0AA2608C1B1BB8F5E10C6032012BA00E5C422016D4D2250D0E5F1C
        24E8DE0104A00208AA8ED1BB57FA80AEBF02A9CB046C82DA26625BE00CD4CBA8
        CF1B54F21A1556AB75809E20080A800BDEDD3EA67D8343C8CA272AD3E3C40B15
        54404510C92EA7A28888E7A5F92AEAD38A38AD862675B4E28864A1C872D460FF
        F961BC786E1B71A85A108B3A8B8A0149894BDF78FB6868DEAFB05A2E11CFCCD2
        B3AB174D221AB32F51DF90DD47457C8C737E1D114769B2CCCA9A19094DDBB154
        9A632D5A66E7F1BDB42BD3D85ADC29CC9A54C04F17C40B0951B1C29772FD4598
        B62D4B73737477F7B0796B487D6602DB58F6D63B2E347391E71CB59536F1CFC6
        D7FBEFA362D86AA4B018B1E7C44992C529926AD14F50BF7BA749BD082A5EA8BA
        9010D7CD0860C24633FD88AB1D9D1C79C5647E5D72560001505401554421B55A
        FEFCA3F9184803600BB00928B01EC13FB10206489E9CDDED0036FC9D7F01FAB6
        A14B22EE620A0000000049454E44AE426082}
      TabOrder = 1
      TabStop = False
      OnClick = btnOpenDirectoryClick
    end
    object edtNomArq: TEditFocus
      Tag = 99
      Left = 118
      Top = 11
      Width = 411
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnExit = edtNomArqExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 552
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 520
  end
  object FileOpenDialog: TFileOpenDialog
    DefaultExtension = '*.txt'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Arquivos de Texto (*.txt)'
        FileMask = '*.txt'
      end>
    Options = []
    Left = 456
    Top = 40
  end
end
