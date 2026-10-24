inherited frmPedidoCompra: TfrmPedidoCompra
  Left = 218
  Top = 161
  Width = 800
  Height = 591
  ActiveControl = nil
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o de Pedido de Compra'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 463
    Width = 792
    inherited btnSair: TBitBtn
      Left = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 541
    Width = 792
    inherited pnlNomeForm: TPanel
      Left = 673
      Width = 119
    end
    inherited pnlInfo: TPanel
      Width = 673
    end
  end
  inherited pgcDados: TPageControl
    Top = 172
    Width = 792
    Height = 291
    Visible = False
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 792
    Height = 81
    Align = alTop
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 16
      Top = 13
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 10
      Top = 36
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Entrega:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 172
      Top = 36
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comprador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 29
      Top = 59
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cnd.Pgto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQtdCtn: TLabel
      Left = 490
      Top = 36
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Containers:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEdicao: TLabel
      Left = 635
      Top = 11
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'EDI'#199#195'O DO PED. Nro.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpDestino: TLabel
      Left = 655
      Top = 36
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa Destino:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 490
      Top = 60
      Width = 96
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto Adicional:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 636
      Top = 59
      Width = 13
      Height = 14
      Caption = '% '
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 78
      Top = 6
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 0
      OnEnter = edtCodIteEnter
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtCompra: TEditFocus
      Tag = 99
      Left = 231
      Top = 29
      Width = 257
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 40
      TabOrder = 3
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object mskDtaPed: TMaskEditFocus
      Tag = 99
      Left = 78
      Top = 29
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 78
      Top = 52
      Width = 410
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99.999.999.999.999.999.999.999.999.999.999.999.999;0;_'
      MaxLength = 50
      TabOrder = 5
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNomFor: TEditFocus
      Left = 142
      Top = 6
      Width = 346
      Height = 22
      TabStop = False
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
      Alignment = taLeftJustify
    end
    object chkPedImp: TCheckBox
      Left = 491
      Top = 10
      Width = 129
      Height = 17
      Caption = 'Pedido de Importa'#231#227'o'
      TabOrder = 1
      OnClick = chkPedImpClick
    end
    object edtQtdCtn: TEditFocus
      Tag = 99
      Left = 571
      Top = 29
      Width = 46
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 4
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtNumPed: TEditFocus
      Left = 741
      Top = 5
      Width = 46
      Height = 22
      TabStop = False
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
      Alignment = taRightJustify
    end
    object edtEmpDestino: TEditFocus
      Left = 741
      Top = 29
      Width = 46
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      Alignment = taRightJustify
    end
    object edtDesAdi: TEditFocus
      Tag = 99
      Left = 589
      Top = 52
      Width = 44
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 9
      OnEnter = edtDesAdiEnter
      OnExit = edtDesAdiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
      Alignment = taRightJustify
    end
  end
  object pnlItens: TPanel [4]
    Left = 0
    Top = 81
    Width = 792
    Height = 91
    Align = alTop
    Color = 16770261
    TabOrder = 4
    object Label5: TLabel
      Left = 52
      Top = 25
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 171
      Top = 25
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 613
      Top = 25
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 16
      Top = 49
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 166
      Top = 49
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vr. Unitario:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 315
      Top = 49
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 48
      Top = 72
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = '% IPI:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 181
      Top = 72
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor IPI:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 335
      Top = 72
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = '% Sub:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 468
      Top = 72
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Sub:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 77
      Top = 18
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 2
      OnChange = edtCodIteChange
      OnEnter = edtCodIteEnter
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 226
      Top = 18
      Width = 375
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 57
      TabOrder = 3
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtCodUni: TEditFocus
      Tag = 99
      Left = 657
      Top = 18
      Width = 45
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 4
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 77
      Top = 41
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 5
      OnEnter = edtQtdIteEnter
      OnExit = edtQtdIteExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
      Alignment = taRightJustify
    end
    object edtUnitar: TEditFocus
      Tag = 99
      Left = 226
      Top = 41
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 6
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      Alignment = taRightJustify
    end
    object edtValTot: TEditFocus
      Tag = 99
      Left = 373
      Top = 41
      Width = 78
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 7
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
      Alignment = taRightJustify
    end
    object edtPerIpi: TEditFocus
      Tag = 99
      Left = 77
      Top = 64
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 8
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
      Alignment = taRightJustify
    end
    object edtTotIpi: TEditFocus
      Tag = 99
      Left = 226
      Top = 64
      Width = 78
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 9
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
      Alignment = taRightJustify
    end
    object edtPerSub: TEditFocus
      Tag = 99
      Left = 373
      Top = 64
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 10
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
      Alignment = taRightJustify
    end
    object edtTotSub: TEditFocus
      Tag = 99
      Left = 522
      Top = 64
      Width = 78
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 11
      OnEnter = edtCodIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
      Alignment = taRightJustify
    end
    object rdbCodIte: TRadioButton
      Left = 77
      Top = 4
      Width = 113
      Height = 14
      Caption = 'C'#243'digo do Item'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rdbCodIteClick
    end
    object rdbCodFab: TRadioButton
      Left = 229
      Top = 4
      Width = 113
      Height = 14
      Caption = 'C'#243'digo da F'#225'brica'
      TabOrder = 1
      OnClick = rdbCodFabClick
    end
  end
  object Panel3: TPanel [5]
    Left = 0
    Top = 172
    Width = 792
    Height = 291
    Align = alClient
    TabOrder = 5
    object dbgItens: TDBGridCitel
      Left = 1
      Top = 1
      Width = 790
      Height = 191
      Align = alClient
      DataSource = frmModuloSPR.dtsTemporaria
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDblClick = dbgItensDblClick
      OnEnter = dbgItensEnter
      OnExit = dbgItensExit
      OnKeyDown = dbgItensKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'ITE_CODITE'
          Title.Caption = 'C'#243'digo'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_DESITE'
          Title.Caption = 'Descri'#231#227'o'
          Width = 187
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtde.'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_SIGUNI'
          Title.Caption = 'UN'
          Width = 29
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_LITROS'
          Title.Caption = 'Litrag.'
          Width = 50
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_UNITAR'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr. Unit'#225'rio'
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_TOTITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Total'
          Width = 91
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_PERIPI'
          Title.Alignment = taRightJustify
          Title.Caption = '% IPI'
          Width = 45
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_TOTIPI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor IPI'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_PERSUB'
          Title.Alignment = taRightJustify
          Title.Caption = '% SUB'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_TOTSUB'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor SUB'
          Width = 76
          Visible = True
        end>
    end
    object pnlVendas: TPanel
      Left = 1
      Top = 215
      Width = 790
      Height = 75
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 1
      object lblVendas: TLabel
        Left = 14
        Top = 3
        Width = 41
        Height = 14
        Caption = 'Vendas:'
      end
      object lblMes01: TLabel
        Left = 56
        Top = 3
        Width = 42
        Height = 14
        Caption = 'lblMes01'
        Visible = False
      end
      object lblMes02: TLabel
        Left = 112
        Top = 3
        Width = 42
        Height = 14
        Caption = 'lblMes02'
        Visible = False
      end
      object lblMes03: TLabel
        Left = 168
        Top = 3
        Width = 42
        Height = 14
        Caption = 'lblMes03'
        Visible = False
      end
      object lblMes04: TLabel
        Left = 224
        Top = 3
        Width = 42
        Height = 14
        Caption = 'lblMes04'
        Visible = False
      end
      object lblMes05: TLabel
        Left = 280
        Top = 3
        Width = 42
        Height = 14
        Caption = 'lblMes05'
        Visible = False
      end
      object lblMes06: TLabel
        Left = 336
        Top = 3
        Width = 42
        Height = 14
        Caption = 'lblMes06'
        Visible = False
      end
      object lblMes07: TLabel
        Left = 56
        Top = 38
        Width = 42
        Height = 14
        Caption = 'lblMes07'
        Visible = False
      end
      object lblMes08: TLabel
        Left = 112
        Top = 38
        Width = 42
        Height = 14
        Caption = 'lblMes08'
        Visible = False
      end
      object lblMes09: TLabel
        Left = 168
        Top = 38
        Width = 42
        Height = 14
        Caption = 'lblMes09'
        Visible = False
      end
      object lblMes10: TLabel
        Left = 224
        Top = 38
        Width = 42
        Height = 14
        Caption = 'lblMes10'
        Visible = False
      end
      object lblMes11: TLabel
        Left = 280
        Top = 38
        Width = 42
        Height = 14
        Caption = 'lblMes11'
        Visible = False
      end
      object lblMes12: TLabel
        Left = 336
        Top = 38
        Width = 42
        Height = 14
        Caption = 'lblMes12'
        Visible = False
      end
      object lblSugest: TLabel
        Left = 509
        Top = 37
        Width = 46
        Height = 14
        Caption = 'Sugest'#227'o'
      end
      object lblSaldos: TLabel
        Left = 580
        Top = 37
        Width = 27
        Height = 14
        Caption = 'Saldo'
      end
      object lblMes: TLabel
        Left = 649
        Top = 37
        Width = 20
        Height = 14
        Caption = 'Mes'
      end
      object lblMedia: TLabel
        Left = 438
        Top = 37
        Width = 28
        Height = 14
        Caption = 'Media'
      end
      object lblQtdPen: TLabel
        Left = 718
        Top = 37
        Width = 65
        Height = 14
        Caption = 'Qtd Pendente'
      end
      object Label24: TLabel
        Left = 439
        Top = 0
        Width = 61
        Height = 14
        Caption = 'Maior Venda'
      end
      object Label25: TLabel
        Left = 509
        Top = 0
        Width = 22
        Height = 14
        Caption = 'Data'
      end
      object dbeMes01: TDBEditFocus
        Left = 56
        Top = 16
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 0
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes02: TDBEditFocus
        Left = 112
        Top = 16
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 1
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes04: TDBEditFocus
        Left = 224
        Top = 16
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 3
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes03: TDBEditFocus
        Left = 168
        Top = 16
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 2
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes06: TDBEditFocus
        Left = 336
        Top = 16
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 5
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes05: TDBEditFocus
        Left = 280
        Top = 16
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 4
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes07: TDBEditFocus
        Left = 56
        Top = 51
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 6
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes08: TDBEditFocus
        Left = 112
        Top = 51
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 7
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes10: TDBEditFocus
        Left = 224
        Top = 51
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 9
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes09: TDBEditFocus
        Left = 168
        Top = 51
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 8
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes12: TDBEditFocus
        Left = 336
        Top = 51
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 11
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes11: TDBEditFocus
        Left = 280
        Top = 51
        Width = 54
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 10
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMes: TDBEditFocus
        Left = 648
        Top = 49
        Width = 68
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSaldos: TDBEditFocus
        Left = 578
        Top = 49
        Width = 68
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSugest: TDBEditFocus
        Left = 508
        Top = 49
        Width = 68
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtValMedia: TEditFocus
        Left = 438
        Top = 49
        Width = 68
        Height = 22
        TabStop = False
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 15
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taRightJustify
      end
      object dbeQtdPen: TDBEditFocus
        Left = 718
        Top = 49
        Width = 68
        Height = 22
        TabStop = False
        DataSource = frmModuloSPR.dtsTemporaria
        Enabled = False
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtMaQtSa: TEditFocus
        Left = 438
        Top = 15
        Width = 68
        Height = 22
        TabStop = False
        Enabled = False
        ReadOnly = True
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taRightJustify
      end
      object edtMaDtSa: TEditFocus
        Left = 509
        Top = 15
        Width = 68
        Height = 22
        TabStop = False
        Enabled = False
        ReadOnly = True
        TabOrder = 18
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taRightJustify
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 192
      Width = 790
      Height = 23
      Align = alBottom
      Color = 16770261
      TabOrder = 2
      object Label23: TLabel
        Left = 7
        Top = 4
        Width = 28
        Height = 14
        Caption = 'Item:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDescricao: TLabel
        Left = 56
        Top = 4
        Width = 59
        Height = 14
        Caption = 'lblDescricao'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object Panel4: TPanel [6]
    Left = 0
    Top = 463
    Width = 792
    Height = 27
    Align = alBottom
    Color = 16770261
    TabOrder = 6
    object Label13: TLabel
      Left = 7
      Top = 7
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'TOTAIS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 239
      Top = 7
      Width = 13
      Height = 14
      Alignment = taRightJustify
      Caption = 'IPI:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 349
      Top = 7
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'ITENS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 478
      Top = 7
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'SUB+IPI+ITENS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 650
      Top = 7
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'LITRAGEM:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 119
      Top = 7
      Width = 24
      Height = 14
      Alignment = taRightJustify
      Caption = 'SUB:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtValTotIpi: TEditFocus
      Left = 256
      Top = 2
      Width = 80
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taRightJustify
    end
    object edtValTotIte: TEditFocus
      Left = 385
      Top = 2
      Width = 80
      Height = 22
      TabStop = False
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
      Alignment = taRightJustify
    end
    object edtValTotGer: TEditFocus
      Left = 555
      Top = 2
      Width = 80
      Height = 22
      TabStop = False
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
      Alignment = taRightJustify
    end
    object edtLitragem: TEditFocus
      Left = 708
      Top = 2
      Width = 80
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taRightJustify
    end
    object edtValTotSub: TEditFocus
      Left = 147
      Top = 2
      Width = 80
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taRightJustify
    end
  end
  object Panel5: TPanel [7]
    Left = 0
    Top = 490
    Width = 792
    Height = 51
    Align = alBottom
    Color = 16770261
    TabOrder = 7
    object lblStatus: TLabel
      Left = 8
      Top = 3
      Width = 282
      Height = 16
      Caption = 'Pressione [ENTER] para digitar a quantidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnSairPedido: TBitBtn
      Left = 685
      Top = 23
      Width = 102
      Height = 22
      Caption = '[ Esc ] Sair'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnSairPedidoClick
    end
    object btnConfirma: TBitBtn
      Left = 3
      Top = 23
      Width = 88
      Height = 22
      Caption = '[ F10 ] Confirma'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnApaga: TBitBtn
      Left = 181
      Top = 23
      Width = 88
      Height = 22
      Caption = '[ DEL ] Apaga'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnClick = btnApagaClick
    end
    object btnEstoque: TBitBtn
      Left = 270
      Top = 23
      Width = 117
      Height = 22
      Caption = '[ F6 ] Estoque das lojas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnClick = btnEstoqueClick
    end
    object btnLitragem: TBitBtn
      Left = 92
      Top = 23
      Width = 88
      Height = 22
      Caption = '[ F5 ] Litragem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnLitragemClick
    end
    object btnPedidosPend: TBitBtn
      Left = 389
      Top = 23
      Width = 131
      Height = 22
      Caption = '[ F7 ] Pedidos Pendentes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Visible = False
      OnClick = btnPedidosPendClick
    end
    object btnEditarItem: TBitBtn
      Left = 523
      Top = 23
      Width = 110
      Height = 22
      Caption = '[ F8 ] Editar Item'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = btnEditarItemClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 736
    Top = 104
  end
end
