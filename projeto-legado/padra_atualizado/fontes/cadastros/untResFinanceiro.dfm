inherited frmResFinanceiro: TfrmResFinanceiro
  Left = 324
  Top = 206
  Width = 604
  Height = 754
  BorderIcons = [biSystemMenu]
  Caption = 'Resumo Financeiro'
  Position = poMainFormCenter
  ExplicitTop = -13
  ExplicitWidth = 604
  ExplicitHeight = 754
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 681
    Width = 598
    TabOrder = 2
    ExplicitTop = 660
    ExplicitWidth = 598
    DesignSize = (
      598
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 594
      TabOrder = 3
      ExplicitWidth = 594
    end
    inherited btnSair: TBitBtnLocked
      Left = 517
      TabOrder = 2
      ExplicitLeft = 517
    end
    object btnObsCli: TBitBtnLocked
      Left = 123
      Top = 3
      Width = 92
      Height = 22
      Caption = '[ F6 ] Obs Cliente'
      TabOrder = 1
      OnClick = btnObsCliClick
    end
    object btnDadosCobr: TBitBtnLocked
      Left = 6
      Top = 3
      Width = 117
      Height = 22
      Caption = '[ F5 ] Dados Cobran'#231'a'
      TabOrder = 0
      OnClick = btnDadosCobrClick
    end
    object btnAlterarLimCre: TBitBtnLocked
      Left = 216
      Top = 3
      Width = 137
      Height = 22
      Caption = '[F7] Alterar limite de cr'#233'dito'
      TabOrder = 4
      OnClick = btnAlterarLimCreClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 709
    Width = 598
    TabOrder = 3
    ExplicitTop = 688
    ExplicitWidth = 598
    inherited pnlNomeForm: TPanel
      Left = 427
      ExplicitLeft = 427
    end
    inherited pnlInfo: TPanel
      Width = 427
      ExplicitWidth = 427
    end
  end
  object pnlCliente: TPanel [2]
    Left = 0
    Top = 0
    Width = 598
    Height = 74
    Align = alTop
    AutoSize = True
    Color = 16770261
    TabOrder = 0
    object pnlDadosCliente: TPanel
      Left = 1
      Top = 1
      Width = 596
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 25
        Top = 9
        Width = 38
        Height = 14
        Caption = 'Cliente: '
      end
      object lblCpfCnpjCliente: TLabel
        Left = 419
        Top = 9
        Width = 28
        Height = 14
        Caption = 'CNPJ:'
      end
      object edtCodCliente: TEditFocus
        Tag = 99
        Left = 70
        Top = 6
        Width = 64
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodClienteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesCliente: TEditFocus
        Left = 136
        Top = 6
        Width = 267
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCpfCnpjCliente: TEditFocus
        Left = 451
        Top = 6
        Width = 106
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnCopiarCpfCnpj: TcxButton
        Left = 561
        Top = 6
        Width = 23
        Height = 22
        Hint = 'Copiar CPF/CNPJ'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000025744558745469746C6500436F70793B426172733B526962626F6E3B
          5374616E646172643B436C6F6E656D0EDF5B000001B649444154785E7D90318B
          53411446CF7DD94D229AC24A2BC1CADE56248D8A76D65A2B6C6721DA0A82D66A
          A1A58DFD7656168B0B36D6AB85827F40566159F3E6CDBD9F929921210B4E3317
          1EE7BC33D724B17E66B3D9E8F9EBBD0F9DD95C18104842180290109053FAF8E4
          C18D6B5B9C3C9DD07CE7CE65A0C9A9F06A7EF1F6F35560B4149899011D6093C9
          647CE1FC1952EAF9B37000A28266DD3F62C47432C2B303582BE89EBDF954B265
          7CF97EC8C1B79F88AE660702CE9D9D72FBE62526E35364DF10483E7F74FFCA7F
          B39FBEDA27E78C24D210EB02CC73418E6BB6B07207C8C474DC2DB3DD45881305
          960747802464566E00A3CC1572050A11454013903C00080C095001010221897E
          88B5026D3E21832042C8A83308812850CE840721E1B1B18361080484B4064351
          14B1BB2384043E6C1464CFE54314A87A304140CB66BADD11802B00B47AC29254
          2D68FF368450D4820876DF1FF0F5C711B93FDA07721330785058519750E02613
          780A1EEE5CBF381E8F7F0103B06802A2EEE0F4740B54F090210588964D4AE9B0
          EFFBDF8D6B02EFD3F1DEBDC7BB73B15AA299AABD088645C906D814A4772FEFDE
          02B601033879A396BD2EF80B61825062DDA3F2C70000000049454E44AE426082}
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        TabOrder = 3
        OnClick = btnCopiarCpfCnpjClick
      end
    end
    object pnlRedLoj: TPanel
      Left = 1
      Top = 31
      Width = 596
      Height = 42
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label38: TLabel
        Left = 6
        Top = 3
        Width = 57
        Height = 14
        Caption = 'Rede Lojas:'
      end
      object edtCodRedLoj: TEditFocus
        Tag = 99
        Left = 70
        Top = 1
        Width = 64
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesRedLoj: TEditFocus
        Left = 136
        Top = 1
        Width = 267
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkRedLoj: TCheckBox
        Left = 70
        Top = 24
        Width = 481
        Height = 17
        Caption = 
          'Listar tamb'#233'm os outros clientes da mesma rede de loja deste cli' +
          'ente.'
        TabOrder = 2
        OnClick = chkRedLojClick
      end
    end
  end
  object Panel2: TPanel [3]
    Left = 406
    Top = 74
    Width = 192
    Height = 607
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 1
    ExplicitHeight = 586
    object pnlUltCom: TPanel
      Left = 0
      Top = 0
      Width = 192
      Height = 154
      Align = alTop
      Color = 16770261
      TabOrder = 0
      object Label14: TLabel
        Left = 1
        Top = 1
        Width = 190
        Height = 14
        Align = alTop
        Alignment = taCenter
        Caption = #218'LTIMA COMPRA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 92
      end
      object Label15: TLabel
        Left = 37
        Top = 27
        Width = 25
        Height = 14
        Caption = 'Data:'
      end
      object Label19: TLabel
        Left = 22
        Top = 50
        Width = 40
        Height = 14
        Caption = 'N'#186' Nota:'
      end
      object Label20: TLabel
        Left = 34
        Top = 73
        Width = 28
        Height = 14
        Caption = 'Valor:'
      end
      object Label21: TLabel
        Left = 28
        Top = 119
        Width = 34
        Height = 14
        Caption = 'Inativo:'
      end
      object Label40: TLabel
        Left = 7
        Top = 96
        Width = 55
        Height = 14
        Caption = 'Cond. Pgto:'
      end
      object edtNumNota: TEditFocus
        Left = 62
        Top = 46
        Width = 110
        Height = 22
        Alignment = taRightJustify
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
      object edtVrUltCom: TEditFocus
        Left = 62
        Top = 69
        Width = 110
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtInativo: TEditFocus
        Left = 62
        Top = 115
        Width = 110
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDtaUltCom: TEditFocus
        Left = 62
        Top = 23
        Width = 110
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object mskCndPag: TMaskEditFocus
        Tag = 99
        Left = 62
        Top = 92
        Width = 110
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        EditMask = 
          '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
          '99.999.999.999.999.999.999.999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 98
        ReadOnly = True
        TabOrder = 4
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object pnlAtrasados: TPanel
      Left = 0
      Top = 154
      Width = 192
      Height = 122
      Align = alTop
      Color = 16770261
      TabOrder = 1
      object Label24: TLabel
        Left = 1
        Top = 1
        Width = 190
        Height = 14
        Align = alTop
        Alignment = taCenter
        Caption = 'ATRASADOS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 66
      end
      object Label25: TLabel
        Left = 24
        Top = 26
        Width = 28
        Height = 14
        Caption = 'M'#233'dia'
      end
      object Label26: TLabel
        Left = 26
        Top = 49
        Width = 26
        Height = 14
        Caption = 'Maior'
      end
      object Label27: TLabel
        Left = 26
        Top = 72
        Width = 25
        Height = 14
        Caption = 'Atual'
      end
      object Label13: TLabel
        Left = 8
        Top = 94
        Width = 47
        Height = 14
        Caption = 'Md. Pond.'
      end
      object edtMaiorAtrasado: TEditFocus
        Left = 62
        Top = 45
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 1
        OnMouseLeave = edtMaiorAtrasadoMouseLeave
        OnMouseMove = edtMaiorAtrasadoMouseMove
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtAtualAtrasado: TEditFocus
        Left = 62
        Top = 68
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 2
        OnMouseLeave = edtAtualAtrasadoMouseLeave
        OnMouseMove = edtAtualAtrasadoMouseMove
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtMediaAtrasado: TEditFocus
        Left = 62
        Top = 22
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 0
        OnMouseLeave = edtMediaAtrasadoMouseLeave
        OnMouseMove = edtMediaAtrasadoMouseMove
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtPonderadaAtraso: TEditFocus
        Left = 62
        Top = 91
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 3
        OnMouseLeave = edtPonderadaAtrasoMouseLeave
        OnMouseMove = edtPonderadaAtrasoMouseMove
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object pnlCadastro: TPanel
      Left = 0
      Top = 276
      Width = 192
      Height = 331
      Align = alClient
      Color = 16770261
      TabOrder = 2
      ExplicitHeight = 310
      object lbl1: TLabel
        Left = 7
        Top = 31
        Width = 59
        Height = 14
        Caption = #218'lt. 3 meses'
      end
      object Label17: TLabel
        Left = 1
        Top = 1
        Width = 190
        Height = 14
        Align = alTop
        Alignment = taCenter
        Caption = 'ACUMULADOS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 77
      end
      object Label18: TLabel
        Left = 7
        Top = 54
        Width = 62
        Height = 14
        Caption = 'Maior no ano'
      end
      object Label34: TLabel
        Left = 8
        Top = 75
        Width = 60
        Height = 14
        Caption = 'Dt Maior ano'
      end
      object edtAcumulo: TEditFocus
        Left = 78
        Top = 25
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 0
        OnMouseLeave = edtAcumuloMouseLeave
        OnMouseMove = edtAcumuloMouseMove
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtAcumuloAno: TEditFocus
        Left = 78
        Top = 48
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 1
        OnMouseLeave = edtAcumuloAnoMouseLeave
        OnMouseMove = edtAcumuloAnoMouseMove
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDtaMaiAcumulo: TEditFocus
        Left = 78
        Top = 71
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 2
        OnMouseLeave = edtDtaMaiAcumuloMouseLeave
        OnMouseMove = edtDtaMaiAcumuloMouseMove
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object pnlDataCadastro: TPanel
        Left = 1
        Top = 301
        Width = 190
        Height = 29
        Align = alBottom
        Color = 16770261
        TabOrder = 3
        ExplicitTop = 280
        object Label35: TLabel
          Left = 15
          Top = 8
          Width = 44
          Height = 14
          Caption = 'Cadastro'
        end
        object edtCadastro: TEditFocus
          Left = 77
          Top = 3
          Width = 94
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 0
          OnMouseLeave = edtCadastroMouseLeave
          OnMouseMove = edtCadastroMouseMove
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 74
    Width = 406
    Height = 607
    Align = alLeft
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 4
    ExplicitHeight = 586
    object pnlDados: TPanel
      Left = 0
      Top = 0
      Width = 406
      Height = 607
      Align = alClient
      Color = 16770261
      TabOrder = 0
      ExplicitHeight = 586
      object Panel5: TPanel
        Left = 1
        Top = 185
        Width = 404
        Height = 122
        Align = alTop
        Color = 16770261
        TabOrder = 0
        object lblChequeAVista: TLabel
          Left = 21
          Top = 18
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'Chq. a Vista:'
        end
        object lblChequeAPrazo: TLabel
          Left = 18
          Top = 41
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Chq. a Prazo:'
        end
        object lblPredatados: TLabel
          Left = 1
          Top = 62
          Width = 82
          Height = 14
          Caption = 'Total Cheques:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 3
          Top = 95
          Width = 80
          Height = 14
          Caption = 'Chq. Devolvid.:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtQtdChequeAVistaEmAberto: TEditFocus
          Left = 84
          Top = 14
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtQtdChequeAPrazoEmAberto: TEditFocus
          Left = 84
          Top = 37
          Width = 40
          Height = 22
          Alignment = taRightJustify
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
        object edtValorChequeAVistaEmAberto: TEditFocus
          Left = 125
          Top = 14
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtValorChequeAPrazoEmAberto: TEditFocus
          Left = 125
          Top = 37
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtQtdChequeAVistaLiquidados: TEditFocus
          Left = 245
          Top = 14
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtQtdChequeAPrazoLiquidados: TEditFocus
          Left = 245
          Top = 37
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtValorChequeAVistaLiquidados: TEditFocus
          Left = 286
          Top = 14
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtValorChequeAPrazoLiquidados: TEditFocus
          Left = 286
          Top = 37
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnChequeAVistaEmAberto: TBitBtnLocked
          Left = 197
          Top = 15
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos em Atraso...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = btnChequeAVistaEmAbertoClick
        end
        object btnChequeAPrazoEmAberto: TBitBtnLocked
          Left = 197
          Top = 39
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos em Atraso...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = btnChequeAPrazoEmAbertoClick
        end
        object btnChequeAVistaLiquidado: TBitBtnLocked
          Left = 358
          Top = 15
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos em Atraso...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          OnClick = btnChequeAVistaLiquidadoClick
        end
        object btnChequeAPrazoLiquidado: TBitBtnLocked
          Left = 358
          Top = 39
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos em Atraso...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnClick = btnChequeAPrazoLiquidadoClick
        end
        object edtQtdAberto2: TEditFocus
          Left = 84
          Top = 60
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVrAberto2: TEditFocus
          Left = 125
          Top = 60
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnChqPreAberto: TBitBtnLocked
          Left = 197
          Top = 61
          Width = 24
          Height = 21
          Hint = 'Visualizar Cheques Pr'#233'-datados em Aberto...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          OnClick = btnChqPreAbertoClick
        end
        object edtQtdLiq2: TEditFocus
          Left = 245
          Top = 60
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVrLiq2: TEditFocus
          Left = 286
          Top = 60
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnChqPreLiquidado: TBitBtnLocked
          Left = 358
          Top = 61
          Width = 24
          Height = 21
          Hint = 'Visualizar Cheques Pr'#233'-datados Liquidados...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          OnClick = btnChqPreLiquidadoClick
        end
        object edtQtdAberto3: TEditFocus
          Left = 84
          Top = 91
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVrAberto3: TEditFocus
          Left = 125
          Top = 91
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnChqDevAberto: TBitBtnLocked
          Left = 197
          Top = 92
          Width = 24
          Height = 21
          Hint = 'Visualizar Cheques devolvidos em Aberto...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 20
          OnClick = btnChqDevAbertoClick
        end
        object edtQtdLiq3: TEditFocus
          Left = 245
          Top = 91
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 21
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVrLiq3: TEditFocus
          Left = 286
          Top = 91
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 22
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnChqDevLiquidado: TBitBtnLocked
          Left = 358
          Top = 92
          Width = 24
          Height = 21
          Hint = 'Visualizar Cheques devolvidos Liquidados...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 23
          OnClick = btnChqDevLiquidadoClick
        end
      end
      object pnlPedNaoFat: TPanel
        Left = 1
        Top = 124
        Width = 404
        Height = 30
        Align = alTop
        Color = 16770261
        TabOrder = 1
        object Label16: TLabel
          Left = 10
          Top = 7
          Width = 72
          Height = 14
          Caption = 'Ped. n'#227'o Fatur.'
        end
        object edtQtdPedNaoFat: TEditFocus
          Left = 84
          Top = 4
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTotPedNaoFat: TEditFocus
          Left = 125
          Top = 4
          Width = 72
          Height = 22
          Alignment = taRightJustify
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
        object btnPedNaoFat: TBitBtnLocked
          Left = 197
          Top = 5
          Width = 24
          Height = 21
          Hint = 'Visualizar Pedidos de Venda n'#227'o Faturados...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnPedNaoFatClick
        end
      end
      object Panel7: TPanel
        Left = 1
        Top = 1
        Width = 404
        Height = 123
        Align = alTop
        Color = 16770261
        TabOrder = 2
        object Label2: TLabel
          Left = 13
          Top = 86
          Width = 70
          Height = 14
          Caption = 'Total T'#237'tulos:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 91
          Top = 22
          Width = 26
          Height = 14
          Caption = 'Qtde.'
        end
        object Label6: TLabel
          Left = 114
          Top = 2
          Width = 62
          Height = 14
          Caption = 'EM ABERTO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 148
          Top = 22
          Width = 25
          Height = 14
          Caption = 'Valor'
        end
        object Label8: TLabel
          Left = 252
          Top = 22
          Width = 26
          Height = 14
          Caption = 'Qtde.'
        end
        object Label9: TLabel
          Left = 269
          Top = 2
          Width = 65
          Height = 14
          Caption = 'LIQUIDADOS'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 309
          Top = 22
          Width = 25
          Height = 14
          Caption = 'Valor'
        end
        object Label23: TLabel
          Left = 13
          Top = 64
          Width = 70
          Height = 14
          Caption = 'Tit. Atrasados:'
        end
        object lblTitulosDentroPrazo: TLabel
          Left = 20
          Top = 42
          Width = 63
          Height = 14
          Caption = 'Tit. no Prazo:'
        end
        object edtQtdAberto1: TEditFocus
          Left = 84
          Top = 84
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVrAberto1: TEditFocus
          Left = 125
          Top = 84
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtQtdLiq1: TEditFocus
          Left = 245
          Top = 84
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVrLiq1: TEditFocus
          Left = 286
          Top = 84
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnTitAberto: TBitBtnLocked
          Left = 197
          Top = 85
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos em Aberto...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = btnTitAbertoClick
        end
        object btnTitLiquidado: TBitBtnLocked
          Left = 358
          Top = 85
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos Liquidados...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = btnTitLiquidadoClick
        end
        object edtAtrasQtd: TEditFocus
          Left = 84
          Top = 61
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtAtrasVr: TEditFocus
          Left = 125
          Top = 61
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtAtrasLiqQtd: TEditFocus
          Left = 245
          Top = 61
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtAtrasLiqVr: TEditFocus
          Left = 286
          Top = 61
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnTitAtrasado: TBitBtnLocked
          Left = 197
          Top = 63
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos Liquidados em Aberto...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          OnClick = btnTitAtrasadoClick
        end
        object btnTitLiqAtrasado: TBitBtnLocked
          Left = 358
          Top = 62
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos Liquidados em Atraso...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnClick = btnTitLiqAtrasadoClick
        end
        object edtQtdDentroPrazoAberto: TEditFocus
          Left = 84
          Top = 38
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtValorDentroPrazoAberto: TEditFocus
          Left = 125
          Top = 38
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnTitulosDentroPrazoAberto: TBitBtnLocked
          Left = 197
          Top = 40
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos Liquidados em Atraso...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          OnClick = btnTitulosDentroPrazoAbertoClick
        end
        object edtQtdDentroPrazoLiquidado: TEditFocus
          Left = 245
          Top = 38
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtValorDentroPrazoLiquidado: TEditFocus
          Left = 286
          Top = 38
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnTitulosDentroPrazoLiquidado: TBitBtnLocked
          Left = 358
          Top = 39
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos Liquidados em Atraso...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          OnClick = btnTitulosDentroPrazoLiquidadoClick
        end
      end
      object Panel6: TPanel
        Left = 1
        Top = 394
        Width = 404
        Height = 38
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 3
        ExplicitTop = 369
        object Label22: TLabel
          Left = 44
          Top = 11
          Width = 39
          Height = 14
          Caption = 'TOTAL:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtTotalQtd: TEditFocus
          Left = 84
          Top = 7
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTotalVr: TEditFocus
          Left = 125
          Top = 7
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTotalLiqQtd: TEditFocus
          Left = 245
          Top = 7
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTotalLiqValor: TEditFocus
          Left = 286
          Top = 7
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
      object pnlEPemAberto: TPanel
        Left = 1
        Top = 154
        Width = 404
        Height = 31
        Align = alTop
        Color = 16770261
        TabOrder = 4
        object Label12: TLabel
          Left = 14
          Top = 7
          Width = 69
          Height = 14
          Caption = 'EP. em Aberto:'
        end
        object edtQtdEPemAberto: TEditFocus
          Left = 84
          Top = 4
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTotEPemAberto: TEditFocus
          Left = 125
          Top = 4
          Width = 72
          Height = 22
          Alignment = taRightJustify
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
        object btnEmpAberto: TBitBtnLocked
          Left = 197
          Top = 5
          Width = 24
          Height = 21
          Hint = 'Visualizar Empr'#233'stimos em aberto para o cliente...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnEmpAbertoClick
        end
      end
      object Panel8: TPanel
        Left = 1
        Top = 307
        Width = 404
        Height = 87
        Align = alTop
        ShowCaption = False
        TabOrder = 5
        object Label31: TLabel
          Left = 32
          Top = 12
          Width = 51
          Height = 14
          Caption = 'Cr'#233'ditos:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label36: TLabel
          Left = 16
          Top = 57
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telecheque:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblCash: TLabel
          Left = 26
          Top = 35
          Width = 57
          Height = 14
          Caption = 'Cashback:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtQtdAbertoCred: TEditFocus
          Left = 84
          Top = 8
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVrAbertoCred: TEditFocus
          Left = 125
          Top = 8
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnCredAberto: TBitBtnLocked
          Left = 198
          Top = 9
          Width = 24
          Height = 21
          Hint = 'Visualizar Cr'#233'ditos em Aberto...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnCredAbertoClick
        end
        object edtQtdLiqCred: TEditFocus
          Left = 245
          Top = 8
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVrLiqCred: TEditFocus
          Left = 286
          Top = 8
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnCredLiquidado: TBitBtnLocked
          Left = 359
          Top = 9
          Width = 24
          Height = 21
          Hint = 'Visualizar Cr'#233'ditos Liquidados...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = btnCredLiquidadoClick
        end
        object edtTeleQtd: TEditFocus
          Left = 84
          Top = 54
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTeleVr: TEditFocus
          Left = 125
          Top = 54
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTeleLiqQtd: TEditFocus
          Left = 245
          Top = 54
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTeleLiqVr: TEditFocus
          Left = 286
          Top = 54
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnTelechequeEmAberto: TBitBtnLocked
          Left = 197
          Top = 55
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos em Atraso...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          OnClick = btnTelechequeEmAbertoClick
        end
        object btnTelechequeLiquidado: TBitBtnLocked
          Left = 359
          Top = 55
          Width = 24
          Height = 21
          Hint = 'Visualizar T'#237'tulos em Atraso...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnClick = btnTelechequeLiquidadoClick
        end
        object edtQtdAbertoCash: TEditFocus
          Left = 84
          Top = 31
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVrAbertoCash: TEditFocus
          Left = 125
          Top = 31
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnCashAberto: TBitBtnLocked
          Left = 198
          Top = 32
          Width = 24
          Height = 21
          Hint = 'Visualizar Cashback em Aberto...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          OnClick = btnCashAbertoClick
        end
        object edtQtdLiqCash: TEditFocus
          Left = 245
          Top = 31
          Width = 40
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVrLiqCash: TEditFocus
          Left = 286
          Top = 31
          Width = 72
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnCashLiquidado: TBitBtnLocked
          Left = 359
          Top = 32
          Width = 24
          Height = 21
          Hint = 'Visualizar Cashback Liquidados...'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          OnClick = btnCashLiquidadoClick
        end
      end
      object Panel9: TPanel
        Left = 1
        Top = 432
        Width = 404
        Height = 60
        Align = alTop
        TabOrder = 6
        ExplicitTop = 407
        object Label37: TLabel
          Left = 19
          Top = 10
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'Qtd. Prorrog.'
        end
        object Label39: TLabel
          Left = 20
          Top = 35
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'M'#233'dia (dias)'
        end
        object edtQtdPrd: TEditFocus
          Left = 83
          Top = 7
          Width = 113
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtLiqPrd: TEditFocus
          Left = 245
          Top = 7
          Width = 113
          Height = 22
          Alignment = taRightJustify
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
        object edtMedPrd: TEditFocus
          Left = 83
          Top = 30
          Width = 113
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtMedLiqPrd: TEditFocus
          Left = 245
          Top = 30
          Width = 113
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
      object pnlDados2: TPanel
        Left = 1
        Top = 492
        Width = 404
        Height = 118
        Align = alTop
        Color = 16770261
        TabOrder = 7
        ExplicitTop = 467
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 204
          Height = 116
          Align = alLeft
          BevelOuter = bvNone
          Color = 16770261
          TabOrder = 0
          object Label28: TLabel
            Left = 49
            Top = 24
            Width = 27
            Height = 14
            Caption = 'Limite'
          end
          object Label29: TLabel
            Left = 19
            Top = 47
            Width = 57
            Height = 14
            Caption = 'Dispon'#237'vel'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label3: TLabel
            Left = 36
            Top = 70
            Width = 40
            Height = 14
            Caption = 'Cr'#233'ditos'
          end
          object lblLimiteAlpe: TLabel
            Left = 25
            Top = 92
            Width = 51
            Height = 14
            Alignment = taRightJustify
            Caption = 'Limite Alpe'
            Visible = False
          end
          object edtLimTotal: TEditFocus
            Left = 81
            Top = 20
            Width = 85
            Height = 22
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Enabled = False
            ParentBiDiMode = False
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtDisponivel: TEditFocus
            Left = 81
            Top = 43
            Width = 85
            Height = 22
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Enabled = False
            ParentBiDiMode = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtCreditos: TEditFocus
            Left = 81
            Top = 66
            Width = 85
            Height = 22
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Enabled = False
            ParentBiDiMode = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object btnExiCre: TBitBtnLocked
            Left = 166
            Top = 67
            Width = 24
            Height = 21
            Hint = 'Visualizar Cr'#233'ditos do Cliente...'
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = btnExiCreClick
          end
          object btnLimiteAlpe: TBitBtnLocked
            Left = 81
            Top = 89
            Width = 52
            Height = 21
            Caption = 'Verificar'
            TabOrder = 4
            Visible = False
            OnClick = btnLimiteAlpeClick
          end
        end
        object Panel4: TPanel
          Left = 205
          Top = 1
          Width = 198
          Height = 116
          Align = alClient
          BevelOuter = bvNone
          Color = 16770261
          TabOrder = 1
          object Label30: TLabel
            Left = 0
            Top = 0
            Width = 198
            Height = 14
            Align = alTop
            Alignment = taCenter
            Caption = '      MAIOR COMPRA'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 105
          end
          object Label32: TLabel
            Left = 27
            Top = 24
            Width = 22
            Height = 14
            Caption = 'Data'
          end
          object Label33: TLabel
            Left = 12
            Top = 46
            Width = 37
            Height = 14
            Caption = 'N'#186' Nota'
          end
          object Label11: TLabel
            Left = 23
            Top = 70
            Width = 25
            Height = 14
            Caption = 'Valor'
          end
          object edtMaiorCompra: TEditFocus
            Left = 53
            Top = 66
            Width = 110
            Height = 22
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Enabled = False
            ParentBiDiMode = False
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtDtaMaiorCompra: TEditFocus
            Left = 53
            Top = 20
            Width = 110
            Height = 22
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Enabled = False
            ParentBiDiMode = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtNotaMaiorComp: TEditFocus
            Left = 53
            Top = 43
            Width = 110
            Height = 22
            Alignment = taRightJustify
            BiDiMode = bdLeftToRight
            Enabled = False
            ParentBiDiMode = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
        end
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 32
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 512
    Top = 32
  end
end
