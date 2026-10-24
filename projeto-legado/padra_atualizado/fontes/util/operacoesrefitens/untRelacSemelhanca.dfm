inherited frmRelacSemelhanca: TfrmRelacSemelhanca
  Left = 260
  Top = 223
  Width = 739
  Caption = 'Relacionamento de Semelhan'#231'a'
  Position = poScreenCenter
  ExplicitWidth = 739
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 436
    Width = 733
    ExplicitTop = 432
    ExplicitWidth = 733
    DesignSize = (
      733
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 729
      ExplicitWidth = 729
    end
  end
  inherited pgcDados: TPageControl
    Top = 105
    Width = 733
    Height = 331
    ExplicitTop = 105
    ExplicitWidth = 733
    ExplicitHeight = 327
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 725
      ExplicitHeight = 295
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 733
    Height = 105
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 73
      Top = 16
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label2: TLabel
      Left = 5
      Top = 54
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo de F'#225'brica:'
    end
    object Label3: TLabel
      Left = 329
      Top = 54
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo de Barras:'
    end
    object Label4: TLabel
      Left = 62
      Top = 77
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 95
      Top = 8
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
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
    object edtCodFab: TEditFocus
      Tag = 99
      Left = 95
      Top = 46
      Width = 170
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 25
      TabOrder = 1
      OnExit = edtCodFabExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 35
      TipoTexto = ttAlfanumerico
    end
    object Panel1: TPanel
      Left = 0
      Top = 37
      Width = 765
      Height = 3
      BevelOuter = bvLowered
      ParentBackground = False
      ParentColor = True
      TabOrder = 6
    end
    object edtCodBar: TEditFocus
      Tag = 99
      Left = 417
      Top = 46
      Width = 170
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 15
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 142
      Top = 8
      Width = 277
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnConfirmar: TBitBtnLocked
      Left = 438
      Top = 73
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
      TabOrder = 4
      OnClick = btnConfirmarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 513
      Top = 73
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
      TabOrder = 5
      OnClick = btnCancelaItemClick
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 95
      Top = 71
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 3
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMar: TEditFocus
      Left = 142
      Top = 71
      Width = 277
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
  end
  object pnlBotoesSim: TPanel [4]
    Left = 0
    Top = 436
    Width = 733
    Height = 24
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object btnConfirma: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 135
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
      ExplicitHeight = 24
    end
    object btnDeletar: TBitBtnLocked
      Left = 136
      Top = 1
      Width = 135
      Height = 22
      Align = alLeft
      Caption = '[ DEL ] Exclui'
      TabOrder = 1
      OnClick = btnDeletarClick
      ExplicitHeight = 24
    end
    object btnCancelarEntrada: TBitBtnLocked
      Left = 656
      Top = 1
      Width = 76
      Height = 22
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 3
      OnClick = btnCancelarEntradaClick
    end
    object btnCadMarcas: TBitBtnLocked
      Left = 271
      Top = 1
      Width = 135
      Height = 22
      Align = alLeft
      Caption = '[ F7 ] Cadastro de Marcas'
      TabOrder = 2
      OnClick = btnCadMarcasClick
      ExplicitHeight = 24
    end
  end
  object dbgItens: TDBGridCitel [5]
    Left = 0
    Top = 105
    Width = 733
    Height = 331
    Align = alClient
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODFAB'
        Title.Caption = 'C'#243'd. F'#225'brica'
        Width = 190
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODBAR'
        Title.Caption = 'C'#243'd. Barras'
        Width = 190
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODMAR'
        Title.Caption = 'Marca'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESMAR'
        Title.Caption = 'Descri'#231#227'o da Marca'
        Width = 268
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Width = 733
    ExplicitWidth = 733
    inherited pnlNomeForm: TPanel
      Left = 562
      ExplicitLeft = 562
    end
    inherited pnlInfo: TPanel
      Width = 562
      ExplicitWidth = 562
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 696
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 560
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 136
    Top = 136
  end
  object dtsGrid: TDataSource
    Left = 296
    Top = 160
  end
end
