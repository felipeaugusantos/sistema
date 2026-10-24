inherited frmPreparaGeracaoTEEdicao: TfrmPreparaGeracaoTEEdicao
  Width = 797
  Height = 396
  Caption = 'Preparador para Gera'#231#227'o de Transfer'#234'ncia de Estoque'
  ExplicitWidth = 797
  ExplicitHeight = 396
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 323
    Width = 791
    TabOrder = 3
    ExplicitTop = 323
    ExplicitWidth = 791
    inherited FlwBotoes: TFlowPanel
      Width = 787
      ExplicitWidth = 787
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 150
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnPedCompGrid: TBitBtnLocked
        Left = 150
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F12 ] Ped. Compra (Grid)'
        TabOrder = 1
        OnClick = btnPedCompGridClick
      end
      object btnCadLoteSubItem: TBitBtnLocked
        Left = 300
        Top = 0
        Width = 150
        Height = 22
        Caption = 'Cadastro Lote Sub-Itens'
        Enabled = False
        TabOrder = 2
        Visible = False
        OnClick = btnCadLoteSubItemClick
      end
      object btnVisualizarSubItens: TBitBtnLocked
        Left = 450
        Top = 0
        Width = 150
        Height = 22
        Caption = 'Visualizar Sub-Itens'
        TabOrder = 3
        Visible = False
        OnClick = btnVisualizarSubItensClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 710
      Top = 2
      Cancel = False
      ModalResult = 0
      ExplicitLeft = 710
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 351
    Width = 791
    TabOrder = 4
    ExplicitTop = 351
    ExplicitWidth = 791
    inherited pnlNomeForm: TPanel
      Left = 620
      ExplicitLeft = 620
    end
    inherited pnlInfo: TPanel
      Width = 620
      ExplicitWidth = 620
    end
  end
  object pnlProduto: TPanel [2]
    Left = 0
    Top = 0
    Width = 791
    Height = 113
    Align = alTop
    BevelOuter = bvLowered
    Caption = 'pnlProduto'
    ParentColor = True
    TabOrder = 0
    object Label7: TLabel
      Left = 26
      Top = 15
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
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
      Left = 69
      Top = 11
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 159
      Top = 11
      Width = 388
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object Panel3: TPanel
      Left = 1
      Top = 35
      Width = 789
      Height = 77
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel3'
      Enabled = False
      ParentColor = True
      TabOrder = 2
      object Label1: TLabel
        Left = 9
        Top = 8
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 552
        Top = 8
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
      object Label3: TLabel
        Left = 32
        Top = 31
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 6
        Top = 54
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
      object dbeRefere: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 4
        Width = 478
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'REFERE'
        DataSource = dtsItem
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
      object DBEditFocus1: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 27
        Width = 712
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'DESMAR'
        DataSource = dtsItem
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
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus2: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 50
        Width = 712
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'NOMFOR'
        DataSource = dtsItem
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
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus3: TDBEditFocus
        Tag = 99
        Left = 597
        Top = 4
        Width = 183
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'SIGUNI'
        DataSource = dtsItem
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlEmprersa: TPanel [3]
    Left = 0
    Top = 113
    Width = 791
    Height = 110
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 1
    object Label5: TLabel
      Left = 19
      Top = 12
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa Origem:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 7
      Top = 35
      Width = 94
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estoque Dispon'#237'vel:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 17
      Top = 58
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa Destino:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNumLot: TLabel
      Left = 571
      Top = 12
      Width = 24
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lote:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 7
      Top = 83
      Width = 94
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estoque Dispon'#237'vel:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtEmpOri: TEditFocus
      Tag = 99
      Left = 103
      Top = 8
      Width = 106
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnExit = edtEmpOriExit
      OnKeyPress = edtEmpOriKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpOri: TEditFocus
      Left = 211
      Top = 8
      Width = 336
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
    object edtSaldos: TEditFocus
      Tag = 99
      Left = 103
      Top = 31
      Width = 106
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtEmpDes: TEditFocus
      Tag = 99
      Left = 103
      Top = 54
      Width = 106
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnExit = edtEmpDesExit
      OnKeyPress = edtEmpDesKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpDes: TEditFocus
      Left = 211
      Top = 54
      Width = 570
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
    object edtNumLot: TEditFocus
      Tag = 99
      Left = 598
      Top = 8
      Width = 184
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 1
      OnKeyPress = edtNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttAlfanumerico
    end
    object edtSaldoDestino: TEditFocus
      Tag = 99
      Left = 103
      Top = 79
      Width = 106
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 223
    Width = 791
    Height = 100
    Align = alClient
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 2
    object Label9: TLabel
      Left = 24
      Top = 13
      Width = 220
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade j'#225' cadastrada para transfer'#234'ncia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQtdTra: TLabel
      Left = 129
      Top = 36
      Width = 115
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade a transferir:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCriticaTexoParte1: TLabel
      Left = 24
      Top = 60
      Width = 674
      Height = 14
      Alignment = taRightJustify
      Caption = 
        'Aten'#231#227'o! J'#225' existe uma quantidade cadastrada para transfer'#234'ncia ' +
        'na empresa origem e destino informadas. Ao confirmar, '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblCriticaTexoParte2: TLabel
      Left = 24
      Top = 77
      Width = 310
      Height = 14
      Alignment = taRightJustify
      Caption = 'o sistema ir'#225' sobrepor a solicita'#231#227'o feita anteriormente.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object edtQtdCad: TEditFocus
      Tag = 99
      Left = 246
      Top = 9
      Width = 106
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
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
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdTra: TEditFocus
      Tag = 99
      Left = 246
      Top = 32
      Width = 106
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      OnExit = edtQtdTraExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 720
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 744
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 648
    Top = 200
  end
  object dtsItem: TDataSource
    Left = 568
    Top = 208
  end
end
