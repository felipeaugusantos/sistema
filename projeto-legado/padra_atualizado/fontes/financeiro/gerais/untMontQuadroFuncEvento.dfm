inherited frmMontQuadroFuncEvento: TfrmMontQuadroFuncEvento
  Left = 219
  Top = 148
  Width = 768
  Height = 556
  BorderIcons = [biSystemMenu]
  Caption = 'Montagem do Quadro de Funcion'#225'rios no Evento'
  Position = poMainFormCenter
  ExplicitWidth = 768
  ExplicitHeight = 556
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 483
    Width = 762
    TabOrder = 3
    ExplicitTop = 483
    ExplicitWidth = 762
    inherited FlwBotoes: TFlowPanel
      Width = 758
      ExplicitWidth = 758
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 22
        Caption = '[ F10 ] &Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnCancelar: TBitBtnLocked
        Left = 100
        Top = 0
        Width = 100
        Height = 22
        Caption = '[ Esc ] C&ancelar'
        TabOrder = 1
        OnClick = btnCancelarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 681
      ExplicitLeft = 681
    end
  end
  inherited pnlStatus: TPanel
    Top = 511
    Width = 762
    TabOrder = 4
    ExplicitTop = 511
    ExplicitWidth = 762
    inherited pnlNomeForm: TPanel
      Left = 591
      ExplicitLeft = 591
    end
    inherited pnlInfo: TPanel
      Width = 591
      ExplicitWidth = 591
    end
  end
  object pnl1: TPanel [2]
    Left = 0
    Top = 0
    Width = 762
    Height = 36
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object lbl1: TLabel
      Left = 36
      Top = 11
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Evento:'
    end
    object lbl2: TLabel
      Left = 524
      Top = 11
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data do Evento:'
    end
    object edtCodEve: TEditFocus
      Tag = 99
      Left = 74
      Top = 7
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodEveKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesEve: TEditFocus
      Left = 145
      Top = 7
      Width = 310
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaEve: TMaskEditFocus
      Tag = 99
      Left = 603
      Top = 7
      Width = 70
      Height = 22
      Color = 16768952
      Enabled = False
      EditMask = '!99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pnl2: TPanel [3]
    Left = 0
    Top = 411
    Width = 762
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 2
    object lbl3: TLabel
      Left = 565
      Top = 9
      Width = 78
      Height = 18
      Alignment = taRightJustify
      Caption = 'Valor Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblVlrTot: TLabel
      Left = 713
      Top = 9
      Width = 28
      Height = 18
      Alignment = taRightJustify
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnIncluir: TBitBtnLocked
      Left = 8
      Top = 7
      Width = 77
      Height = 22
      Caption = '&Incluir'
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
      TabOrder = 0
      OnClick = btnIncluirClick
    end
    object btnExcluir: TBitBtnLocked
      Left = 86
      Top = 7
      Width = 77
      Height = 22
      Caption = '&Excluir'
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
      OnClick = btnExcluirClick
    end
  end
  object cxGrdQuadro: TcxGridCitel [4]
    Left = 0
    Top = 36
    Width = 762
    Height = 375
    Align = alClient
    TabOrder = 1
    OnExit = cxGrdQuadroExit
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGrdQuadroTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxGrdQuadroTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = cxGrdQuadroTableViewEditKeyPress
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsBehavior.CellHints = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGrdQuadroTableViewNROGER: TcxGridDBColumn
        Caption = 'Ordem Geral'
        DataBinding.FieldName = 'NROGER'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxGrdQuadroTableViewNROFNC: TcxGridDBColumn
        Caption = 'Ordem Fun'#231#227'o'
        DataBinding.FieldName = 'NROFNC'
        Options.Editing = False
        Options.Focusing = False
        Width = 83
      end
      object cxGrdQuadroTableViewNOMFUN: TcxGridDBColumn
        Caption = 'Funcion'#225'rio'
        DataBinding.FieldName = 'NOMFUN'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = '...'
            Default = True
            Hint = 'Pesquisar Funcion'#225'rio'
            Kind = bkEllipsis
          end>
        Properties.ClickKey = 0
        Properties.ReadOnly = True
        Properties.OnButtonClick = cxGrdQuadroTableViewNOMFUNPropertiesButtonClick
        Width = 240
      end
      object cxGrdQuadroTableViewFUNCAO: TcxGridDBColumn
        Caption = 'Fun'#231#227'o'
        DataBinding.FieldName = 'FUNCAO'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = '...'
            Default = True
            Hint = 'Pesquisar Fun'#231#227'o'
            Kind = bkEllipsis
          end>
        Properties.ClickKey = 0
        Properties.ReadOnly = True
        Properties.OnButtonClick = cxGrdQuadroTableViewFUNCAOPropertiesButtonClick
        Width = 200
      end
      object cxGrdQuadroTableViewDTAINI: TcxGridDBColumn
        Caption = 'Data e Hora In'#237'cio'
        DataBinding.FieldName = 'DTAINI'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.DisplayFormat = 'dd/mm/yyyy hh:nn'
        Properties.EditFormat = 'dd/mm/yyyy hh:nn'
        Properties.Kind = ckDateTime
        Width = 130
      end
      object cxGrdQuadroTableViewDTAFIM: TcxGridDBColumn
        Caption = 'Data e Hora T'#233'rmino'
        DataBinding.FieldName = 'DTAFIM'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.DisplayFormat = 'dd/mm/yyyy hh:nn'
        Properties.EditFormat = 'dd/mm/yyyy hh:nn'
        Properties.Kind = ckDateTime
        Width = 130
      end
      object cxGrdQuadroTableViewONIBUS: TcxGridDBColumn
        Caption = #212'nibus'
        DataBinding.FieldName = 'ONIBUS'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.EditMask = '999'
        Width = 44
      end
      object cxGrdQuadroTableViewVLRFUN: TcxGridDBColumn
        Caption = 'R$ Valor'
        DataBinding.FieldName = 'VLRFUN'
        Width = 80
      end
      object cxGrdQuadroTableViewGERCTR: TcxGridDBColumn
        Caption = 'Gerar Contrato'
        DataBinding.FieldName = 'GERCTR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Width = 95
      end
    end
    object cxGrdQuadroLevel: TcxGridLevel
      GridView = cxGrdQuadroTableView
    end
  end
  object pnl3: TPanel [5]
    Left = 0
    Top = 447
    Width = 762
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 5
    object cxCboModContrato: TcxLookupComboBox
      Left = 8
      Top = 6
      Properties.KeyFieldNames = 'CODSER'
      Properties.ListColumns = <
        item
          FieldName = 'NOMSER'
        end>
      Properties.ListSource = dtsModContrato
      TabOrder = 0
      Width = 220
    end
    object btnGerarContrato: TBitBtnLocked
      Left = 230
      Top = 7
      Width = 130
      Height = 22
      Caption = '&Gerar Contrato'
      TabOrder = 1
      OnClick = btnGerarContratoClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 160
  end
  object dtsModContrato: TDataSource
    Left = 504
    Top = 160
  end
end
