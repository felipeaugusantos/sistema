inherited frmRelacSimilaridade: TfrmRelacSimilaridade
  Left = 282
  Top = 348
  Width = 943
  Height = 557
  Caption = 'Relacionamento de Similaridade'
  WindowState = wsMaximized
  ExplicitWidth = 943
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 484
    Width = 937
    ExplicitTop = 484
    ExplicitWidth = 937
    DesignSize = (
      937
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 933
      ExplicitWidth = 933
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 512
    Width = 937
    ExplicitTop = 512
    ExplicitWidth = 937
    inherited pnlNomeForm: TPanel
      Left = 797
      Width = 140
      ExplicitLeft = 797
      ExplicitWidth = 140
    end
    inherited pnlInfo: TPanel
      Width = 797
      ExplicitWidth = 797
    end
  end
  inherited pgcDados: TPageControl
    Top = 61
    Width = 937
    Height = 423
    Visible = False
    ExplicitTop = 61
    ExplicitWidth = 937
    ExplicitHeight = 423
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 929
      ExplicitHeight = 391
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 937
    Height = 61
    Align = alTop
    Color = 16770261
    TabOrder = 4
    object Label1: TLabel
      Left = 33
      Top = 16
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Similar:'
    end
    object Label2: TLabel
      Left = 12
      Top = 39
      Width = 91
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo do Produto:'
    end
    object Label3: TLabel
      Left = 308
      Top = 16
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto principal:'
    end
    object edtCodSim: TEditFocus
      Left = 105
      Top = 8
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 105
      Top = 31
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 15
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object cxlProPri: TcxLookupComboBox
      Left = 397
      Top = 7
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'ITE_CODITE'
      Properties.ListColumns = <
        item
          Caption = 'Produto'
          FieldName = 'DESITE'
        end>
      Properties.ListSource = dtsConsulta
      TabOrder = 2
      Width = 383
    end
  end
  object dbgItens: TDBGridCitel [4]
    Left = 0
    Top = 61
    Width = 937
    Height = 423
    Align = alClient
    DataSource = dtsConsulta
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 299
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODFAB'
        Title.Caption = 'C'#243'd. F'#225'brica'
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Width = 218
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAR_DESMAR'
        Title.Caption = 'Marca'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNI_SIGUNI'
        Title.Caption = 'UN'
        Width = 35
        Visible = True
      end>
  end
  object pnlBotoesSim: TPanel [5]
    Left = 0
    Top = 484
    Width = 937
    Height = 28
    Align = alBottom
    Color = 16770261
    TabOrder = 5
    DesignSize = (
      937
      28)
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 4
      Width = 111
      Height = 21
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnDeletar: TBitBtnLocked
      Left = 115
      Top = 4
      Width = 111
      Height = 21
      Caption = '[ DEL ] Deleta'
      TabOrder = 1
      OnClick = btnDeletarClick
    end
    object btnPesquisa: TBitBtnLocked
      Left = 228
      Top = 4
      Width = 111
      Height = 21
      Caption = '[ F5 ] Pesquisar'
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
      TabOrder = 2
      OnClick = btnPesquisaClick
    end
    object btnCancelarEntrada: TBitBtnLocked
      Left = 817
      Top = 4
      Width = 111
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '[ Esc ] Sair'
      TabOrder = 3
      OnClick = btnCancelarEntradaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 80
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 344
    Top = 104
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 240
    Top = 224
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 320
    Top = 224
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 320
    Top = 280
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 384
    Top = 224
  end
end
