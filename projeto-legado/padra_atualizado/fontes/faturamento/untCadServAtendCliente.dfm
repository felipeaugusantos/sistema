inherited frmCadServAtendCliente: TfrmCadServAtendCliente
  Left = 196
  Top = 176
  Width = 652
  Height = 700
  Caption = 'Servi'#231'o de Atendimento ao Cliente '
  OnDestroy = FormDestroy
  ExplicitWidth = 652
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 630
    Width = 646
    Height = 25
    TabOrder = 1
    ExplicitTop = 630
    ExplicitWidth = 646
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 564
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 564
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Height = 21
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 80
        Height = 21
        ExplicitWidth = 80
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 566
      Width = 78
      Height = 21
      Align = alRight
      ExplicitLeft = 566
      ExplicitWidth = 78
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 655
    Width = 646
    TabOrder = 3
    ExplicitTop = 655
    ExplicitWidth = 646
    inherited pnlNomeForm: TPanel
      Left = 299
      ExplicitLeft = 299
      object ComboBoxFocus1: TComboBoxFocus
        Left = 156
        Top = 16
        Width = 145
        Height = 22
        TabOrder = 0
        Text = 'ComboBoxFocus1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    inherited pnlInfo: TPanel
      Width = 299
      ExplicitWidth = 299
    end
  end
  inherited pgcDados: TPageControl
    Width = 646
    Height = 630
    Visible = False
    ExplicitWidth = 646
    ExplicitHeight = 630
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 638
      ExplicitHeight = 598
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 646
    Height = 630
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lbl1: TColorLabel
      Left = 20
      Top = 12
      Width = 113
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo do Atendimento:'
      CorDestaque = clRed
    end
    object lblDtaAtn: TColorLabel
      Left = 211
      Top = 12
      Width = 65
      Height = 14
      Caption = 'Data do SAC:'
      CorDestaque = clRed
    end
    object lblCliente: TColorLabel
      Left = 98
      Top = 35
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      CorDestaque = clRed
    end
    object lblVendedor: TColorLabel
      Left = 34
      Top = 58
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador/Vendedor:'
      CorDestaque = clRed
    end
    object lbProduto: TColorLabel
      Left = 93
      Top = 104
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
      CorDestaque = clRed
    end
    object lblQtdIte: TColorLabel
      Left = 14
      Top = 196
      Width = 119
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade de Produtos:'
      CorDestaque = clRed
    end
    object lblDescPro: TColorLabel
      Left = 19
      Top = 242
      Width = 114
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o do Problema:'
      CorDestaque = clRed
    end
    object lblDescSol: TColorLabel
      Left = 24
      Top = 383
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o da Solu'#231#227'o:'
      CorDestaque = clRed
    end
    object lblDescRes: TColorLabel
      Left = 17
      Top = 605
      Width = 116
      Height = 14
      Alignment = taRightJustify
      Caption = 'Resp. pelo Atendimento:'
      CorDestaque = clRed
    end
    object lblDepVen: TLabel
      Left = 63
      Top = 219
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object ColorLabel1: TColorLabel
      Left = 22
      Top = 81
      Width = 111
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo de Atendimento:'
      CorDestaque = clRed
    end
    object lbNumLot: TColorLabel
      Left = 109
      Top = 150
      Width = 24
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lote:'
      CorDestaque = clRed
    end
    object ColorLabel3: TColorLabel
      Left = 429
      Top = 357
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Status SAC:'
      CorDestaque = clRed
    end
    object ColorLabel4: TColorLabel
      Left = 104
      Top = 515
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'A'#231#227'o:'
      CorDestaque = clRed
    end
    object lblResolvidoEm: TColorLabel
      Left = 493
      Top = 582
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Resolvido Em:'
      CorDestaque = clRed
    end
    object lbLoteProducao: TColorLabel
      Left = 10
      Top = 172
      Width = 123
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lote Ordem de Produ'#231#227'o:'
      CorDestaque = clRed
    end
    object lblDtaSol: TColorLabel
      Left = 364
      Top = 12
      Width = 95
      Height = 14
      Caption = 'Data de Solicita'#231#227'o:'
      CorDestaque = clRed
    end
    object lblCodTpa: TColorLabel
      Left = 33
      Top = 127
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Atendimento:'
      CorDestaque = clRed
    end
    object dbeCodSac: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 8
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_CODSAC'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeQtdIte: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 192
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_QTDITE'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodCli: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 31
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_CODCLI'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 3
      OnKeyPress = dbeCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeCodVen: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 54
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_CODVEN'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
      OnKeyPress = dbeCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 100
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_CODITE'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 9
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeCodRes: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 601
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_CODREP'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 25
      OnKeyPress = dbeCodResKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object mmoDesPro: TDBMemoFocus
      Tag = 99
      Left = 136
      Top = 238
      Width = 500
      Height = 112
      DataField = 'SAC_DESPRB'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 18
      OnKeyPress = mmoDesProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object mmoDesSol: TDBMemoFocus
      Tag = 99
      Left = 136
      Top = 380
      Width = 500
      Height = 112
      DataField = 'SAC_DESSOL'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 20
      OnKeyPress = mmoDesSolKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object chkProRes: TDBCheckBox
      Tag = 99
      Left = 136
      Top = 582
      Width = 281
      Height = 17
      Caption = 'Marque aqui caso o Problema tenha sido Resolvido.'
      Color = 16770261
      DataField = 'SAC_RSLPRO'
      DataSource = dtsCadSac
      ParentColor = False
      TabOrder = 23
      ValueChecked = 'R'
      ValueUnchecked = 'N'
      OnClick = chkProResClick
    end
    object dbeNomCli: TDBEditFocus
      Left = 202
      Top = 31
      Width = 434
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'SAC_NOMCLI'
      DataSource = dtsCadSac
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TDBEditFocus
      Left = 202
      Top = 54
      Width = 434
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'SAC_NOMVEN'
      DataSource = dtsCadSac
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TDBEditFocus
      Left = 202
      Top = 100
      Width = 434
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'SAC_DESITE'
      DataSource = dtsCadSac
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomRes: TDBEditFocus
      Left = 202
      Top = 601
      Width = 434
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'SAC_NOMREP'
      DataSource = dtsCadSac
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaAtn: TDBEditFocus
      Tag = 99
      Left = 282
      Top = 8
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_DTAATN'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesDep: TEditFocus
      Left = 202
      Top = 215
      Width = 434
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodDep: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 215
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_CODDEP'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 16
      OnKeyPress = dbeCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeMotAte: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 77
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_CODMOT'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 7
      OnKeyPress = dbeMotAteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesMot: TEditFocus
      Left = 202
      Top = 77
      Width = 434
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
    object dbeNumLot: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 146
      Width = 177
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_NUMLOT'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 13
      OnKeyPress = dbeNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object btnArquivosDeSac: TBitBtnLocked
      Left = 136
      Top = 350
      Width = 133
      Height = 30
      Caption = 'Arquivos de SAC'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FF92635DA46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769A46769A46769A46769A46769A46769A46769A46769FF00FFFF
        00FFFF00FFFF00FFFF00FF93655EF2D9B0F2D7ABF0D4A9F0D1A5EFD1A1F0CF9E
        EFCE9CEFCB98EECA95EDC992EDC78FEDC68EEDC58BEBC488EBC286EBC184EBC0
        829F6F60FF00FFFF00FFFF00FFFF00FFFF00FF93655FF3DAB5F2D8B0F2D7ADF2
        D5AAF0D3A5EFD1A3EFD09FEFCE9DEFCC99EFCB97EDCA93EEC991EDC68EEBC58B
        EBC489EBC287EBC2869F6F60FF00FFFF00FFFF00FFFF00FFFF00FF93655FF4DD
        BAF3DAB6008100008100F2D5AAF0D4A7811E00811E00811E00811E00811E0081
        1E00811E00811E00811E00EDC58AEDC4889F6F60FF00FFFF00FFFF00FFFF00FF
        FF00FF93655FF4E0BDF3DEBB008100008100F3D8B0F2D5ACF0D4A9F2D3A4F0D1
        A1EFCF9FEFCE9CEECC98EECA96EEC992EDC990EDC68CEDC58B9F6F60FF00FFFF
        00FFFF00FFFF00FFFF00FF654441A79A86A69882A6977FA5967EA5957BA59378
        A59276A59173A59072A48F6EA48E6CA38C6AA38B68A18A66A18965A18862A188
        606C4C41FF00FFFF00FFFF00FF004B00004B00004B00004B00004B00004B0000
        4B00004B00004B00004B00004B00004B00004B00004B00004B00004B00004B00
        004B00004B00004B00004B00004B00004B00FF00FF004B00FF00FF986963F7E6
        CCF7E5C9F6E2C5F6E1C1F4DEBFF4DDBAF3DCB6F3D9B2F2D7AFF2D5ABF0D4A9F0
        D3A4F0D0A1EFCF9EEFCE9AEFCB98EECB969F6F60FF00FF004B00FF00FF004B00
        FF00FF9E6E64F8E9D0F7E6CE004B00004B00F6E2C2F4E0BF004B00004B00004B
        00004B00004B00004B00004B00004B00004B00EFCE9CEECC999F6F60FF00FF00
        4B00FF00FF004B00FF00FFA37266FAEBD7F8EAD3004B00004B00F6E3C7F6E2C4
        F4E0C0F4DEBCF3DCB8F3DCB5F2D8B1F2D7ADF2D4AAF0D3A6F0D1A4F0D0A0EFCE
        9D9F6F60FF00FF004B00FF00FF004B00FF00FF724F46AAA195A99F91A79E8FA9
        9E8EA99D8BA79A89A79A86A79983A79881A6977FA6967BA59379A59377A59175
        A59072A48F70A48F6D6C4C42FF00FF004B00FF00FF004B00004B00004A000049
        00004800004800004900004A00004B00004B00004B00004B00004B00004B0000
        4B00004B00004B00004B00004B00004B00004B00004B00004B00FF00FFFF00FF
        FF00FFA77766DED7CAD4CCBFD4CABBDCD1C1EBE0CAF4E6CFF7E9CFF7E6CAF6E3
        C7F4E2C4F4E0C0F4DEBCF4DCB8F3DCB5F3D9B1F2D7ADF0D5AAA07264FF00FFFF
        00FFFF00FFFF00FFFF00FFA1735FBFBAB0ABA59C005800006200DDD1C1F0E3D0
        801E00811E00811E00811E00811E00811E00811E00811E00811E00F3D9B2F3D8
        AFA07264FF00FFFF00FFFF00FFFF00FFFF00FF004B00004B00004B00004B0000
        5600CEC5B6E7DCCBF0E5D1F6E7D1F6E7D0F7E6CEF7E5CAF6E3C6F6E1C2F4E0BF
        F3DEBBF4DCB6F3D9B4A07264FF00FFFF00FFFF00FFFF00FFFF00FF004B000895
        1106900E004B0098938BB8B0A6CEC5B8DDD4C2EBE1CEF6E9D3F8EAD3F7E7CEF7
        E6CBF6E3C6F6E1C4F6E0C0F4DEBCF3DDB8A07264FF00FFFF00FFFF00FFFF00FF
        FF00FF004B000C9D190A9814004B008A888198938CA7A198BFB6AADDD4C4F2E6
        D4F8EBD7F8EAD3F8E9D0F7E6CCF6E5C9F6E2C5F4E1C1F4E0BDA07264FF00FFFF
        00FF004B00004B00004B00004B0011A6240EA11D004B00004B00004B00004B00
        ABA59CD5CCC1F0E6D7F8EDD9FAEDD8F8EAD5F8E9D1F7E6CCF6E5CAF6E3C6F6E1
        C1A07264FF00FFFF00FF004B0025C74720C1401CBA3818B23014AC2911A5220D
        A01C0A9A17004B005814006E19007D1D00801E00811E00811E00811E00811E00
        811E00F7E6CAF6E3C6A07264FF00FFFF00FF004B002CD35528CC4D23C5451FBF
        3E1BB73517B02E13AB2710A520004B00BFBBB4DEDAD0F3EDE0FBF2E3FBF0E1FA
        EFDDF8EDDAF8EBD7F8EAD3F7E9CFF7E6CBA07264FF00FFFF00FF004B00004B00
        004B00004B0027CB4B22C443004B00004B00004B00004B00E0DCD7EFEAE2FAF3
        E9FBF4E9FBF2E5FAF2E2FBEFE0FAEEDAF8EBD8F8EAD4F7E7D0A07264FF00FFFF
        00FFFF00FFFF00FFFF00FF004B002DD45829CF52004B00AAA9A7D0CFCCEBE9E5
        F6F2EDFAF6EFFBF6EEFCF6EDFCF4E9FBF2E6FAF0E2FAEFE0FAEEDDFAEDD8F8EA
        D4A07264FF00FFFF00FFFF00FFFF00FFFF00FF004B0034DE6530D95E004B009D
        6B4FB77E5CC98965CE8C67CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68
        CF8E68CF8E68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FF004B00004B
        00004B00004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentFont = False
      TabOrder = 27
      WordWrap = True
      OnClick = btnArquivosDeSacClick
    end
    object cmbStatusSac: TDBComboBoxFocus
      Tag = 99
      Left = 491
      Top = 354
      Width = 145
      Height = 22
      DataField = 'SAC_STATUS'
      DataSource = dtsCadSac
      Items.Strings = (
        'Procede'
        'N'#227'o Procede')
      TabOrder = 19
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkPlanoAcao: TDBCheckBox
      Tag = 99
      Left = 136
      Top = 493
      Width = 153
      Height = 17
      Caption = 'Precisa abrir Plano de A'#231#227'o'
      Color = 16770261
      DataField = 'SAC_PLACAO'
      DataSource = dtsCadSac
      ParentColor = False
      TabOrder = 21
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = chkPlanoAcaoClick
    end
    object dbeAcao: TDBMemoFocus
      Tag = 99
      Left = 136
      Top = 511
      Width = 500
      Height = 66
      DataField = 'SAC_TXTPLA'
      DataSource = dtsCadSac
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 22
      OnKeyPress = mmoDesSolKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object dbeResolvidoEm: TDBEditFocus
      Tag = 99
      Left = 563
      Top = 578
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_RESOLV'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 24
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLoteProducao: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 169
      Width = 177
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_LTEPRD'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaSol: TDBEditFocus
      Tag = 99
      Left = 464
      Top = 8
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_DTASOL'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodTpa: TDBEditFocus
      Tag = 99
      Left = 136
      Top = 123
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SAC_CODTPA'
      DataSource = dtsCadSac
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 11
      OnKeyPress = dbeCodTpaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesTpa: TEditFocus
      Left = 202
      Top = 123
      Width = 434
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 359
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 192
  end
  object dtsCadSac: TDataSource
    OnStateChange = dtsCadSacStateChange
    Left = 326
    Top = 192
  end
end
