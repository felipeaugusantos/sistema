inherited frmCancelamentoDocumentos: TfrmCancelamentoDocumentos
  Left = 238
  Top = 221
  Width = 880
  Height = 380
  BorderIcons = [biSystemMenu]
  Caption = 'Cancelamento de Documentos'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 880
  ExplicitHeight = 380
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 309
    Width = 874
    Height = 26
    Enabled = True
    ParentCtl3D = False
    TabOrder = 4
    TabStop = True
    Visible = True
    ExplicitTop = 309
    ExplicitWidth = 874
    ExplicitHeight = 26
    DesignSize = (
      874
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 870
      Height = 22
      ExplicitWidth = 870
      ExplicitHeight = 22
      object btnEstornoCtr: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 127
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Estorno Cta. Rec.'
        Enabled = False
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
        TabOrder = 0
        OnClick = btnEstornoCtrClick
      end
      object btnEstorno: TBitBtnLocked
        Left = 127
        Top = 0
        Width = 127
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'E&storno Cta. Pag.'
        Enabled = False
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
        TabOrder = 1
        OnClick = btnEstornoClick
      end
      object btnPendentesDeCancelamento: TBitBtnLocked
        Left = 254
        Top = 0
        Width = 159
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'Pend'#234'ncias de Cancelamento'
        TabOrder = 2
        Visible = False
        OnClick = btnPendentesDeCancelamentoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 794
      Top = 2
      ExplicitLeft = 794
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 335
    Width = 874
    ExplicitTop = 335
    ExplicitWidth = 874
    inherited pnlNomeForm: TPanel
      Left = 703
      ExplicitLeft = 703
    end
    inherited pnlInfo: TPanel
      Width = 703
      ExplicitWidth = 703
    end
  end
  inherited pgcDados: TPageControl
    Left = 417
    Width = 457
    Height = 309
    Visible = False
    ExplicitLeft = 417
    ExplicitWidth = 457
    ExplicitHeight = 309
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 449
      ExplicitHeight = 277
    end
  end
  object pnlEspecies: TPanel [3]
    Left = 0
    Top = 0
    Width = 417
    Height = 309
    Align = alLeft
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lsbEspecies: TListBox
      Left = 1
      Top = 1
      Width = 415
      Height = 307
      Align = alClient
      Color = 16776176
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 17
      ParentFont = False
      TabOrder = 0
      OnDblClick = lsbEspeciesDblClick
      OnKeyDown = lsbEspeciesKeyDown
    end
  end
  object pnlGeral: TPanel [4]
    Left = 417
    Top = 0
    Width = 457
    Height = 309
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlDadosDoc: TPanel
      Left = 1
      Top = 1
      Width = 455
      Height = 82
      Align = alTop
      Color = 16770261
      Enabled = False
      ParentBackground = False
      TabOrder = 0
      object lblDocumento: TLabel
        Left = 52
        Top = 12
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
      end
      object lblCliFor: TLabel
        Left = 9
        Top = 34
        Width = 100
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente / Fornecedor:'
      end
      object lblSerie: TLabel
        Left = 229
        Top = 12
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'S'#233'rie:'
        Visible = False
      end
      object lblTitPes: TColorLabel
        Left = 325
        Top = 12
        Width = 107
        Height = 14
        Caption = '(C)liente (F)ornecedor'
        Visible = False
        CorDestaque = clRed
      end
      object edtCliFor: TEditFocus
        Tag = 99
        Left = 111
        Top = 30
        Width = 86
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 3
        OnKeyPress = edtCliForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesCri: TEditFocus
        Left = 199
        Top = 30
        Width = 232
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
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 111
        Top = 7
        Width = 86
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttAlfanumerico
      end
      object edtSerie: TEditFocus
        Tag = 99
        Left = 260
        Top = 7
        Width = 38
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 1
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTipPes: TEditFocus
        Tag = 99
        Left = 304
        Top = 7
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 2
        Text = 'C'
        Visible = False
        OnExit = edtTipPesExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object btnAdicionar: TBitBtnLocked
        Left = 203
        Top = 54
        Width = 111
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
        TabOrder = 6
        OnClick = btnAdicionarClick
      end
      object btnCancelar: TBitBtnLocked
        Left = 309
        Top = 54
        Width = 111
        Height = 22
        Caption = 'C&ancela'
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
        TabOrder = 7
        OnClick = btnCancelarClick
      end
      object chkInutilizacao: TCheckBox
        Left = 8
        Top = 58
        Width = 163
        Height = 17
        Caption = 'Inutiliza'#231#227'o'
        TabOrder = 5
        Visible = False
      end
    end
    object pnlInfoArq: TPanel
      Left = 1
      Top = 83
      Width = 455
      Height = 225
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lblCadIte: TLabel
        Left = 53
        Top = 13
        Width = 123
        Height = 18
        Caption = 'Cadastro de Itens'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lblItensNota: TLabel
        Left = 51
        Top = 45
        Width = 91
        Height = 18
        Caption = 'Itens da Nota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lblDadosNota: TLabel
        Left = 51
        Top = 78
        Width = 157
        Height = 18
        Caption = 'Dados Gerais da Nota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object RxLabel3: TLabel
        Left = 51
        Top = 111
        Width = 127
        Height = 18
        Caption = 'Contas a Receber'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object RxLabel4: TLabel
        Left = 51
        Top = 144
        Width = 80
        Height = 18
        Caption = 'Livro Fiscal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object RxLabel5: TLabel
        Left = 50
        Top = 177
        Width = 110
        Height = 18
        Caption = 'Contas a Pagar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object imgCadItens: TImage
        Left = 15
        Top = 5
        Width = 32
        Height = 32
        Transparent = True
      end
      object imgItensNota: TImage
        Left = 15
        Top = 38
        Width = 32
        Height = 32
        Transparent = True
      end
      object imgDadosNota: TImage
        Left = 15
        Top = 71
        Width = 32
        Height = 32
        Transparent = True
      end
      object imgCtaReceber: TImage
        Left = 15
        Top = 104
        Width = 32
        Height = 32
        Transparent = True
      end
      object imgCtaPagar: TImage
        Left = 15
        Top = 170
        Width = 32
        Height = 32
        Transparent = True
      end
      object imgLivroFiscal: TImage
        Left = 15
        Top = 137
        Width = 32
        Height = 32
        Transparent = True
      end
      object imgAlterado: TImage
        Left = 240
        Top = 38
        Width = 32
        Height = 32
        AutoSize = True
        Picture.Data = {
          055449636F6E0000010001002020040000000000E80200001600000028000000
          2000000040000000010004000000000000020000000000000000000000000000
          0000000000000000000080000080000000808000800000008000800080800000
          C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF0000000000000000888888800000000000000000000008888888888888
          0000000000000000088800000008888888000000000000008000222222200088
          8880000000000000022222222222220088880000000000022222222222222222
          0888800000000022222222222222222220888800000002222222222222222222
          2208880000002222222222222222222222208880000022222222227F72222222
          2220888000022222222227FFF2222222222208800002222222227FFFF7222222
          22220888000222222227FFFFFF2222222222088800222222227FFF7FFF722222
          222220880022222227FFF72FFFF2222222222088002222222FFF7227FFF72222
          222220880022222222222222FFFF22222222208800222222222222227FFF7222
          2222208800222222222222222FFFF22222222080002222222222222227FFF722
          22222080000222222222222222FFFF22222208800002222222222222227FFF72
          222208000002222222222222222FFFF222220800000022222222222222222222
          2220800000002222222222222222222222200000000002222222222222222222
          2200000000000022222222222222222220000000000000022222222222222222
          0000000000000000022222222222220000000000000000000000222222200000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FFFC07FFFFE000FFFF80003FFF00001FFE00000FFC000007F8000003
          F0000003E0000001E0000001C0000001C0000000C00000008000000080000000
          8000000080000000800000008000000180000001C0000001C0000003C0000003
          E0000007E000000FF000001FF800003FFC00007FFE0000FFFF8003FFFFF01FFF
          FFFFFFFF}
        Transparent = True
        Visible = False
      end
      object imgNaoAlterado: TImage
        Left = 280
        Top = 38
        Width = 32
        Height = 32
        AutoSize = True
        Picture.Data = {
          055449636F6E0000010001002020040000000000E80200001600000028000000
          2000000040000000010004000000000000020000000000000000000000000000
          0000000000000000000080000080000000808000800000008000800080800000
          C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF0000000000000000888888800000000000000000000008888888888888
          0000000000000000088800000008888888000000000000008000999999900088
          8880000000000000099999999999990088880000000000099999999999999999
          0888800000000099999999999999999990888800000009999999999999999999
          9908880000019999999999999999999999908880000199999999999999999999
          9990888000199999999999999999999999990880001999999999999999999999
          9999088800199999999999999999999999990888019999999999999999999999
          999990880199999999999999999999999999908801999FFFFFFFFFFFFFFFFFFF
          FF99908801999FFFFFFFFFFFFFFFFFFFFF99908801999FFFFFFFFFFFFFFFFFFF
          FF99908801999999999999999999999999999080019999999999999999999999
          9999908000199999999999999999999999990880001999999999999999999999
          9999080000199999999999999999999999990800000199999999999999999999
          9990800000019999999999999999999999900000000019999999999999999999
          9900000000000199999999999999999991000000000000199999999999999999
          1000000000000001199999999999991100000000000000000111999999911100
          0000000000000000000011111110000000000000000000000000000000000000
          00000000FFFC07FFFFE000FFFF80003FFF00001FFE00000FFC000007F8000003
          F0000003E0000001E0000001C0000001C0000000C00000008000000080000000
          8000000080000000800000008000000180000001C0000001C0000003C0000003
          E0000007E000000FF000001FF800003FFC00007FFE0000FFFF8003FFFFF01FFF
          FFFFFFFF}
        Transparent = True
        Visible = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 24
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 80
    Top = 48
  end
end
