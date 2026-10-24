inherited frmCtpAtribPortador: TfrmCtpAtribPortador
  Left = 286
  Top = 180
  Width = 1273
  Height = 621
  BorderStyle = bsSingle
  Caption = 'Alterar Dados de Duplicatas - Contas a Pagar'
  WindowState = wsMaximized
  ExplicitWidth = 1273
  ExplicitHeight = 621
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 550
    Width = 1267
    Height = 26
    ExplicitTop = 550
    ExplicitWidth = 1267
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 1186
      Height = 22
      ExplicitWidth = 1186
      ExplicitHeight = 22
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
      object btnConfirma: TBitBtnLocked
        Left = 280
        Top = 0
        Width = 140
        Height = 22
        Caption = '[F10] Confirma'
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
        OnClick = btnConfirmaClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 420
        Top = 0
        Width = 140
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
        Left = 560
        Top = 0
        Width = 140
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
      object btnHistDocumentos: TBitBtnLocked
        Left = 700
        Top = 0
        Width = 111
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
      Left = 1188
      Top = 2
      Align = alRight
      ExplicitLeft = 1188
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 576
    Width = 1267
    ExplicitTop = 576
    ExplicitWidth = 1267
    inherited pnlNomeForm: TPanel
      Left = 1096
      ExplicitLeft = 1096
    end
    inherited pnlInfo: TPanel
      Width = 1096
      ExplicitWidth = 1096
    end
  end
  inherited pnlHeader: TPanel
    Width = 1267
    Height = 247
    TabOrder = 7
    ExplicitWidth = 1267
    ExplicitHeight = 247
    object Label1: TLabel
      Left = 49
      Top = 47
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lblCodEmp: TLabel
      Left = 63
      Top = 93
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object ColorLabel2: TColorLabel
      Left = 572
      Top = 22
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object Label11: TLabel
      Left = 479
      Top = 22
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Veio Boleto?:'
    end
    object Label4: TLabel
      Left = 496
      Top = 46
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque?:'
    end
    object ColorLabel1: TColorLabel
      Left = 572
      Top = 46
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 496
      Top = 70
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Veio NF?:'
    end
    object ColorLabel3: TColorLabel
      Left = 572
      Top = 70
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object Label6: TLabel
      Left = 491
      Top = 93
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Previs'#227'o?:'
    end
    object ColorLabel4: TColorLabel
      Left = 572
      Top = 93
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object Label7: TLabel
      Left = 491
      Top = 116
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dep'#243'sito?:'
    end
    object ColorLabel5: TColorLabel
      Left = 572
      Top = 116
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object Label8: TLabel
      Left = 64
      Top = 140
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label9: TLabel
      Left = 474
      Top = 140
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Original:'
    end
    object Label10: TLabel
      Left = 54
      Top = 164
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico 1:'
    end
    object Label12: TLabel
      Left = 54
      Top = 188
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico 2:'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 111
      Top = 43
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 1
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
      Left = 184
      Top = 43
      Width = 284
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 111
      Top = 89
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 4
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
      Left = 184
      Top = 89
      Width = 284
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCheque: TEditFocus
      Tag = 99
      Left = 544
      Top = 42
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 12
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtVeioNF: TEditFocus
      Tag = 99
      Left = 544
      Top = 65
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 13
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtDeposito: TEditFocus
      Tag = 99
      Left = 544
      Top = 111
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 15
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object btnCarrContas: TBitBtnLocked
      Left = 568
      Top = 221
      Width = 115
      Height = 23
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
      TabOrder = 18
      OnClick = btnCarrContasClick
    end
    object edtVeiobo: TEditFocus
      Tag = 99
      Left = 544
      Top = 15
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 11
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtPrevisao: TEditFocus
      Tag = 99
      Left = 544
      Top = 88
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 14
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object pnlPeriodo: TPanel
      Left = 54
      Top = 208
      Width = 504
      Height = 38
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 17
      object Label3: TLabel
        Left = 145
        Top = 12
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = 'a'
      end
      object Label2: TLabel
        Left = 8
        Top = 12
        Width = 39
        Height = 14
        Alignment = taRightJustify
        Caption = 'Per'#237'odo:'
      end
      object rdgPeriodo: TRadioGroup
        Left = 249
        Top = 1
        Width = 248
        Height = 34
        Caption = 'Filtrar por:'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Vencimento'
          'Cadastro'
          'Baixa')
        TabOrder = 2
      end
      object mskDtaFin: TcxDateEdit
        Tag = 99
        Left = 155
        Top = 9
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
      object mskDtaIni: TcxDateEdit
        Tag = 99
        Left = 50
        Top = 9
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
        TabOrder = 0
        Width = 90
      end
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 17
      Top = 66
      Width = 460
      Height = 22
      TabOrder = 3
      ExplicitLeft = 17
      ExplicitTop = 66
      ExplicitWidth = 460
      inherited lblEventos: TLabel
        Width = 87
        Height = 14
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Width = 70
        Height = 22
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 167
        Width = 284
        Height = 22
        Enabled = True
        ExplicitLeft = 167
        ExplicitWidth = 284
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 39
      Top = 112
      Width = 442
      Height = 22
      TabOrder = 6
      ExplicitLeft = 39
      ExplicitTop = 112
      ExplicitWidth = 442
      inherited lblPlaContas: TLabel
        Left = 4
        Width = 66
        Height = 14
        Caption = 'Plano Contas:'
        ExplicitLeft = 4
        ExplicitWidth = 66
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 145
        Width = 284
        Height = 22
        ExplicitLeft = 145
        ExplicitWidth = 284
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 72
        Width = 70
        Height = 22
        OnExit = fraPlanoDeContasMskCodCtaExit
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 72
        ExplicitWidth = 70
        ExplicitHeight = 22
      end
    end
    object rdgStatus: TRadioGroup
      Left = 110
      Top = 4
      Width = 358
      Height = 33
      Caption = ' Status '
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Abertas'
        'Baixadas')
      TabOrder = 0
      OnClick = rdgStatusClick
    end
    object edtCodPort: TEditFocus
      Tag = 99
      Left = 111
      Top = 136
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 7
      OnKeyPress = edtCodPortKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPort: TEditFocus
      Left = 184
      Top = 135
      Width = 284
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtHist1: TEditFocus
      Tag = 99
      Left = 111
      Top = 160
      Width = 357
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtHist2: TEditFocus
      Tag = 99
      Left = 111
      Top = 184
      Width = 357
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtVlrOrig: TCurrencyEditFocus
      Tag = 99
      Left = 544
      Top = 136
      Margins.Left = 4
      Margins.Top = 1
      EditValue = 0.000000000000000000
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '0.00;-0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 124
    end
  end
  inherited pnlTail: TPanel
    Top = 534
    Width = 1267
    Height = 0
    TabOrder = 2
    ExplicitTop = 534
    ExplicitWidth = 1267
    ExplicitHeight = 0
  end
  inherited dbgConsulta: TDBGridCitel
    Left = 8
    Top = 280
    Width = 1267
    Height = 131
    Align = alNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
    TabOrder = 3
    Visible = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CTP_NUMDUP'
        Title.Caption = 'Duplicata'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_SERIE_'
        Title.Caption = 'S'#233'rie'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_CODEMP'
        Title.Caption = 'Emp.'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_CODFOR'
        Title.Caption = 'Fornec.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_NOMFOR'
        Title.Caption = 'Nome do Fornecedor'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_DTACAD'
        Title.Caption = 'Cadastro'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_DTAVEN'
        Title.Caption = 'Vencimento'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_CODPOR'
        Title.Caption = 'Portador'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_CODEVE'
        Title.Caption = 'Ctr. Custos'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_CODCTA'
        Title.Caption = 'Plano de Contas'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_VEIOBO'
        Title.Caption = 'Veio Boleto?'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_VEIONF'
        Title.Caption = 'Veio NF?'
        Width = 61
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_USACHQ'
        Title.Caption = 'Cheque'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_PREVIS'
        Title.Caption = 'Previs'#227'o'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_DEPOSI'
        Title.Caption = 'Dep'#243'sito'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTP_VALORI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Original'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTP_JURSUJ'
        Title.Alignment = taRightJustify
        Title.Caption = 'Juros'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTP_MULSUJ'
        Title.Alignment = taRightJustify
        Title.Caption = 'Multa'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_VENDOR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vendor'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTP_DESSUJ'
        Title.Alignment = taRightJustify
        Title.Caption = 'Desconto'
        Width = 60
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 247
    Width = 1267
    TabOrder = 4
    ExplicitTop = 247
    ExplicitWidth = 1267
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtValor: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
  end
  object prbProgresso: TProgressBar [6]
    Left = 0
    Top = 534
    Width = 1267
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 5
    Visible = False
  end
  object grdConsulta: TcxGrid [7]
    Left = 0
    Top = 287
    Width = 1267
    Height = 247
    Align = alClient
    TabOrder = 6
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdConsultaDBTableView1: TcxGridDBTableView
      OnDblClick = dbgConsultaDblClick
      OnKeyDown = grdConsultaDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdConsultaDBTableView1CustomDrawCell
      DataController.DataSource = dtsConsulta
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.HideSelection = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object grdConsultaDBTableView1CTP_NUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'CTP_NUMDUP'
        Width = 90
      end
      object grdConsultaDBTableView1CTP_SERIE_: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'CTP_SERIE_'
        Width = 35
      end
      object grdConsultaDBTableView1CTP_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CTP_CODEMP'
        Width = 35
      end
      object grdConsultaDBTableView1CTP_CODFOR: TcxGridDBColumn
        Caption = 'Fornec.'
        DataBinding.FieldName = 'CTP_CODFOR'
        Width = 55
      end
      object grdConsultaDBTableView1CTP_NOMFOR: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'CTP_NOMFOR'
        Width = 150
      end
      object grdConsultaDBTableView1CTP_DTACAD: TcxGridDBColumn
        Caption = 'Cadastro'
        DataBinding.FieldName = 'CTP_DTACAD'
        Width = 62
      end
      object grdConsultaDBTableView1CTP_DTAVEN: TcxGridDBColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'CTP_DTAVEN'
        Width = 70
      end
      object grdConsultaDBTableView1CTP_CODPOR: TcxGridDBColumn
        Caption = 'Portador'
        DataBinding.FieldName = 'CTP_CODPOR'
        Width = 47
      end
      object grdConsultaDBTableView1CTP_CODEVE: TcxGridDBColumn
        Caption = 'Ctr. Custos'
        DataBinding.FieldName = 'CTP_CODEVE'
        Width = 59
      end
      object grdConsultaDBTableView1CTP_CODCTA: TcxGridDBColumn
        Caption = 'Plano de Contas'
        DataBinding.FieldName = 'CTP_CODCTA'
        Width = 100
      end
      object grdConsultaDBTableView1CTP_VEIOBO: TcxGridDBColumn
        Caption = 'Veio Boleto?'
        DataBinding.FieldName = 'CTP_VEIOBO'
        Width = 70
      end
      object grdConsultaDBTableView1CTP_VEIONF: TcxGridDBColumn
        Caption = 'Veio NF?'
        DataBinding.FieldName = 'CTP_VEIONF'
        Width = 61
      end
      object grdConsultaDBTableView1CTP_USACHQ: TcxGridDBColumn
        Caption = 'Cheque'
        DataBinding.FieldName = 'CTP_USACHQ'
        Width = 55
      end
      object grdConsultaDBTableView1CTP_PREVIS: TcxGridDBColumn
        Caption = 'Previs'#227'o'
        DataBinding.FieldName = 'CTP_PREVIS'
        Width = 60
      end
      object grdConsultaDBTableView1CTP_DEPOSI: TcxGridDBColumn
        Caption = 'Dep'#243'sito'
        DataBinding.FieldName = 'CTP_DEPOSI'
        Width = 48
      end
      object grdConsultaDBTableView1CTP_VALORI: TcxGridDBColumn
        Caption = 'Valor Original'
        DataBinding.FieldName = 'CTP_VALORI'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object grdConsultaDBTableView1CTP_JURSUJ: TcxGridDBColumn
        Caption = 'Juros'
        DataBinding.FieldName = 'CTP_JURSUJ'
        HeaderAlignmentHorz = taRightJustify
        Width = 60
      end
      object grdConsultaDBTableView1CTP_MULSUJ: TcxGridDBColumn
        Caption = 'Multa'
        DataBinding.FieldName = 'CTP_MULSUJ'
        HeaderAlignmentHorz = taRightJustify
        Width = 60
      end
      object grdConsultaDBTableView1CTP_VENDOR: TcxGridDBColumn
        Caption = 'Vendor'
        DataBinding.FieldName = 'CTP_VENDOR'
        Width = 60
      end
      object grdConsultaDBTableView1CTP_DESSUJ: TcxGridDBColumn
        Caption = 'Desconto'
        DataBinding.FieldName = 'CTP_DESSUJ'
        HeaderAlignmentHorz = taRightJustify
        Width = 60
      end
      object grdConsultaDBTableView1CTP_PORBAI: TcxGridDBColumn
        Caption = 'Port. Baixa'
        DataBinding.FieldName = 'CTP_PORBAI'
        Width = 75
      end
      object grdConsultaDBTableView1CTP_HIST01: TcxGridDBColumn
        Caption = 'Hist'#243'rico 1'
        DataBinding.FieldName = 'CTP_HIST01'
        Width = 300
      end
      object grdConsultaDBTableView1CTP_HIST02: TcxGridDBColumn
        Caption = 'Hist'#243'rico 2'
        DataBinding.FieldName = 'CTP_HIST02'
        Width = 300
      end
      object grdConsultaDBTableView1AUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
      end
      object grdConsultaDBTableView1TABELA: TcxGridDBColumn
        DataBinding.FieldName = 'TABELA'
        Visible = False
      end
    end
    object grdConsultaLevel1: TcxGridLevel
      GridView = grdConsultaDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 724
    Top = 12
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1032
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1088
    Top = 16
  end
  inherited qryConsulta: TUniQuery
    Left = 920
    Top = 80
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 804
    Top = 4
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 844
    Top = 76
  end
  inherited dtsConsulta: TDataSource
    Left = 884
    Top = 12
  end
end
