inherited frmEditorMetas: TfrmEditorMetas
  Width = 1366
  Height = 768
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Editor de Metas'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1366
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1360
    ExplicitTop = 695
    ExplicitWidth = 1360
    inherited FlwBotoes: TFlowPanel
      Width = 1356
      ExplicitTop = 2
      ExplicitWidth = 1356
    end
    inherited btnSair: TBitBtnLocked
      Left = 1280
      ExplicitLeft = 1280
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1360
    ExplicitTop = 723
    ExplicitWidth = 1360
    inherited pnlNomeForm: TPanel
      Left = 1013
      ExplicitLeft = 1013
    end
    inherited pnlInfo: TPanel
      Width = 1013
      ExplicitWidth = 1013
    end
  end
  inherited pgcDados: TPageControl
    Width = 1360
    Height = 695
    ExplicitWidth = 1360
    ExplicitHeight = 695
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1352
      ExplicitHeight = 663
    end
  end
  object pnlFundoAbaGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 1360
    Height = 695
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object pnlBotoesAbaGeral: TPanel
      Left = 0
      Top = 670
      Width = 1360
      Height = 25
      Align = alBottom
      TabOrder = 3
      object btnCopiarMetas: TBitBtnLocked
        Left = 1
        Top = 1
        Width = 121
        Height = 23
        Align = alLeft
        Caption = '[F3] Copiar Metas'
        TabOrder = 0
        OnClick = btnCopiarMetasClick
      end
      object btnHeranca: TBitBtnLocked
        Left = 1238
        Top = 1
        Width = 121
        Height = 23
        Align = alRight
        Caption = '[F6] Heran'#231'a'
        TabOrder = 1
        TabStop = False
        OnClick = btnHerancaClick
      end
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 1360
      Height = 58
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 35
        Top = 8
        Width = 26
        Height = 14
        Caption = 'Meta:'
      end
      object Label2: TLabel
        Left = 16
        Top = 32
        Width = 45
        Height = 14
        Caption = 'Empresa:'
      end
      object Label3: TLabel
        Left = 525
        Top = 32
        Width = 54
        Height = 14
        Caption = 'Data Inicial:'
      end
      object Label4: TLabel
        Left = 681
        Top = 32
        Width = 50
        Height = 14
        Caption = 'Data Final:'
      end
      object edtCodMet: TEditFocus
        Tag = 99
        Left = 67
        Top = 5
        Width = 78
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesMet: TEditFocus
        Tag = 99
        Left = 149
        Top = 5
        Width = 678
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 67
        Top = 29
        Width = 78
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 2
        OnKeyPress = edtCodVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomEmp: TEditFocus
        Left = 149
        Top = 29
        Width = 372
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16770261
        Enabled = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDtaIni: TcxDateEdit
        Tag = 99
        Left = 585
        Top = 29
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 4
        Width = 90
      end
      object edtDtaFin: TcxDateEdit
        Tag = 99
        Left = 737
        Top = 29
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 5
        Width = 90
      end
    end
    object pnlFundoAbaDigitacaoMetas: TPanel
      Left = 0
      Top = 281
      Width = 1360
      Height = 389
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object cxgMetas: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1360
        Height = 389
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgMetasDBTableViewCitel: TcxGridDBTableViewCitel
          OnKeyDown = cxgMetasDBTableViewCitelKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyDown = cxgMetasDBTableViewCitelEditKeyDown
          DataController.DataSource = dtsMetas
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnMoving = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
        end
        object cxgMetasLevel1: TcxGridLevel
          GridView = cxgMetasDBTableViewCitel
        end
      end
    end
    object pnlColunasFiltrosEMetas: TPanel
      Left = 0
      Top = 58
      Width = 1360
      Height = 223
      Align = alTop
      TabOrder = 1
      object pnlFiltros: TPanel
        Left = 9
        Top = -1
        Width = 521
        Height = 221
        BevelOuter = bvNone
        TabOrder = 0
        object Label5: TLabel
          Left = 79
          Top = 8
          Width = 57
          Height = 14
          Caption = 'Vendedor:'
          FocusControl = edtCodVen
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 84
          Top = 32
          Width = 52
          Height = 14
          Caption = 'Digitador:'
          FocusControl = edtCodDig
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 51
          Top = 56
          Width = 85
          Height = 14
          Caption = 'Representante:'
          FocusControl = edtCodRep
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 77
          Top = 80
          Width = 59
          Height = 14
          Caption = 'Fornecedor:'
          FocusControl = edtCodFor
        end
        object Label9: TLabel
          Left = 29
          Top = 104
          Width = 107
          Height = 14
          Caption = 'Atividade Fornecedor:'
          FocusControl = edtAtiFor
        end
        object Label10: TLabel
          Left = 103
          Top = 128
          Width = 33
          Height = 14
          Caption = 'Marca:'
          FocusControl = edtCodMar
        end
        object Label11: TLabel
          Left = 74
          Top = 152
          Width = 62
          Height = 14
          Caption = 'Linha/Grupo:'
          FocusControl = edtLinGru
        end
        object Label12: TLabel
          Left = 96
          Top = 176
          Width = 40
          Height = 14
          Caption = 'Produto:'
          FocusControl = edtCodIte
        end
        object Label13: TLabel
          Left = 11
          Top = 200
          Width = 125
          Height = 14
          Caption = 'Departamento do Produto:'
          FocusControl = edtDepIte
        end
        object edtCodVen: TEditFocus
          Tag = 99
          Left = 147
          Top = 5
          Width = 78
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 0
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtNomVen: TEditFocus
          Left = 229
          Top = 5
          Width = 267
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16770261
          Enabled = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomDig: TEditFocus
          Left = 229
          Top = 29
          Width = 267
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16770261
          Enabled = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodDig: TEditFocus
          Tag = 99
          Left = 147
          Top = 29
          Width = 78
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 2
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtNomRep: TEditFocus
          Left = 229
          Top = 53
          Width = 267
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16770261
          Enabled = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodRep: TEditFocus
          Tag = 99
          Left = 147
          Top = 53
          Width = 78
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 4
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtNomFor: TEditFocus
          Left = 229
          Top = 77
          Width = 267
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16770261
          Enabled = False
          ReadOnly = True
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodFor: TEditFocus
          Tag = 99
          Left = 147
          Top = 77
          Width = 78
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 8
          TabOrder = 6
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttAlfanumerico
        end
        object edtDesAtiFor: TEditFocus
          Left = 229
          Top = 101
          Width = 267
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16770261
          Enabled = False
          ReadOnly = True
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAtiFor: TEditFocus
          Tag = 99
          Left = 147
          Top = 101
          Width = 78
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 8
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtDesMar: TEditFocus
          Left = 229
          Top = 125
          Width = 267
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16770261
          Enabled = False
          ReadOnly = True
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodMar: TEditFocus
          Tag = 99
          Left = 147
          Top = 125
          Width = 78
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 6
          TabOrder = 10
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttAlfanumerico
        end
        object edtDesLinGru: TEditFocus
          Left = 229
          Top = 149
          Width = 267
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16770261
          Enabled = False
          ReadOnly = True
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesIte: TEditFocus
          Left = 229
          Top = 173
          Width = 267
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16770261
          Enabled = False
          ReadOnly = True
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodIte: TEditFocus
          Tag = 99
          Left = 147
          Top = 173
          Width = 78
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 14
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesDepIte: TEditFocus
          Left = 229
          Top = 197
          Width = 267
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16770261
          Enabled = False
          ReadOnly = True
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDepIte: TEditFocus
          Tag = 99
          Left = 147
          Top = 197
          Width = 78
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 16
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtLinGru: TMaskEditFocus
          Tag = 99
          Left = 147
          Top = 149
          Width = 78
          Height = 22
          CharCase = ecUpperCase
          EditMask = '999.999;0;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentFont = False
          TabOrder = 12
          Text = ''
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
      object pnlMetas: TPanel
        Left = 568
        Top = 0
        Width = 291
        Height = 220
        BevelOuter = bvNone
        TabOrder = 1
        object lblPositivacaoClientes: TLabel
          Left = 59
          Top = 8
          Width = 114
          Height = 14
          Caption = 'Positiva'#231#227'o de Clientes:'
          FocusControl = edtPosCli
        end
        object Label15: TLabel
          Left = 97
          Top = 32
          Width = 76
          Height = 14
          Caption = 'Itens por Notas:'
          FocusControl = edtIteNot
        end
        object Label16: TLabel
          Left = 96
          Top = 56
          Width = 77
          Height = 14
          Caption = 'Valor de Venda:'
          FocusControl = edtValVen
        end
        object Label17: TLabel
          Left = 33
          Top = 80
          Width = 140
          Height = 14
          Caption = 'Volume de Vendas em Litros:'
          FocusControl = edtVolLit
        end
        object Label18: TLabel
          Left = 15
          Top = 104
          Width = 158
          Height = 14
          Caption = 'Volume de Vendas em Unidades:'
          FocusControl = edtVolUni
        end
        object Label19: TLabel
          Left = 86
          Top = 128
          Width = 87
          Height = 14
          Caption = 'Margem de Lucro:'
          FocusControl = edtMarLuc
        end
        object edtPosCli: TcxCurrencyEdit
          Left = 180
          Top = 5
          Properties.Alignment.Horz = taRightJustify
          Properties.DecimalPlaces = 0
          Properties.DisplayFormat = '0;-0'
          TabOrder = 0
          Width = 80
        end
        object edtIteNot: TcxCurrencyEdit
          Left = 180
          Top = 29
          Properties.Alignment.Horz = taRightJustify
          Properties.DecimalPlaces = 0
          Properties.DisplayFormat = '0;-0'
          TabOrder = 1
          Width = 80
        end
        object edtValVen: TcxCurrencyEdit
          Left = 180
          Top = 53
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          TabOrder = 2
          Width = 80
        end
        object edtVolLit: TcxCurrencyEdit
          Left = 180
          Top = 77
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          TabOrder = 3
          Width = 80
        end
        object edtVolUni: TcxCurrencyEdit
          Left = 180
          Top = 101
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          TabOrder = 4
          Width = 80
        end
        object edtMarLuc: TcxCurrencyEdit
          Left = 180
          Top = 125
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          TabOrder = 5
          Width = 80
        end
        object btnGerarMetas: TBitBtnLocked
          Left = 141
          Top = 195
          Width = 121
          Height = 24
          Caption = '[F4] Gerar Metas'
          TabOrder = 6
          OnClick = btnGerarMetasClick
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1088
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 976
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1104
    Top = 184
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 1212
    Top = 180
    PixelsPerInch = 96
    object cxHeaderNegrito: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxGeralContent: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
  end
  object dtsMetas: TDataSource
    Left = 1180
    Top = 108
  end
end
