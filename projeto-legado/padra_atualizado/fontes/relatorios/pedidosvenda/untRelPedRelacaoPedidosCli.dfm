inherited frmRelPedRelacaoPedidosCli: TfrmRelPedRelacaoPedidosCli
  Left = 404
  Top = 212
  Width = 530
  Height = 745
  Caption = 'Relat'#243'rio de Pedidos por Cliente'
  OnDestroy = FormDestroy
  ExplicitWidth = 530
  ExplicitHeight = 745
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 673
    Width = 524
    ExplicitTop = 673
    ExplicitWidth = 524
    inherited btnSair: TBitBtnLocked
      Left = 443
      ExplicitLeft = 443
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 5
      ExplicitLeft = 5
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 83
      ExplicitLeft = 83
    end
  end
  inherited pnlDados: TPanel
    Width = 524
    Height = 667
    ExplicitWidth = 524
    ExplicitHeight = 667
    object Label11: TLabel [0]
      Left = 8
      Top = 37
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDesDtaIni: TLabel [1]
      Left = 77
      Top = 19
      Width = 105
      Height = 14
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesDtaFin: TLabel [2]
      Left = 77
      Top = 55
      Width = 105
      Height = 14
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel [3]
      Left = 8
      Top = 1
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [4]
      Left = 8
      Top = 73
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel [5]
      Left = 8
      Top = 147
      Width = 33
      Height = 14
      Caption = 'Regi'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCodDig: TLabel [6]
      Left = 8
      Top = 183
      Width = 42
      Height = 14
      Caption = 'Digitador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblTabPre: TLabel [7]
      Left = 156
      Top = 383
      Width = 169
      Height = 14
      Caption = 'Tabela de Venda p/ Pre'#231'o Sugerido'
    end
    object lblCodCid: TLabel [8]
      Left = 8
      Top = 256
      Width = 33
      Height = 14
      Caption = 'Cidade'
    end
    object Label1: TLabel [9]
      Left = 8
      Top = 220
      Width = 47
      Height = 14
      Caption = 'Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [10]
      Left = 8
      Top = 111
      Width = 30
      Height = 14
      Caption = 'Marca'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shaVen: TShape [11]
      Left = 8
      Top = 233
      Width = 8
      Height = 22
    end
    inherited gpbDestino: TGroupBox
      Left = 156
      Top = 292
      Width = 175
      TabOrder = 15
      ExplicitLeft = 156
      ExplicitTop = 292
      ExplicitWidth = 175
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Left = 8
        ExplicitLeft = 8
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 15
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 51
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodCliente: TEditFocus
      Left = 8
      Top = 87
      Width = 64
      Height = 22
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnExit = edtCodClienteExit
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
      Left = 73
      Top = 87
      Width = 440
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgFaturamento: TRadioGroup
      Tag = 99
      Left = 8
      Top = 337
      Width = 146
      Height = 82
      Caption = 'Faturamento'
      ItemIndex = 0
      Items.Strings = (
        'Todos Pedidos'
        'J'#225' Faturados'
        'N'#227'o Faturados'
        'Baixados N'#227'o Entregues')
      TabOrder = 17
      OnClick = rdgFaturamentoClick
      OnExit = rdgFaturamentoExit
    end
    object gpbTipo: TGroupBox
      Left = 8
      Top = 292
      Width = 146
      Height = 45
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      object ColorLabel2: TColorLabel
        Left = 29
        Top = 20
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipo: TEditFocus
        Tag = 99
        Left = 8
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        OnChange = edtTipoChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object rdgTipQtd: TRadioGroup
      Tag = 99
      Left = 156
      Top = 337
      Width = 175
      Height = 45
      Caption = 'Tipo de Quantidade'
      Columns = 2
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        'Original'
        'Pendente')
      TabOrder = 18
      OnClick = rdgTipQtdClick
    end
    object rdgTipOpe: TRadioGroup
      Left = 333
      Top = 261
      Width = 180
      Height = 87
      Caption = 'Tipo de Opera'#231#227'o'
      ItemIndex = 3
      Items.Strings = (
        'Vendas'
        'Bonifica'#231#227'o'
        'Conta e Ordem'
        'Todas as opera'#231#245'es')
      TabOrder = 16
    end
    object chkItePen: TCheckBox
      Tag = 99
      Left = 334
      Top = 348
      Width = 183
      Height = 17
      Caption = 'Mostrar somente itens pendentes'
      Enabled = False
      TabOrder = 19
      OnClick = chkItePenClick
    end
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 8
      Top = 160
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 6
      OnExit = edtCodRegExit
      OnKeyPress = edtCodRegKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtNomReg: TEditFocus
      Left = 73
      Top = 160
      Width = 440
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object pnlFilLib: TPanel
      Left = 1
      Top = 512
      Width = 522
      Height = 154
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 26
      object gpbLibFin: TGroupBox
        Left = 9
        Top = 99
        Width = 249
        Height = 45
        Caption = 'Liberado pelo Dep. Financeiro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        object ColorLabel3: TColorLabel
          Left = 29
          Top = 20
          Width = 96
          Height = 14
          Caption = '(S)im (N)'#227'o (T)odos'
          CorDestaque = clRed
        end
        object edtLibFin: TEditFocus
          Tag = 99
          Left = 8
          Top = 16
          Width = 18
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 0
          Text = 'T'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
      end
      object gpbLibCom: TGroupBox
        Left = 267
        Top = 99
        Width = 246
        Height = 45
        Caption = 'Liberado pelo Dep. Comercial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        object ColorLabel4: TColorLabel
          Left = 29
          Top = 20
          Width = 96
          Height = 14
          Caption = '(S)im (N)'#227'o (T)odos'
          CorDestaque = clRed
        end
        object edtLibCom: TEditFocus
          Tag = 99
          Left = 8
          Top = 16
          Width = 18
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 0
          Text = 'T'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
      end
      object rgbVisItens: TRadioGroup
        Left = 9
        Top = -2
        Width = 249
        Height = 52
        Caption = 'Visualizar'
        ItemIndex = 0
        Items.Strings = (
          'Todos'
          'Apenas itens que podem ser atendidos'
          'Apenas itens que n'#227'o podem ser atendidos')
        TabOrder = 0
      end
      object gpbDtaPre: TGroupBox
        Left = 9
        Top = 51
        Width = 249
        Height = 47
        Caption = 'Pedidos faturados acima da data de previs'#227'o?'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object ColorLabel5: TColorLabel
          Left = 29
          Top = 20
          Width = 96
          Height = 14
          Caption = '(S)im (N)'#227'o (T)odos'
          Enabled = False
          CorDestaque = clRed
        end
        object edtDtaPre: TEditFocus
          Tag = 99
          Left = 8
          Top = 18
          Width = 18
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 0
          Text = 'T'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
      end
      object chkPedImp: TCheckBox
        Left = 280
        Top = 76
        Width = 201
        Height = 17
        Caption = 'Listar apenas pedidos j'#225' impressos?'
        TabOrder = 4
      end
      object chkCliFil: TCheckBox
        Left = 280
        Top = 59
        Width = 201
        Height = 17
        Caption = 'Listar apenas Clientes Filiais?'
        TabOrder = 3
      end
      object rdgOrigem: TRadioGroup
        Left = 267
        Top = -2
        Width = 249
        Height = 52
        Caption = 'Origem'
        ItemIndex = 0
        Items.Strings = (
          'Todos'
          'Somente Autcom'
          'Somente Tablet/Site')
        TabOrder = 1
      end
    end
    object edtCodDig: TEditFocus
      Tag = 99
      Left = 8
      Top = 197
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 8
      OnExit = edtCodDigExit
      OnKeyPress = edtCodDigKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 73
      Top = 197
      Width = 440
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object cbxTabPre: TComboBoxFocus
      Left = 156
      Top = 397
      Width = 357
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 22
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 8
      Top = 269
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 12
      OnExit = edtCodCidExit
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomCid: TEditFocus
      Left = 73
      Top = 269
      Width = 258
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVendedor: TEditFocus
      Tag = 99
      Left = 18
      Top = 233
      Width = 54
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 10
      OnExit = edtCodVendedorExit
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 73
      Top = 233
      Width = 440
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMarca: TEditFocus
      Left = 8
      Top = 124
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 4
      OnExit = edtCodMarcaExit
      OnKeyPress = edtCodMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMarca: TEditFocus
      Left = 73
      Top = 124
      Width = 440
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkImpRef: TCheckBox
      Tag = 99
      Left = 334
      Top = 363
      Width = 121
      Height = 17
      Caption = 'Imprimir Refer'#234'ncia'
      Checked = True
      State = cbChecked
      TabOrder = 20
    end
    object chkImpMar: TCheckBox
      Tag = 99
      Left = 334
      Top = 378
      Width = 103
      Height = 17
      Caption = 'Imprimir Marca'
      Checked = True
      State = cbChecked
      TabOrder = 21
    end
    object pnlOcorrencia: TPanel
      Left = 1
      Top = 439
      Width = 522
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 24
      object Label5: TLabel
        Left = 9
        Top = -1
        Width = 54
        Height = 14
        Caption = 'Ocorr'#234'ncia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodOco: TEditFocus
        Left = 9
        Top = 12
        Width = 34
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        OnExit = edtCodOcoExit
        OnKeyPress = edtCodOcoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesOco: TEditFocus
        Left = 45
        Top = 12
        Width = 472
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object pnlFaseObra: TPanel
      Left = 1
      Top = 474
      Width = 522
      Height = 38
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 25
      object Label6: TLabel
        Left = 9
        Top = -1
        Width = 66
        Height = 14
        Caption = 'Fase da Obra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodFase: TEditFocus
        Left = 9
        Top = 13
        Width = 62
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        ParentFont = False
        TabOrder = 0
        OnExit = edtCodFaseExit
        OnKeyPress = edtCodFaseKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesFase: TEditFocus
        Left = 77
        Top = 11
        Width = 440
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object Panel1: TPanel
      Left = 1
      Top = 421
      Width = 522
      Height = 18
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 23
      object chkFreImp: TCheckBox
        Left = 8
        Top = 0
        Width = 368
        Height = 17
        Caption = 'Considerar Valor de Frete + Impostos no Valor dos Itens'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
    end
  end
  object pgbProgresso: TProgressBar [3]
    Left = 0
    Top = 667
    Width = 524
    Height = 6
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 701
    Width = 524
    TabOrder = 4
    ExplicitTop = 701
    ExplicitWidth = 524
    inherited pnlNomeForm: TPanel
      Left = 353
      ExplicitLeft = 353
    end
    inherited pnlInfo: TPanel
      Width = 353
      ExplicitWidth = 353
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 271
    Top = 67
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 303
    Top = 67
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 271
    Top = 3
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 239
    Top = 3
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 207
    Top = 3
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 207
    Top = 67
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 271
    Top = 35
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 207
    Top = 35
  end
  inherited frxGen: TfrxUserDataSet
    Left = 239
    Top = 35
  end
  inherited frxDesigner: TfrxDesigner
    Left = 239
    Top = 67
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 303
    Top = 35
  end
end
