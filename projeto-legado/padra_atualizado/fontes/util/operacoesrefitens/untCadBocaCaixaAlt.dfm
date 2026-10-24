inherited frmCadBocaCaixaAlt: TfrmCadBocaCaixaAlt
  Left = 227
  Top = 199
  Width = 837
  Height = 542
  Caption = 'Altera'#231#227'o Global de Boca de Caixa'
  ExplicitWidth = 837
  ExplicitHeight = 542
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 470
    Width = 831
    TabOrder = 1
    ExplicitTop = 470
    ExplicitWidth = 831
    DesignSize = (
      831
      28)
    inherited btnSair: TBitBtnLocked
      Left = 748
      ExplicitLeft = 748
    end
    object btnGravar: TBitBtnLocked
      Left = 5
      Top = 4
      Width = 75
      Height = 20
      Caption = '&Gravar'
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
      TabOrder = 1
      OnClick = btnGravarClick
    end
  end
  object pnlDadosItem: TPanel [2]
    Left = 0
    Top = 0
    Width = 831
    Height = 233
    Align = alTop
    Color = 16770261
    TabOrder = 0
    OnEnter = pnlDadosItemEnter
    object Label4: TLabel
      Left = 3
      Top = 34
      Width = 85
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Produto:'
    end
    object Label9: TLabel
      Left = 20
      Top = 12
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 29
      Top = 79
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
    object Label11: TLabel
      Left = 55
      Top = 57
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
    object lblDescricao: TLabel
      Left = 7
      Top = 101
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 32
      Top = 144
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
    object Label12: TLabel
      Left = 424
      Top = 144
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
    object Label13: TLabel
      Left = 11
      Top = 123
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Final:'
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
      Left = 90
      Top = 26
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 1
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
      Left = 161
      Top = 26
      Width = 344
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtComVar: TEditFocus
      Tag = 99
      Left = 423
      Top = 200
      Width = 70
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPreMin: TEditFocus
      Tag = 99
      Left = 262
      Top = 200
      Width = 70
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 90
      Top = 4
      Width = 70
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = ''
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 161
      Top = 4
      Width = 344
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFornecedor: TEditFocus
      Tag = 99
      Left = 90
      Top = 70
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 3
      OnExit = edtFornecedorExit
      OnKeyPress = edtFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 161
      Top = 70
      Width = 256
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMarca: TEditFocus
      Tag = 99
      Left = 90
      Top = 48
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 2
      OnExit = edtMarcaExit
      OnKeyPress = edtMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMarca: TEditFocus
      Left = 161
      Top = 48
      Width = 256
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescriIni: TEditFocus
      Tag = 99
      Left = 90
      Top = 92
      Width = 327
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnExit = edtDescriIniExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Tag = 99
      Left = 90
      Top = 136
      Width = 327
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Tag = 99
      Left = 468
      Top = 136
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 7
      OnKeyPress = edtUnidadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescriFin: TEditFocus
      Tag = 99
      Left = 90
      Top = 114
      Width = 327
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object Panel1: TPanel
      Left = 0
      Top = 167
      Width = 827
      Height = 2
      BevelOuter = bvLowered
      TabOrder = 12
    end
    object rdgTipAlt: TRadioGroup
      Tag = 99
      Left = 8
      Top = 176
      Width = 153
      Height = 49
      Caption = 'Altera'#231#227'o por'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Fator'
        'Valor')
      TabOrder = 13
    end
    object chkPreMin: TCheckBox
      Tag = 99
      Left = 176
      Top = 208
      Width = 86
      Height = 17
      Caption = 'Pre'#231'o M'#237'nimo:'
      TabOrder = 14
      OnClick = chkPreMinClick
    end
    object chkComiss: TCheckBox
      Tag = 99
      Left = 352
      Top = 208
      Width = 71
      Height = 17
      Caption = 'Comiss'#227'o:'
      TabOrder = 16
      OnClick = chkComissClick
    end
    object btnConfirmar: TBitBtnLocked
      Left = 499
      Top = 200
      Width = 74
      Height = 22
      Caption = '&Carregar'
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
      OnClick = btnConfirmarClick
    end
  end
  object dbgItens: TDBGridCitel [3]
    Left = 0
    Top = 233
    Width = 831
    Height = 227
    Align = alClient
    DataSource = dtsBocCai
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'd. Item'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 290
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODEMP'
        Title.Caption = 'Emp'
        Width = 25
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PREATU'
        Title.Alignment = taRightJustify
        Title.Caption = 'Pre'#231'o M'#237'nimo Atual'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PRENOV'
        Title.Alignment = taRightJustify
        Title.Caption = 'Pre'#231'o M'#237'nimo Novo'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'COMATU'
        Title.Alignment = taRightJustify
        Title.Caption = 'Comiss'#227'o Atual'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'COMNOV'
        Title.Alignment = taRightJustify
        Title.Caption = 'Comiss'#227'o Nova'
        Visible = False
      end>
  end
  object ProgressBar: TProgressBar [4]
    Left = 0
    Top = 460
    Width = 831
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 4
  end
  inherited pnlStatus: TPanel
    Top = 498
    Width = 831
    TabOrder = 2
    ExplicitTop = 498
    ExplicitWidth = 831
    inherited pnlNomeForm: TPanel
      Left = 660
      ExplicitLeft = 660
    end
    inherited pnlInfo: TPanel
      Width = 660
      ExplicitWidth = 660
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 592
    Top = 24
  end
  object dtsBocCai: TDataSource
    Left = 472
    Top = 296
  end
end
