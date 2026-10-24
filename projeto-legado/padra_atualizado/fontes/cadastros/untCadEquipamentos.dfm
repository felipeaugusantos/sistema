inherited frmCadEquipamentos: TfrmCadEquipamentos
  Left = 319
  Top = 465
  Width = 534
  Height = 450
  Caption = 'Cadastro de Equipamentos'
  OnDestroy = FormDestroy
  ExplicitWidth = 534
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 380
    Width = 528
    Height = 25
    ExplicitTop = 380
    ExplicitWidth = 528
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 451
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 451
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 75
        ExplicitLeft = 365
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 453
      Width = 73
      Height = 21
      Align = alRight
      ExplicitLeft = 453
      ExplicitWidth = 73
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 528
    ExplicitTop = 405
    ExplicitWidth = 528
    inherited pnlNomeForm: TPanel
      Left = 351
      Width = 177
      ExplicitLeft = 351
      ExplicitWidth = 177
    end
    inherited pnlInfo: TPanel
      Width = 351
      ExplicitWidth = 351
    end
  end
  inherited pgcDados: TPageControl
    Left = 536
    Top = 18
    Width = 73
    Height = 33
    Align = alNone
    TabOrder = 3
    Visible = False
    ExplicitLeft = 536
    ExplicitTop = 18
    ExplicitWidth = 73
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 1
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 528
    Height = 380
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    object Label2: TLabel
      Left = 11
      Top = 42
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 27
      Top = 19
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label6: TLabel
      Left = 30
      Top = 65
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lbl1: TLabel
      Left = 23
      Top = 87
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label5: TLabel
      Left = 16
      Top = 134
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Voltagem:'
    end
    object lblIteCcr: TLabel
      Left = 265
      Top = 134
      Width = 156
      Height = 14
      Alignment = taRightJustify
      Caption = 'Assist'#234'ncia T'#233'cnica Autorizada:'
    end
    object clbIteCcr: TColorLabel
      Left = 460
      Top = 134
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object lblModelo: TLabel
      Left = 26
      Top = 111
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Modelo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 37
      Width = 451
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQU_DESCRI'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 14
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQU_CODIGO'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeCodMar: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 60
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQU_CODMAR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      OnKeyPress = dbeCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodMarChamaCadastro
    end
    object edtDesMar: TEditFocus
      Left = 123
      Top = 60
      Width = 393
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
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 83
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQU_CODITE'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 4
      OnExit = dbeCodIteExit
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodIteChamaCadastro
    end
    object edtDesIte: TEditFocus
      Left = 123
      Top = 83
      Width = 393
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object dbeVoltag: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 129
      Width = 194
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQU_VOLTAG'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAutori: TDBEditFocus
      Tag = 99
      Left = 423
      Top = 129
      Width = 34
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQU_AUTORI'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeModelo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 106
      Width = 451
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQU_MODELO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gpbServicos: TGroupBox
      Left = 2
      Top = 164
      Width = 524
      Height = 214
      Align = alBottom
      Caption = 'Servi'#231'os'
      TabOrder = 9
      object pnlServicos: TPanel
        Left = 2
        Top = 16
        Width = 520
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          520
          56)
        object lblServiço: TLabel
          Left = 19
          Top = 6
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Servi'#231'o:'
        end
        object lblValSer: TLabel
          Left = 31
          Top = 29
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor:'
        end
        object lblDesMax: TLabel
          Left = 151
          Top = 29
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto M'#225'ximo:'
        end
        object edtCodSer: TEditFocus
          Tag = 99
          Left = 61
          Top = 3
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtCodSerKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtValSer: TEditFocus
          Tag = 99
          Left = 61
          Top = 26
          Width = 76
          Height = 22
          Alignment = taRightJustify
          MaxLength = 12
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesMax: TEditFocus
          Tag = 99
          Left = 241
          Top = 26
          Width = 76
          Height = 22
          Alignment = taRightJustify
          MaxLength = 12
          TabOrder = 3
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object btnAdicionarSer: TBitBtnLocked
          Left = 336
          Top = 26
          Width = 86
          Height = 22
          Anchors = [akTop, akRight]
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
          TabOrder = 4
          OnClick = btnAdicionarSerClick
        end
        object edtDesSer: TEditFocus
          Left = 119
          Top = 3
          Width = 393
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
        object btnCancelaSer: TBitBtnLocked
          Left = 426
          Top = 26
          Width = 86
          Height = 22
          Anchors = [akTop, akRight]
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
          TabOrder = 5
          OnClick = btnCancelaSerClick
        end
      end
      object dbgGridSerEqu: TDBGridCitel
        Left = 2
        Top = 72
        Width = 520
        Height = 140
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgGridSerEquKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'DESSER'
            Title.Caption = 'Servi'#231'o'
            Width = 322
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALSER'
            Title.Caption = 'Valor Servi'#231'o'
            Width = 74
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESMAX'
            Title.Caption = 'Desconto M'#225'ximo'
            Width = 90
            Visible = True
          end>
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 4
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 272
    Top = 8
  end
  object dtsSerEqu: TDataSource
    Left = 208
    Top = 236
  end
end
