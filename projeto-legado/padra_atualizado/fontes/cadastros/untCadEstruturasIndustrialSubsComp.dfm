inherited frmCadEstruturasIndustrialSubsComp: TfrmCadEstruturasIndustrialSubsComp
  Width = 703
  Height = 446
  Caption = 'Estruturas - Substitui'#231#227'o de Componentes'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 703
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 374
    Width = 697
    TabOrder = 1
    ExplicitTop = 374
    ExplicitWidth = 697
    inherited btnSair: TBitBtnLocked
      Left = 618
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 1
      ExplicitLeft = 614
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 100
      Height = 24
      Align = alLeft
      Caption = '[ F10 ] Substituir'
      TabOrder = 0
      OnClick = btnConfirmaClick
      ExplicitLeft = 7
      ExplicitTop = 3
      ExplicitHeight = 22
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 697
    Height = 374
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object grbSubProdAtual: TGroupBox
      Left = 1
      Top = 1
      Width = 695
      Height = 90
      Align = alTop
      Caption = 'Sub-Produto Atual'
      TabOrder = 0
      object Label2: TLabel
        Left = 57
        Top = 28
        Width = 40
        Height = 14
        Caption = 'Produto:'
      end
      object Label3: TLabel
        Left = 42
        Top = 51
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia:'
      end
      object Label4: TLabel
        Left = 221
        Top = 51
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object edtProAtu: TEditFocus
        Tag = 99
        Left = 101
        Top = 24
        Width = 51
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtProAtuKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesProAtu: TEditFocus
        Left = 153
        Top = 24
        Width = 490
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtRefProAtu: TEditFocus
        Left = 101
        Top = 47
        Width = 118
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUniProAtu: TEditFocus
        Left = 264
        Top = 47
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object grbSubProdSubst: TGroupBox
      Left = 1
      Top = 91
      Width = 695
      Height = 90
      Align = alTop
      Caption = 'Sub-Produto para Substitui'#231#227'o'
      TabOrder = 1
      object Label1: TLabel
        Left = 57
        Top = 34
        Width = 40
        Height = 14
        Caption = 'Produto:'
      end
      object Label5: TLabel
        Left = 42
        Top = 57
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia:'
      end
      object Label6: TLabel
        Left = 221
        Top = 57
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object Label20: TLabel
        Left = 313
        Top = 57
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Toler'#226'ncia:'
      end
      object Label21: TLabel
        Left = 450
        Top = 58
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object edtProSub: TEditFocus
        Tag = 99
        Left = 101
        Top = 30
        Width = 51
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtProSubKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesProSub: TEditFocus
        Left = 153
        Top = 30
        Width = 490
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtRefProSub: TEditFocus
        Left = 101
        Top = 53
        Width = 118
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUniProSub: TEditFocus
        Left = 264
        Top = 53
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPerTol: TEditFocus
        Tag = 99
        Left = 366
        Top = 53
        Width = 78
        Height = 22
        Alignment = taRightJustify
        Color = clWhite
        MaxLength = 10
        TabOrder = 1
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 10
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object grbEstruturas: TGroupBox
      Left = 1
      Top = 181
      Width = 695
      Height = 192
      Align = alClient
      Caption = 'Estruturas'
      TabOrder = 2
      object Label7: TLabel
        Left = 11
        Top = 27
        Width = 87
        Height = 14
        Caption = 'Produto Estrutura:'
      end
      object Label8: TLabel
        Left = 78
        Top = 50
        Width = 20
        Height = 14
        Caption = 'Cor:'
      end
      object Label9: TLabel
        Left = 6
        Top = 73
        Width = 92
        Height = 14
        Caption = 'C'#243'digo da F'#243'rmula:'
      end
      object lblLinhaGrupo: TLabel
        Left = 36
        Top = 96
        Width = 62
        Height = 14
        Caption = 'Linha/Grupo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblMarca: TLabel
        Left = 65
        Top = 119
        Width = 33
        Height = 14
        Caption = 'Marca:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtProEst: TEditFocus
        Tag = 99
        Left = 101
        Top = 23
        Width = 51
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtProEstKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesProEst: TEditFocus
        Left = 153
        Top = 23
        Width = 488
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCorEst: TEditFocus
        Tag = 99
        Left = 101
        Top = 46
        Width = 51
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 4
        TabOrder = 1
        OnKeyPress = edtCorEstKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 4
        TipoTexto = ttNumerico
      end
      object edtDesCorEst: TEditFocus
        Left = 153
        Top = 46
        Width = 488
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 101
        Top = 69
        Width = 118
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 101
        Top = 92
        Width = 64
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
        TabOrder = 3
        Text = ''
        OnExit = mskLinGruExit
        OnKeyPress = mskLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGrupo: TEditFocus
        Left = 165
        Top = 93
        Width = 476
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 8
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
        Left = 104
        Top = 116
        Width = 64
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
        TabOrder = 4
        OnExit = edtCodMarExit
        OnKeyPress = edtCodMarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMar: TEditFocus
        Left = 165
        Top = 116
        Width = 476
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object rdgIteAti: TRadioGroup
        Left = 101
        Top = 138
        Width = 244
        Height = 44
        Caption = 'Status'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Ativo'
          'Inativo'
          'Todos')
        TabOrder = 5
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 402
    Width = 697
    TabOrder = 2
    ExplicitTop = 402
    ExplicitWidth = 697
    inherited pnlNomeForm: TPanel
      Left = 526
      ExplicitLeft = 526
    end
    inherited pnlInfo: TPanel
      Width = 526
      ExplicitWidth = 526
    end
  end
end
