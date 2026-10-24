inherited frmManutencaoOrigemProdAcabados: TfrmManutencaoOrigemProdAcabados
  Width = 616
  Height = 477
  Caption = 'Manuten'#231#227'o da Origem de Produtos Acabados'
  Position = poMainFormCenter
  ExplicitWidth = 616
  ExplicitHeight = 477
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 404
    Width = 610
    ExplicitTop = 404
    ExplicitWidth = 610
    inherited FlwBotoes: TFlowPanel
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 527
      ExplicitLeft = 527
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 432
    Width = 610
    ExplicitTop = 432
    ExplicitWidth = 610
    inherited pnlNomeForm: TPanel
      Left = 439
      ExplicitLeft = 439
    end
    inherited pnlInfo: TPanel
      Width = 439
      ExplicitWidth = 439
    end
  end
  object grbSubProdAtual: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 610
    Height = 81
    Align = alTop
    Caption = ' Produto Acabado '
    TabOrder = 2
    object Label2: TLabel
      Left = 15
      Top = 28
      Width = 40
      Height = 14
      Caption = 'Produto:'
    end
    object Label8: TLabel
      Left = 15
      Top = 56
      Width = 56
      Height = 14
      Caption = 'Refer'#234'ncia:'
    end
    object Label9: TLabel
      Left = 181
      Top = 57
      Width = 64
      Height = 14
      Caption = 'Unid. Medida:'
    end
    object edtCodProdutoAcabado: TEditFocus
      Tag = 99
      Left = 61
      Top = 25
      Width = 51
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodProdutoAcabadoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomeProdutoAcabado: TEditFocus
      Left = 113
      Top = 25
      Width = 489
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
    object edtReferenciaAcabado: TEditFocus
      Tag = 99
      Left = 77
      Top = 51
      Width = 99
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      MaxLength = 4
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtUniMedidaAcabado: TEditFocus
      Tag = 99
      Left = 249
      Top = 51
      Width = 53
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      MaxLength = 4
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
  end
  object GroupBox1: TGroupBox [3]
    Left = 0
    Top = 81
    Width = 610
    Height = 104
    Align = alTop
    Caption = ' Origem '
    TabOrder = 3
    object Label1: TLabel
      Left = 12
      Top = 29
      Width = 84
      Height = 14
      Caption = 'Produto a Granel:'
    end
    object Label6: TLabel
      Left = 12
      Top = 53
      Width = 20
      Height = 14
      Caption = 'Cor:'
    end
    object Label10: TLabel
      Left = 12
      Top = 82
      Width = 56
      Height = 14
      Caption = 'Refer'#234'ncia:'
    end
    object Label11: TLabel
      Left = 203
      Top = 80
      Width = 64
      Height = 14
      Caption = 'Unid. Medida:'
    end
    object edtCodProdutoGranelOrigem: TEditFocus
      Tag = 99
      Left = 101
      Top = 24
      Width = 51
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 5
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomeProdutoGranelOrigem: TEditFocus
      Left = 153
      Top = 24
      Width = 449
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
    object edtNomeCorGranelOrigem: TEditFocus
      Left = 153
      Top = 49
      Width = 449
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
    object edtCodCorGranelOrigem: TEditFocus
      Tag = 99
      Left = 101
      Top = 49
      Width = 51
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 4
      ReadOnly = True
      TabOrder = 3
      OnKeyPress = edtCodCorGranelOrigemKeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtReferenciaGranelOrigem: TEditFocus
      Tag = 99
      Left = 101
      Top = 74
      Width = 97
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      MaxLength = 4
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtUniMedidaGranelOrigem: TEditFocus
      Tag = 99
      Left = 271
      Top = 74
      Width = 53
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      MaxLength = 4
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
  end
  object GroupBox2: TGroupBox [4]
    Left = 0
    Top = 265
    Width = 610
    Height = 66
    Align = alTop
    Caption = ' Origem '
    TabOrder = 6
    object Label3: TLabel
      Left = 12
      Top = 29
      Width = 102
      Height = 14
      Caption = 'Produto Composi'#231#227'o:'
    end
    object edtCodProdutoComposicaoOrigem: TEditFocus
      Tag = 99
      Left = 117
      Top = 25
      Width = 51
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 5
      ReadOnly = True
      TabOrder = 0
      OnExit = edtCodProdutoComposicaoOrigemExit
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomeProdutoComposicaoOrigem: TEditFocus
      Left = 169
      Top = 25
      Width = 433
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
  end
  object GroupBox3: TGroupBox [5]
    Left = 0
    Top = 185
    Width = 610
    Height = 80
    Align = alTop
    Caption = ' Novo'
    TabOrder = 4
    object Label4: TLabel
      Left = 12
      Top = 29
      Width = 84
      Height = 14
      Caption = 'Produto a Granel:'
    end
    object Label7: TLabel
      Left = 12
      Top = 53
      Width = 20
      Height = 14
      Caption = 'Cor:'
    end
    object edtCodProdutoGranelNovo: TEditFocus
      Tag = 99
      Left = 116
      Top = 25
      Width = 51
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodProdutoGranelNovoExit
      OnKeyPress = edtCodProdutoGranelNovoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomeProdutoGranelNovo: TEditFocus
      Left = 168
      Top = 25
      Width = 434
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
    object edtNomeCorGranelNovo: TEditFocus
      Left = 168
      Top = 52
      Width = 433
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
    object edtCodCorGranelNovo: TEditFocus
      Tag = 99
      Left = 116
      Top = 52
      Width = 51
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 4
      TabOrder = 3
      OnExit = edtCodCorGranelNovoExit
      OnKeyPress = edtCodCorGranelNovoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
  end
  object GroupBox4: TGroupBox [6]
    Left = 0
    Top = 331
    Width = 610
    Height = 66
    Align = alTop
    Caption = ' Novo '
    TabOrder = 5
    object Label5: TLabel
      Left = 12
      Top = 29
      Width = 102
      Height = 14
      Caption = 'Produto Composi'#231#227'o:'
    end
    object edtCodProdutoComposicaoNovo: TEditFocus
      Tag = 99
      Left = 117
      Top = 25
      Width = 51
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodProdutoComposicaoNovoExit
      OnKeyPress = edtCodProdutoComposicaoNovoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomeProdutoComposicaoNovo: TEditFocus
      Left = 169
      Top = 25
      Width = 433
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 576
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 568
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 488
    Top = 192
  end
end
