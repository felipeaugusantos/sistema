inherited frmFatItensRomaneio: TfrmFatItensRomaneio
  Left = 208
  Top = 234
  Width = 800
  Height = 400
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeable
  Caption = 'Itens do Documento'
  Position = poScreenCenter
  ExplicitWidth = 800
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 319
    Width = 784
    Height = 26
    ExplicitTop = 319
    ExplicitWidth = 784
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 780
      Height = 22
      ExplicitWidth = 780
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F10 ] Confirma Itens'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnInformacoes: TBitBtnLocked
        Left = 110
        Top = 0
        Width = 160
        Height = 22
        Caption = '[ F9 ] Informa'#231#245'es sobre o Item'
        TabOrder = 1
        OnClick = btnInformacoesClick
      end
      object btnMarcaDesmarca: TBitBtnLocked
        Left = 270
        Top = 0
        Width = 201
        Height = 22
        Caption = '[ F8 ] Marca/Desmarca Todos os Itens'
        TabOrder = 2
        OnClick = btnMarcaDesmarcaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 704
      Top = 2
      ExplicitLeft = 704
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 345
    Width = 784
    ExplicitTop = 345
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 84
    Align = alTop
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 23
      Top = 12
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 8
      Top = 35
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 442
      Top = 35
      Width = 58
      Height = 14
      Caption = 'Quantidade:'
    end
    object edtCodIte: TEditFocus
      Left = 64
      Top = 8
      Width = 57
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescri: TEditFocus
      Left = 64
      Top = 31
      Width = 353
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtQtdIte: TEditFocus
      Left = 507
      Top = 31
      Width = 73
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object btnAdicionaItem: TBitBtnLocked
      Left = 409
      Top = 56
      Width = 85
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
      TabOrder = 3
      OnClick = btnAdicionaItemClick
    end
    object btnCancelar: TBitBtnLocked
      Left = 495
      Top = 56
      Width = 85
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
      TabOrder = 4
      OnClick = btnCancelarClick
    end
  end
  object dbgItens: TcxGrid [3]
    Left = 0
    Top = 84
    Width = 784
    Height = 235
    Align = alClient
    TabOrder = 3
    LockedStateImageOptions.AssignedValues = [lsiavColor]
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    LookAndFeel.ScrollbarMode = sbmClassic
    LookAndFeel.SkinName = ''
    object dbgItensDBView: TcxGridDBTableView
      OnKeyDown = dbgItensDBViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgItensDBViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GridLines = glVertical
      OptionsView.GroupByBox = False
      object dbgItensDET_CODITE: TcxGridDBColumn
        AlternateCaption = 'Item'
        Caption = 'Item'
        DataBinding.FieldName = 'DET_CODITE'
        Width = 64
      end
      object dbgItensDET_DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DET_DESITE'
        Width = 400
      end
      object dbgItensDET_UNIDAD: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'DET_UNIDAD'
        Width = 50
      end
      object dbgItensDET_NUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'DET_NUMLOT'
        Width = 100
      end
      object dbgItensTURENT: TcxGridDBColumn
        Caption = 'Turno'
        DataBinding.FieldName = 'TURENT'
      end
      object dbgItensDET_QTDITE: TcxGridDBColumn
        Caption = 'Qtd. Romaneio'
        DataBinding.FieldName = 'DET_QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Width = 76
      end
      object dbgItensDET_QTDBAI: TcxGridDBColumn
        Caption = 'Qtd. Entrega'
        DataBinding.FieldName = 'DET_QTDBAI'
        HeaderAlignmentHorz = taRightJustify
        Width = 77
      end
      object dbgItensDET_EMPORI: TcxGridDBColumn
        Caption = 'Emp. Ori'
        DataBinding.FieldName = 'DET_EMPORI'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 65
      end
    end
    object dbgItenslevel: TcxGridLevel
      GridView = dbgItensDBView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 152
  end
end
