inherited frmCadMetasRapel: TfrmCadMetasRapel
  Width = 639
  Height = 461
  Caption = 'Cadastro de Metas de Rapel'
  OnDestroy = FormDestroy
  ExplicitWidth = 639
  ExplicitHeight = 461
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 390
    Width = 633
    TabOrder = 2
    ExplicitTop = 390
    ExplicitWidth = 633
    inherited FlwBotoes: TFlowPanel
      Width = 629
      ExplicitTop = 2
      ExplicitWidth = 629
      inherited btnConfirma: TBitBtnLocked
        Width = 105
        ModalResult = 0
        ExplicitWidth = 105
      end
      object btnCopiarMetas: TBitBtnLocked
        Left = 105
        Top = 0
        Width = 105
        Height = 22
        Caption = '[ F11 ] Copiar Metas'
        Enabled = False
        TabOrder = 1
        OnClick = btnCopiarMetasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 554
      Top = 2
      ModalResult = 0
      ExplicitLeft = 554
      ExplicitTop = 2
    end
  end
  object pnlCabec: TPanel [2]
    Left = 0
    Top = 0
    Width = 633
    Height = 45
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object pnlMesAnoOrigem: TPanel
      Left = 385
      Top = 1
      Width = 247
      Height = 43
      Align = alRight
      BevelInner = bvLowered
      BevelOuter = bvNone
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      TabStop = True
      Visible = False
      ExplicitLeft = 384
      object Label4: TLabel
        Left = 1
        Top = 15
        Width = 183
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Copiar metas do Per'#237'odo de Origem:'
      end
      object Bevel2: TBevel
        Left = 0
        Top = 0
        Width = 1
        Height = 35
        Shape = bsLeftLine
      end
      object mskDtaOrigem: TMaskEditFocus
        Tag = 99
        Left = 188
        Top = 11
        Width = 53
        Height = 22
        EditMask = '99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 384
      Height = 43
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 376
      object Label1: TLabel
        Left = 4
        Top = 1
        Width = 36
        Height = 14
        Caption = 'Per'#237'odo'
      end
      object lblEmpresa: TLabel
        Left = 63
        Top = 1
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object mskPeriodo: TMaskEditFocus
        Tag = 99
        Left = 4
        Top = 16
        Width = 57
        Height = 22
        EditMask = '!99/9999;1;_'
        MaxLength = 7
        TabOrder = 0
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodEmpresa: TEditFocus
        Tag = 99
        Left = 63
        Top = 16
        Width = 57
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
        TabOrder = 1
        OnExit = edtCodEmpresaExit
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
        Left = 122
        Top = 16
        Width = 248
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
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
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlCorpo: TPanel [3]
    Left = 0
    Top = 45
    Width = 633
    Height = 345
    Align = alClient
    Enabled = False
    ParentColor = True
    TabOrder = 1
    object lblFornecedor: TLabel
      Left = 6
      Top = 7
      Width = 56
      Height = 14
      Alignment = taRightJustify
      BiDiMode = bdRightToLeft
      Caption = 'Fornecedor'
      ParentBiDiMode = False
    end
    object Label2: TLabel
      Left = 344
      Top = 5
      Width = 84
      Height = 14
      Alignment = taRightJustify
      BiDiMode = bdRightToLeft
      Caption = 'Meta de Compras'
      ParentBiDiMode = False
    end
    object Label3: TLabel
      Left = 436
      Top = 4
      Width = 40
      Height = 14
      Alignment = taRightJustify
      BiDiMode = bdRightToLeft
      Caption = '% Rapel'
      ParentBiDiMode = False
    end
    object Bevel1: TBevel
      Left = 2
      Top = 52
      Width = 630
      Height = 10
      Shape = bsTopLine
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 5
      Top = 21
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 71
      Top = 21
      Width = 271
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
    object edtMeta: TEditFocus
      Tag = 99
      Left = 344
      Top = 20
      Width = 90
      Height = 22
      Alignment = taLeftJustify
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
    object edtRapel: TEditFocus
      Tag = 99
      Left = 436
      Top = 20
      Width = 80
      Height = 22
      Alignment = taLeftJustify
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
    object dbgItens: TDBGridCitel
      Left = 5
      Top = 67
      Width = 620
      Height = 271
      BorderStyle = bsNone
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 6
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyUp = dbgItensKeyUp
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'RAP_CODFOR'
          Title.Caption = 'C'#243'digo'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FOR_NOMFOR'
          Title.Caption = 'Fornecedor'
          Width = 283
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RAP_VALMET'
          Title.Caption = 'Meta de Compras'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RAP_RAPEL_'
          Title.Caption = '% Rapel'
          Width = 76
          Visible = True
        end>
    end
    object btnAdicionar: TBitBtnLocked
      Left = 520
      Top = 3
      Width = 100
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
      TabOrder = 4
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 520
      Top = 26
      Width = 100
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
      TabOrder = 5
      OnClick = btnCancelaItemClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 416
    Width = 633
    TabOrder = 3
    ExplicitTop = 416
    ExplicitWidth = 633
    inherited pnlNomeForm: TPanel
      Left = 462
      ExplicitLeft = 462
    end
    inherited pnlInfo: TPanel
      Width = 462
      ExplicitWidth = 462
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 176
    Top = 176
  end
end
