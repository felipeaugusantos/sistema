inherited frmLiberacaoLocalizacaoFisicaColetor: TfrmLiberacaoLocalizacaoFisicaColetor
  Width = 554
  Height = 540
  Caption = 'Libera'#231#227'o de Localiza'#231#245'es F'#237'sicas do Coletor'
  ExplicitWidth = 554
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 469
    Width = 548
    TabOrder = 2
    ExplicitTop = 469
    ExplicitWidth = 548
    inherited FlwBotoes: TFlowPanel
      Width = 467
      ExplicitWidth = 544
      inherited btnConfirma: TBitBtnLocked
        Width = 84
        ModalResult = 0
        ExplicitWidth = 84
      end
      object btnMarcaDesmarca: TBitBtnLocked
        Left = 84
        Top = 0
        Width = 136
        Height = 22
        Caption = '[ENTER] Marca/Desmarca'
        TabOrder = 1
        OnClick = btnMarcaDesmarcaClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 220
        Top = 0
        Width = 123
        Height = 22
        Caption = '&Marcar Todos'
        TabOrder = 2
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 343
        Top = 0
        Width = 115
        Height = 22
        Caption = '&Desmarcar Todos'
        TabOrder = 3
        OnClick = btnDesmarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 469
      Top = 2
      Align = alRight
      ModalResult = 0
      ExplicitLeft = 469
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 495
    Width = 548
    TabOrder = 3
    ExplicitTop = 495
    ExplicitWidth = 548
    inherited pnlNomeForm: TPanel
      Left = 377
      ExplicitLeft = 377
    end
    inherited pnlInfo: TPanel
      Width = 377
      ExplicitWidth = 377
    end
  end
  object pnlBusca: TPanel [3]
    Left = 0
    Top = 0
    Width = 548
    Height = 67
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object lblDocumentoRomaneio: TLabel
      Left = 32
      Top = 37
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Romaneio:'
    end
    object Label3: TLabel
      Left = 5
      Top = 13
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Localiza'#231#227'o F'#237'sica:'
    end
    object edtDocRom: TEditFocus
      Tag = 99
      Left = 101
      Top = 33
      Width = 150
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtLocFis: TEditFocus
      Tag = 99
      Left = 101
      Top = 9
      Width = 150
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnFiltrar: TBitBtnLocked
      Left = 257
      Top = 33
      Width = 85
      Height = 22
      Caption = '&Consultar'
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
      TabOrder = 2
      OnClick = btnFiltrarClick
    end
  end
  object cxgLocalizacoes: TcxGridCitel [4]
    Left = 0
    Top = 67
    Width = 548
    Height = 379
    Align = alClient
    TabOrder = 1
    object cxgLocalizacoesTBV: TcxGridDBTableViewCitel
      OnKeyDown = cxgLocalizacoesTBVKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgLocalizacoesTBVCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgLocalizacoesTBVDocumentoRomaneio: TcxGridDBColumn
        Caption = 'Romaneio'
        DataBinding.FieldName = 'DOCROM'
        Width = 127
      end
      object cxgLocalizacoesTBVLocalizacao: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o'
        DataBinding.FieldName = 'LOCFIS'
        Width = 141
      end
      object cxgLocalizacoesTBVCodigoOperador: TcxGridDBColumn
        Caption = 'C'#243'd. Operador'
        DataBinding.FieldName = 'CODOPE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 83
      end
      object cxgLocalizacoesTBVNomeOperador: TcxGridDBColumn
        Caption = 'Nome Operador'
        DataBinding.FieldName = 'NOMOPE'
        Width = 176
      end
      object cxgLocalizacoesTBVMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object cxgLocalizacoesLVL: TcxGridLevel
      GridView = cxgLocalizacoesTBV
    end
  end
  object pnlLegenda: TPanel [5]
    Left = 0
    Top = 446
    Width = 548
    Height = 23
    Align = alBottom
    TabOrder = 5
    DesignSize = (
      548
      23)
    object shpSelecionado: TShape
      Left = 373
      Top = 3
      Width = 16
      Height = 16
      Anchors = [akTop, akRight]
      Brush.Color = clGreen
      ExplicitLeft = 360
    end
    object Label4: TLabel
      Left = 395
      Top = 4
      Width = 147
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Localiza'#231#245'es Selecionadas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 382
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 220
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 156
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 280
    Top = 180
  end
  object UniQuery1: TUniQuery
    Constraints = <>
    Left = 264
    Top = 256
  end
end
