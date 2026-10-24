inherited frmConsultaFatItem: TfrmConsultaFatItem
  VertScrollBar.Range = 245
  Caption = 'Consulta Itens'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 282
  end
  inherited pnlBotoes: TPanel
    inherited btnSair: TBitBtnLocked
      Left = 664
      Top = 3
      ExplicitLeft = 664
      ExplicitTop = 3
    end
  end
  object pnlDadosItem: TPanel [4]
    Left = 0
    Top = 282
    Width = 780
    Height = 64
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object Label3: TLabel
      Left = 8
      Top = 13
      Width = 30
      Height = 14
      Caption = 'Saldo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblSalRes: TLabel
      Left = 124
      Top = 13
      Width = 86
      Height = 14
      Caption = 'Saldo Reservado:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object dbeIteAti: TDBText
      Left = 617
      Top = 13
      Width = 50
      Height = 14
      AutoSize = True
      DataField = 'ITE_ITEATI'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPreCus: TLabel
      Left = 297
      Top = 13
      Width = 62
      Height = 14
      Caption = 'Pre'#231'o Custo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 447
      Top = 13
      Width = 78
      Height = 14
      Caption = 'Dias n'#227'o vende:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object dbeSaldos: TDBEditFocus
      Left = 43
      Top = 7
      Width = 75
      Height = 22
      DataField = 'ITE_SALDOS'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreCus: TDBEditFocus
      Left = 364
      Top = 7
      Width = 75
      Height = 22
      DataField = 'ITE_PRECUS'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus2: TDBEditFocus
      Left = 531
      Top = 7
      Width = 75
      Height = 22
      DataField = 'ULTVEN'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtSalRes: TEditFocus
      Left = 216
      Top = 7
      Width = 76
      Height = 22
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnPedSalRes: TBitBtnLocked
      Left = 254
      Top = 37
      Width = 238
      Height = 23
      Caption = '[ F7 ] Mostra Pedidos de Saldos Reservado'
      TabOrder = 3
      Visible = False
      OnClick = btnPedSalResClick
    end
    object btnSimilares: TBitBtnLocked
      Left = 498
      Top = 37
      Width = 180
      Height = 23
      Caption = '[ F8 ] Similares'
      TabOrder = 5
      Visible = False
      OnClick = btnSimilaresClick
    end
    object btnMostraEstoque: TBitBtnLocked
      Left = 71
      Top = 37
      Width = 180
      Height = 23
      Caption = '[ F6 ] Mostra Estoque das Lojas'
      TabOrder = 1
      Visible = False
      OnClick = btnMostraEstoqueClick
    end
  end
end
