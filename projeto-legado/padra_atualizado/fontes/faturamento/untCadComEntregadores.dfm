inherited frmCadComEntregadores: TfrmCadComEntregadores
  Left = 245
  Top = 238
  Width = 858
  Height = 450
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Controle de Entregadores'
  ExplicitWidth = 858
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 380
    Width = 852
    Height = 25
    ExplicitTop = 380
    ExplicitWidth = 852
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 771
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 771
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 77
        ExplicitWidth = 77
      end
      inherited btnGravar: TBitBtnLocked
        Left = 77
        Width = 100
        Caption = '[F10] - &Gravar'
        ExplicitLeft = 77
        ExplicitWidth = 100
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 177
        Width = 77
        ExplicitLeft = 177
        ExplicitWidth = 77
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 254
        Width = 77
        ExplicitLeft = 254
        ExplicitWidth = 77
      end
      inherited btnCancela: TBitBtnLocked
        Left = 331
        Width = 77
        ExplicitLeft = 331
        ExplicitWidth = 77
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 408
        Width = 77
        ExplicitLeft = 408
        ExplicitWidth = 77
      end
      object bntEntregas: TBitBtnLocked
        Left = 485
        Top = 0
        Width = 77
        Height = 20
        Caption = 'E&ntregas'
        TabOrder = 6
        OnClick = bntEntregasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 773
      Height = 21
      Align = alRight
      ExplicitLeft = 773
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 852
    ExplicitTop = 405
    ExplicitWidth = 852
    inherited pnlNomeForm: TPanel
      Left = 505
      ExplicitLeft = 505
    end
    inherited pnlInfo: TPanel
      Width = 505
      ExplicitWidth = 505
    end
  end
  inherited pgcDados: TPageControl
    Width = 852
    Height = 380
    ExplicitWidth = 852
    ExplicitHeight = 380
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 844
      ExplicitHeight = 348
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 852
    Height = 380
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object bvlTopo: TBevel
      Left = 1
      Top = 1
      Width = 850
      Height = 140
      Align = alTop
      Style = bsRaised
    end
    object lblProEnt: TLabel
      Left = 30
      Top = 10
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Prox.Entrega:'
    end
    object lblEntregador: TLabel
      Left = 39
      Top = 33
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Entregador:'
    end
    object bvlDocumentos: TBevel
      Left = 1
      Top = 141
      Width = 850
      Height = 57
      Align = alTop
      Style = bsRaised
      ExplicitTop = 142
    end
    object lblBaixada: TLabel
      Left = 221
      Top = 7
      Width = 75
      Height = 22
      Caption = 'Baixada'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label2: TLabel
      Left = 57
      Top = 56
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ve'#237'culo:'
    end
    object Label4: TLabel
      Left = 17
      Top = 79
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'm. Ajudantes:'
    end
    object Label5: TLabel
      Left = 32
      Top = 102
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#227'o:'
    end
    object pnlDocume: TPanel
      Left = 4
      Top = 143
      Width = 536
      Height = 26
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
      object lblDocumento: TLabel
        Left = 34
        Top = 7
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
      end
      object lblEspecie: TLabel
        Left = 175
        Top = 7
        Width = 41
        Height = 14
        Caption = 'Esp'#233'cie:'
      end
      object lblEmpresa: TLabel
        Left = 249
        Top = 7
        Width = 45
        Height = 14
        Caption = 'Empresa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtDocume: TEditFocus
        Tag = 99
        Left = 93
        Top = 2
        Width = 80
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
        TipoTexto = ttNumerico
      end
      object edtCodEmpresa: TEditFocus
        Tag = 99
        Left = 296
        Top = 2
        Width = 29
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
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        OnKeyPress = edtCodEmpresaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpresa: TEditFocus
        Left = 326
        Top = 2
        Width = 205
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 217
        Top = 2
        Width = 30
        Height = 22
        Hint = 'PC - GA - OS - MI - FF - NF - IF - TR - DV - TE - BR - PR'
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 1
        OnEnter = edtEspDocEnter
        OnExit = edtEspDocExit
        OnKeyPress = edtEspDocKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object pnlCodBar: TPanel
      Left = 4
      Top = 143
      Width = 536
      Height = 26
      BevelOuter = bvNone
      TabOrder = 6
      object Label3: TLabel
        Left = 4
        Top = 7
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo de Barras:'
      end
      object edtCodBar: TEditFocus
        Tag = 99
        Left = 93
        Top = 2
        Width = 439
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 44
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object edtSenMot: TEditFocus
      Tag = 99
      Left = 97
      Top = 30
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 1
      OnKeyPress = edtSenMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeProEnt: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 7
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ENG_PROENT'
      DataSource = dtsComEng
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbgDocumentos: TDBGridCitel
      Left = 1
      Top = 198
      Width = 850
      Height = 159
      Align = alClient
      DataSource = dtsComEnd
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 10
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDocumentosDrawColumnCell
      OnKeyDown = dbgDocumentosKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'END_NUMDOC'
          Title.Caption = 'Documento'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'END_ESPDOC'
          Title.Caption = 'Esp'#233'cie'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'END_EMPDOC'
          Title.Caption = 'Empresa'
          Width = 46
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLI_CODCLI'
          Title.Caption = 'Cliente/Fornecedor'
          Width = 238
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'END_QTDNOT'
          Title.Alignment = taCenter
          Title.Caption = 'Q.Canhotos'
          Width = 67
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GER_PESBRU'
          Title.Caption = 'Peso Bruto'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GER_PESLIQ'
          Title.Caption = 'Peso L'#237'q.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GER_VOLUME'
          Title.Caption = 'Qtd. Volumes'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CID_CODCID'
          Title.Caption = 'Cidade'
          Width = 130
          Visible = True
        end>
    end
    object dbePlaVei: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 53
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ENG_PLAVEI'
      DataSource = dtsComEng
      MaxLength = 8
      TabOrder = 2
      OnKeyPress = dbePlaVeiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesVei: TEditFocus
      Left = 161
      Top = 53
      Width = 438
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
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
    object edtNomMot: TEditFocus
      Left = 161
      Top = 30
      Width = 438
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
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
    object TPanel
      Left = 1
      Top = 357
      Width = 850
      Height = 22
      Align = alBottom
      ParentColor = True
      TabOrder = 13
      object lblIteExp: TLabel
        Left = 524
        Top = 5
        Width = 89
        Height = 14
        Caption = 'Entrega Urgente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object shpIteExp: TShape
        Left = 509
        Top = 6
        Width = 12
        Height = 12
        Brush.Color = clRed
      end
    end
    object pnlCidade: TPanel
      Left = 6
      Top = 169
      Width = 534
      Height = 28
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 7
      object Label1: TLabel
        Left = 53
        Top = 7
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodCidade: TEditFocus
        Tag = 99
        Left = 91
        Top = 0
        Width = 49
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
        MaxLength = 5
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodCidadeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesCidade: TEditFocus
        Left = 140
        Top = 0
        Width = 249
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
    object btnAdicionar: TBitBtnLocked
      Left = 541
      Top = 145
      Width = 77
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
      TabOrder = 8
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 541
      Top = 167
      Width = 77
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
      TabOrder = 9
      OnClick = btnCancelaItemClick
    end
    object edtNumAju: TDBEditFocus
      Tag = 99
      Left = 97
      Top = 76
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ENG_NUMAJU'
      DataSource = dtsComEng
      MaxLength = 2
      TabOrder = 3
      OnKeyPress = dbePlaVeiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeObserv: TDBMemoFocus
      Left = 97
      Top = 99
      Width = 502
      Height = 38
      DataField = 'ENG_OBSERV'
      DataSource = dtsComEng
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 253
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 488
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 264
    Top = 152
  end
  object dtsComEng: TDataSource
    Left = 416
    Top = 184
  end
  object dtsComEnd: TDataSource
    Left = 408
    Top = 253
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 312
    Top = 224
  end
  object frxReport1: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42580.456125185180000000
    ReportOptions.LastChange = 42580.456125185180000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 328
    Top = 8
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 124.724490000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object BarCode1: TfrxBarCodeView
          Left = 37.795300000000000000
          Top = 15.118120000000000000
          Width = 103.000000000000000000
          Height = 71.811070000000000000
          BarType = bcCodeEAN13
          Rotation = 0
          TestLine = False
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 204.094620000000000000
        Width = 718.110700000000000000
      end
    end
  end
end
