inherited frmFatExclusaoVendasPerdidas: TfrmFatExclusaoVendasPerdidas
  Width = 968
  Height = 577
  Caption = 'Exclus'#227'o de Vendas Perdidas'
  ExplicitWidth = 968
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 494
    Width = 952
    ExplicitTop = 494
    ExplicitWidth = 952
    inherited FlwBotoes: TFlowPanel
      Width = 948
      ExplicitWidth = 948
      object btnGravar: TBitBtnLocked
        Left = 231
        Top = 0
        Width = 189
        Height = 22
        Caption = '[ F10 ] Apagar Vendas Perdidas'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnGravarClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 420
        Top = 0
        Width = 123
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
        Left = 543
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
      Left = 874
      ExplicitLeft = 874
    end
  end
  inherited pnlStatus: TPanel
    Top = 522
    Width = 952
    ExplicitTop = 522
    ExplicitWidth = 952
    inherited pnlNomeForm: TPanel
      Left = 781
      ExplicitLeft = 781
    end
    inherited pnlInfo: TPanel
      Width = 781
      ExplicitWidth = 781
    end
  end
  inherited pnlHeader: TPanel
    Width = 952
    Height = 114
    ExplicitWidth = 952
    ExplicitHeight = 114
    object Label2: TLabel
      Left = 583
      Top = 88
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dt. Cadastro:'
    end
    object Label3: TLabel
      Left = 716
      Top = 89
      Width = 9
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object lblLinGru: TLabel
      Left = 559
      Top = 13
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha/Grupo:'
    end
    object Label1: TLabel
      Left = 11
      Top = 63
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object lblProduto: TLabel
      Left = 21
      Top = 13
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label5: TLabel
      Left = 28
      Top = 88
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo:'
    end
    object lblFornecedor: TLabel
      Left = 2
      Top = 38
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label4: TLabel
      Left = 571
      Top = 38
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lblEmpresa: TLabel
      Left = 559
      Top = 63
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 650
      Top = 84
      Width = 61
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 7
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 731
      Top = 84
      Width = 63
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 625
      Top = 9
      Width = 48
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
      TabOrder = 1
      Text = ''
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 675
      Top = 9
      Width = 271
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 66
      Top = 59
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 4
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 133
      Top = 59
      Width = 422
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 66
      Top = 9
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 133
      Top = 9
      Width = 422
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodMot: TEditFocus
      Tag = 99
      Left = 66
      Top = 84
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 6
      OnKeyPress = edtCodMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesMot: TEditFocus
      Left = 133
      Top = 84
      Width = 272
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 87
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
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 66
      Top = 34
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 133
      Top = 34
      Width = 422
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 608
      Top = 34
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesMar: TEditFocus
      Left = 675
      Top = 34
      Width = 271
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnCarregarProdutos: TBitBtnLocked
      Left = 806
      Top = 85
      Width = 128
      Height = 21
      Align = alCustom
      Caption = '&Carregar Produtos'
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
      TabOrder = 15
      OnClick = btnCarregarProdutosClick
    end
    object edtDesEmp: TEditFocus
      Left = 675
      Top = 59
      Width = 271
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 608
      Top = 59
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 5
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlTail: TPanel
    Top = 461
    Width = 952
    Height = 33
    Visible = True
    ExplicitTop = 461
    ExplicitWidth = 952
    ExplicitHeight = 33
    object Label6: TLabel
      Left = 356
      Top = 9
      Width = 57
      Height = 14
      Caption = 'Documento:'
    end
    object Label7: TLabel
      Left = 555
      Top = 9
      Width = 67
      Height = 14
      Caption = 'Valor Unit'#225'rio:'
    end
    object Label8: TLabel
      Left = 765
      Top = 9
      Width = 62
      Height = 14
      Caption = 'Total do Item:'
    end
    object dbeDocume: TDBEditFocus
      Left = 415
      Top = 6
      Width = 120
      Height = 22
      DataField = 'DOCUME'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnitar: TDBEditFocus
      Left = 624
      Top = 6
      Width = 117
      Height = 22
      DataField = 'VPD_UNITAR'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTotIte: TDBEditFocus
      Left = 829
      Top = 6
      Width = 117
      Height = 22
      DataField = 'VPD_TOTITE'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 156
    Width = 952
    Height = 305
    Columns = <
      item
        Expanded = False
        FieldName = 'VPG_DTACAD'
        Title.Caption = 'Dt.Cadastro'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VPD_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VPD_DESITE'
        Title.Caption = 'Produto'
        Width = 364
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ITE_CODUNI'
        Title.Alignment = taCenter
        Title.Caption = 'UN'
        Width = 23
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VPD_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 68
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'VPG_CODVEN'
        Title.Alignment = taCenter
        Title.Caption = 'Vendedor'
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MOT_DESMOT'
        Title.Caption = 'Motivo'
        Width = 223
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VPG_CODEMP'
        Title.Caption = 'Empresa'
        Width = 57
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 114
    Width = 952
    Height = 42
    ExplicitTop = 114
    ExplicitWidth = 952
    ExplicitHeight = 42
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 624
    Top = 200
  end
  inherited qryConsulta: TUniQuery
    Left = 692
    Top = 216
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 768
    Top = 216
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 664
    Top = 236
  end
  inherited dtsConsulta: TDataSource
    Left = 596
    Top = 224
  end
end
