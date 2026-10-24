inherited frmManLanCon: TfrmManLanCon
  Left = 329
  Top = 205
  Width = 628
  Height = 570
  Caption = 'Manuten'#231#227'o dos Lan'#231'amentos Cont'#225'beis'
  OnDestroy = FormDestroy
  ExplicitWidth = 628
  ExplicitHeight = 570
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 499
    Width = 622
    Height = 26
    ExplicitTop = 499
    ExplicitWidth = 622
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 560
      Height = 22
      ExplicitWidth = 560
      ExplicitHeight = 22
      inherited btnIncluir: TBitBtnLocked
        Width = 70
        ExplicitWidth = 70
      end
      inherited btnGravar: TBitBtnLocked
        Left = 70
        Width = 70
        ExplicitWidth = 70
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 140
        Width = 70
        ExplicitLeft = 140
        ExplicitWidth = 70
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 210
        Width = 70
        ExplicitLeft = 210
        ExplicitWidth = 70
      end
      inherited btnCancela: TBitBtnLocked
        Left = 280
        ExplicitLeft = 280
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 352
        Width = 75
        ExplicitLeft = 352
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 562
      Width = 58
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 562
      ExplicitWidth = 58
    end
    object btnExclusaoLote: TBitBtnLocked
      Left = 430
      Top = 2
      Width = 94
      Height = 20
      Caption = 'Exclus'#227'o &Lote'
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
      OnClick = btnExclusaoLoteClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 622
    Height = 499
    TabOrder = 3
    StyleElements = [seFont, seBorder]
    OnChange = pgcDadosChange
    ExplicitWidth = 622
    ExplicitHeight = 499
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 614
      ExplicitHeight = 467
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 614
        Height = 467
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 40
          Top = 63
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta Cr'#233'dito:'
        end
        object Label3: TLabel
          Left = 460
          Top = 15
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data:'
        end
        object Label6: TLabel
          Left = 18
          Top = 364
          Width = 90
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Lan'#231'amento:'
        end
        object Label10: TLabel
          Left = 44
          Top = 39
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta D'#233'bito:'
        end
        object Label4: TLabel
          Left = 41
          Top = 81
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Complemento:'
        end
        object Label5: TLabel
          Left = 58
          Top = 15
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Emp. Lan.:'
        end
        object Label7: TLabel
          Left = 9
          Top = 388
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro Custo D'#233'bito:'
        end
        object Label8: TLabel
          Left = 263
          Top = 364
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Operador:'
        end
        object lbTipLan: TLabel
          Left = 34
          Top = 439
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Lancto:'
        end
        object Label1: TLabel
          Left = 26
          Top = 338
          Width = 82
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hist'#243'rico Padr'#227'o:'
        end
        object lbCCuscr: TLabel
          Left = 5
          Top = 414
          Width = 103
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro Custo Cr'#233'dito:'
        end
        object dbeConCre: TDBEditFocus
          Tag = 99
          Left = 111
          Top = 59
          Width = 137
          Height = 22
          DataField = 'CON_CONCRE'
          DataSource = dtsLanCon
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          OnClick = dbeConCreClick
          OnKeyPress = dbeConCreKeyPress
          OnKeyUp = dbeConCreKeyUp
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaLan: TDBEditFocus
          Tag = 99
          Left = 489
          Top = 11
          Width = 90
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CON_DTALAN'
          DataSource = dtsLanCon
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeValLan: TDBEditFocus
          Tag = 99
          Left = 111
          Top = 360
          Width = 94
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CON_VALLAN'
          DataSource = dtsLanCon
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtDesConCre: TEditFocus
          Left = 366
          Top = 59
          Width = 214
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
        object dbeConDeb: TDBEditFocus
          Tag = 99
          Left = 111
          Top = 35
          Width = 137
          Height = 22
          DataField = 'CON_CONDEB'
          DataSource = dtsLanCon
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnClick = dbeConDebClick
          OnKeyPress = dbeConDebKeyPress
          OnKeyUp = dbeConDebKeyUp
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesConDeb: TEditFocus
          Left = 366
          Top = 35
          Width = 214
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeHistor: TDBMemoFocus
          Left = 111
          Top = 84
          Width = 468
          Height = 247
          DataField = 'CON_HISTOR'
          DataSource = dtsLanCon
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object dbeEmpLan: TDBEditFocus
          Tag = 99
          Left = 111
          Top = 11
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CON_EMPLAN'
          DataSource = dtsLanCon
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = dbeEmpLanExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCcusto: TDBEditFocus
          Tag = 99
          Left = 111
          Top = 385
          Width = 64
          Height = 22
          DataField = 'CON_CCUSTO'
          DataSource = dtsLanCon
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 14
          OnKeyPress = dbeCcustoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesCCusto: TEditFocus
          Left = 181
          Top = 385
          Width = 398
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtConCreRed: TEditFocus
          Tag = 99
          Left = 250
          Top = 59
          Width = 114
          Height = 22
          Alignment = taLeftJustify
          Color = clWhite
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          OnClick = edtConCreRedClick
          OnKeyUp = edtConCreRedKeyUp
          NormalColor = clWhite
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtConDebRed: TEditFocus
          Tag = 99
          Left = 250
          Top = 35
          Width = 114
          Height = 22
          Alignment = taLeftJustify
          Color = clWhite
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          OnClick = edtConDebRedClick
          OnKeyUp = edtConDebRedKeyUp
          NormalColor = clWhite
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeCodOpe: TDBEditFocus
          Tag = 99
          Left = 315
          Top = 360
          Width = 63
          Height = 22
          Color = 16768952
          DataField = 'CON_CODOPE'
          DataSource = dtsLanCon
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtNomOpe: TEditFocus
          Left = 381
          Top = 360
          Width = 198
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 13
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbcAutoma: TDBCheckBox
          Left = 367
          Top = 439
          Width = 146
          Height = 17
          Caption = 'Lan'#231'amento Autom'#225'tico?'
          Color = 16768952
          DataField = 'CON_AUTOMA'
          DataSource = dtsLanCon
          Enabled = False
          ParentColor = False
          ReadOnly = True
          TabOrder = 19
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object dbgBuscaConta: TDBGridCitel
          Left = 111
          Top = 108
          Width = 474
          Height = 185
          DataSource = dtsBusca
          Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 20
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          Visible = False
          OnDblClick = dbgBuscaContaDblClick
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'CODCON'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CONRED'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCON'
              Visible = True
            end>
        end
        object dbeAutoincrem: TDBEditFocus
          Tag = 99
          Left = 240
          Top = 11
          Width = 202
          Height = 22
          CharCase = ecUpperCase
          DataField = 'AUTOINCREM'
          DataSource = dtsLanCon
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 21
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtTipLan: TComboBoxFocus
          Tag = 99
          Left = 111
          Top = 436
          Width = 242
          Height = 22
          Style = csDropDownList
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeHisPad: TDBEditFocus
          Tag = 99
          Left = 111
          Top = 335
          Width = 64
          Height = 22
          DataField = 'CON_HISPAD'
          DataSource = dtsLanCon
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          OnKeyPress = dbeHisPadKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object edtDesHistPadrao: TEditFocus
          Left = 181
          Top = 335
          Width = 398
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 10
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeCcuscr: TDBEditFocus
          Tag = 99
          Left = 111
          Top = 411
          Width = 64
          Height = 22
          DataField = 'CON_CCUSCR'
          DataSource = dtsLanCon
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 16
          OnKeyPress = dbeCcuscrKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesCcuscr: TEditFocus
          Left = 181
          Top = 411
          Width = 398
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      end
    end
    object tbsConferencia: TTabSheet
      Caption = '2 - Confer'#234'ncia'
      ImageIndex = 1
      object Label11: TLabel
        Left = 29
        Top = 14
        Width = 23
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo:'
      end
      object lblCodEmp: TLabel
        Left = 7
        Top = 40
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object Label12: TLabel
        Left = 358
        Top = 13
        Width = 39
        Height = 14
        Alignment = taRightJustify
        Caption = 'Per'#237'odo:'
      end
      object Label13: TLabel
        Left = 4
        Top = 311
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Conta D'#233'bito:'
      end
      object Label14: TLabel
        Left = 0
        Top = 339
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Conta Cr'#233'dito:'
      end
      object Label15: TLabel
        Left = 23
        Top = 367
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object Label16: TLabel
        Left = 40
        Top = 395
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor:'
      end
      object Label17: TLabel
        Left = 448
        Top = 339
        Width = 37
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cr'#233'dito:'
      end
      object Label18: TLabel
        Left = 452
        Top = 311
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'D'#233'bito:'
      end
      object edtTipoLanctoConf: TComboBoxFocus
        Tag = 99
        Left = 60
        Top = 9
        Width = 285
        Height = 22
        Style = csDropDownList
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 60
        Top = 37
        Width = 53
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 3
        OnExit = edtCodEmpExit
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomEmp: TEditFocus
        Left = 120
        Top = 37
        Width = 225
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 484
        Top = 9
        Width = 70
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 2
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 408
        Top = 9
        Width = 70
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object cxgConf: TcxGridCitel
        Left = 3
        Top = 69
        Width = 598
        Height = 231
        TabOrder = 7
        object cxgConfDBTableViewCitel1: TcxGridDBTableViewCitel
          OnKeyUp = cxgConfDBTableViewCitel1KeyUp
          Navigator.Buttons.CustomButtons = <>
          OnCellClick = cxgConfDBTableViewCitel1CellClick
          DataController.DataSource = dtsConfer
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgConfDBTableViewCitel1Column1: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'CON_EMPLAN'
            Width = 53
          end
          object cxgConfDBTableViewCitel1Column2: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'CON_DTALAN'
            Width = 66
          end
          object cxgConfDBTableViewCitel1Column4: TcxGridDBColumn
            Caption = 'Conta D'#233'bito'
            DataBinding.FieldName = 'CONDEB'
            Width = 150
          end
          object cxgConfDBTableViewCitel1Column5: TcxGridDBColumn
            Caption = 'Conta Cr'#233'dito'
            DataBinding.FieldName = 'CONCRE'
            Width = 150
          end
          object cxgConfDBTableViewCitel1Column6: TcxGridDBColumn
            Caption = 'Valor'
            DataBinding.FieldName = 'CON_VALLAN'
            Width = 74
          end
          object cxgConfDBTableViewCitel1Column7: TcxGridDBColumn
            Caption = 'Hist'#243'rico'
            DataBinding.FieldName = 'CON_HISPAD'
            Width = 50
          end
        end
        object cxgConfLevel1: TcxGridLevel
          GridView = cxgConfDBTableViewCitel1
        end
      end
      object edtContaDebitoConf: TEditFocus
        Tag = 99
        Left = 80
        Top = 308
        Width = 267
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtContaCreditoConf: TEditFocus
        Tag = 99
        Left = 80
        Top = 336
        Width = 267
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtHisPadConf: TEditFocus
        Tag = 99
        Left = 80
        Top = 364
        Width = 55
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesHisPadConf: TEditFocus
        Left = 141
        Top = 364
        Width = 206
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 13
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValLanConf: TEditFocus
        Tag = 99
        Left = 80
        Top = 392
        Width = 105
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtSomaCReditoConf: TEditFocus
        Tag = 99
        Left = 497
        Top = 336
        Width = 105
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtSomaDebitoConf: TEditFocus
        Tag = 99
        Left = 497
        Top = 308
        Width = 105
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object btnFiltrar: TBitBtnLocked
        Left = 360
        Top = 37
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
        PopupMenu = popConsulta
        TabOrder = 5
        OnClick = btnFiltrarClick
      end
      object btnCancelar: TBitBtnLocked
        Left = 456
        Top = 37
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
        TabOrder = 6
        OnClick = btnCancelarClick
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 525
    Width = 622
    ExplicitTop = 525
    ExplicitWidth = 622
    inherited pnlNomeForm: TPanel
      Left = 478
      Width = 144
      ExplicitLeft = 478
      ExplicitWidth = 144
    end
    inherited pnlInfo: TPanel
      Width = 478
      ExplicitWidth = 478
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 284
    Top = 140
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 252
    Top = 140
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 216
  end
  object dtsLanCon: TDataSource
    Left = 40
    Top = 192
  end
  object dtsBusca: TDataSource
    Left = 420
    Top = 188
  end
  object dtsConfer: TDataSource
    Left = 160
    Top = 304
  end
  object popConsulta: TPopupMenu
    Left = 468
    Top = 144
    object mnuFiltros: TMenuItem
      Caption = 'Utilizando os filtros selecionados.'
      OnClick = mnuFiltrosClick
    end
    object mnuRegistroSelecionado: TMenuItem
      Caption = 'Todos os lan'#231'amentos do registro selecionado.'
      OnClick = mnuRegistroSelecionadoClick
    end
  end
end
