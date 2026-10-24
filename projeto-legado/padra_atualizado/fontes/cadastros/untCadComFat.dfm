inherited frmCadComFat: TfrmCadComFat
  Left = 244
  Top = 135
  Width = 629
  Height = 500
  Caption = 'Faixa de faturamento para comiss'#227'o de vendedores'
  OnDestroy = FormDestroy
  ExplicitWidth = 629
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  object lbl19: TLabel [0]
    Left = 0
    Top = 410
    Width = 623
    Height = 20
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 'Pressione [ DELETE ] para excluir qualquer registro da grid'
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    StyleElements = [seFont, seBorder]
    ExplicitLeft = 8
    ExplicitTop = 400
    ExplicitWidth = 618
  end
  inherited pnlBotoes: TPanel
    Top = 430
    Width = 623
    Height = 25
    ExplicitTop = 430
    ExplicitWidth = 618
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 542
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 614
      ExplicitHeight = 21
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 544
      Height = 21
      Align = alRight
      ExplicitLeft = 538
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 623
    Height = 410
    ExplicitWidth = 618
    ExplicitHeight = 410
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 610
      ExplicitHeight = 378
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 623
    Height = 410
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitWidth = 618
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 621
      Height = 65
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      ExplicitWidth = 616
      object Label1: TLabel
        Left = 10
        Top = 13
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 116
        Top = 13
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object dbeCodPes: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 9
        Width = 62
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_CODTAB'
        DataSource = dtsComFat
        TabOrder = 0
        OnExit = dbeCodPesExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDescricao: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 9
        Width = 438
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_DESCRI'
        DataSource = dtsComFat
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object pnlDepartamento: TPanel
        Left = 3
        Top = 33
        Width = 608
        Height = 28
        BevelOuter = bvNone
        TabOrder = 2
        object lblCodDep: TLabel
          Left = 5
          Top = 3
          Width = 38
          Height = 14
          Alignment = taRightJustify
          Caption = 'Depart.:'
        end
        object dbeCodDep: TDBEditFocus
          Tag = 99
          Left = 45
          Top = 0
          Width = 62
          Height = 22
          CharCase = ecUpperCase
          DataField = 'COM_CODDEP'
          DataSource = dtsComFat
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnKeyPress = dbeCodDepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object edtDesDep: TEditFocus
          Left = 108
          Top = 0
          Width = 498
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
    end
    object pnlGrid: TPanel
      Left = 1
      Top = 324
      Width = 621
      Height = 85
      Align = alClient
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 3
      ExplicitWidth = 616
      object Label12: TLabel
        Left = 8
        Top = 293
        Width = 228
        Height = 14
        Caption = 'Pressione [DEL] para remover registros do Grid'
      end
      object dbgDados: TDBGridCitel
        Left = 0
        Top = 0
        Width = 621
        Height = 287
        Align = alTop
        DataSource = dtsDados
        Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDblClick = dbgDadosDblClick
        OnKeyDown = dbgDadosKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_MARINI'
            Title.Alignment = taRightJustify
            Title.Caption = 'Margem Inicial'
            Width = 98
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_MARFIN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Margem Final'
            Width = 89
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_FATINI'
            Title.Alignment = taRightJustify
            Title.Caption = 'Faturamento Inicial'
            Width = 145
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_FATFIN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Faturamento Final'
            Width = 145
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_PERCOM'
            Title.Alignment = taRightJustify
            Title.Caption = '% Comiss'#227'o'
            Width = 100
            Visible = True
          end>
      end
    end
    object pnlCentro: TPanel
      Left = 1
      Top = 274
      Width = 621
      Height = 50
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 2
      ExplicitWidth = 616
      object Label5: TLabel
        Left = 230
        Top = 8
        Width = 89
        Height = 14
        Caption = 'Faturamento Inicial'
      end
      object Label6: TLabel
        Left = 338
        Top = 8
        Width = 85
        Height = 14
        Caption = 'Faturamento Final'
      end
      object Label7: TLabel
        Left = 450
        Top = 8
        Width = 60
        Height = 14
        Caption = '% Comiss'#227'o'
      end
      object Label8: TLabel
        Left = 8
        Top = 8
        Width = 67
        Height = 14
        Caption = 'Margem Inicial'
      end
      object Label9: TLabel
        Left = 116
        Top = 8
        Width = 63
        Height = 14
        Caption = 'Margem Final'
      end
      object Bevel1: TBevel
        Left = 222
        Top = 8
        Width = 2
        Height = 35
      end
      object Bevel2: TBevel
        Left = 443
        Top = 8
        Width = 2
        Height = 35
      end
      object edtFatIni: TEditFocus
        Tag = 99
        Left = 230
        Top = 22
        Width = 103
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 2
        Text = '0,000'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object edtFatFin: TEditFocus
        Tag = 99
        Left = 335
        Top = 22
        Width = 103
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 3
        Text = '0,000'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object edtPerCom: TEditFocus
        Tag = 99
        Left = 450
        Top = 22
        Width = 81
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 4
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
      object btnAdicionar: TBitBtnLocked
        Left = 537
        Top = 23
        Width = 72
        Height = 20
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
        TabOrder = 5
        OnClick = btnAdicionarClick
      end
      object dbeMarIni: TEditFocus
        Tag = 99
        Left = 8
        Top = 21
        Width = 103
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 0
        Text = '0,000'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object dbeMarFin: TEditFocus
        Tag = 99
        Left = 113
        Top = 22
        Width = 103
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 1
        Text = '0,000'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
    end
    object pnlMecanicos: TPanel
      Left = 1
      Top = 66
      Width = 621
      Height = 208
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      ExplicitWidth = 616
      object Panel2: TPanel
        Left = 2
        Top = 2
        Width = 617
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 612
        DesignSize = (
          617
          41)
        object lbl1: TLabel
          Left = 6
          Top = 7
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Mec'#226'nico:'
        end
        object btnAddMecanico: TBitBtnLocked
          Left = 525
          Top = 3
          Width = 87
          Height = 22
          Anchors = [akTop, akRight]
          Caption = '&Adicionar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFAB4B14AE4B13AE4B13B04B14B04B14B04B14B04A12B0
            4912AF4C14AD4C15FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAA4B15AC4A10
            D05524F1614AF86B53F97A5BF98067F9705DF26149C3542CAA4A13FF00FFFF00
            FFFF00FFFF00FFFF00FFA94B14AF4A13DA572DF67257FC8C69FB7F5BFCBFB0FB
            C7C1F36047CD5737AA4C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB24B18
            E4623CFE8E6DFF8A63FF9072FFEEEBFFEEEBF77E62C2532EA84B18FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAF4D1BD86740FD8A5DF58059DEB5AAE8F6F5FE
            D8CAFF906DCF663EA84914FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            E66D3993484049396E294187374B8A6E556DD96C42CF632DFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C33950138AD0A38A305309E00
            258D2B2F7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            0016411658CA1C55BC1B56BC1C54BB1954BC0338ACFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF000000143E802677F32069D81E64CF1F62CD21
            68D21E5EC5FF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FF000000
            123E752676D92165BD1F63CA1D5CC32472DB256FDBFF00FFFF00FFFF00FF317F
            13317F13FF00FFFF00FFFF00FF0505050D11130208121645723295F22E8AF131
            93F8277AEDFF00FF317F13317F132B99322B9630317F13317F13FF00FF3B3836
            3B383638332C123454288CD536A2F3339DEE1C50B7FF00FF317F13317F132C90
            2B2C902B317F13317F13FF00FFFF00FF3E3C3A7574746C69673C414B162A3F11
            2136FF00FFFF00FFFF00FFFF00FF317F13317F13FF00FFFF00FFFF00FFFF00FF
            FF00FF91908E91908E857F7A342E29FF00FFFF00FFFF00FFFF00FFFF00FF317F
            13317F13FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 1
          OnClick = btnAddMecanicoClick
          ExplicitLeft = 520
        end
        object edtNomMec: TEditFocus
          Left = 109
          Top = 3
          Width = 409
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtCodMec: TEditFocus
          Tag = 99
          Left = 58
          Top = 3
          Width = 50
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          OnKeyPress = edtCodMecKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
      end
      object Panel3: TPanel
        Left = 2
        Top = 36
        Width = 617
        Height = 170
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 612
        object grdMecanicos: TcxGridCitel
          Left = 0
          Top = 0
          Width = 617
          Height = 170
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 612
          object grdDbMecanicos: TcxGridDBTableViewCitel
            OnKeyDown = grdDbMecanicosKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsMecanicos
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object grdDbMecanicosColumn1: TcxGridDBColumn
              Caption = 'C'#243'digo do Mec'#226'nico'
              DataBinding.FieldName = 'COM_CODMEC'
              Width = 120
            end
            object grdDbMecanicosColumn2: TcxGridDBColumn
              Caption = 'Nome do Mec'#226'nico'
              DataBinding.FieldName = 'OPE_NOMOPE'
              Width = 418
            end
          end
          object grdMecanicosLevel1: TcxGridLevel
            GridView = grdDbMecanicos
          end
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 623
    ExplicitTop = 455
    ExplicitWidth = 618
    inherited pnlNomeForm: TPanel
      Left = 276
      ExplicitLeft = 271
    end
    inherited pnlInfo: TPanel
      Width = 276
      ExplicitWidth = 271
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 832
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 800
    Top = 8
  end
  object dtsComFat: TDataSource
    Left = 320
    Top = 240
  end
  object dtsDados: TDataSource
    Left = 353
    Top = 240
  end
  object dtsMecanicos: TDataSource
    Left = 49
    Top = 176
  end
end
