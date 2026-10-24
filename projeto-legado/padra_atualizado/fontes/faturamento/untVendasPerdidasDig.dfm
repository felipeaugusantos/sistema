inherited frmVendasPerdidasDig: TfrmVendasPerdidasDig
  Left = 218
  Top = 149
  Width = 1024
  Height = 768
  BorderStyle = bsSingle
  Caption = 'Vendas Perdidas'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 697
    Width = 1018
    Height = 26
    ExplicitTop = 697
    ExplicitWidth = 1018
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 894
      Height = 22
      ExplicitWidth = 894
      ExplicitHeight = 22
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 120
        ExplicitWidth = 120
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 120
        Width = 120
        ExplicitLeft = 120
        ExplicitWidth = 120
      end
      object btnGravar: TBitBtnLocked
        Left = 240
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F10] Confirmar'
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
      object btnExcVen: TBitBtnLocked
        Left = 360
        Top = 0
        Width = 121
        Height = 22
        Caption = 'E&xcluir toda venda'
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
        Visible = False
        OnClick = btnExcVenClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 896
      Top = 2
      Width = 120
      Align = alRight
      ModalResult = 2
      ExplicitLeft = 896
      ExplicitTop = 2
      ExplicitWidth = 120
    end
  end
  inherited pnlHeader: TPanel
    Width = 1018
    Height = 292
    ExplicitWidth = 1018
    ExplicitHeight = 292
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 1018
      Height = 89
      Align = alTop
      ParentColor = True
      TabOrder = 0
      object Label3: TLabel
        Left = 14
        Top = 61
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object lblCliFor: TLabel
        Left = 29
        Top = 38
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Label5: TLabel
        Left = 600
        Top = 15
        Width = 86
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data de cadastro:'
      end
      object Label6: TLabel
        Left = 8
        Top = 15
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sequencial:'
      end
      object Label7: TLabel
        Left = 136
        Top = 15
        Width = 240
        Height = 14
        Caption = '(Sequencial em branco inclui novo registro)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 606
        Top = 38
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = #218'ltima altera'#231#227'o:'
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 66
        Top = 34
        Width = 65
        Height = 22
        Hint = 'Pressione INSERT para inserir um novo cliente'
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 8
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnEnter = edtCodCliEnter
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
        Left = 132
        Top = 34
        Width = 460
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
      object edtSenVen: TEditFocus
        Tag = 99
        Left = 66
        Top = 57
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 10
        PasswordChar = '*'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomVen: TEditFocus
        Left = 132
        Top = 57
        Width = 460
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtCodigo: TEditFocus
        Tag = 99
        Left = 66
        Top = 11
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 6
        TabOrder = 0
        OnKeyPress = edtCodigoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object mskDtaCad: TMaskEditFocus
        Left = 690
        Top = 11
        Width = 80
        Height = 22
        TabStop = False
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        ReadOnly = True
        TabOrder = 5
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaAlt: TMaskEditFocus
        Left = 690
        Top = 34
        Width = 80
        Height = 22
        TabStop = False
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        ReadOnly = True
        TabOrder = 6
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 89
      Width = 1018
      Height = 203
      Align = alClient
      ParentColor = True
      TabOrder = 1
      object Label1: TLabel
        Left = 52
        Top = 13
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto:'
      end
      object Label2: TLabel
        Left = 34
        Top = 36
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label4: TLabel
        Left = 58
        Top = 59
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Motivo:'
      end
      object Label221: TLabel
        Left = 66
        Top = 134
        Width = 26
        Height = 14
        Alignment = taRightJustify
        Caption = 'Obs.:'
      end
      object Label12: TLabel
        Left = 170
        Top = 37
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vlr. Unit'#225'rio:'
      end
      object Label15: TLabel
        Left = 301
        Top = 37
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object btnAdicionar: TBitBtnLocked
        Left = 635
        Top = 132
        Width = 84
        Height = 22
        Caption = '&Confirma'
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
        TabOrder = 9
        OnClick = btnAdicionarClick
      end
      object btnCancelaItem: TBitBtnLocked
        Left = 635
        Top = 176
        Width = 84
        Height = 22
        Caption = 'C&ancelar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
          015603015603FF00FF0000820000820000820000820000820000820000820000
          820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
          27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
          30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
          FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
          0082000082000082000082000082000082000082000082000082FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
          00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
          0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
          50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
          5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
          8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 11
        OnClick = btnCancelaItemClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 635
        Top = 154
        Width = 84
        Height = 22
        Caption = '&Excluir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 10
        OnClick = btnExcluirClick
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 94
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
        Tag = 99
        Left = 160
        Top = 9
        Width = 460
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 87
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdIte: TEditFocus
        Tag = 99
        Left = 94
        Top = 32
        Width = 65
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtMotivo: TEditFocus
        Tag = 99
        Left = 160
        Top = 55
        Width = 460
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        MaxLength = 87
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
      object edtCodMot: TEditFocus
        Tag = 99
        Left = 94
        Top = 55
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 5
        OnKeyPress = edtCodMotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object memObserv: TMemoFocus
        Tag = 99
        Left = 95
        Top = 129
        Width = 526
        Height = 58
        ScrollBars = ssVertical
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object edtUnitar: TEditFocus
        Tag = 99
        Left = 230
        Top = 32
        Width = 65
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
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,####0.0000'
      end
      object edtTotIte: TEditFocus
        Tag = 99
        Left = 356
        Top = 32
        Width = 104
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,####0.00'
      end
      object pnlConcorrencia: TPanel
        Left = 2
        Top = 77
        Width = 629
        Height = 51
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 7
        Visible = False
        DesignSize = (
          629
          51)
        object Label9: TLabel
          Left = 5
          Top = 29
          Width = 85
          Height = 14
          Caption = 'Vr. Concorr'#234'ncia:'
        end
        object Label10: TLabel
          Left = 22
          Top = 6
          Width = 68
          Height = 14
          Caption = 'Concorr'#234'ncia:'
        end
        object edtCodCon: TEditFocus
          Tag = 99
          Left = 93
          Top = 3
          Width = 66
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtCodConKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesCon: TEditFocus
          Left = 161
          Top = 3
          Width = 457
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          Color = 16768952
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
        object edtVlrCon: TEditFocus
          Tag = 99
          Left = 93
          Top = 26
          Width = 88
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,####0.0000'
        end
      end
    end
  end
  inherited pnlTail: TPanel
    Top = 649
    Width = 1018
    ExplicitTop = 649
    ExplicitWidth = 1018
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 332
    Width = 1018
    Height = 317
    TabStop = False
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OnKeyDown = dbgConsultaKeyDown
    Zebra = True
    Columns = <
      item
        Expanded = False
        FieldName = 'VPD_CODITE'
        Title.Caption = 'C'#243'd.Item'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VPD_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 343
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VPD_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 98
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VPD_UNITAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vlr. Unit'#225'rio'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VPD_TOTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MOT_DESMOT'
        Title.Caption = 'Motivo'
        Width = 290
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNR_DESCON'
        Title.Caption = 'Concorr'#234'ncia'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VPD_VLRCON'
        Title.Caption = 'Vr. Concorr'#234'ncia'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 292
    Width = 1018
    ExplicitTop = 292
    ExplicitWidth = 1018
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
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 256
  end
  inherited qryConsulta: TUniQuery
    Top = 256
  end
  inherited dspConsulta: TUniDataSetProvider
    Top = 256
  end
  inherited cdsConsulta: TUniClientDataSet
    AfterScroll = cdsConsultaAfterScroll
    Top = 256
  end
  inherited dtsConsulta: TDataSource
    Top = 256
  end
end
