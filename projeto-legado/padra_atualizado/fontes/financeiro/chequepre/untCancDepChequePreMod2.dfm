inherited frmCancDepChequePreMod2: TfrmCancDepChequePreMod2
  Left = 276
  Top = 221
  Width = 921
  Height = 571
  BorderIcons = [biSystemMenu]
  Caption = 'Cancelamento de Dep'#243'sito de Cheque'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 921
  ExplicitHeight = 571
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 500
    Width = 915
    Height = 26
    TabOrder = 2
    ExplicitLeft = -18
    ExplicitTop = 360
    ExplicitWidth = 915
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 800
      Height = 22
      TabOrder = 1
      ExplicitWidth = 911
      ExplicitHeight = 22
      object btnIniBus: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 121
        Height = 22
        BiDiMode = bdLeftToRight
        Caption = '[ F5 ] Inicia Busca'
        ParentBiDiMode = False
        TabOrder = 0
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 121
        Top = 0
        Width = 121
        Height = 22
        BiDiMode = bdLeftToRight
        Caption = '[ F6 ] Localiza Pr'#243'xima'
        ParentBiDiMode = False
        TabOrder = 1
        OnClick = btnLocProxClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 242
        Top = 0
        Width = 121
        Height = 22
        BiDiMode = bdLeftToRight
        Caption = '[ F7 ] Marcar Todos'
        ParentBiDiMode = False
        TabOrder = 2
        OnClick = btnMarcarTodosClick
      end
      object btnDesmTodos: TBitBtnLocked
        Left = 363
        Top = 0
        Width = 121
        Height = 22
        BiDiMode = bdLeftToRight
        Caption = '[ F8 ] Desmarcar Todos'
        ParentBiDiMode = False
        TabOrder = 3
        OnClick = btnDesmTodosClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 484
        Top = 0
        Width = 121
        Height = 22
        BiDiMode = bdLeftToRight
        Caption = '[ F10 ] Confirma'
        ParentBiDiMode = False
        TabOrder = 4
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 832
      Top = -1
      TabOrder = 0
      TabStop = False
      Visible = False
      ExplicitLeft = 832
      ExplicitTop = -1
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 802
      Top = 2
      Width = 111
      Height = 22
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnSairBaixaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 526
    Width = 915
    TabOrder = 3
    ExplicitTop = 526
    ExplicitWidth = 915
    inherited pnlNomeForm: TPanel
      Left = 744
      ExplicitLeft = 744
    end
    inherited pnlInfo: TPanel
      Width = 744
      ExplicitWidth = 744
    end
  end
  object pnlCons: TPanel [3]
    Left = 0
    Top = 0
    Width = 915
    Height = 86
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 59
      Top = 12
      Width = 40
      Height = 14
      Caption = 'Banco : '
    end
    object Label2: TLabel
      Left = 50
      Top = 38
      Width = 49
      Height = 14
      Caption = 'Ag'#234'ncia : '
    end
    object Label3: TLabel
      Left = 176
      Top = 38
      Width = 82
      Height = 14
      Caption = 'Conta Corrente : '
    end
    object Label4: TLabel
      Left = 342
      Top = 38
      Width = 86
      Height = 14
      Caption = 'N'#250'mero Cheque : '
    end
    object EdtCodBco: TEditFocus
      Tag = 99
      Left = 102
      Top = 8
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = EdtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object EdtNumAge: TEditFocus
      Tag = 99
      Left = 102
      Top = 34
      Width = 66
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object EdtConCor: TEditFocus
      Tag = 99
      Left = 261
      Top = 34
      Width = 66
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object EdtNumChq: TEditFocus
      Tag = 99
      Left = 431
      Top = 34
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomBco: TEditFocus
      Left = 168
      Top = 8
      Width = 417
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
    object btnPesquisa: TBitBtnLocked
      Left = 261
      Top = 58
      Width = 79
      Height = 23
      Caption = '&Pesquisar'
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
      OnClick = btnPesquisaClick
    end
    object btnCarrCheques: TBitBtnLocked
      Left = 102
      Top = 58
      Width = 121
      Height = 23
      Align = alCustom
      Caption = '&Carregar Cheques'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 4
      OnClick = btnCarrChequesClick
    end
  end
  object pnlInf: TPanel [4]
    Left = 0
    Top = 86
    Width = 560
    Height = 414
    Align = alLeft
    TabOrder = 1
    object dbgCheques: TcxGrid
      Left = 1
      Top = 1
      Width = 558
      Height = 377
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object dbgChequesDados: TcxGridDBTableView
        OnKeyDown = dbgChequesDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgChequesDadosCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        Preview.AutoHeight = False
        object dbgChequesDadosCHQ_NUMCHQ: TcxGridDBColumn
          Caption = 'N'#250'mero do Cheque'
          DataBinding.FieldName = 'CHQ_NUMCHQ'
          Width = 98
        end
        object dbgChequesDadosCHQ_CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CHQ_CODEMP'
          Width = 52
        end
        object dbgChequesDadosCHQ_DTACAD: TcxGridDBColumn
          Caption = 'Dta. cad.'
          DataBinding.FieldName = 'CHQ_DTACAD'
          Width = 62
        end
        object dbgChequesDadosCHQ_DTAVEN: TcxGridDBColumn
          Caption = 'Dta. Venc.'
          DataBinding.FieldName = 'CHQ_DTAVEN'
          Width = 80
        end
        object dbgChequesDadosCHQ_DTADEP: TcxGridDBColumn
          Caption = 'Dta. Dep'#243'sito'
          DataBinding.FieldName = 'CHQ_DTADEP'
          Width = 88
        end
        object dbgChequesDadosCHQ_CTADEP: TcxGridDBColumn
          Caption = 'Cta. Dep'#243'sito'
          DataBinding.FieldName = 'CHQ_CTADEP'
          Width = 78
        end
        object dbgChequesDadosCHQ_VALCHQ: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'CHQ_VALCHQ'
          Width = 86
        end
        object dbgChequesDadosCHQ_MARDES: TcxGridDBColumn
          Caption = 'Marca'
          DataBinding.FieldName = 'CHQ_MARDES'
          Visible = False
        end
      end
      object dbgChequesNivel: TcxGridLevel
        GridView = dbgChequesDados
      end
    end
    object pnlTotais: TPanel
      Left = 1
      Top = 379
      Width = 558
      Height = 34
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label23: TLabel
        Left = 317
        Top = 10
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object Label9: TLabel
        Left = 10
        Top = 10
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Cheques:'
      end
      object edtTotalCheques: TEditFocus
        Left = 83
        Top = 6
        Width = 83
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtValorTotal: TEditFocus
        Left = 348
        Top = 6
        Width = 83
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
  end
  object pnlAux1: TPanel [5]
    Left = 560
    Top = 86
    Width = 355
    Height = 414
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 5
    object pnlDadosCheque: TPanel
      Left = 0
      Top = 0
      Width = 355
      Height = 296
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label5: TLabel
        Left = 40
        Top = 30
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
      end
      object Nome: TLabel
        Left = 44
        Top = 52
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label7: TLabel
        Left = 31
        Top = 74
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ag'#234'ncia:'
      end
      object Label10: TLabel
        Left = 7
        Top = 96
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cta. Corrente:'
      end
      object Label12: TLabel
        Left = 11
        Top = 118
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Cheque:'
      end
      object Label14: TLabel
        Left = 31
        Top = 140
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Emitente:'
      end
      object Label6: TLabel
        Left = 25
        Top = 162
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o:'
      end
      object Label8: TLabel
        Left = 30
        Top = 184
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Telefone:'
      end
      object Label13: TLabel
        Left = 26
        Top = 206
        Width = 48
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Nota:'
      end
      object Label18: TLabel
        Left = 11
        Top = 226
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vencimento:'
      end
      object Label22: TLabel
        Left = 46
        Top = 250
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor:'
      end
      object edtBanco: TEditFocus
        Left = 76
        Top = 26
        Width = 263
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtNome: TEditFocus
        Left = 76
        Top = 48
        Width = 263
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
      object edtAgencia: TEditFocus
        Left = 76
        Top = 70
        Width = 263
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtCtaCorrente: TEditFocus
        Left = 76
        Top = 92
        Width = 263
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtNroCheque: TEditFocus
        Left = 76
        Top = 114
        Width = 263
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtEmitente: TEditFocus
        Left = 76
        Top = 136
        Width = 263
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEndereco: TEditFocus
        Left = 76
        Top = 158
        Width = 263
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
      object edtTelefone: TEditFocus
        Left = 76
        Top = 180
        Width = 263
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
      object edtNroNota: TEditFocus
        Left = 76
        Top = 202
        Width = 263
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtVencimento: TEditFocus
        Left = 76
        Top = 224
        Width = 263
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValor: TEditFocus
        Left = 76
        Top = 246
        Width = 263
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlInformativos: TPanel
      Left = 0
      Top = 296
      Width = 355
      Height = 118
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label16: TLabel
        Left = 2
        Top = 2
        Width = 351
        Height = 12
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'SELECIONADOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 355
      end
      object Label17: TLabel
        Left = 22
        Top = 39
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nro. Cheques:'
      end
      object Label19: TLabel
        Left = 38
        Top = 62
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object edtChqSelecionados: TEditFocus
        Left = 94
        Top = 35
        Width = 83
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtTotalSelecionado: TEditFocus
        Left = 94
        Top = 58
        Width = 83
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
      object GroupBox1: TGroupBox
        Left = 223
        Top = 58
        Width = 119
        Height = 51
        Caption = 'Legenda'
        TabOrder = 2
        object Shape1: TShape
          Left = 8
          Top = 16
          Width = 14
          Height = 14
        end
        object Label21: TLabel
          Left = 27
          Top = 16
          Width = 65
          Height = 14
          Caption = 'Selecionados'
        end
        object Shape2: TShape
          Left = 8
          Top = 32
          Width = 14
          Height = 14
        end
        object Label24: TLabel
          Left = 27
          Top = 32
          Width = 87
          Height = 14
          Caption = 'N'#227'o Selecionados'
        end
        object Label25: TLabel
          Left = 11
          Top = 16
          Width = 8
          Height = 14
          Caption = 'A'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          StyleElements = []
        end
        object Label26: TLabel
          Left = 11
          Top = 32
          Width = 8
          Height = 14
          Caption = 'A'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          StyleElements = []
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 848
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 792
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 744
    Top = 32
  end
  object dsConsulta: TDataSource
    Left = 661
    Top = 32
  end
end
