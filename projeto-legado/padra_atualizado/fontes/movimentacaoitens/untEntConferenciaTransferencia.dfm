inherited frmEntConferenciaTransferencia: TfrmEntConferenciaTransferencia
  Width = 954
  Height = 543
  BorderStyle = bsSizeable
  Caption = 'Confer'#234'ncia de Transfer'#234'ncia entre Armazens'
  WindowState = wsMaximized
  ExplicitWidth = 954
  ExplicitHeight = 543
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 209
    Width = 938
    Height = 6
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 177
    ExplicitWidth = 880
  end
  inherited pnlBotoes: TPanel
    Top = 462
    Width = 938
    ExplicitTop = 462
    ExplicitWidth = 938
    inherited FlwBotoes: TFlowPanel
      Width = 934
      ExplicitWidth = 934
      inherited btnConfirma: TBitBtnLocked
        Width = 113
        Caption = '[F10] &Confirma'
        ModalResult = 0
        TabStop = False
        ExplicitWidth = 113
      end
      object btnReniciarContagem: TBitBtnLocked
        Left = 113
        Top = 0
        Width = 113
        Height = 22
        Caption = '&Reiniciar Contagem'
        NumGlyphs = 2
        TabOrder = 1
        TabStop = False
        OnClick = btnReniciarContagemClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 226
        Top = 0
        Width = 183
        Height = 22
        Caption = '&Excluir produto da confer'#234'ncia'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        TabStop = False
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 858
      ModalResult = 0
      TabStop = False
      ExplicitLeft = 858
    end
  end
  inherited pnlStatus: TPanel
    Top = 488
    Width = 938
    ExplicitTop = 488
    ExplicitWidth = 938
    inherited pnlNomeForm: TPanel
      Left = 767
      ExplicitLeft = 767
    end
    inherited pnlInfo: TPanel
      Width = 767
      ExplicitWidth = 767
    end
  end
  object pnlHeader: TPanel [3]
    Left = 0
    Top = 0
    Width = 938
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 3
      Top = 9
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo da Confer'#234'ncia:'
    end
    object clbSubProdPermiteVendaSeparado: TColorLabel
      Left = 159
      Top = 8
      Width = 96
      Height = 14
      Caption = '(S)Sa'#237'da (E)Entrada'
      CorDestaque = clRed
    end
    object Label8: TLabel
      Left = 54
      Top = 32
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Armaz'#233'm:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 6
      Top = 56
      Width = 97
      Height = 14
      Caption = 'Per'#237'odo de Emiss'#227'o:'
    end
    object Label5: TLabel
      Left = 186
      Top = 56
      Width = 6
      Height = 14
      Caption = #224
    end
    object Label6: TLabel
      Left = 6
      Top = 80
      Width = 461
      Height = 14
      Caption = 
        'Transfer'#234'ncias pendentes de Confer'#234'ncia de Sa'#237'da (ou Entrada, co' +
        'nforme informado no filtro): '
    end
    object edtCodTip: TEditFocus
      Tag = 99
      Left = 105
      Top = 5
      Width = 52
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesAmz: TEditFocus
      Left = 159
      Top = 28
      Width = 373
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtDataInicial: TMaskEditFocus
      Left = 105
      Top = 52
      Width = 73
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtDataFinal: TMaskEditFocus
      Left = 198
      Top = 52
      Width = 73
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnPesquisar: TBitBtnLocked
      Left = 407
      Top = 52
      Width = 125
      Height = 22
      Caption = '[ F5 ] &Pesquisar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
        1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
        7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
        E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
        EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
        8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 5
      OnClick = btnPesquisarClick
    end
    object edtCodAmz: TEditFocus
      Tag = 99
      Left = 105
      Top = 28
      Width = 52
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 1
      OnExit = edtCodAmzExit
      OnKeyPress = edtCodAmzKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgConsulta: TDBGridCitel [4]
    Left = 0
    Top = 215
    Width = 938
    Height = 215
    TabStop = False
    Align = alClient
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgConsultaDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_DTADOC'
        Title.Caption = 'Data Documento'
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Documento'
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_DESMAR'
        Title.Caption = 'Marca'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_ARMORI'
        Title.Caption = 'Armz. Origem'
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_ARMDES'
        Title.Caption = 'Armz. Destino'
        Width = 102
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_QTDCFS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtde. Conferida'
        Width = 103
        Visible = True
      end>
  end
  object pnlTail: TPanel [5]
    Left = 0
    Top = 430
    Width = 938
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    object Label2: TLabel
      Left = 6
      Top = 10
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object Label3: TLabel
      Left = 211
      Top = 10
      Width = 58
      Height = 14
      Caption = 'Quantidade:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 44
      Top = 6
      Width = 163
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 275
      Top = 4
      Width = 73
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 1
      Text = '1,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object dbgConsultaArmazem: TDBGridCitel [6]
    Left = 0
    Top = 97
    Width = 938
    Height = 112
    TabStop = False
    Align = alTop
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgConsultaArmazemDrawColumnCell
    OnDblClick = dbgConsultaArmazemDblClick
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_DTADOC'
        Title.Caption = 'Data Documento'
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Documento'
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_ESPDOC'
        Title.Caption = 'Esp. Doc.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_ARMORI'
        Title.Caption = 'Armz. Origem'
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_ARMDES'
        Title.Caption = 'Armz. Destino'
        Width = 102
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_STATUS'
        Title.Caption = 'Status'
        Width = 299
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 24
  end
end
