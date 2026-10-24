inherited frmFatBaixaPedidoDev: TfrmFatBaixaPedidoDev
  Height = 590
  Caption = 'Baixa de Pedidos de Devolu'#231#227'o'
  ExplicitHeight = 590
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 507
    TabOrder = 5
    ExplicitTop = 507
    inherited FlwBotoes: TFlowPanel
      inherited btnPesquisar: TBitBtnLocked
        Width = 118
        ExplicitWidth = 118
      end
      object btnConfirma: TBitBtnLocked
        Left = 236
        Top = 0
        Width = 118
        Height = 23
        Caption = '[ F10 ] Confirma'
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
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 354
        Top = 0
        Width = 118
        Height = 22
        Caption = '[ F6 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 472
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F7 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 615
      Top = 2
      Width = 98
      ExplicitLeft = 615
      ExplicitTop = 2
      ExplicitWidth = 98
    end
  end
  inherited pnlHeader: TPanel
    Height = 73
    TabOrder = 1
    ExplicitHeight = 73
    object Label2: TLabel
      Left = 29
      Top = 17
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Emiss'#227'o:'
    end
    object Label3: TLabel
      Left = 185
      Top = 17
      Width = 6
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object Label1: TLabel
      Left = 77
      Top = 44
      Width = 35
      Height = 14
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 269
      Top = 16
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 114
      Top = 12
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnEnter = mskDtaIniEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 196
      Top = 12
      Width = 66
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 114
      Top = 40
      Width = 70
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
      TabOrder = 4
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
      Left = 185
      Top = 40
      Width = 472
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 316
      Top = 12
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 373
      Top = 12
      Width = 284
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  end
  inherited pnlTail: TPanel
    Top = 459
    TabOrder = 2
    ExplicitTop = 459
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 113
    Height = 346
    TabStop = False
    TabOrder = 3
    Columns = <
      item
        Expanded = False
        FieldName = 'DTAENT'
        Title.Caption = 'Emiss'#227'o'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMDOC'
        Title.Caption = 'Pedido'
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESPDOC'
        Title.Caption = 'Esp'#233'cie'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODEMP'
        Title.Caption = 'Empresa'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODVEN'
        Title.Caption = 'Vendedor'
        Width = 197
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPDEV'
        Title.Caption = 'Esp'#233'cie Doc. Dev.'
        Width = 100
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 73
    TabOrder = 4
    ExplicitTop = 73
  end
  inherited pnlStatus: TPanel
    Top = 535
    TabOrder = 0
    ExplicitTop = 535
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 24
  end
  inherited qryConsulta: TUniQuery
    Top = 200
  end
  inherited dspConsulta: TUniDataSetProvider
    Top = 200
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 192
    Top = 200
  end
  inherited dtsConsulta: TDataSource
    Top = 200
  end
end
