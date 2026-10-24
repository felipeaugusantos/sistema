inherited frmMostraDadosCobranca: TfrmMostraDadosCobranca
  Width = 792
  Height = 401
  Caption = 'Dados de Cobran'#231'a'
  OnDestroy = FormDestroy
  ExplicitWidth = 792
  ExplicitHeight = 401
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 330
    Width = 786
    ExplicitTop = 330
    ExplicitWidth = 786
    inherited FlwBotoes: TFlowPanel
      Width = 782
      ExplicitTop = 2
      ExplicitWidth = 782
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 703
      ExplicitLeft = 703
    end
  end
  inherited pnlStatus: TPanel
    Top = 356
    Width = 786
    ExplicitTop = 356
    ExplicitWidth = 786
    inherited pnlNomeForm: TPanel
      Left = 615
      ExplicitLeft = 615
    end
    inherited pnlInfo: TPanel
      Width = 615
      ExplicitWidth = 615
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 786
    Height = 330
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object grbConsulta: TGroupBox
      Left = 12
      Top = 12
      Width = 747
      Height = 302
      Caption = 'Consulta de Cr'#233'dito'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object ColorLabel17: TColorLabel
        Left = 133
        Top = 27
        Width = 515
        Height = 14
        Caption = 
          'SERASA (1), EQUIFAX (2), SINDCOMERCIO (3), CHECKCHECK (4),  MAST' +
          'ER LITE E A'#199#213'ES (5) ou SCPC (6)'
        CorDestaque = clRed
      end
      object Label150: TLabel
        Left = 6
        Top = 27
        Width = 85
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Tipo de Pesquisa:'
      end
      object pnlConsulta: TPanel
        Left = 3
        Top = 49
        Width = 734
        Height = 240
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 1
        object Label151: TLabel
          Left = 4
          Top = 6
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Data da Consulta:'
        end
        object Label152: TLabel
          Left = 203
          Top = 6
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Qtd. Protestos:'
        end
        object Label153: TLabel
          Left = 329
          Top = 6
          Width = 102
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cheques Devolvidos:'
        end
        object Label154: TLabel
          Left = 4
          Top = 24
          Width = 85
          Height = 61
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Observa'#231#245'es:'#13#10'Pressione TAB'#13#10'para a pr'#243'xima'#13#10'p'#225'gina'
        end
        object dbeDtaCon: TDBEditFocus
          Tag = 99
          Left = 93
          Top = 2
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_DTACON'
          DataSource = dtsDadCob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeQrdPro: TDBEditFocus
          Tag = 99
          Left = 279
          Top = 2
          Width = 32
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_QTDPRO'
          DataSource = dtsDadCob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeCheDev: TDBEditFocus
          Tag = 99
          Left = 435
          Top = 2
          Width = 32
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CLI_CHEDEV'
          DataSource = dtsDadCob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeObsCon: TDBMemoFocus
          Tag = 99
          Left = 92
          Top = 26
          Width = 637
          Height = 206
          DataField = 'CLI_OBSCON'
          DataSource = dtsDadCob
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object btnAbrirPastaCredito: TBitBtnLocked
          Left = 477
          Top = 1
          Width = 140
          Height = 23
          Caption = 'Arquivos de Consulta'
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
          TabOrder = 3
          OnClick = btnAbrirPastaCreditoClick
        end
      end
      object dbeCodCon: TDBEditFocus
        Tag = 99
        Left = 95
        Top = 23
        Width = 34
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CLI_CODCON'
        DataSource = dtsDadCob
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 168
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 160
  end
  object dtsDadCob: TDataSource
    Left = 488
    Top = 216
  end
end
