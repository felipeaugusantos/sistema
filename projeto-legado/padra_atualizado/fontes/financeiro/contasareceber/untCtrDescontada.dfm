inherited frmCtrDescontada: TfrmCtrDescontada
  Left = 291
  Top = 201
  Width = 1075
  Height = 511
  Caption = 
    'Altera'#231#227'o de Portador / Descontada / Centro de Custos / Plano de' +
    ' Contas - Contas a Receber'
  WindowState = wsMaximized
  ExplicitWidth = 1075
  ExplicitHeight = 511
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 428
    Width = 1059
    TabOrder = 7
    ExplicitTop = 428
    ExplicitWidth = 1059
    inherited FlwBotoes: TFlowPanel
      Width = 915
      ExplicitWidth = 915
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 140
        ExplicitWidth = 140
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 140
        Width = 140
        ExplicitLeft = 140
        ExplicitWidth = 140
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 280
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F7 ] Marca Todos'
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
        TabOrder = 2
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 420
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F8 ] Desmarca Todos'
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
        TabOrder = 3
        OnClick = btnDesmarcaTodosClick
      end
      object btnGravar: TBitBtnLocked
        Left = 560
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F10 ] Confirma'
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
        TabOrder = 4
        OnClick = btnGravarClick
      end
      object btnHistDocumentos: TBitBtnLocked
        Left = 700
        Top = 0
        Width = 140
        Height = 22
        Caption = '&Hist. Documentos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD4C00BD4C00
          BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C
          00BD4C00BD4C00BD4C00BD4C00FFF2E2FFEFDDFEEBD8811E00FEE6CBFEE2C6FE
          E0C0E3B08AFEDAB5FED8B0FFD5ABE3A97AFED1A3FECF9EBD4C00BD4C00FFF3E6
          FFF0E1FEEEDC811E00FEE9CFFFE5CAFEE2C4E3B18EFEDDB8FFD9B2FFD8AFE3AB
          7EFED3A5FED0A0BD4C00BD4C00FEF4EBFEF3E6FFF0E1811E00FEEAD4FFE6CEFE
          E3C9E5B490FEDEBCFFDAB7FED8B1E3AB80FED4A7FED1A3BD4C00BD4C00811E00
          811E00811E00811E00E5BDA3E5BCA0E3BA9EE3B899E5B695E5B590E3B28BE5B0
          88E3AD83E3AC81BD4C00BD4C00FFF8F2FFF7EEFFF3E7811E00FFEEDCFFEBD7FE
          E9D0E3B696FEE2C4FEE0BFFEDCB8E3AD86FFD8AFFED5AABD4C00BD4C00FFFBF4
          FFF8F0FEF6EB811E00FFF0E1FFEDDCFEEAD5E5B899FFE5C9FEE2C2FFE0BDE3B0
          88FED9B2FFD7ADBD4C00BD4C00FFFCF8FFFAF4FFF7EF811E00FFF3E5FFEFE0FE
          EDD9E5BA9DFFE7CEFFE3C7FFE1C1E3B18BFEDCB5FED8B1BD4C00BD4C00811E00
          811E00811E00811E00811E00811E00811E00811E00811E00811E00811E00811E
          00811E00811E00BD4C00BD4C00FFFFFEFFFCFAFFFBF6811E00FFF6EDFFF4E6FF
          F2E1811E00FFEBD7FFE9D0FEE6CA811E00FEE0BFFEDDB7BD4C00BD4C00FFFFFF
          FFFEFCFFFCF8811E00FFF8EFFFF4EAFEF3E5811E00FEEEDAFFEAD4FFE7CE811E
          00FFE1C2FEDEBCBD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD
          4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 5
        OnClick = btnHistDocumentosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 917
      Top = 2
      Width = 140
      Height = 24
      Align = alRight
      ExplicitLeft = 917
      ExplicitTop = 2
      ExplicitWidth = 140
      ExplicitHeight = 24
    end
  end
  inherited pnlHeader: TPanel
    Width = 1059
    Height = 79
    TabOrder = 0
    ExplicitWidth = 1059
    ExplicitHeight = 79
    object Label1: TLabel
      Left = 30
      Top = 13
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label4: TLabel
      Left = 20
      Top = 36
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lbl2: TLabel
      Left = 437
      Top = 35
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lbl3: TLabel
      Left = 29
      Top = 59
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object lbl9: TLabel
      Left = 445
      Top = 59
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regi'#227'o:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 70
      Top = 9
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 143
      Top = 9
      Width = 264
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 70
      Top = 32
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 3
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 143
      Top = 32
      Width = 264
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 486
      Top = 32
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 5
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPor: TEditFocus
      Left = 559
      Top = 32
      Width = 242
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 70
      Top = 55
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 7
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
      Left = 143
      Top = 55
      Width = 264
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
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 486
      Top = 55
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 9
      OnExit = edtCodRegExit
      OnKeyPress = edtCodRegKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesReg: TEditFocus
      Left = 559
      Top = 55
      Width = 242
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 422
      Top = 9
      Width = 386
      Height = 22
      TabOrder = 2
      ExplicitLeft = 422
      ExplicitTop = 9
      ExplicitWidth = 386
      inherited lblEventos: TLabel
        Left = 3
        Width = 56
        Height = 14
        Caption = 'Ctr. Custos:'
        ExplicitLeft = 3
        ExplicitWidth = 56
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Left = 64
        Width = 70
        Height = 22
        OnExit = fraCentroCustoedtCodEveExit
        ExplicitLeft = 64
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 137
        Width = 242
        Height = 22
        ExplicitLeft = 137
        ExplicitWidth = 242
        ExplicitHeight = 22
      end
    end
  end
  inherited pnlTail: TPanel
    Top = 373
    Width = 1059
    Height = 55
    Enabled = False
    TabOrder = 8
    Visible = True
    ExplicitTop = 373
    ExplicitWidth = 1059
    ExplicitHeight = 55
    object lbl4: TLabel
      Left = 19
      Top = 33
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lbl5: TLabel
      Left = 7
      Top = 9
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ctr. Custos:'
    end
    object lbl6: TLabel
      Left = 282
      Top = 9
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object lbl7: TLabel
      Left = 845
      Top = 9
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total dos Itens:'
    end
    object lbl8: TLabel
      Left = 802
      Top = 33
      Width = 143
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor dos Itens Selecionados:'
    end
    object lbl10: TLabel
      Left = 585
      Top = 9
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtde. Total dos Itens:'
    end
    object lbl11: TLabel
      Left = 542
      Top = 33
      Width = 144
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtde. dos Itens Selecionados:'
    end
    object dbedtDesEvento: TDBEdit
      Left = 67
      Top = 5
      Width = 209
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'CTR_DESEVE'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
    end
    object dbeNomPortador: TDBEdit
      Left = 67
      Top = 29
      Width = 209
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'CTR_NOMPOR'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
    end
    object dbeNomCidade: TDBEdit
      Left = 322
      Top = 5
      Width = 217
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'CTR_NOMCID'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
    end
    object edtTotGer: TEditFocus
      Left = 949
      Top = 5
      Width = 106
      Height = 22
      TabStop = False
      Alignment = taRightJustify
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
    object edtTotSel: TEditFocus
      Left = 949
      Top = 29
      Width = 106
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtQtdTotGer: TEditFocus
      Left = 690
      Top = 5
      Width = 106
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
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
    object edtQtdTotSel: TEditFocus
      Left = 690
      Top = 29
      Width = 106
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 197
    Width = 1059
    Height = 176
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    Visible = False
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'CTR_NUMDUP'
        Title.Caption = 'Duplicata'
        Width = 102
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_PARCEL'
        Title.Caption = 'Par.'
        Width = 26
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CODEMP'
        Title.Caption = 'Empresa'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_DTACAD'
        Title.Caption = 'Cadastro'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_DTAVEN'
        Title.Caption = 'Vencimento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CODCLI'
        Title.Caption = 'C'#243'd.Cliente'
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_DESCON'
        Title.Caption = 'Descontada'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_IMPBOL'
        Title.Caption = 'Bol?'
        Width = 32
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CTR_ENVBCO'
        Title.Caption = 'Enviado Banco?'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CODPOR'
        Title.Caption = 'Portador'
        Width = 49
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTR_VALDUP'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 63
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 157
    Width = 1059
    TabOrder = 4
    ExplicitTop = 157
    ExplicitWidth = 1059
    inherited lblPesquisa: TLabel
      Top = 12
      ExplicitTop = 12
    end
    inherited lblNomeCampo: TLabel
      Top = 12
      ExplicitTop = 12
    end
    inherited edtValor: TEditFocus
      Width = 97
      ExplicitWidth = 97
    end
  end
  object pnlFormasPagto: TPanel [6]
    Left = 0
    Top = 79
    Width = 1059
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 1
    object Label5: TLabel
      Left = 2
      Top = 3
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Forma Pagto:'
    end
    object edtCodFpg: TEditFocus
      Tag = 99
      Left = 70
      Top = 0
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
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
    object edtDesFpg: TEditFocus
      Left = 143
      Top = 0
      Width = 264
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
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 413
      Top = 0
      Width = 391
      Height = 22
      TabOrder = 1
      ExplicitLeft = 413
      ExplicitWidth = 391
      inherited lblPlaContas: TLabel
        Left = 2
        Width = 66
        Height = 14
        Caption = 'Plano Contas:'
        ExplicitLeft = 2
        ExplicitWidth = 66
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 146
        Width = 242
        Height = 22
        ExplicitLeft = 146
        ExplicitWidth = 242
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 73
        Width = 70
        Height = 22
        OnExit = fraPlanoDeContasMskCodCtaExit
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 73
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
    end
  end
  object pnlPeriodo: TPanel [7]
    Left = 0
    Top = 128
    Width = 1059
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label9: TLabel
      Left = 39
      Top = 8
      Width = 26
      Height = 14
      Caption = 'Filtro:'
    end
    object ColorLabel1: TColorLabel
      Left = 114
      Top = 9
      Width = 120
      Height = 14
      Caption = '(V)encimento (C)adastro'
      CorDestaque = clRed
    end
    object Label2: TLabel
      Left = 442
      Top = 7
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label3: TLabel
      Left = 581
      Top = 9
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'a'
    end
    object edtFiltro: TEditFocus
      Tag = 99
      Left = 70
      Top = 4
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 0
      Text = 'V'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 486
      Top = 2
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 592
      Top = 2
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 2
      Width = 90
    end
    object btnCarrTitulos: TBitBtnLocked
      Left = 688
      Top = 4
      Width = 114
      Height = 21
      Align = alCustom
      Caption = '&Carregar T'#237'tulos'
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
      TabOrder = 3
      OnClick = btnCarrTitulosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 456
    Width = 1059
    TabOrder = 9
    ExplicitTop = 456
    ExplicitWidth = 1059
    inherited pnlNomeForm: TPanel
      Left = 888
      ExplicitLeft = 888
    end
    inherited pnlInfo: TPanel
      Width = 888
      ExplicitWidth = 888
    end
  end
  object cxgConsulta: TcxGridCitel [9]
    Left = 0
    Top = 197
    Width = 1059
    Height = 176
    Align = alClient
    TabOrder = 6
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgConsultaTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgConsultaTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgConsultaTableViewCellDblClick
      OnCustomDrawCell = cxgConsultaTableViewCustomDrawCell
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.OnChanged = cxgConsultaTableViewDataControllerFilterChanged
      DataController.Filter.AutoDataSetFilter = True
      DataController.Filter.TranslateBetween = True
      DataController.Filter.TranslateLike = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.FocusRect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgConsultaTableViewCTR_NUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'CTR_NUMDUP'
        Width = 102
      end
      object cxgConsultaTableViewCTR_PARCEL: TcxGridDBColumn
        Caption = 'Par.'
        DataBinding.FieldName = 'CTR_PARCEL'
        Width = 26
      end
      object cxgConsultaTableViewCTR_ESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'CTR_ESPDOC'
        Width = 27
      end
      object cxgConsultaTableViewCTR_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CTR_CODEMP'
        Width = 48
      end
      object cxgConsultaTableViewCTR_DTACAD: TcxGridDBColumn
        Caption = 'Cadastro'
        DataBinding.FieldName = 'CTR_DTACAD'
        Width = 65
      end
      object cxgConsultaTableViewCTR_DTAVEN: TcxGridDBColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'CTR_DTAVEN'
        Width = 65
      end
      object cxgConsultaTableViewCTR_CODCLI: TcxGridDBColumn
        Caption = 'C'#243'd.Cliente'
        DataBinding.FieldName = 'CTR_CODCLI'
        Width = 59
      end
      object cxgConsultaTableViewCTR_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CTR_NOMCLI'
        Width = 124
      end
      object cxgConsultaTableViewCTR_DESCON: TcxGridDBColumn
        Caption = 'Descontada'
        DataBinding.FieldName = 'CTR_DESCON'
        Width = 70
      end
      object cxgConsultaTableViewCTR_IMPBOL: TcxGridDBColumn
        Caption = 'Bol?'
        DataBinding.FieldName = 'CTR_IMPBOL'
        Width = 32
      end
      object cxgConsultaTableViewCTR_ENVBCO: TcxGridDBColumn
        Caption = 'Enviado Banco?'
        DataBinding.FieldName = 'CTR_ENVBCO'
        Width = 90
      end
      object cxgConsultaTableViewCTR_CODPOR: TcxGridDBColumn
        Caption = 'Portador'
        DataBinding.FieldName = 'CTR_CODPOR'
        Width = 49
      end
      object cxgConsultaTableViewCTR_VALDUP: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'CTR_VALDUP'
        Width = 63
      end
      object cxgConsultaTableViewAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
      end
    end
    object cxgConsultaLevel: TcxGridLevel
      GridView = cxgConsultaTableView
    end
  end
  object pnlAuxiliar: TPanel [10]
    Left = 0
    Top = 103
    Width = 1059
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object Label8: TLabel
      Left = 15
      Top = 3
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodven: TEditFocus
      Tag = 99
      Left = 70
      Top = 0
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnExit = edtCodvenExit
      OnKeyPress = edtCodvenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 143
      Top = 0
      Width = 264
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 288
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 248
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 440
    Top = 240
  end
  inherited qryConsulta: TUniQuery
    Left = 128
    Top = 288
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 160
    Top = 288
  end
  inherited cdsConsulta: TUniClientDataSet
    FilterOptions = [foCaseInsensitive]
    Left = 192
    Top = 288
  end
  inherited dtsConsulta: TDataSource
    Left = 224
    Top = 288
  end
end
