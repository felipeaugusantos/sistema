inherited frmCadBocaCaixa: TfrmCadBocaCaixa
  Left = 194
  Top = 165
  Width = 1372
  Height = 797
  Caption = 'Boca de Caixa'
  ExplicitLeft = -230
  ExplicitWidth = 1372
  ExplicitHeight = 797
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 728
    Width = 1366
    Height = 24
    ExplicitTop = 451
    ExplicitWidth = 763
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Width = 1302
      Height = 20
      ExplicitTop = 2
      ExplicitWidth = 699
      ExplicitHeight = 20
      inherited btnIncluir: TBitBtnLocked
        Width = 65
        ExplicitWidth = 65
      end
      inherited btnGravar: TBitBtnLocked
        Left = 65
        Width = 65
        ExplicitLeft = 65
        ExplicitWidth = 65
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 130
        Width = 65
        ExplicitLeft = 130
        ExplicitWidth = 65
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 195
        Width = 132
        Caption = '&Excluir Boca de Caixa'
        ParentFont = False
        ExplicitLeft = 195
        ExplicitWidth = 132
      end
      inherited btnCancela: TBitBtnLocked
        Left = 327
        Width = 74
        ExplicitLeft = 327
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 401
        Width = 75
        ExplicitLeft = 401
        ExplicitWidth = 75
      end
      object btnExcluirVarias: TBitBtnLocked
        Left = 476
        Top = 0
        Width = 101
        Height = 20
        Caption = '[F11] Excluir &V'#225'rias'
        NumGlyphs = 2
        TabOrder = 6
        OnClick = btnExcluirVariasClick
      end
      object btnDelIte: TBitBtnLocked
        Left = 577
        Top = 0
        Width = 110
        Height = 20
        Caption = '[Del] Excluir Item'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          300033FFFFFF3333377739999993333333333777777F3333333F399999933333
          3300377777733333337733333333333333003333333333333377333333333333
          3333333333333333333F333333333333330033333F33333333773333C3333333
          330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
          333333377F33333333FF3333C333333330003333733333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 7
        OnClick = btnDelIteClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1304
      Width = 60
      Height = 20
      Align = alRight
      ExplicitLeft = 701
      ExplicitWidth = 60
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 752
    Width = 1366
    ExplicitTop = 475
    ExplicitWidth = 763
    inherited pnlNomeForm: TPanel
      Left = 1185
      Width = 181
      ExplicitLeft = 582
      ExplicitWidth = 181
    end
    inherited pnlInfo: TPanel
      Width = 1185
      ExplicitWidth = 582
    end
  end
  inherited pgcDados: TPageControl
    Width = 1366
    Height = 728
    ExplicitWidth = 763
    ExplicitHeight = 451
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 755
      ExplicitHeight = 419
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 1366
    Height = 728
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitWidth = 763
    ExplicitHeight = 451
    object pnlDadosItem: TPanel
      Left = 1
      Top = 1
      Width = 1364
      Height = 222
      Align = alTop
      Color = 16770261
      TabOrder = 0
      ExplicitWidth = 761
      object Label4: TLabel
        Left = 3
        Top = 30
        Width = 85
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Produto:'
      end
      object lblComiss: TLabel
        Left = 296
        Top = 192
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Comiss'#227'o:'
      end
      object lblTitCom: TLabel
        Left = 7
        Top = 192
        Width = 146
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre'#231'o Min. Pgto. de Comiss'#227'o:'
      end
      object Label9: TLabel
        Left = 20
        Top = 8
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
        Top = 74
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
        Top = 52
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
        Top = 96
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
        Top = 140
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
        Left = 1018
        Top = 140
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
        Top = 118
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
      object lblOpSele: TLabel
        Left = 510
        Top = 162
        Width = 95
        Height = 14
        Cursor = crHandPoint
        Caption = 'Op'#231#245'es de Sele'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lblOpSeleClick
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
        Width = 937
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 15
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
        Left = 347
        Top = 188
        Width = 70
        Height = 22
        Alignment = taRightJustify
        TabOrder = 10
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
        Left = 154
        Top = 188
        Width = 70
        Height = 22
        Alignment = taRightJustify
        TabOrder = 9
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
        Width = 937
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
        Width = 937
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
        Width = 937
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 16
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDescriIni: TEditFocus
        Left = 90
        Top = 92
        Width = 1008
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
        Left = 90
        Top = 136
        Width = 922
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
        Left = 1062
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
        Left = 90
        Top = 114
        Width = 1008
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
        Top = 179
        Width = 1345
        Height = 8
        BevelOuter = bvLowered
        TabOrder = 18
      end
      object clbEmpresa: TCheckListBox
        Left = 1105
        Top = 5
        Width = 241
        Height = 152
        ItemHeight = 14
        TabOrder = 8
        OnExit = clbEmpresaExit
        OnKeyDown = clbEmpresaKeyDown
      end
      object btnConfirmar: TBitBtnLocked
        Left = 601
        Top = 188
        Width = 74
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
        TabOrder = 12
        OnClick = btnConfirmarClick
      end
      object btnCancelaItem: TBitBtnLocked
        Left = 675
        Top = 188
        Width = 74
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
        TabOrder = 13
        OnClick = btnCancelaItemClick
      end
      object chkLimparCampos: TCheckBox
        Left = 424
        Top = 192
        Width = 169
        Height = 17
        Caption = 'Limpar campos ao confirmar?'
        Checked = True
        State = cbChecked
        TabOrder = 11
      end
      object btnImportarPlanilha: TBitBtnLocked
        Left = 750
        Top = 188
        Width = 108
        Height = 22
        Caption = '&Importar Planilha'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF848484FF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB882
          4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF848484FF848484FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 19
        OnClick = btnImportarPlanilhaClick
      end
    end
    object dbgItens: TDBGridCitel
      Left = 1
      Top = 223
      Width = 1364
      Height = 504
      Align = alClient
      DataSource = dtsBcaCai
      Enabled = False
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnEnter = dbgItensEnter
      OnExit = dbgItensExit
      OnKeyDown = dbgItensKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CODITE'
          Title.Caption = 'C'#243'd. Item'
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESITE'
          Title.Caption = 'Descri'#231#227'o'
          Width = 280
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODUNI'
          Title.Caption = 'Uni.'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'UNIDAD'
          Title.Caption = 'Unid.'
          Width = 22
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PRECUS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Pr. Custo'
          Width = 77
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PREVEN'
          Title.Alignment = taRightJustify
          Title.Caption = 'Pr. Venda'
          Width = 77
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PREMIN'
          Title.Alignment = taRightJustify
          Title.Caption = 'Pr. M'#237'nimo'
          Width = 77
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'COMVAR'
          Title.Alignment = taRightJustify
          Title.Caption = 'Comiss'#227'o'
          Width = 68
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DTACAD'
          Title.Caption = 'Dta Cad.'
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 192
    Top = 328
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 96
    Top = 328
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 272
  end
  object dtsBcaCai: TDataSource
    Left = 280
    Top = 272
  end
  object popOpSele: TPopupMenu
    Left = 687
    Top = 96
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = MarcarTodos1Click
    end
    object DesmarcarTodos1: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = DesmarcarTodos1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InverterSeleo1: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = InverterSeleo1Click
    end
  end
end
