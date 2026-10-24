inherited frmRelFatVendasCliente: TfrmRelFatVendasCliente
  Left = 341
  Top = 143
  Width = 614
  Height = 805
  Caption = 'Relat'#243'rio de Movimento de Clientes'
  ExplicitWidth = 614
  ExplicitHeight = 805
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 734
    Width = 608
    ExplicitTop = 734
    ExplicitWidth = 608
    inherited FlwBotoes: TFlowPanel
      Width = 527
      ExplicitWidth = 527
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 529
      ExplicitLeft = 529
    end
  end
  inherited pnlStatus: TPanel
    Top = 760
    Width = 608
    ExplicitTop = 760
    ExplicitWidth = 608
    inherited pnlNomeForm: TPanel
      Left = 437
      TabOrder = 1
      ExplicitLeft = 437
    end
    inherited pnlInfo: TPanel
      Width = 437
      TabOrder = 0
      ExplicitWidth = 437
      inherited shpMultSel: TShape
        Left = 414
        Visible = True
        ExplicitLeft = 414
      end
    end
  end
  inherited pnlDados: TPanel
    Width = 608
    Height = 734
    ExplicitWidth = 608
    ExplicitHeight = 734
    inherited gpbDestino: TGroupBox
      Left = 111
      Top = 638
      Width = 105
      Height = 59
      TabOrder = 9
      ExplicitLeft = 111
      ExplicitTop = 638
      ExplicitWidth = 105
      ExplicitHeight = 59
      inherited ColorLabel1: TColorLabel
        Left = 37
        Top = 11
        Width = 36
        Caption = '(V)'#237'deo'
        ExplicitLeft = 37
        ExplicitTop = 11
        ExplicitWidth = 36
      end
      object ColorLabel6: TColorLabel [1]
        Left = 37
        Top = 27
        Width = 62
        Height = 14
        Caption = '(I)mpressora'
        CorDestaque = clRed
      end
      object ColorLabel7: TColorLabel [2]
        Left = 37
        Top = 43
        Width = 34
        Height = 14
        Caption = '(E)xcel'
        CorDestaque = clRed
      end
      inherited edtDestino: TEditFocus
        Left = 12
        Top = 26
        ExplicitLeft = 12
        ExplicitTop = 26
      end
    end
    object gpbTipo: TGroupBox
      Left = 14
      Top = 601
      Width = 137
      Height = 37
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 18
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipo: TEditFocus
        Tag = 99
        Left = 7
        Top = 13
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gpbMargem: TGroupBox
      Left = 300
      Top = 601
      Width = 134
      Height = 37
      Caption = 'Mostrar Margem?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object ColorLabel3: TColorLabel
        Left = 37
        Top = 18
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object shpMargem: TShape
        Left = 6
        Top = 13
        Width = 8
        Height = 20
      end
      object edtMargem: TEditFocus
        Tag = 99
        Left = 15
        Top = 13
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'S'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object rdgOrdem: TRadioGroup
      Left = 14
      Top = 638
      Width = 91
      Height = 59
      Caption = 'Ordem'
      ItemIndex = 1
      Items.Strings = (
        'Alfab'#233'tica'
        'Emiss'#227'o')
      TabOrder = 8
    end
    object gpbCancelados: TGroupBox
      Left = 157
      Top = 601
      Width = 137
      Height = 37
      Caption = 'Exibir Doc. Cancelados?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object ColorLabel5: TColorLabel
        Left = 28
        Top = 18
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtDocCan: TEditFocus
        Tag = 99
        Left = 7
        Top = 13
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'N'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
    end
    object pnlMovRede: TPanel
      Left = 1
      Top = 579
      Width = 606
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object chkMovRede: TCheckBox
        Left = 232
        Top = -2
        Width = 210
        Height = 20
        Caption = 'Mostrar todo o mov. da Rede do cliente'
        TabOrder = 1
      end
      object chkRefUni: TCheckBox
        Left = 13
        Top = -2
        Width = 212
        Height = 20
        Caption = 'Exibir colunas de Refer'#234'ncia e Unidade'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object chkExbTATL: TCheckBox
        Left = 450
        Top = -2
        Width = 141
        Height = 20
        Caption = 'Exibir Documentos TA/TL'
        TabOrder = 2
      end
    end
    object rdgEmpresa: TRadioGroup
      Left = 222
      Top = 638
      Width = 93
      Height = 59
      Caption = 'Empresa de'
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Faturamento'
        'Origem')
      ParentCtl3D = False
      TabOrder = 10
    end
    object gpbExiSom: TGroupBox
      Left = 321
      Top = 638
      Width = 272
      Height = 59
      Caption = 'Exibir Somente'
      TabOrder = 11
      object chkSomDev: TCheckBox
        Left = 7
        Top = 11
        Width = 97
        Height = 15
        Caption = 'Devolu'#231#245'es'
        TabOrder = 0
        OnClick = chkSomDevClick
      end
      object chkSomTra: TCheckBox
        Left = 136
        Top = 11
        Width = 114
        Height = 15
        Caption = 'Transf. de Estoque'
        TabOrder = 3
        OnClick = chkSomDevClick
      end
      object chkSomCon: TCheckBox
        Left = 7
        Top = 27
        Width = 114
        Height = 15
        Caption = 'Consigna'#231#245'es'
        TabOrder = 1
        OnClick = chkSomDevClick
      end
      object chkSomFut: TCheckBox
        Left = 136
        Top = 27
        Width = 114
        Height = 15
        Caption = 'Entrega Futura'
        TabOrder = 4
        OnClick = chkSomDevClick
      end
      object chkSomBai: TCheckBox
        Left = 7
        Top = 42
        Width = 141
        Height = 15
        Caption = 'Baixa de Entrega Futura'
        TabOrder = 2
        OnClick = chkSomDevClick
      end
    end
    object pnlAutPas: TPanel
      Left = 1
      Top = 498
      Width = 606
      Height = 81
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object gpbAutCen: TGroupBox
        Left = 13
        Top = -3
        Width = 579
        Height = 82
        Caption = 'Autocenter'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label24: TLabel
          Left = 345
          Top = 45
          Width = 17
          Height = 14
          Caption = 'Cor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label23: TLabel
          Left = 287
          Top = 45
          Width = 20
          Height = 14
          Caption = 'Ano'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 7
          Top = 45
          Width = 34
          Height = 14
          Caption = 'Modelo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 287
          Top = 12
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
        object Label17: TLabel
          Left = 7
          Top = 12
          Width = 35
          Height = 14
          Caption = 'Ve'#237'culo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDesMod: TEditFocus
          Left = 65
          Top = 58
          Width = 220
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtDesCor: TEditFocus
          Left = 403
          Top = 58
          Width = 169
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtCodCor: TEditFocus
          Tag = 99
          Left = 345
          Top = 58
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 4
          ParentFont = False
          TabOrder = 7
          OnExit = edtCodCorExit
          OnKeyPress = edtCodCorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 4
          TipoTexto = ttNumerico
        end
        object edtAno: TEditFocus
          Tag = 99
          Left = 287
          Top = 58
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 4
          ParentFont = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 4
          TipoTexto = ttAlfanumerico
        end
        object edtCodMod: TEditFocus
          Tag = 99
          Left = 7
          Top = 58
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 4
          ParentFont = False
          TabOrder = 4
          OnExit = edtCodModExit
          OnKeyPress = edtCodModKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 4
          TipoTexto = ttNumerico
        end
        object edtDesMar: TEditFocus
          Left = 345
          Top = 25
          Width = 227
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtCodMar: TEditFocus
          Tag = 99
          Left = 287
          Top = 25
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 4
          ParentFont = False
          TabOrder = 2
          OnExit = edtCodMarExit
          OnKeyPress = edtCodMarKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 4
          TipoTexto = ttNumerico
        end
        object mskPlaVei: TMaskEditFocus
          Tag = 99
          Left = 7
          Top = 25
          Width = 55
          Height = 22
          CharCase = ecUpperCase
          EditMask = 'aaa-9a99;0;'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ParentFont = False
          TabOrder = 0
          Text = ''
          OnExit = mskPlaVeiExit
          OnKeyPress = mskPlaVeiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesVei: TEditFocus
          Left = 65
          Top = 25
          Width = 220
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
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 728
      Width = 606
      Height = 5
      Align = alBottom
      Smooth = True
      TabOrder = 12
      Visible = False
    end
    object pnlEventos: TPanel
      Left = 1
      Top = 465
      Width = 606
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lblCodEmb: TLabel
        Left = 294
        Top = -2
        Width = 60
        Height = 14
        Caption = 'Embarca'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodEmb: TEditFocus
        Tag = 99
        Left = 294
        Top = 10
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        BiDiMode = bdLeftToRight
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 1
        OnExit = edtCodEmbExit
        OnKeyPress = edtCodEmbKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtNomEmb: TEditFocus
        Left = 352
        Top = 10
        Width = 241
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
      inline fraCentroCusto: TfraCentroCustoEditFocus
        Left = 5
        Top = 1
        Width = 289
        Height = 31
        TabOrder = 0
        ExplicitLeft = 5
        ExplicitTop = 1
        ExplicitWidth = 289
        ExplicitHeight = 31
        inherited lblEventos: TLabel
          Left = 9
          Top = -3
          Width = 84
          Height = 14
          Caption = 'Centro de Custos'
          ExplicitLeft = 9
          ExplicitTop = -3
          ExplicitWidth = 84
          ExplicitHeight = 14
        end
        inherited edtCodEve: TEditFocus
          Left = 9
          Top = 9
          Width = 65
          Height = 22
          OnExit = fraCentroCustoedtCodEveExit
          ExplicitLeft = 9
          ExplicitTop = 9
          ExplicitWidth = 65
          ExplicitHeight = 22
        end
        inherited edtDesEve: TEditFocus
          Left = 75
          Top = 9
          Width = 213
          Height = 22
          ExplicitLeft = 75
          ExplicitTop = 9
          ExplicitWidth = 213
          ExplicitHeight = 22
        end
      end
    end
    object pnlFiltros: TPanel
      Left = 1
      Top = 1
      Width = 606
      Height = 464
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label5: TLabel
        Left = 15
        Top = 0
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
      object Label7: TLabel
        Left = 83
        Top = 18
        Width = 58
        Height = 14
        Caption = '(ENTRADA)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 157
        Top = 0
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
      object Label8: TLabel
        Left = 226
        Top = 19
        Width = 58
        Height = 14
        Caption = '(ENTRADA)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 303
        Top = 247
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
      object Label1: TLabel
        Left = 14
        Top = 138
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
      object Label9: TLabel
        Left = 14
        Top = 34
        Width = 59
        Height = 14
        Caption = 'Linha/Grupo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 294
        Top = 34
        Width = 37
        Height = 14
        Caption = 'Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEmpresa: TLabel
        Left = 294
        Top = 283
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 14
        Top = 69
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
      end
      object Label10: TLabel
        Left = 294
        Top = 69
        Width = 53
        Height = 14
        Caption = 'Refer'#234'ncia'
      end
      object Label11: TLabel
        Left = 14
        Top = 283
        Width = 33
        Height = 14
        Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object shpLiberado: TShape
        Left = 295
        Top = 261
        Width = 5
        Height = 20
      end
      object Label2: TLabel
        Left = 14
        Top = 319
        Width = 56
        Height = 14
        Caption = 'Fornecedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 294
        Top = 319
        Width = 45
        Height = 14
        Caption = 'Atividade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl1: TLabel
        Left = 14
        Top = 103
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
      object lblTintasDisp: TLabel
        Left = 294
        Top = 103
        Width = 29
        Height = 14
        Caption = 'Tintas'
        FocusControl = edtTintasDisp
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object Label16: TLabel
        Left = 14
        Top = 247
        Width = 69
        Height = 14
        Caption = 'Rede de Lojas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 14
        Top = 355
        Width = 71
        Height = 14
        Caption = 'Representante'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object shpRepres: TShape
        Tag = 99
        Left = 7
        Top = 369
        Width = 5
        Height = 21
      end
      object lblComCus: TLabel
        Left = 294
        Top = 355
        Width = 151
        Height = 14
        Caption = 'Composi'#231#227'o do Pre'#231'o de Custo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 15
        Top = 210
        Width = 118
        Height = 14
        Caption = 'Consumidor (CGC / CPF)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 550
        Top = 69
        Width = 38
        Height = 14
        Caption = 'Esp'#233'cie'
      end
      object Label18: TLabel
        Left = 294
        Top = 138
        Width = 76
        Height = 14
        Caption = 'Cliente a Excluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 14
        Top = 425
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
      object lblRegiao: TLabel
        Left = 14
        Top = 390
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
      object Label26: TLabel
        Left = 294
        Top = 212
        Width = 95
        Height = 14
        Caption = 'Consumidor (Nome)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblCodCla: TLabel
        Left = 294
        Top = 0
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Classifica'#231#227'o Fiscal'
      end
      object Label27: TLabel
        Left = 14
        Top = 172
        Width = 101
        Height = 14
        Caption = 'Endere'#231'o de Entrega'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblNumCmp: TLabel
        Left = 294
        Top = 355
        Width = 122
        Height = 14
        Caption = 'Pedido de Compra Cliente'
      end
      object lblForPag: TLabel
        Left = 294
        Top = 390
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Caption = 'Forma de Pagto'
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 14
        Top = 14
        Width = 63
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 157
        Top = 14
        Width = 64
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtCodVendedor: TEditFocus
        Tag = 99
        Left = 303
        Top = 261
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
        MaxLength = 10
        ParentFont = False
        TabOrder = 25
        OnExit = edtCodVendedorExit
        OnKeyPress = edtCodVendedorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCliente: TEditFocus
        Tag = 99
        Left = 14
        Top = 152
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
        MaxLength = 8
        ParentFont = False
        TabOrder = 15
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
        Tag = 99
        Left = 79
        Top = 152
        Width = 214
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 16
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesVendedor: TEditFocus
        Left = 369
        Top = 261
        Width = 223
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 26
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskLinhaGrupo: TMaskEditFocus
        Tag = 99
        Left = 14
        Top = 48
        Width = 63
        Height = 22
        EditMask = '999.999;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        ParentFont = False
        TabOrder = 4
        Text = ''
        OnEnter = mskLinhaGrupoEnter
        OnExit = mskLinhaGrupoExit
        OnKeyPress = mskLinhaGrupoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtProdutos: TEditFocus
        Tag = 99
        Left = 294
        Top = 48
        Width = 65
        Height = 22
        Alignment = taLeftJustify
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
        OnExit = edtProdutosExit
        OnKeyPress = edtProdutosKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesGrupo: TEditFocus
        Left = 80
        Top = 48
        Width = 213
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
      object edtDesProduto: TEditFocus
        Left = 360
        Top = 48
        Width = 233
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
      object edtCodEmpresa: TEditFocus
        Tag = 99
        Left = 294
        Top = 297
        Width = 29
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
        TabOrder = 29
        OnExit = edtCodEmpresaExit
        OnKeyPress = edtCodEmpresaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpresa: TEditFocus
        Left = 324
        Top = 297
        Width = 269
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 30
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDescri: TEditFocus
        Left = 14
        Top = 83
        Width = 279
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtRefere: TEditFocus
        Left = 294
        Top = 83
        Width = 255
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCidade: TEditFocus
        Tag = 99
        Left = 14
        Top = 297
        Width = 65
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
        TabOrder = 27
        OnExit = edtCodCidadeExit
        OnKeyPress = edtCodCidadeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesCidade: TEditFocus
        Left = 80
        Top = 297
        Width = 213
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 28
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtFornecedor: TEditFocus
        Tag = 99
        Left = 14
        Top = 333
        Width = 65
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
        MaxLength = 8
        ParentFont = False
        TabOrder = 31
        OnExit = edtFornecedorExit
        OnKeyPress = edtFornecedorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesFornecedor: TEditFocus
        Tag = 99
        Left = 80
        Top = 333
        Width = 213
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 32
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodAtividade: TEditFocus
        Tag = 99
        Left = 294
        Top = 333
        Width = 29
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
        TabOrder = 33
        OnExit = edtCodAtividadeExit
        OnKeyPress = edtCodAtividadeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesAtividade: TEditFocus
        Left = 324
        Top = 333
        Width = 269
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 34
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMarca: TEditFocus
        Tag = 99
        Left = 14
        Top = 117
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        ParentFont = False
        TabOrder = 11
        OnExit = edtMarcaExit
        OnKeyPress = edtMarcaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMarca: TEditFocus
        Left = 72
        Top = 117
        Width = 221
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 12
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTintasDisp: TEditFocus
        Tag = 99
        Left = 294
        Top = 117
        Width = 57
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
        TabOrder = 13
        Visible = False
        OnKeyPress = edtTintasDispKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesTinta: TEditFocus
        Left = 352
        Top = 117
        Width = 241
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 14
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodRede: TEditFocus
        Left = 14
        Top = 261
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 23
        OnExit = edtCodRedeExit
        OnKeyPress = edtCodRedeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesRede: TEditFocus
        Left = 80
        Top = 261
        Width = 213
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 24
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodRep: TEditFocus
        Tag = 99
        Left = 14
        Top = 369
        Width = 65
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
        MaxLength = 10
        ParentFont = False
        TabOrder = 35
        OnExit = edtCodRepExit
        OnKeyPress = edtCodRepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomRep: TEditFocus
        Left = 80
        Top = 369
        Width = 213
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 36
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cbbComCus: TComboBoxFocus
        Tag = 99
        Left = 295
        Top = 368
        Width = 299
        Height = 22
        Style = csDropDownList
        TabOrder = 37
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtCodCliExcluir: TEditFocus
        Tag = 99
        Left = 294
        Top = 152
        Width = 65
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
        MaxLength = 8
        ParentFont = False
        TabOrder = 17
        OnExit = edtCodCliExcluirExit
        OnKeyPress = edtCodCliExcluirKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesCliExcluir: TEditFocus
        Tag = 99
        Left = 360
        Top = 152
        Width = 233
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 18
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCliCon: TEditFocus
        Tag = 99
        Left = 14
        Top = 226
        Width = 118
        Height = 22
        Hint = 
          'Campo "Cliente" deve estar preenchido com o c'#243'digo do "Cliente C' +
          'onsumidor"'
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 18
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 20
        OnExit = edtCodCliConExit
        OnKeyPress = edtCodCliConKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 18
        TipoTexto = ttNumerico
      end
      object edtNomCliCon: TEditFocus
        Tag = 99
        Left = 133
        Top = 226
        Width = 160
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 21
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEspDoc: TEditFocus
        Left = 550
        Top = 83
        Width = 43
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodFase: TEditFocus
        Left = 14
        Top = 439
        Width = 65
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
        TabOrder = 43
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
        Left = 80
        Top = 439
        Width = 213
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 44
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodReg: TEditFocus
        Tag = 99
        Left = 14
        Top = 404
        Width = 65
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
        TabOrder = 39
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
        Left = 80
        Top = 404
        Width = 213
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 40
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtConNom: TEditFocus
        Left = 294
        Top = 226
        Width = 299
        Height = 22
        Hint = 
          'Campo "Cliente" deve estar preenchido com o c'#243'digo do "Cliente C' +
          'onsumidor"'
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 22
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodClaFis: TEditFocus
        Tag = 99
        Left = 294
        Top = 14
        Width = 66
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 4
        TabOrder = 2
        OnExit = edtCodClaFisExit
        OnKeyPress = edtCodClaFisKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 4
        TipoTexto = ttNumerico
      end
      object edtDesClaFis: TEditFocus
        Left = 360
        Top = 14
        Width = 233
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cbbEndCli: TComboBoxFocus
        Tag = 99
        Left = 14
        Top = 188
        Width = 579
        Height = 22
        Style = csDropDownList
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtNumCmp: TEditFocus
        Left = 294
        Top = 369
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 38
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesFpg: TEditFocus
        Left = 324
        Top = 404
        Width = 269
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 42
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodFpg: TEditFocus
        Tag = 99
        Left = 294
        Top = 404
        Width = 29
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
        TabOrder = 41
        OnExit = edtCodFpgExit
        OnKeyPress = edtCodFpgKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
    end
    object gpbAjuste: TGroupBox
      Left = 440
      Top = 601
      Width = 153
      Height = 37
      Caption = 'Mostrar Ajuste de Estoque?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      object ColorLabel4: TColorLabel
        Left = 29
        Top = 18
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtAjuste: TEditFocus
        Tag = 99
        Left = 7
        Top = 13
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'S'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 288
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 320
    Top = 88
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 448
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 416
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 384
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 352
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 320
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 256
  end
  inherited frxGen: TfrxUserDataSet
    Left = 288
  end
  inherited frxDesigner: TfrxDesigner
    Left = 512
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 544
  end
  object svdExcel: TSaveDialog
    Filter = 'Arquivos Excel|*.xls'
    Left = 352
    Top = 88
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45271.614289201390000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  blnImprimeUmaVez: Boolean;'
      '  strDescVeiculo: String;'
      '  strNomeCidade: String;'
      '  fltDesEsp: Double;'
      '  fltTotIte: Double;     '
      '  fltTotMkp: Double; '
      '  fltTotCus: Double; '
      '  fltTotDoc: Double; '
      '  fltTotDesEsp: Double; '
      '  fltTotTotIte: Double; '
      '  fltTotMkpIte: Double; '
      '  fltTotTotCus: Double; '
      '  fltTotTotDoc: Double; '
      '  fltTotIteGer: Double; '
      '  fltTotMkpGer: Double; '
      '  fltTotMarGer: Double; '
      '  fltTotDesGer: Double; '
      '  fltTotDocGer: Double; '
      '  fltTotDesEspOrdAlf: Double; '
      '  fltTotQtd: Double; '
      '  fltTotQtdD: Double; '
      '  fltTotQtdG: Double;'
      '  fltAltLinha1: Double;'
      '  fltAltLinha2: Double;'
      
        '  fltAltDuasLinhas: Double;                                     ' +
        '                  '
      '    '
      'procedure rllCidadeCliOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllCidadeCli.Text := IIF(<frxRelatorio."NOMCID"> <> '#39#39', '#39'CIDAD' +
        'E: '#39' + <frxRelatorio."NOMCID"> + '#39'-'#39' + <frxRelatorio."ESTADO">, ' +
        #39#39') + fFormataCGCCli(<frxRelatorio."CGCCLI">);'
      'end;'
      ''
      'procedure rllNomCliOnBeforePrint(Sender: TfrxComponent);'
      
        'begin                                                           ' +
        '                            '
      
        '  rllNomCli.Text := '#39'CLIENTE: '#39' + <frxRelatorio."CODCLI"> + '#39'-'#39' ' +
        '+ <frxRelatorio."NOMCLI"> + IIF(<frxRelatorio."FONE01"> <> '#39#39', '#39 +
        '  TELEFONE: '#39' + fFormataFone(<frxRelatorio."FONE01">), '#39#39');    '
      'end;'
      ''
      'procedure rllCidadeCli2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllCidadeCli2.Text := IIF(<frxRelatorio."NOMCID"> <> '#39#39', '#39'CIDA' +
        'DE: '#39' + <frxRelatorio."NOMCID"> + '#39'-'#39' + <frxRelatorio."ESTADO">,' +
        ' '#39#39') + fFormataCGCCli(<frxRelatorio."CGCCLI">);  '
      'end;    '
      ''
      'procedure rllNomCli2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllNomCli2.Text := '#39'CLIENTE: '#39' + <frxRelatorio."CODCLI"> + '#39'-'#39 +
        ' + <frxRelatorio."NOMCLI"> + IIF(<frxRelatorio."FONE01"> <> '#39#39', ' +
        #39'  TELEFONE: '#39' + fFormataFone(<frxRelatorio."FONE01">), '#39#39');  '
      'end;    '
      ''
      'procedure GroupFooter2OnAfterPrint(Sender: TfrxComponent);'
      'begin    '
      '  fltDesEsp  := 0;'
      '  fltTotIte  := 0;'
      '  fltTotMkp  := 0;'
      '  fltTotCus  := 0;'
      '  fltTotQtdD := 0;'
      '  fltTotDoc  := 0;         '
      '  '
      '  blnImprimeUmaVez := False;  '
      'end;'
      ''
      'procedure GroupFooter3OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltDesEsp  := 0;'
      '  fltTotIte  := 0;'
      '  fltTotMkp  := 0;'
      '  fltTotCus  := 0;'
      '  fltTotQtdD := 0;'
      '  fltTotDoc  := 0;'
      '    '
      '  blnImprimeUmaVez := False;  '
      'end;'
      ''
      'procedure rllMargGrupo1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxRelatorio."MARMKP"> = '#39'4'#39' then'
      
        '    rllMargGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fCalculaPrecoV' +
        'enda(2, <frxRelatorio."TOTCUS">, <frxRelatorio."MAMKP4"> - IIF(f' +
        'VeioTelaVendas, <frxRelatorio."DESESP">, 0), 0,0,0,0,0))  '
      '  else'
      
        '    rllMargGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fCalculaPrecoV' +
        'enda(2, <frxRelatorio."TOTCUS">, <frxRelatorio."TOTITE"> - IIF(f' +
        'VeioTelaVendas, <frxRelatorio."DESESP">, 0), 0,0,0,0,0));     '
      'end;    '
      ''
      
        'procedure rllTotCliMargGrupo1OnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin  '
      '  if <frxRelatorio."MARMKP"> = '#39'4'#39' then'
      
        '    rllTotCliMargGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fCalcula' +
        'PrecoVenda(2, fltTotTotCus,(fltTotMkpIte - IIF(fVeioTelaVendas, ' +
        'fltTotDesEsp, 0)),0,0,0,0,0))  '
      '  else'
      
        '    rllTotCliMargGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fCalcula' +
        'PrecoVenda(2, fltTotTotCus,(fltTotTotIte - IIF(fVeioTelaVendas, ' +
        'fltTotDesEsp, 0)),0,0,0,0,0));  '
      'end;    '
      ''
      
        'procedure rllTotDocMargGrupo1OnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin  '
      '  if <frxRelatorio."MARMKP"> = '#39'4'#39' then'
      
        '    rllTotDocMargGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fCalcula' +
        'PrecoVenda(2, fltTotCus, (fltTotMkp - IIF(fVeioTelaVendas, fltDe' +
        'sEsp, 0)),0,0,0,0,0))  '
      '  else'
      
        '    rllTotDocMargGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fCalcula' +
        'PrecoVenda(2, fltTotCus, (fltTotIte - IIF(fVeioTelaVendas, fltDe' +
        'sEsp, 0)),0,0,0,0,0));  '
      'end;'
      ''
      
        'procedure rllTotDocMargGrupoAnaliticoEmissaoOnBeforePrint(Sender' +
        ': TfrxComponent);'
      'begin'
      '  if <frxRelatorio."MARMKP"> = '#39'4'#39' then'
      
        '    rllTotDocMargGrupoAnaliticoEmissao.Text := FormatFloat('#39'#,##' +
        '0.00'#39', fCalculaPrecoVenda(2, fltTotCus, (fltTotMkp - IIF(fVeioTe' +
        'laVendas, fltDesEsp, 0)),0,0,0,0,0))  '
      '  else'
      
        '    rllTotDocMargGrupoAnaliticoEmissao.Text := FormatFloat('#39'#,##' +
        '0.00'#39', fCalculaPrecoVenda(2, fltTotCus, (fltTotIte - IIF(fVeioTe' +
        'laVendas, fltDesEsp, 0)),0,0,0,0,0));  '
      'end;'
      ''
      'procedure rllTotGerMagOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxRelatorio."MARMKP"> = '#39'4'#39' then'
      
        '    rllTotGerMag.Text := FormatFloat('#39'#,##0.00'#39', fCalculaPrecoVe' +
        'nda(2, fltTotMarGer, fltTotMkpIte - IIF(fVeioTelaVendas, fltTotD' +
        'esEsp, 0),0,0,0,0,0))  '
      '  else'
      
        '    rllTotGerMag.Text := FormatFloat('#39'#,##0.00'#39', fCalculaPrecoVe' +
        'nda(2, fltTotMarGer, fltTotTotIte - IIF(fVeioTelaVendas, fltTotD' +
        'esEsp, 0),0,0,0,0,0));  '
      'end;'
      ''
      'procedure rllTotTotGerMarOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxRelatorio."MARMKP"> = '#39'4'#39' then'
      
        '    rllTotTotGerMar.Text := FormatFloat('#39'#,##0.00'#39', fCalculaPrec' +
        'oVenda(2, fltTotMarGer, (fltTotMkpGer - IIF(fVeioTelaVendas, flt' +
        'TotDesGer, 0)),0,0,0,0,0))  '
      '  else'
      
        '    rllTotTotGerMar.Text := FormatFloat('#39'#,##0.00'#39', fCalculaPrec' +
        'oVenda(2, fltTotMarGer, (fltTotIteGer - IIF(fVeioTelaVendas, flt' +
        'TotDesGer, 0)),0,0,0,0,0));  '
      'end;'
      ''
      'procedure rllMargemSintOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxRelatorio."MARMKP"> = '#39'4'#39' then'
      
        '    rllMargemSint.Text := FormatFloat('#39'#,##0.00'#39', fCalculaPrecoV' +
        'enda(2, <frxRelatorio."TOTCUS">, <frxRelatorio."MAMKP4"> - IIF(f' +
        'VeioTelaVendas, <frxRelatorio."DESESP">, 0), 0,0,0,0,0))  '
      '  else'
      
        '    rllMargemSint.Text := FormatFloat('#39'#,##0.00'#39', fCalculaPrecoV' +
        'enda(2, <frxRelatorio."TOTCUS">, <frxRelatorio."TOTITE"> - IIF(f' +
        'VeioTelaVendas, <frxRelatorio."DESESP">, 0), 0,0,0,0,0));  '
      'end;'
      ''
      
        'procedure rllTotCliMargemGrupo2OnBeforePrint(Sender: TfrxCompone' +
        'nt);'
      'begin'
      '  If <frxRelatorio."MARMKP"> = '#39'4'#39' Then'
      
        '    rllTotCliMargemGrupo2.Text := FormatFloat('#39'#,##0.00'#39', fCalcu' +
        'laPrecoVenda(2, fltTotCus, fltTotMkp - IIF(fVeioTelaVendas, fltD' +
        'esEsp, 0),0,0,0,0,0))'
      '  Else'
      
        '    rllTotCliMargemGrupo2.Text := FormatFloat('#39'#,##0.00'#39', fCalcu' +
        'laPrecoVenda(2, fltTotCus, fltTotIte - IIF(fVeioTelaVendas, fltD' +
        'esEsp, 0),0,0,0,0,0));  '
      'end;'
      ''
      
        'procedure rllMargemSintEmissaoOnBeforePrint(Sender: TfrxComponen' +
        't);'
      'begin'
      '  if <frxRelatorio."MARMKP"> = '#39'4'#39' then'
      
        '    rllMargemSintEmissao.Text := FormatFloat('#39'#,##0.00'#39', fCalcul' +
        'aPrecoVenda(2, <frxRelatorio."TOTCUS">, <frxRelatorio."MAMKP4"> ' +
        '- IIF(fVeioTelaVendas, <frxRelatorio."DESESP">, 0), 0,0,0,0,0)) ' +
        ' '
      '  else'
      
        '    rllMargemSintEmissao.Text := FormatFloat('#39'#,##0.00'#39', fCalcul' +
        'aPrecoVenda(2, <frxRelatorio."TOTCUS">, <frxRelatorio."TOTITE"> ' +
        '- IIF(fVeioTelaVendas, <frxRelatorio."DESESP">, 0), 0,0,0,0,0));' +
        '  '
      'end;'
      ''
      'procedure rllTotGerMag2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxRelatorio."MARMKP"> = '#39'4'#39' then'
      
        '    rllTotGerMag2.Text := FormatFloat('#39'#,##0.00'#39', fCalculaPrecoV' +
        'enda(2, fltTotMarGer, fltTotMkpIte - IIF(fVeioTelaVendas, fltTot' +
        'DesEsp, 0),0,0,0,0,0))  '
      '  else'
      
        '    rllTotGerMag2.Text := FormatFloat('#39'#,##0.00'#39', fCalculaPrecoV' +
        'enda(2, fltTotMarGer, fltTotTotIte - IIF(fVeioTelaVendas, fltTot' +
        'DesEsp, 0),0,0,0,0,0));   '
      'end;    '
      ''
      'procedure rllCustoGrupo1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (<frxRelatorio."CODITE"> = <frxRelatorio."ITESER">) or (<fr' +
        'xRelatorio."CODITE"> = <frxRelatorio."SERTER">) then'
      '    rllCustoGrupo1.Text := FormatFloat('#39'#,##0.00'#39', 0.00)'
      '  else'
      
        '    rllCustoGrupo1.Text := FormatFloat('#39'#,##0.00'#39', <frxRelatorio' +
        '."TOTCUS">);                 '
      'end;    '
      ''
      'procedure rlbDetalheOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if not blnImprimeUmaVez then'
      '  begin'
      '    strDescVeiculo := <frxRelatorio."PLAKMS">;  '
      
        '    strNomeCidade := <frxRelatorio."NOMCID"> + '#39'-'#39' + <frxRelator' +
        'io."ESTADO">;'
      ''
      
        '    if not ((<frxRelatorio."CODITE"> = <frxRelatorio."ITESER">) ' +
        'or (<frxRelatorio."CODITE"> = <frxRelatorio."SERTER">)) then'
      '    begin  '
      '      '
      '      fltDesEsp := fltDesEsp + <frxRelatorio."DESESP">;    '
      '      fltTotIte := fltTotIte + <frxRelatorio."TOTITE">;    '
      '      fltTotMkp := fltTotMkp + <frxRelatorio."MAMKP4">;    '
      '      fltTotCus := fltTotCus + <frxRelatorio."TOTCUS">;    '
      '      fltTotDoc := fltTotDoc + <frxRelatorio."TOTDOC">;    '
      ''
      '      fltTotDesEsp := fltTotDesEsp + <frxRelatorio."DESESP">;'
      '      fltTotTotIte := fltTotTotIte + <frxRelatorio."TOTITE">;'
      '      fltTotMkpIte := fltTotMkpIte + <frxRelatorio."MAMKP4">;'
      '      fltTotTotCus := fltTotTotCus + <frxRelatorio."TOTCUS">;'
      '      fltTotTotDoc := fltTotTotDoc + <frxRelatorio."TOTDOC">;'
      ''
      '      fltTotIteGer := fltTotIteGer + <frxRelatorio."TOTITE">;'
      '      fltTotMkpGer := fltTotMkpGer + <frxRelatorio."MAMKP4">;'
      '      fltTotMarGer := fltTotMarGer + <frxRelatorio."TOTCUS">;'
      '      fltTotDesGer := fltTotDesGer + <frxRelatorio."DESESP">;'
      '      fltTotDocGer := fltTotDocGer + <frxRelatorio."TOTDOC">;'
      
        '      fltTotDesEspOrdAlf := fltTotDesEspOrdAlf + <frxRelatorio."' +
        'DESESP">;'
      ''
      '      fltTotQtd    := fltTotQtd    + <frxRelatorio."QTDITE">;'
      '      fltTotQtdD   := fltTotQtdD   + <frxRelatorio."QTDITE">;'
      '      fltTotQtdG   := fltTotQtdG   + <frxRelatorio."QTDITE">;'
      '      '
      '    end;'
      '      '
      '  end;'
      ''
      
        '  if (<frxRelatorio."CODITE"> = <frxRelatorio."ITESER">) or (<fr' +
        'xRelatorio."CODITE"> = <frxRelatorio."SERTER">) then'
      '  begin'
      '    if blnImprimeUmaVez then'
      '    begin'
      '      rdbDtaDoc.Visible := False;'
      '      rdbNumDoc.Visible := False;'
      '      rdbQtdIte.Visible := False;'
      '      rdbValUnit.Visible := False;'
      '      rdbTotIte.Visible := False;'
      '      rllCustoGrupo1.Visible := False;'
      '      rllMargGrupo1.Visible := False;'
      '      rdbDocOri.Visible := False;'
      '      rdbCodEmp.Visible := False;'
      '      rdbCodVen.Visible := False;'
      '      rdbClaFis.Visible := False;'
      '      rdbCodIte.Visible := False;'
      '      rdbDescri.Visible := False;'
      '      rdbRefere.Visible := False;'
      '      rdbUnidad.Visible := False;'
      '      rdbTotDoc.Visible := False;'
      '      rdbDocCan.Visible := False;'
      '      rdbCodSer.Visible := True;'
      '      rdbDesSer.Visible := True;'
      '      rdbQtdSer.Visible := True;'
      '      rdbUniSer.Visible := True;'
      
        '      rdbValSer.Visible := True;                                ' +
        '                                         '
      '    end;              '
      '    blnImprimeUmaVez := True;'
      '  end'
      '  else          '
      '  begin'
      '      rdbDtaDoc.Visible := True;'
      '      rdbNumDoc.Visible := True;'
      '      rdbQtdIte.Visible := True;'
      '      rdbValUnit.Visible := True;'
      '      rdbTotIte.Visible := True;'
      '      rllCustoGrupo1.Visible := True;'
      '      rllMargGrupo1.Visible := True;'
      '      rdbDocOri.Visible := True;'
      '      rdbCodEmp.Visible := True;'
      '      rdbCodVen.Visible := True;'
      '      rdbClaFis.Visible := True;'
      '      rdbCodIte.Visible := True;'
      '      rdbDescri.Visible := True;'
      '      rdbRefere.Visible := True;'
      '      rdbUnidad.Visible := True;'
      '      rdbTotDoc.Visible := True;'
      '      rdbDocCan.Visible := True;'
      '      rdbCodSer.Visible := False;'
      '      rdbDesSer.Visible := False;'
      '      rdbQtdSer.Visible := False;'
      '      rdbUniSer.Visible := False;'
      '      rdbValSer.Visible := False;'
      '  end;                  '
      'end;'
      ''
      'procedure GroupFooter2OnBeforePrint(Sender: TfrxComponent);'
      'begin                 '
      '  if fltDesEsp <> 0 then'
      '  begin'
      '    GroupFooter2.Height  := fltAltDuasLinhas;'
      '    rllTotDocGrupo1.Top     := fltAltLinha2;'
      '    rllTotDocGerGrupo1.Top  := fltAltLinha2;'
      '    rllTotDocMargGrupo1.Top := fltAltLinha2;'
      '    rllTotCusGerGrupo1.Top  := fltAltLinha2;'
      '    rllTotVDocGrupo1.Top    := fltAltLinha2;'
      '    rllTotQtdD.Top          := fltAltLinha2;'
      ''
      '    rllDesEspTotDes.Visible  := True;'
      '    rllDesEspTot.Visible     := True;'
      
        '    rlblDesEspTotIPI.Visible := True;                           ' +
        '                   '
      '  end'
      '  else'
      '  begin'
      '    GroupFooter2.Height  := fltAltDuasLinhas / 2;            '
      '    rllTotDocGrupo1.Top     := fltAltLinha1;'
      '    rllTotDocGerGrupo1.Top  := fltAltLinha1;'
      '    rllTotDocMargGrupo1.Top := fltAltLinha1;'
      '    rllTotCusGerGrupo1.Top  := fltAltLinha1;'
      '    rllTotVDocGrupo1.Top    := fltAltLinha1;'
      '    rllTotQtdD.Top          := fltAltLinha1;'
      ''
      '    rllDesEspTotDes.Visible  := False;'
      '    rllDesEspTot.Visible     := False;'
      '    rlblDesEspTotIPI.Visible := False;        '
      '  end;      '
      'end;'
      ''
      'procedure GroupFooter1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotDesEsp := 0;'
      '  fltTotTotIte := 0;'
      '  fltTotTotCus := 0;'
      '  fltTotTotDoc := 0;'
      '  fltTotQtd    := 0;  '
      'end;'
      ''
      'procedure Footer2OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotTotIte := 0;'
      '  fltTotMarGer := 0;'
      '  fltTotTotDoc := 0;'
      '  fltTotQtdG   := 0;  '
      'end;'
      ''
      'procedure Footer1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotIteGer := 0;'
      '  fltTotMarGer := 0;  '
      'end;'
      ''
      'procedure GroupFooter0OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotIte := 0;'
      '  fltTotMkp := 0;'
      '  fltTotCus := 0;'
      '  fltTotDoc := 0;  '
      'end;'
      ''
      'procedure Footer3OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotTotIte := 0;'
      '  fltTotMarGer := 0;'
      '  fltTotTotDoc := 0;'
      '  fltTotQtdG   := 0;  '
      'end;    '
      ''
      'procedure rllDesEspTotOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllDesEspTot.Text := FormatFloat('#39'#,##0.00'#39', fltDesEsp);      '
      'end;'
      ''
      'procedure rlblDesEspTotIPIOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlblDesEspTotIPI.Text := FormatFloat('#39'#,##0.00'#39', fltDesEsp);  '
      'end;'
      ''
      
        'procedure rllTotDocGerGrupo1OnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      
        '  rllTotDocGerGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte);' +
        '      '
      'end;'
      ''
      
        'procedure rllTotCusGerGrupo1OnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      
        '  rllTotCusGerGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fltTotCus);' +
        '  '
      'end;'
      ''
      'procedure rllTotVDocGrupo1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotVDocGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fltTotDoc);  '
      'end;    '
      ''
      'procedure rllTotQtdDOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotQtdD.Text := FormatFloat('#39'#,##0.00'#39', fltTotQtdD);       ' +
        ' '
      'end;'
      ''
      'procedure rllTotQtdOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotQtd.Text := FormatFloat('#39'#,##0.00'#39', fltTotQtd);  '
      'end;'
      ''
      
        'procedure rllTotCliGerGrupo1OnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      
        '  rllTotCliGerGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fltTotTotIt' +
        'e);  '
      'end;'
      ''
      
        'procedure rllTotCusCliGrupo1OnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      
        '  rllTotCusCliGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fltTotTotCu' +
        's);  '
      'end;'
      ''
      
        'procedure rllTotVDocCliGrupo1OnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  rllTotVDocCliGrupo1.Text := FormatFloat('#39'#,##0.00'#39', fltTotTotD' +
        'oc);      '
      'end;'
      ''
      
        'procedure rllTotVDocCliGrupo2OnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  rllTotVDocCliGrupo2.Text := FormatFloat('#39'#,##0.00'#39', fltTotDoc)' +
        ';  '
      'end;    '
      ''
      
        'procedure rllTotDocGerGrupoAnaliticoSinteticoOnBeforePrint(Sende' +
        'r: TfrxComponent);'
      'begin'
      
        '  rllTotDocGerGrupoAnaliticoSintetico.Text := FormatFloat('#39'#,##0' +
        '.00'#39', fltTotIte);  '
      'end;'
      ''
      
        'procedure rllDesEspTotAnaliticoEmissaoOnBeforePrint(Sender: Tfrx' +
        'Component);'
      'begin'
      
        '  rllDesEspTotAnaliticoEmissao.Text := FormatFloat('#39'#,##0.00'#39', f' +
        'ltDesEsp);  '
      'end;'
      ''
      
        'procedure rllTotCusGerGrupoAnaliticoEmissaoOnBeforePrint(Sender:' +
        ' TfrxComponent);'
      'begin'
      
        '  rllTotCusGerGrupoAnaliticoEmissao.Text := FormatFloat('#39'#,##0.0' +
        '0'#39', fltTotCus);  '
      'end;'
      ''
      
        'procedure rllTotDocGerGrupoAnaliticoEmissaoOnBeforePrint(Sender:' +
        ' TfrxComponent);'
      'begin'
      
        '  rllTotDocGerGrupoAnaliticoEmissao.Text := FormatFloat('#39'#,##0.0' +
        '0'#39', fltTotDoc);  '
      'end;'
      ''
      'procedure rllTotGerDescEspsOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotGerDescEsps.Text := FormatFloat('#39'#,##0.00'#39', fltTotDesEsp' +
        'OrdAlf);  '
      'end;'
      ''
      'procedure rllTotGerProdsOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotGerProds.Text := FormatFloat('#39'#,##0.00'#39', fltTotIteGer+fl' +
        'tTotDesEspOrdAlf);  '
      'end;'
      ''
      'procedure rllTotGerDocsOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotGerDocs.Text := FormatFloat('#39'#,##0.00'#39', fltTotIteGer);  '
      'end;'
      ''
      'procedure rllTotCusDocsOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotCusDocs.Text := FormatFloat('#39'#,##0.00'#39', fltTotMarGer);  '
      'end;'
      ''
      'procedure rllTotTotDocsOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotTotDocs.Text := FormatFloat('#39'#,##0.00'#39', fltTotDocGer);  '
      'end;'
      ''
      'procedure rllTotQtdGOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotQtdG.Text := FormatFloat('#39'#,##0.00'#39', fltTotQtdG);  '
      'end;'
      ''
      'procedure rllTotGerDesEspOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotGerDesEsp.Text := FormatFloat('#39'#,##0.00'#39', fltTotDesEspOr' +
        'dAlf);  '
      'end;'
      ''
      'procedure rllTotGerProOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotGerPro.Text := FormatFloat('#39'#,##0.00'#39', fltTotIteGer+fltT' +
        'otDesEspOrdAlf);  '
      'end;'
      ''
      'procedure rllTotTotGeralOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotTotGeral.Text := FormatFloat('#39'#,##0.00'#39', fltTotIteGer); ' +
        ' '
      'end;'
      ''
      'procedure rllTotCusGeralOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotCusGeral.Text := FormatFloat('#39'#,##0.00'#39', fltTotMarGer); ' +
        ' '
      'end;'
      ''
      'procedure rllTotTotDocGeralOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotTotDocGeral.Text := FormatFloat('#39'#,##0.00'#39', fltTotDocGer' +
        ');  '
      'end;'
      ''
      
        'procedure rllTotCliMargGrupo2OnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  rllTotCliMargGrupo2.Text := FormatFloat('#39'#,##0.00'#39', fltTotIte)' +
        ';  '
      'end;'
      ''
      
        'procedure rllTotCusCliGrupo2OnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      
        '  rllTotCusCliGrupo2.Text := FormatFloat('#39'#,##0.00'#39', fltTotCus);' +
        '  '
      'end;'
      ''
      
        'procedure rllTotGerDescEsps2OnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      
        '  rllTotGerDescEsps2.Text := FormatFloat('#39'#,##0.00'#39', fltTotDesEs' +
        'pOrdAlf);   '
      'end;'
      ''
      'procedure rllTotGerProds2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotGerProds2.Text := FormatFloat('#39'#,##0.00'#39', fltTotIteGer+f' +
        'ltTotDesEspOrdAlf);    '
      'end;'
      ''
      'procedure rllTotGerDocs2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotGerDocs2.Text := FormatFloat('#39'#,##0.00'#39', fltTotIteGer); ' +
        '   '
      'end;'
      ''
      'procedure rllTotCusDocs2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotCusDocs2.Text := FormatFloat('#39'#,##0.00'#39', fltTotMarGer); ' +
        '  '
      'end;'
      ''
      'procedure rllTotTotDocs2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllTotTotDocs2.Text := FormatFloat('#39'#,##0.00'#39', fltTotDocGer);'
      'end;    '
      ''
      'procedure rlbPLAKMSOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbPLAKMS.Text := strDescVeiculo;             '
      'end;'
      ''
      'procedure GroupFooter3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if fltDesEsp <> 0 then'
      '  begin'
      '    rllDesEspTotDesAnaliticoEmissao.Visible := True;'
      '    rllDesEspTotAnaliticoEmissao.Visible    := True;'
      '  End'
      '  Else'
      '  Begin'
      '    rllDesEspTotDesAnaliticoEmissao.Visible := False;'
      '    rllDesEspTotAnaliticoEmissao.Visible    := False;'
      '  End;  '
      'end;'
      ''
      'procedure rdbQtdSerOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxRelatorio."QTDSER"> = 0 then'
      '    rdbQtdSer.Text := '#39#39
      '  else'
      '  begin'
      
        '    rdbQtdSer.Text := FormatFloat('#39'#,##0.00'#39', <frxRelatorio."QTD' +
        'SER">);'
      '    fltTotQtdG := fltTotQtdG + <frxRelatorio."QTDSER">;'
      '  end;  '
      'end;'
      ''
      'procedure rdbUniSerOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxRelatorio."UNISER"> = 0 then'
      '    rdbUniSer.Text := '#39#39
      '  else'
      
        '    rdbUniSer.Text := FormatFloat('#39'#,##0.00'#39', <frxRelatorio."UNI' +
        'SER">);  '
      'end;'
      ''
      'procedure rdbValSerOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxRelatorio."VALSER"> = 0 then'
      '    rdbValSer.Text := '#39#39
      '  else'
      '  begin'
      
        '    rdbValSer.Text := FormatFloat('#39'#,##0.00'#39', <frxRelatorio."VAL' +
        'SER">);'
      '    fltTotIte    := fltTotIte     + <frxRelatorio."VALSER">;'
      '    fltTotIteGer := fltTotIteGer  + <frxRelatorio."VALSER">;'
      '    fltTotDoc    := fltTotDoc     + <frxRelatorio."VALSER">;'
      '    fltTotDocGer := fltTotDocGer  + <frxRelatorio."VALSER">;'
      '  end;  '
      'end;'
      ''
      'procedure rlbDetalheCndPagOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotIte    := fltTotIte + <frxRelatorio."TOTITE">;'
      '  fltTotMkp    := fltTotMkp + <frxRelatorio."MAMKP4">;'
      '  fltTotDoc    := fltTotDoc + <frxRelatorio."TOTDOC">;'
      '  fltTotTotIte := fltTotTotIte + <frxRelatorio."TOTITE">;'
      '  fltTotMkpIte := fltTotMkpIte + <frxRelatorio."MAMKP4">;'
      '  fltTotTotDoc := fltTotTotDoc + <frxRelatorio."TOTDOC">;'
      '  fltTotDesEsp := fltTotDesEsp + <frxRelatorio."DESESP">;'
      '  fltTotIteGer := fltTotIteGer + <frxRelatorio."TOTITE">;'
      '  fltTotMkpGer := fltTotMkpGer + <frxRelatorio."MAMKP4">;'
      '  fltTotDocGer := fltTotDocGer + <frxRelatorio."TOTDOC">;'
      
        '  fltTotDesEspOrdAlf := fltTotDesEspOrdAlf + <frxRelatorio."DESE' +
        'SP">;'
      ''
      '  fltTotCus    := fltTotCus + <frxRelatorio."TOTCUS">;'
      '  fltTotMarGer := fltTotMarGer + <frxRelatorio."TOTCUS">;  '
      'end;'
      ''
      'procedure rlbDetalheClienteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotIte    := fltTotIte + <frxRelatorio."TOTITE">;'
      '  fltTotMkp    := fltTotMkp + <frxRelatorio."MAMKP4">;'
      '  fltTotDoc    := fltTotDoc + <frxRelatorio."TOTDOC">;'
      '  fltTotTotIte := fltTotTotIte + <frxRelatorio."TOTITE">;'
      '  fltTotMkpIte := fltTotMkpIte + <frxRelatorio."MAMKP4">;'
      '  fltTotTotDoc := fltTotTotDoc + <frxRelatorio."TOTDOC">;'
      '  fltTotDesEsp := fltTotDesEsp + <frxRelatorio."DESESP">;'
      '  fltTotIteGer := fltTotIteGer + <frxRelatorio."TOTITE">;'
      '  fltTotMkpGer := fltTotMkpGer + <frxRelatorio."MAMKP4">;'
      '  fltTotDocGer := fltTotDocGer + <frxRelatorio."TOTDOC">;'
      
        '  fltTotDesEspOrdAlf := fltTotDesEspOrdAlf + <frxRelatorio."DESE' +
        'SP">;'
      ''
      '  fltTotCus    := fltTotCus + <frxRelatorio."TOTCUS">;'
      '  fltTotMarGer := fltTotMarGer + <frxRelatorio."TOTCUS">;  '
      'end;    '
      ''
      'procedure rdbConPagOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbConPag.Text := fFormataCondPag(<frxRelatorio."CONPAG">);   ' +
        '                                   '
      'end;    '
      ''
      'procedure rdbConPag2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rdbConPag2.Text := fFormataCondPag(<frxRelatorio."CONPAG">);  '
      'end;'
      ''
      'procedure rllNomCli4OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllNomCli4.Text := <frxRelatorio."CODCLI"> + '#39'-'#39' + <frxRelator' +
        'io."NOMCLI">;     '
      'end;'
      ''
      'procedure rllCgcCliOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllCgcCli.Text := fFormataCGCCli(<frxRelatorio."CGCCLI">);  '
      'end;'
      ''
      'begin'
      '  blnImprimeUmaVez := False;'
      '    '
      '  strDescVeiculo := '#39#39';'
      '  strNomeCidade := '#39#39';'
      ''
      '  fltTotDocGer := 0;'
      '  fltTotDesEspOrdAlf := 0;      '
      '    '
      '  fltDesEsp := 0;'
      '  fltTotIte := 0;     '
      '  fltTotMkp := 0; '
      '  fltTotCus := 0; '
      '  fltTotDoc := 0;'
      '    '
      '  fltTotDesEsp := 0; '
      '  fltTotTotIte := 0; '
      '  fltTotMkpIte := 0; '
      '  fltTotTotCus := 0; '
      '  fltTotTotDoc := 0;'
      '    '
      '  fltTotIteGer := 0; '
      '  fltTotMkpGer := 0; '
      '  fltTotMarGer := 0; '
      '  fltTotDesGer := 0; '
      ' '
      '  fltTotQtd := 0; '
      '  fltTotQtdD := 0; '
      '  fltTotQtdG := 0;'
      ''
      '  fltAltLinha1 := rllDesEspTotDes.Top;'
      '  fltAltLinha2 := rllTotDocGrupo1.Top;'
      
        '  fltAltDuasLinhas := GroupFooter2.Height;                      ' +
        '              '
      'end.          ')
    OnUserFunction = frxRelatorioJUserFunction
    Left = 452
    Top = 432
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118102910000000000
        ParentFont = False
        Top = 464.882190000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalheOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 15.118102910000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object rdbDtaDoc: TfrxMemoView
          Left = 9.023655000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbNumDoc: TfrxMemoView
          Left = 46.937075000000000000
          Width = 69.543290000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbQtdIte: TfrxMemoView
          Left = 464.882190000000000000
          Width = 27.968460000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbValUnit: TfrxMemoView
          Left = 495.606680000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbTotIte: TfrxMemoView
          Left = 541.913730000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCustoGrupo1: TfrxMemoView
          Left = 588.827150000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllCustoGrupo1OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMargGrupo1: TfrxMemoView
          Left = 629.622450000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllMargGrupo1OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MARGEM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbDocOri: TfrxMemoView
          Left = 120.063080000000000000
          Width = 72.566929130000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCORI"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbCodEmp: TfrxMemoView
          Left = 194.535560000000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbCodVen: TfrxMemoView
          Left = 215.433210000000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbClaFis: TfrxMemoView
          Left = 238.110390000000000000
          Width = 24.188930000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbCodIte: TfrxMemoView
          Left = 264.567100000000000000
          Width = 50.645640000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbDescri: TfrxMemoView
          Left = 317.480520000000000000
          Width = 99.779530000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbRefere: TfrxMemoView
          Left = 419.527830000000000000
          Width = 24.188930000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbUnidad: TfrxMemoView
          Left = 445.984540000000000000
          Width = 16.629870000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbTotDoc: TfrxMemoView
          Left = 668.976810000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTDOC"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbDocCan: TfrxMemoView
          Width = 9.070810000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCCAN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbCodSer: TfrxMemoView
          Left = 162.519790000000000000
          Width = 50.645640000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODSER"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbDesSer: TfrxMemoView
          Left = 215.433210000000000000
          Width = 235.842610000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESSER"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbQtdSer: TfrxMemoView
          Left = 464.882190000000000000
          Width = 27.968460000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rdbQtdSerOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbUniSer: TfrxMemoView
          Left = 495.496062990000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rdbUniSerOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbValSer: TfrxMemoView
          Left = 541.984251970000000000
          Width = 43.086614170000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rdbValSerOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.015525910000000000
        Top = 362.834880000000000000
        Visible = False
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."NOMCLI"'
        ReprintOnNewPage = True
        object rllNomCli: TfrxMemoView
          Left = 5.023655000000000000
          Top = 2.000000000000000000
          Width = 708.283860000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rllNomCliOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'rllNomCli')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object rllCidadeCli: TfrxMemoView
          Left = 4.913385830000000000
          Top = 17.897650000000000000
          Width = 708.283860000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rllCidadeCliOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'rllCidadeCli')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 15.102350000000000000
        Top = 325.039580000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object shpTitulo: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 15.102350000000000000
          Fill.BackColor = clSilver
        end
        object rllData: TfrxMemoView
          Left = 9.023655000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllNumDoc: TfrxMemoView
          Left = 46.937075000000000000
          Width = 31.747990000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N.DOC')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllQtde: TfrxMemoView
          Left = 464.882190000000000000
          Width = 27.968460000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllUnit: TfrxMemoView
          Left = 495.606680000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'UNIT.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllValTot: TfrxMemoView
          Left = 541.913730000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCusto: TfrxMemoView
          Left = 588.827150000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMargem: TfrxMemoView
          Left = 629.622450000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '% MARG')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 120.063080000000000000
          Width = 50.645640000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOC ORI.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 194.535560000000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMP.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 215.433210000000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 238.110390000000000000
          Width = 24.188930000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CFOP')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCodigo: TfrxMemoView
          Left = 264.567100000000000000
          Width = 27.968460000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'D.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDescri: TfrxMemoView
          Left = 317.480520000000000000
          Width = 50.645640000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllRefere: TfrxMemoView
          Left = 419.527830000000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REF.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllUnidade: TfrxMemoView
          Left = 445.984540000000000000
          Width = 16.629870000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 668.976810000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOT.C/IPI')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 608.504330000000000000
        Visible = False
        Width = 718.110700000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        object rllTotQtd: TfrxMemoView
          Left = 464.882190000000000000
          Width = 27.968460000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotQtdOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCliGerGrupo1: TfrxMemoView
          Left = 541.913730000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCliGerGrupo1OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCusCliGrupo1: TfrxMemoView
          Left = 588.827150000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCusCliGrupo1OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCliMargGrupo1: TfrxMemoView
          Left = 629.622450000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCliMargGrupo1OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotVDocCliGrupo1: TfrxMemoView
          Left = 668.976810000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotVDocCliGrupo1OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCliGrupo1: TfrxMemoView
          Left = 366.614410000000000000
          Width = 84.661410000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO CLIENTE:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Top = 419.527830000000000000
        Visible = False
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."NUMDOC"'
        ReprintOnNewPage = True
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 555.590910000000000000
        Visible = False
        Width = 718.110700000000000000
        OnAfterPrint = 'GroupFooter2OnAfterPrint'
        OnBeforePrint = 'GroupFooter2OnBeforePrint'
        object rllTotQtdD: TfrxMemoView
          Left = 464.882190000000000000
          Top = 15.118120000000000000
          Width = 27.968460000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotQtdDOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDesEspTot: TfrxMemoView
          Left = 541.913730000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllDesEspTotOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCusGerGrupo1: TfrxMemoView
          Left = 588.827150000000000000
          Top = 15.118120000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCusGerGrupo1OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotDocMargGrupo1: TfrxMemoView
          Left = 629.622450000000000000
          Top = 15.118120000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotDocMargGrupo1OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rlblDesEspTotIPI: TfrxMemoView
          Left = 668.976810000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rlblDesEspTotIPIOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDesEspTotDes: TfrxMemoView
          Left = 366.614410000000000000
          Width = 84.661410000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO ESPECIAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotDocGrupo1: TfrxMemoView
          Left = 366.614410000000000000
          Top = 15.118120000000000000
          Width = 84.661410000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO DOCUMENTO:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotVDocGrupo1: TfrxMemoView
          Left = 668.976810000000000000
          Top = 15.118120000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotVDocGrupo1OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotDocGerGrupo1: TfrxMemoView
          Left = 541.984251970000000000
          Top = 15.118120000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotDocGerGrupo1OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Top = 442.205010000000000000
        Visible = False
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."NUMDOC"'
        ReprintOnNewPage = True
      end
      object GroupFooter3: TfrxGroupFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 502.677490000000000000
        Visible = False
        Width = 718.110700000000000000
        OnAfterPrint = 'GroupFooter3OnAfterPrint'
        OnBeforePrint = 'GroupFooter3OnBeforePrint'
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          Fill.BackColor = clSilver
        end
        object rllTotDocGerGrupoAnaliticoSintetico: TfrxMemoView
          Left = 541.913730000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotDocGerGrupoAnaliticoSinteticoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCusGerGrupoAnaliticoEmissao: TfrxMemoView
          Left = 588.827150000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCusGerGrupoAnaliticoEmissaoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotDocMargGrupoAnaliticoEmissao: TfrxMemoView
          Left = 629.622450000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotDocMargGrupoAnaliticoEmissaoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotDocGerGrupoAnaliticoEmissao: TfrxMemoView
          Left = 668.976810000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotDocGerGrupoAnaliticoEmissaoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotDocGrupoAnaliticoEmissao: TfrxMemoView
          Left = 366.614410000000000000
          Width = 126.236240000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO DOCUMENTO:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDesEspTotAnaliticoEmissao: TfrxMemoView
          Left = 541.984251970000000000
          Top = 15.118120000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllDesEspTotAnaliticoEmissaoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDesEspTotDesAnaliticoEmissao: TfrxMemoView
          Left = 366.614410000000000000
          Top = 15.118120000000000000
          Width = 126.236240000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO ESPECIAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rlbPLAKMS: TfrxMemoView
          Left = 3.779530000000000000
          Width = 345.448980000000000000
          Height = 15.118110236220500000
          OnBeforePrint = 'rlbPLAKMSOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PLAKMS')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 650.079160000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'Footer1OnAfterPrint'
        object Memo8: TfrxMemoView
          Left = 226.771800000000000000
          Width = 164.031540000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DESCONTO ESPECIAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 226.771800000000000000
          Top = 15.118120000000000000
          Width = 164.031540000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DOS PRODUTOS:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 226.771800000000000000
          Top = 30.236240000000000000
          Width = 164.031540000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DOS DOCUMENTOS:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotGerDesEsp: TfrxMemoView
          Left = 541.984251970000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotGerDesEspOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotGerPro: TfrxMemoView
          Left = 541.984251970000000000
          Top = 15.118120000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotGerProOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotTotGeral: TfrxMemoView
          Left = 541.984251970000000000
          Top = 30.236240000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotTotGeralOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotQtdG: TfrxMemoView
          Left = 408.189240000000000000
          Top = 30.236240000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotQtdGOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCusGeral: TfrxMemoView
          Left = 588.850393700000000000
          Top = 30.236240000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCusGeralOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotTotGerMar: TfrxMemoView
          Left = 629.669291340000000000
          Top = 30.236240000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotTotGerMarOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotTotDocGeral: TfrxMemoView
          Left = 668.976377950000000000
          Top = 30.236240000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotTotDocGeralOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 243.771697480000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 183.723285000000000000
          Top = 17.000000000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Left = 183.723285000000000000
          Top = 34.000000000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 587.679160000000000000
          Top = 12.661410000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA [Page]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 546.104330000000000000
          Top = 29.440940000000000000
          Width = 166.374830000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object rllCliente: TfrxMemoView
          Top = 64.251968500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllCliente]')
          ParentFont = False
        end
        object rllVendedor: TfrxMemoView
          Top = 75.590600000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllVendedor]')
          ParentFont = False
        end
        object rllRepresentante: TfrxMemoView
          Top = 86.929190000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllRepresentante]')
          ParentFont = False
        end
        object rllEmpresa: TfrxMemoView
          Top = 98.267780000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllEmpresa]')
          ParentFont = False
        end
        object rllLinhaGrupo: TfrxMemoView
          Top = 109.606370000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllLinhaGrupo]')
          ParentFont = False
        end
        object rllTinta: TfrxMemoView
          Top = 120.944960000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllTinta]')
          ParentFont = False
        end
        object rllDesPro: TfrxMemoView
          Top = 132.283550000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllDesPro]')
          ParentFont = False
        end
        object rllOrdem: TfrxMemoView
          Left = 183.685039370000000000
          Top = 49.574830000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
        end
        object rllEspPro: TfrxMemoView
          Top = 143.622047240000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllEspPro]')
          ParentFont = False
        end
        object rllRegiao: TfrxMemoView
          Top = 154.960629920000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllRegiao]')
          ParentFont = False
        end
        object rllFaseObra: TfrxMemoView
          Top = 166.299212600000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllFaseObra]')
          ParentFont = False
        end
        object rllPlaca: TfrxMemoView
          Top = 177.637795280000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllPlaca]')
          ParentFont = False
        end
        object rllAnoModelo: TfrxMemoView
          Top = 188.976377950000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllAnoModelo]')
          ParentFont = False
        end
        object rllCor: TfrxMemoView
          Top = 200.314960630000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllCor]')
          ParentFont = False
        end
        object rllEvento: TfrxMemoView
          Top = 211.653543310000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllEvento]')
          ParentFont = False
        end
        object rllFormPag: TfrxMemoView
          Top = 222.992125980000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllFormPag]')
          ParentFont = False
        end
        object rllCliExcluir: TfrxMemoView
          Left = 359.055350000000000000
          Top = 64.252010000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllCliExcluir]')
          ParentFont = False
        end
        object rllCidade: TfrxMemoView
          Left = 359.055350000000000000
          Top = 75.590641500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllCidade]')
          ParentFont = False
        end
        object rllFornecedor: TfrxMemoView
          Left = 359.055350000000000000
          Top = 86.929231500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllFornecedor]')
          ParentFont = False
        end
        object rllAtividade: TfrxMemoView
          Left = 359.055350000000000000
          Top = 98.267821500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllAtividade]')
          ParentFont = False
        end
        object rllRedeLoja: TfrxMemoView
          Left = 359.055350000000000000
          Top = 109.606411500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllRedeLoja]')
          ParentFont = False
        end
        object rllComCus: TfrxMemoView
          Left = 359.055350000000000000
          Top = 120.945001500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllComCus]')
          ParentFont = False
        end
        object rllMarca: TfrxMemoView
          Left = 359.055350000000000000
          Top = 132.283591500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllMarca]')
          ParentFont = False
        end
        object rllProduto: TfrxMemoView
          Left = 359.055350000000000000
          Top = 143.622088740000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllProduto]')
          ParentFont = False
        end
        object rllRefPro: TfrxMemoView
          Left = 359.055350000000000000
          Top = 154.960671420000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllRefPro]')
          ParentFont = False
        end
        object rllCliCon: TfrxMemoView
          Left = 359.055350000000000000
          Top = 166.299254100000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllCliCon]')
          ParentFont = False
        end
        object rllNomCon: TfrxMemoView
          Left = 359.055350000000000000
          Top = 177.637836780000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllNomCon]')
          ParentFont = False
        end
        object rllMarcaVei: TfrxMemoView
          Left = 359.055350000000000000
          Top = 188.976419450000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllMarcaVei]')
          ParentFont = False
        end
        object rllEmbarc: TfrxMemoView
          Left = 359.055350000000000000
          Top = 200.315002130000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllEmbarc]')
          ParentFont = False
        end
        object rllClafis: TfrxMemoView
          Left = 359.055350000000000000
          Top = 211.653584810000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllClafis]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxReportSummary
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 755.906000000000000000
        Width = 718.110700000000000000
        Stretched = True
        object rllNomeForm: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 165.013790000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 548.787260000000000000
          Top = 3.779530000000000000
          Width = 160.629560000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetalhe)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          Color = clBlack
          Diagonal = True
        end
        object rllMensagemRodape: TfrxMemoView
          Left = 7.559060000000000000
          Top = 30.236240000000000000
          Width = 701.707050000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllMensagemRodape]')
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbTituloCndPag: TfrxHeader
        FillType = ftBrush
        Height = 15.102350000000000000
        Top = 325.039580000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 15.102350000000000000
          Fill.BackColor = clSilver
        end
        object rllData2: TfrxMemoView
          Left = 9.023655000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllNumDoc2: TfrxMemoView
          Left = 46.937075000000000000
          Width = 31.747990000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N.DOC')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDesEsp: TfrxMemoView
          Left = 495.606680000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.ESP')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 541.913730000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.LIQ')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCusto2: TfrxMemoView
          Left = 588.827150000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMargem2: TfrxMemoView
          Left = 629.622450000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '% MARG')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 120.188976380000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMP.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllVend: TfrxMemoView
          Left = 141.354330710000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 415.968770000000000000
          Width = 24.188930000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CFOP')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllConPag: TfrxMemoView
          Left = 170.078850000000000000
          Width = 107.338590000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONDICAO DE PAGAMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 668.976810000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOT.C/IPI')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbDetalheCndPag: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118102910000000000
        ParentFont = False
        Top = 419.527830000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalheCndPagOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebra2: TfrxMemoView
          Width = 718.110700000000000000
          Height = 15.118102910000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object rdbDtaDoc2: TfrxMemoView
          Left = 9.023655000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbNumDoc2: TfrxMemoView
          Left = 46.937075000000000000
          Width = 69.543290000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbDesEsp: TfrxMemoView
          Left = 495.606680000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DESESP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbTotIte2Sint: TfrxMemoView
          Left = 541.913730000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCustoSint: TfrxMemoView
          Left = 588.827150000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTCUS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMargemSint: TfrxMemoView
          Left = 629.622450000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllMargemSintOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MARGEM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbConPag: TfrxMemoView
          Left = 170.078740160000000000
          Width = 201.070949130000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rdbConPagOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 120.188976380000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 141.354330710000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 416.125984250000000000
          Width = 24.188930000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 668.976810000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTDOC"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Width = 9.070810000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCCAN"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader0: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.015525910000000000
        Top = 362.834880000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."NOMCLI"'
        ReprintOnNewPage = True
        object rllNomCli2: TfrxMemoView
          Left = 5.023655000000000000
          Top = 2.000000000000000000
          Width = 708.283860000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rllNomCli2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'rllNomCli')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object rllCidadeCli2: TfrxMemoView
          Left = 4.913385830000000000
          Top = 17.897650000000000000
          Width = 708.283860000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rllCidadeCli2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'rllCidadeCli')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
      end
      object GroupFooter0: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 457.323130000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'GroupFooter0OnAfterPrint'
        object rllTotCliMargGrupo2: TfrxMemoView
          Left = 541.913730000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCliMargGrupo2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCusCliGrupo2: TfrxMemoView
          Left = 588.827150000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCusCliGrupo2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCliMargemGrupo2: TfrxMemoView
          Left = 629.622450000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCliMargemGrupo2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotVDocCliGrupo2: TfrxMemoView
          Left = 668.976810000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotVDocCliGrupo2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCliGrupo2: TfrxMemoView
          Left = 415.748300000000000000
          Width = 77.102350000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO CLIENTE:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 498.897960000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'Footer2OnAfterPrint'
        object Memo5: TfrxMemoView
          Left = 287.244280000000000000
          Width = 164.031540000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DESCONTO ESPECIAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 287.244280000000000000
          Top = 15.118120000000000000
          Width = 164.031540000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DOS PRODUTOS:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 287.244280000000000000
          Top = 30.236240000000000000
          Width = 164.031540000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DOS DOCUMENTOS:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotGerDescEsps: TfrxMemoView
          Left = 541.984251970000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotGerDescEspsOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotGerProds: TfrxMemoView
          Left = 541.984251970000000000
          Top = 15.118120000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotGerProdsOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotGerDocs: TfrxMemoView
          Left = 541.984251970000000000
          Top = 30.236240000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotGerDocsOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCusDocs: TfrxMemoView
          Left = 588.850393700000000000
          Top = 30.236240000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCusDocsOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotGerMag: TfrxMemoView
          Left = 629.669291340000000000
          Top = 30.236240000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotGerMagOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotTotDocs: TfrxMemoView
          Left = 668.976377950000000000
          Top = 30.236240000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotTotDocsOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 243.771697480000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo48: TfrxMemoView
          Align = baCenter
          Left = 183.723285000000000000
          Top = 17.000000000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 183.723285000000000000
          Top = 34.000000000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 587.679160000000000000
          Top = 12.661410000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA [Page]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 546.104330000000000000
          Top = 29.440940000000000000
          Width = 166.374830000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo53: TfrxMemoView
          Top = 64.251968500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllCliente]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Top = 75.590600000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllVendedor]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Top = 86.929190000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllRepresentante]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Top = 98.267780000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllEmpresa]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Top = 109.606370000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllLinhaGrupo]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Top = 120.944960000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllTinta]')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Top = 132.283550000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllDesPro]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 183.685039370000000000
          Top = 49.574830000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Top = 143.622047240000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllEspPro]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Top = 154.960629920000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllRegiao]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Top = 166.299212600000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllFaseObra]')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Top = 177.637795280000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllPlaca]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Top = 188.976377950000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllAnoModelo]')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Top = 200.314960630000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllCor]')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Top = 211.653543310000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllEvento]')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Top = 222.992125980000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllFormPag]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 359.055350000000000000
          Top = 64.252010000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllCliExcluir]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 359.055350000000000000
          Top = 75.590641500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllCidade]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 359.055350000000000000
          Top = 86.929231500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllFornecedor]')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 359.055350000000000000
          Top = 98.267821500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllAtividade]')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 359.055350000000000000
          Top = 109.606411500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllRedeLoja]')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 359.055350000000000000
          Top = 120.945001500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllComCus]')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 359.055350000000000000
          Top = 132.283591500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllMarca]')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 359.055350000000000000
          Top = 143.622088740000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllProduto]')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 359.055350000000000000
          Top = 154.960671420000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllRefPro]')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 359.055350000000000000
          Top = 166.299254100000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllCliCon]')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Left = 359.055350000000000000
          Top = 177.637836780000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllNomCon]')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Left = 359.055350000000000000
          Top = 188.976419450000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllMarcaVei]')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 359.055350000000000000
          Top = 200.315002130000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllEmbarc]')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 359.055350000000000000
          Top = 211.653584810000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllClafis]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 604.724800000000000000
        Width = 718.110700000000000000
        Stretched = True
        object Memo117: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 165.013790000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 548.787260000000000000
          Top = 3.779530000000000000
          Width = 160.629560000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetalheCndPag)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo119: TfrxMemoView
          Left = 7.559060000000000000
          Top = 30.236240000000000000
          Width = 701.707050000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllMensagemRodape]')
          ParentFont = False
        end
      end
    end
    object Page3: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbTituloCliente: TfrxHeader
        FillType = ftBrush
        Height = 15.102350000000000000
        Top = 325.039580000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 15.102350000000000000
          Fill.BackColor = clSilver
        end
        object Memo35: TfrxMemoView
          Left = 9.023655000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 46.937075000000000000
          Width = 31.747990000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N.DOC')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 495.606680000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'UNIT.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 541.913730000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCusto2SinteticoEmissao: TfrxMemoView
          Left = 588.827150000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMargem2SinteticoEmissao: TfrxMemoView
          Left = 629.622450000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '% MARG')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 120.188976377953000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMP.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 141.354330708661000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 453.543600000000000000
          Width = 24.188930000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CFOP')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 170.078850000000000000
          Width = 50.645640000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 668.976810000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOT.C/IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 343.937230000000000000
          Width = 103.559060000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONDICAO DE PAGAMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbDetalheCliente: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.236222910000000000
        ParentFont = False
        Top = 362.834880000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalheClienteOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebra3: TfrxMemoView
          Width = 718.110700000000000000
          Height = 30.236222910000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Left = 9.023655000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 46.937075000000000000
          Width = 69.543290000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 495.606680000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DESESP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 541.913730000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCustoSintEmissao: TfrxMemoView
          Left = 588.827150000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTCUS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMargemSintEmissao: TfrxMemoView
          Left = 629.622450000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllMargemSintEmissaoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MARGEM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbConPag2: TfrxMemoView
          Left = 343.937007870000000000
          Width = 106.582699130000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rdbConPag2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 120.188976380000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 141.354330710000000000
          Width = 20.409400000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 453.543307090000000000
          Width = 24.188930000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 668.976810000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTDOC"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Width = 9.070810000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCCAN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllNomCli4: TfrxMemoView
          Left = 170.078850000000000000
          Width = 171.590600000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllNomCli4OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCgcCli: TfrxMemoView
          Left = 170.078850000000000000
          Top = 15.118120000000000000
          Width = 171.590600000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllCgcCliOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Footer3: TfrxFooter
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 415.748300000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'Footer3OnAfterPrint'
        object Memo16: TfrxMemoView
          Left = 287.244280000000000000
          Width = 164.031540000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DESCONTO ESPECIAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 287.244280000000000000
          Top = 15.118120000000000000
          Width = 164.031540000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DOS PRODUTOS:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 287.244280000000000000
          Top = 30.236240000000000000
          Width = 164.031540000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DOS DOCUMENTOS:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotGerDescEsps2: TfrxMemoView
          Left = 541.984251970000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotGerDescEsps2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotGerProds2: TfrxMemoView
          Left = 541.984251970000000000
          Top = 15.118120000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotGerProds2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotGerDocs2: TfrxMemoView
          Left = 541.984251970000000000
          Top = 30.236240000000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotGerDocs2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotCusDocs2: TfrxMemoView
          Left = 588.850393700000000000
          Top = 30.236240000000000000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotCusDocs2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotGerMag2: TfrxMemoView
          Left = 629.669291340000000000
          Top = 30.236240000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotGerMag2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotTotDocs2: TfrxMemoView
          Left = 668.976377950000000000
          Top = 30.236240000000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotTotDocs2OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader2: TfrxPageHeader
        FillType = ftBrush
        Height = 243.771697480000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo83: TfrxMemoView
          Align = baCenter
          Left = 183.723285000000000000
          Top = 17.000000000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 183.723285000000000000
          Top = 34.000000000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 587.679160000000000000
          Top = 12.661410000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA [Page]')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 546.104330000000000000
          Top = 29.440940000000000000
          Width = 166.374830000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo87: TfrxMemoView
          Top = 64.251968500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllCliente]')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Top = 75.590600000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllVendedor]')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Top = 86.929190000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllRepresentante]')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Top = 98.267780000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllEmpresa]')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Top = 109.606370000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllLinhaGrupo]')
          ParentFont = False
        end
        object Memo92: TfrxMemoView
          Top = 120.944960000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllTinta]')
          ParentFont = False
        end
        object Memo93: TfrxMemoView
          Top = 132.283550000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllDesPro]')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Left = 183.685039370000000000
          Top = 49.574830000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Top = 143.622047240000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllEspPro]')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Top = 154.960629920000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllRegiao]')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Top = 166.299212600000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllFaseObra]')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Top = 177.637795280000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllPlaca]')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Top = 188.976377950000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllAnoModelo]')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          Top = 200.314960630000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllCor]')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Top = 211.653543310000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllEvento]')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Top = 222.992125980000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllFormPag]')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Left = 359.055350000000000000
          Top = 64.252010000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllCliExcluir]')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Left = 359.055350000000000000
          Top = 75.590641500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllCidade]')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          Left = 359.055350000000000000
          Top = 86.929231500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllFornecedor]')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          Left = 359.055350000000000000
          Top = 98.267821500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllAtividade]')
          ParentFont = False
        end
        object Memo107: TfrxMemoView
          Left = 359.055350000000000000
          Top = 109.606411500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllRedeLoja]')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          Left = 359.055350000000000000
          Top = 120.945001500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllComCus]')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          Left = 359.055350000000000000
          Top = 132.283591500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllMarca]')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          Left = 359.055350000000000000
          Top = 143.622088740000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllProduto]')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          Left = 359.055350000000000000
          Top = 154.960671420000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllRefPro]')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 359.055350000000000000
          Top = 166.299254100000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllCliCon]')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 359.055350000000000000
          Top = 177.637836780000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllNomCon]')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Left = 359.055350000000000000
          Top = 188.976419450000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllMarcaVei]')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Left = 359.055350000000000000
          Top = 200.315002130000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllEmbarc]')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Left = 359.055350000000000000
          Top = 211.653584810000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rllClafis]')
          ParentFont = False
        end
      end
      object ReportSummary2: TfrxReportSummary
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 521.575140000000000000
        Width = 718.110700000000000000
        Stretched = True
        object Memo120: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 165.013790000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          Left = 548.787260000000000000
          Top = 3.779530000000000000
          Width = 160.629560000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetalheCliente)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo122: TfrxMemoView
          Left = 7.559060000000000000
          Top = 30.236240000000000000
          Width = 701.707050000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllMensagemRodape]')
          ParentFont = False
        end
      end
    end
  end
end
