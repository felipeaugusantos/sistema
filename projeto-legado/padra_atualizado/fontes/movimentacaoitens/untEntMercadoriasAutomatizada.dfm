inherited frmEntMercadoriasAutomatizada: TfrmEntMercadoriasAutomatizada
  Width = 1338
  Height = 750
  BorderStyle = bsSizeable
  Caption = 'Entrada de Mercadorias Automatizada'
  OnDestroy = FormDestroy
  ExplicitWidth = 1338
  ExplicitHeight = 750
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 669
    Width = 1322
    TabOrder = 1
    ExplicitTop = 669
    ExplicitWidth = 1322
    inherited FlwBotoes: TFlowPanel
      Width = 1318
      ExplicitWidth = 1318
      inherited btnConfirma: TBitBtnLocked
        Width = 121
        Caption = '[ F10 ] &Confirma'
        ExplicitWidth = 121
      end
      object btnReplica: TBitBtnLocked
        Left = 121
        Top = 0
        Width = 144
        Height = 22
        Caption = 'Replicar Nat. Opera'#231#227'o'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000100000006000000090000000A0000000A0000000B0000
          000B0000000B0000000B0000000B000000070000000200000000000000000000
          00000000000000000005123269BD184492FF174490FF174391FF174190FF1640
          8FFF16408EFF163F8EFF163E8DFF0F2C65BE0000000700000000000000010000
          000600000009000000121A4996FF65BBECFF4BABE8FF4AAAE8FF49ABE7FF48AA
          E7FF49A9E7FF48A9E7FF55B0E9FF16418FFF0000000A00000000000000051F40
          75BD2A59A3FF7794C0FF1C4E9AFF6FC1EEFF4EAFE9FF4DAFE8FF4DADE8FF4CAC
          E8FF4CACE8FF4BACE8FF5AB5EBFF184592FF0000000A00000000000000082C5F
          A6FF79C6F0FF99CDECFF1F539DFF78C8F0FF52B2E9FF51B1E9FF50B1EAFF50B0
          E9FF4FAFE9FF4FAFE9FF61B8ECFF1A4996FF0000000900000000000000072E64
          A9FF82CCF1FF9BD0EEFF2158A1FF82CDF2FF56B5EAFF55B4ECFF54B3EAFF53B3
          EAFF53B3EAFF51B2EAFF67BDEDFF1C4E9AFF0000000800000000000000073168
          ACFF8BD1F3FF9ED3EFFF235DA6FF8AD2F4FF5EBAEDFF61BDEEFF62BEEEFF61BD
          EEFF5EBCECFF5BB7EBFF6EC2EEFF23589FFF000000080000000000000006346D
          B0FF93D5F5FFA0D4EFFF2764ABFF9BDBF6FF6AC4F0FF69C3F0FF69C3F0FF68C3
          F0FF67C2F0FF66C2EFFF7ECBF3FF265FA5FF0000000700000000000000053672
          B4FF9BDAF5FFA5D9F2FF2E6EB0FFA7E1F7FF70C9F1FF70C8F1FF6FC8F2FF6EC8
          F1FF6EC7F0FF6DC6F1FF88D2F4FF2B65AAFF0000000600000000000000053B79
          B8FFA9E2F7FFABDDF3FF3375B6FFAEE5F9FFAEE5F9FFAEE4F9FFADE4F9FFADE4
          F9FFACE4F9FFAAE4F8FFAAE3F8FF2D6CAEFF0000000600000000000000044282
          BDFFB5E6F8FFB0E0F5FF357AB9FF3C80BCFF3A7EBBFF397CBAFF397AB8FF3878
          B7FF3676B6FF3675B5FF3573B3FF3171B3FF0000000500000000000000044689
          C1FFBAE9F9FFD2EFF9FF4086C0FFAFC8E0FFFEFEFEFFFDFCFCFFFCFAF9FFFAF8
          F6FFF8F5F3FFF7F2F0FFF6F0ECFF3C7DBAFF000000040000000000000003498E
          C5FF4586BFFF83ADD3FF5696C7FF448CC3FF4489C2FF4288C2FF4288C2FF4287
          C2FF4187C0FF4185BFFF4084BFFF2F618EBF0000000200000000000000025397
          CBFFB3CBE1FFFEFEFEFFFDFCFCFFFBFAF9FFFAF9F7FFF9F7F6FFF8F6F4FFF6F3
          F1FF91B8D8FF0000000700000003000000020000000100000000000000014275
          99BF589DCDFF589BCCFF579ACCFF579ACCFF5799CCFF5699CBFF5697CAFF5597
          CAFF3F7095BF0000000200000000000000000000000000000000000000000000
          0001000000020000000200000002000000020000000300000003000000030000
          0003000000020000000100000000000000000000000000000000}
        TabOrder = 1
        OnClick = btnReplicaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1239
      ExplicitLeft = 1239
    end
  end
  inherited pnlStatus: TPanel
    Top = 695
    Width = 1322
    TabOrder = 2
    ExplicitTop = 695
    ExplicitWidth = 1322
    inherited pnlNomeForm: TPanel
      Left = 1151
      ExplicitLeft = 1151
    end
    inherited pnlInfo: TPanel
      Width = 1151
      ExplicitWidth = 1151
    end
  end
  object pgcAbas: TPageControl [2]
    Left = 0
    Top = 0
    Width = 1322
    Height = 669
    ActivePage = tbsItens
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    TabStop = False
    OnChange = pgcAbasChange
    object tbsItens: TTabSheet
      Caption = '&1 - Produtos'
      object pnlCabecalho: TPanel
        Left = 0
        Top = 0
        Width = 1314
        Height = 81
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 24
          Top = 11
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data de Entrada:'
        end
        object Label2: TLabel
          Left = 7
          Top = 34
          Width = 97
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#250'mero Documento:'
        end
        object lblCliFor: TLabel
          Left = 45
          Top = 57
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
        end
        object Label4: TLabel
          Left = 279
          Top = 34
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'S'#233'rie:'
        end
        object Label5: TLabel
          Left = 210
          Top = 11
          Width = 97
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data do Documento:'
        end
        object Label6: TLabel
          Left = 529
          Top = 34
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'Esp'#233'cie:'
        end
        object lblCgcCpf: TLabel
          Left = 507
          Top = 57
          Width = 63
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'CNPJ:'
        end
        object mskDtaEnt: TMaskEditFocus
          Tag = 99
          Left = 107
          Top = 7
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          EditMask = '99/99/9999'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtNumDoc: TEditFocus
          Tag = 99
          Left = 107
          Top = 30
          Width = 96
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 12
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttInteiro
        end
        object edtSerie: TEditFocus
          Tag = 99
          Left = 310
          Top = 30
          Width = 63
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
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
        object mskDtaDoc: TMaskEditFocus
          Tag = 99
          Left = 310
          Top = 7
          Width = 63
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          EditMask = '99/99/9999'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ReadOnly = True
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtEspDoc: TEditFocus
          Tag = 99
          Left = 574
          Top = 30
          Width = 63
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object edtCodFor: TEditFocus
          Tag = 99
          Left = 107
          Top = 53
          Width = 96
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomFor: TEditFocus
          Left = 203
          Top = 53
          Width = 304
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 6
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCgcCpf: TEditFocus
          Left = 574
          Top = 53
          Width = 135
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
      end
      object cxgItens: TcxGridCitel
        Left = 0
        Top = 81
        Width = 1314
        Height = 556
        Align = alClient
        TabOrder = 1
        OnExit = cxgItensExit
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvItens: TcxGridDBTableViewCitel
          OnKeyPress = cxvItensKeyPress
          Navigator.Buttons.CustomButtons = <>
          OnCellClick = cxvItensCellClick
          OnEditChanged = cxvItensEditChanged
          OnEditKeyDown = cxvItensEditKeyDown
          OnEditKeyPress = cxvItensEditKeyPress
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle1
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxvItensNROITE: TcxGridDBColumn
            Caption = 'Seq.'
            DataBinding.FieldName = 'ENT_N_ITEM_TELA'
            Options.Editing = False
            Width = 35
          end
          object cxvItensCODBAR: TcxGridDBColumn
            Caption = 'C'#243'digo de Barras'
            DataBinding.FieldName = 'ENT_CODBAR'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 107
          end
          object cxvItensDESITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do produto'
            DataBinding.FieldName = 'ENT_DESITE'
            Options.Editing = False
            Width = 256
          end
          object cxvItensQTDITE: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'ENT_QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 80
          end
          object cxvItensUNITAR: TcxGridDBColumn
            Caption = 'Valor unit'#225'rio'
            DataBinding.FieldName = 'ENT_UNITAR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 80
          end
          object cxvItensVALTOT: TcxGridDBColumn
            Caption = 'Valor total'
            DataBinding.FieldName = 'ENT_TOTITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 80
          end
          object cxvItensVLRCON: TcxGridDBColumn
            Caption = 'Valor Cont'#225'bil'
            DataBinding.FieldName = 'ENT_VLRCON'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 80
          end
          object cxvItensCODCTU: TcxGridDBColumn
            Caption = 'Plano de Contas'
            DataBinding.FieldName = 'ENT_CODCTU'
            PropertiesClassName = 'TcxMaskEditProperties'
            Properties.EditMask = '99.99.999;0;_'
            Properties.OnValidate = cxvItensCODCTAPropertiesValidate
            OnGetDisplayText = cxvItensCODCTUGetDisplayText
            Width = 289
          end
          object cxvItensDESCTA: TcxGridDBColumn
            DataBinding.FieldName = 'ENT_DESCTA'
            Visible = False
          end
          object cxvItensCODCST: TcxGridDBColumn
            Caption = 'CST'
            DataBinding.FieldName = 'ENT_CODFIS'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.MaxLength = 3
            Properties.OnValidate = cxvItensCODCSTPropertiesValidate
            Width = 70
          end
          object cxvItensCDCFOP: TcxGridDBColumn
            Caption = 'CFOP'
            DataBinding.FieldName = 'ENT_CLAFIS'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.MaxLength = 4
            Properties.OnEditValueChanged = cxvItensCDCFOPPropertiesEditValueChanged
            Properties.OnValidate = cxvItensCDCFOPPropertiesValidate
            Width = 70
          end
          object cxvItensNatOpe: TcxGridDBColumn
            Caption = 'Natureza da Opera'#231#227'o'
            DataBinding.FieldName = 'ENT_NATOPE'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.ReadOnly = False
            OnGetProperties = cxvItensNatOpeGetProperties
            Width = 146
          end
        end
        object cxgItensLevel1: TcxGridLevel
          GridView = cxvItens
        end
      end
    end
    object tbsLivro: TTabSheet
      Caption = '2 - Livro Fiscal'
      ImageIndex = 1
      OnShow = tbsLivroShow
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1314
        Height = 87
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label3: TLabel
          Left = 190
          Top = 7
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor ICMS:'
        end
        object Label7: TLabel
          Left = 348
          Top = 7
          Width = 98
          Height = 14
          Alignment = taRightJustify
          Caption = 'Base Sub.Tribut'#225'ria:'
        end
        object Label8: TLabel
          Left = 168
          Top = 30
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Desconto:'
        end
        object TLabel
          Left = 14
          Top = 30
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Frete:'
        end
        object Label10: TLabel
          Left = 342
          Top = 30
          Width = 104
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Desp.Acess'#243'rias:'
        end
        object Label28: TLabel
          Left = 15
          Top = 7
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Base ICMS:'
        end
        object Label29: TLabel
          Left = 610
          Top = 30
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor IPI:'
        end
        object Label32: TLabel
          Left = 549
          Top = 7
          Width = 101
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Sub. Tribut'#225'ria:'
        end
        object Label11: TLabel
          Left = 759
          Top = 30
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Total Nota:'
        end
        object Label12: TLabel
          Left = 762
          Top = 7
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Produtos:'
        end
        object lblCODMOD: TLabel
          Left = 568
          Top = 52
          Width = 37
          Height = 14
          Caption = 'Modelo:'
        end
        object edtDesEsp: TEditFocus
          Left = 250
          Top = 26
          Width = 70
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWhite
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtTotIte: TEditFocus
          Left = 841
          Top = 3
          Width = 70
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWhite
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object DBEditFocus1: TDBEditFocus
          Tag = 99
          Left = 74
          Top = 3
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'FIS_BASICT'
          DataSource = dtsCadFis
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
          NormalColor = clWindow
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object DBEditFocus2: TDBEditFocus
          Tag = 99
          Left = 250
          Top = 3
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLRICT'
          DataSource = dtsCadFis
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object DBEditFocus3: TDBEditFocus
          Tag = 99
          Left = 451
          Top = 3
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'FIS_BCRETT'
          DataSource = dtsCadFis
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object DBEditFocus4: TDBEditFocus
          Tag = 99
          Left = 655
          Top = 3
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'FIS_RETIDT'
          DataSource = dtsCadFis
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object DBEditFocus5: TDBEditFocus
          Tag = 99
          Left = 451
          Top = 26
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'FIS_DACEST'
          DataSource = dtsCadFis
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object DBEditFocus6: TDBEditFocus
          Tag = 99
          Left = 655
          Top = 26
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLRIPT'
          DataSource = dtsCadFis
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object DBEditFocus7: TDBEditFocus
          Tag = 99
          Left = 74
          Top = 26
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLFRET'
          DataSource = dtsCadFis
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object DBEditFocus8: TDBEditFocus
          Tag = 99
          Left = 841
          Top = 26
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'FIS_VLCONT'
          DataSource = dtsCadFis
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object cbxCODMOD: TComboBoxFocus
          Tag = 99
          Left = 611
          Top = 49
          Width = 301
          Height = 22
          Style = csDropDownList
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object pnlDetalhes: TPanel
        Left = 0
        Top = 87
        Width = 1314
        Height = 550
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object vgrDetalhes: TcxDBVerticalGrid
          Left = 2
          Top = 2
          Width = 780
          Height = 546
          BorderStyle = cxcbsNone
          Align = alLeft
          OptionsView.ScrollBars = ssVertical
          OptionsView.GridLineColor = 16770261
          OptionsView.RowHeaderMinWidth = 0
          OptionsView.ShowHeaders = False
          OptionsBehavior.BandSizing = False
          OptionsBehavior.HeaderSizing = False
          OptionsBehavior.AllowChangeRecord = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          Styles.Background = cxsTituloDetalhes
          Styles.OnGetContentStyle = pGetContentStyleDetalhes
          TabOrder = 0
          TabStop = False
          OnEdited = vgrDetalhesEdited
          OnEditing = vgrDetalhesEditing
          DataController.DataSource = dtsCadFis
          Version = 1
          object rowTitulos: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                Caption = '1'#170' Class.'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.ReadOnly = True
                Width = 800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                Caption = '2'#170' Class.'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.ReadOnly = True
                Width = 800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                Caption = '3'#170' Class.'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.ReadOnly = True
                Width = 800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                Caption = '4'#170' Class.'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.ReadOnly = True
                Width = 800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                Caption = '5'#170' Class.'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.ReadOnly = True
                Width = 800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                Caption = 'Total'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.ReadOnly = True
                Width = 800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end>
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object rowClfSc: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Classifica'#231#227'o. Fiscal'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxMaskEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.CharCase = ecUpperCase
                EditProperties.MaskKind = emkRegExpr
                EditProperties.EditMask = '\d*'
                Width = 800
                DataBinding.FieldName = 'FIS_CLFSC1'
                OnGetDisplayText = pGetDisplayTextClaFis
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxMaskEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.CharCase = ecUpperCase
                EditProperties.MaskKind = emkRegExpr
                EditProperties.EditMask = '\d*'
                Width = 800
                DataBinding.FieldName = 'FIS_CLFSC2'
                OnGetDisplayText = pGetDisplayTextClaFis
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxMaskEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.CharCase = ecUpperCase
                EditProperties.MaskKind = emkRegExpr
                EditProperties.EditMask = '\d*'
                Width = 800
                DataBinding.FieldName = 'FIS_CLFSC3'
                OnGetDisplayText = pGetDisplayTextClaFis
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxMaskEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.CharCase = ecUpperCase
                EditProperties.MaskKind = emkRegExpr
                EditProperties.EditMask = '\d*'
                Width = 800
                DataBinding.FieldName = 'FIS_CLFSC4'
                OnGetDisplayText = pGetDisplayTextClaFis
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxMaskEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.CharCase = ecUpperCase
                EditProperties.MaskKind = emkRegExpr
                EditProperties.EditMask = '\d*'
                Width = 800
                DataBinding.FieldName = 'FIS_CLFSC5'
                OnGetDisplayText = pGetDisplayTextClaFis
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxMaskEditProperties'
                EditProperties.Alignment.Horz = taCenter
                EditProperties.CharCase = ecUpperCase
                EditProperties.MaskKind = emkRegExpr
                EditProperties.EditMask = '\d*'
                Width = 800
                DataBinding.FieldName = 'FIS_CLFSCT'
                OnGetDisplayText = pGetDisplayTextClaFis
              end>
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object rowVlCon: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor Cont'#225'bil'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCON1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCON2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCON3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCON4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCON5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCONT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object rowDAces: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Desp. Acess.'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_DACES1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_DACES2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_DACES3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_DACES4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_DACES5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_DACEST'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object rowBasIc: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Base ICMS'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIC1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIC2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIC3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIC4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIC5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASICT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object rowAlqIc: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Al'#237'quota. ICMS'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ALQIC1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ALQIC2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ALQIC3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ALQIC4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ALQIC5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ALQICT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
          object rowVlrIc: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor ICMS'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIC1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIC2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIC3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIC4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIC5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRICT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 6
            ParentID = -1
            Index = 6
            Version = 1
          end
          object rowOutra: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Outras'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_OUTRA1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_OUTRA2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_OUTRA3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_OUTRA4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_OUTRA5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_OUTRAT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 7
            ParentID = -1
            Index = 7
            Version = 1
          end
          object rowIsent: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Isentas'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ISENT1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ISENT2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ISENT3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ISENT4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ISENT5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ISENTT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 8
            ParentID = -1
            Index = 8
            Version = 1
          end
          object rowBcRet: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Base ICMS Subst.'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCRET1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCRET2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCRET3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCRET4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCRET5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCRETT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 9
            ParentID = -1
            Index = 9
            Version = 1
          end
          object rowRetId: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor ICMS Subst.'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_RETID1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_RETID2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_RETID3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_RETID4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_RETID5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_RETIDT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 10
            ParentID = -1
            Index = 10
            Version = 1
          end
          object rowBasAn: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Base ICMS Antecip.'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASAN1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASAN2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASAN3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASAN4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASAN5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASANT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 11
            ParentID = -1
            Index = 11
            Version = 1
          end
          object rowAntIc: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor ICMS Antecip.'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ANTIC1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ANTIC2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ANTIC3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ANTIC4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ANTIC5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_ANTICT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 12
            ParentID = -1
            Index = 12
            Version = 1
          end
          object rowBaeRe: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Base ICMS Subst. N'#227'o Creditado'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAERE1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAERE2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAERE3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAERE4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAERE5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAERET'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 13
            ParentID = -1
            Index = 13
            Version = 1
          end
          object rowVaeRe: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor ICMS Subst. N'#227'o Creditado'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAERE1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAERE2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAERE3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAERE4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAERE5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAERET'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 14
            ParentID = -1
            Index = 14
            Version = 1
          end
          object rowBasIp: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Base IPI'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIP1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIP2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIP3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIP4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIP5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BASIPT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 15
            ParentID = -1
            Index = 15
            Version = 1
          end
          object rowVlrIp: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor IPI'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIP1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIP2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIP3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIP4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIP5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLRIPT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 16
            ParentID = -1
            Index = 16
            Version = 1
          end
          object rowBaeIp: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Base IPI N'#227'o Creditado'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAEIP1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAEIP2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAEIP3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAEIP4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAEIP5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BAEIPI'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 17
            ParentID = -1
            Index = 17
            Version = 1
          end
          object rowVaeIp: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor IPI N'#227'o Creditado'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAEIP1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAEIP2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAEIP3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAEIP4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAEIP5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VAEIPI'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 18
            ParentID = -1
            Index = 18
            Version = 1
          end
          object rowBFCPS: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Base Fundo Combate a Pobreza ST'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_BFCPS1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_BFCPS2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_BFCPS3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_BFCPS4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_BFCPS5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_BFCPST'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 19
            ParentID = -1
            Index = 19
            Version = 1
          end
          object rowVFCPS: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor Fundo Combate a Pobreza ST'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_VFCPS1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_VFCPS2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_VFCPS3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_VFCPS4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_VFCPS5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                Width = 800
                DataBinding.FieldName = 'FIS_VFCPST'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 20
            ParentID = -1
            Index = 20
            Version = 1
          end
          object rowBcCbs: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Base CBS'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCCBS1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCCBS2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCCBS3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCCBS4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCCBS5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCCBST'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 21
            ParentID = -1
            Index = 21
            Version = 1
          end
          object rowVlCbs: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor CBS'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCBS1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCBS2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCBS3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCBS4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCBS5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLCBST'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 22
            ParentID = -1
            Index = 22
            Version = 1
          end
          object rowBcIbs: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Base IBS'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCIBS1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCIBS2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCIBS3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCIBS4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCIBS5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BCIBST'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 23
            ParentID = -1
            Index = 23
            Version = 1
          end
          object rowVlIbs: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor IBS'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLIBS1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLIBS2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLIBS3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLIBS4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLIBS5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VLIBST'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 24
            ParentID = -1
            Index = 24
            Version = 1
          end
          object rowBc_Is: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Base IS'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BC_IS1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BC_IS2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BC_IS3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BC_IS4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BC_IS5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_BC_IST'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 25
            ParentID = -1
            Index = 25
            Version = 1
          end
          object rowVl_Is: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor IS'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VL_IS1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VL_IS2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VL_IS3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VL_IS4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VL_IS5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VL_IST'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 26
            ParentID = -1
            Index = 26
            Version = 1
          end
          object rowQBCMo: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Quantidade tributada monof'#225'sica'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_QBCMO1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_QBCMO2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_QBCMO3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_QBCMO4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_QBCMO5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_QBCMOT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 27
            ParentID = -1
            Index = 27
            Version = 1
          end
          object rowValMo: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Valor monof'#225'sica'
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.Alignment.Horz = taRightJustify
                EditProperties.ReadOnly = True
                Width = 1800
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
                OnGetDisplayText = pGetDisplayTextTitulo
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VALMO1'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VALMO2'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VALMO3'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VALMO4'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VALMO5'
                OnGetDisplayText = pGetDisplayTextValor
              end
              item
                EditPropertiesClassName = 'TcxTextEditProperties'
                EditProperties.ReadOnly = True
                Width = 20
                Options.Editing = False
                Options.Focusing = False
                Options.TabStop = False
              end
              item
                EditPropertiesClassName = 'TcxCurrencyEditProperties'
                EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
                EditProperties.ReadOnly = True
                Width = 800
                DataBinding.FieldName = 'FIS_VALMOT'
                OnGetDisplayText = pGetDisplayTextValor
              end>
            ID = 28
            ParentID = -1
            Index = 28
            Version = 1
          end
        end
      end
    end
    object tbsCtaPag: TTabSheet
      Caption = '&3 - Contas a Pagar'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1314
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Ctl3D = True
        ParentColor = True
        ParentCtl3D = False
        TabOrder = 0
        object Label33: TLabel
          Left = 17
          Top = 26
          Width = 44
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador:'
        end
        object Label36: TLabel
          Left = 831
          Top = 23
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Total Nota:'
        end
        object edtCodPor: TEditFocus
          Tag = 99
          Left = 62
          Top = 19
          Width = 55
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnExit = edtCodPorExit
          OnKeyPress = edtCodPorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomPor: TEditFocus
          Left = 117
          Top = 19
          Width = 401
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
        object DBEditFocus9: TDBEditFocus
          Tag = 99
          Left = 913
          Top = 19
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'FIS_VLCONT'
          DataSource = dtsCadFis
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
          NormalColor = clWindow
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
      end
      object pnlCtaPag: TPanel
        Left = 0
        Top = 57
        Width = 1314
        Height = 580
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object pnlEventos: TPanel
          Left = 0
          Top = 0
          Width = 477
          Height = 580
          Align = alLeft
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Ctl3D = True
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 0
          object Panel4: TPanel
            Left = 0
            Top = 539
            Width = 473
            Height = 37
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object btnExcEve: TBitBtnLocked
              Left = 8
              Top = 8
              Width = 141
              Height = 22
              Caption = '[ DEL ] Exclui evento'
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
              TabOrder = 0
              TabStop = False
              OnClick = btnExcEveClick
            end
            object bbtnDesmembrarValores: TBitBtnLocked
              Left = 168
              Top = 9
              Width = 145
              Height = 22
              Caption = '[F8] Desmembrar Valores'
              TabOrder = 1
              OnClick = bbtnDesmembrarValoresClick
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 473
            Height = 57
            Align = alTop
            BevelOuter = bvNone
            Ctl3D = True
            ParentColor = True
            ParentCtl3D = False
            TabOrder = 0
            object Label34: TLabel
              Left = 317
              Top = 26
              Width = 78
              Height = 14
              Alignment = taRightJustify
              Caption = 'Valor destinado:'
            end
            object edtValEve: TEditFocus
              Tag = 99
              Left = 399
              Top = 19
              Width = 72
              Height = 22
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 1
              OnEnter = edtValEveEnter
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            inline fraCentroCusto: TfraCentroCustoEditFocus
              Left = 3
              Top = 19
              Width = 311
              Height = 22
              TabOrder = 0
              ExplicitLeft = 3
              ExplicitTop = 19
              ExplicitWidth = 311
              inherited lblEventos: TLabel
                Left = 7
                Top = 7
                Width = 50
                Height = 14
                Caption = 'Ctr. Custo:'
                ExplicitLeft = 7
                ExplicitTop = 7
                ExplicitWidth = 50
                ExplicitHeight = 14
              end
              inherited edtCodEve: TEditFocus
                Left = 59
                Height = 22
                OnKeyPress = fraCentroCustoedtCodEveKeyPress
                ExplicitLeft = 59
                ExplicitHeight = 22
              end
              inherited edtDesEve: TEditFocus
                Left = 114
                Width = 195
                Height = 22
                ExplicitLeft = 114
                ExplicitWidth = 195
                ExplicitHeight = 22
              end
            end
          end
          object cxgEventos: TcxGridCitel
            Left = 0
            Top = 57
            Width = 473
            Height = 482
            Align = alClient
            TabOrder = 2
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxvEventos: TcxGridDBTableViewCitel
              OnKeyDown = cxvEventosKeyDown
              Navigator.Buttons.CustomButtons = <>
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skSum
                  Column = cxvEventosVALEVE
                end>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.Footer = True
              OptionsView.GroupByBox = False
              Styles.ContentEven = cxStyle1
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxvEventosCODEVE: TcxGridDBColumn
                Caption = 'Centro de Custo'
                DataBinding.FieldName = 'CODEVE'
                PropertiesClassName = 'TcxLookupComboBoxProperties'
                Properties.DropDownListStyle = lsFixedList
                Properties.KeyFieldNames = 'CODEVE'
                Properties.ListColumns = <
                  item
                    FieldName = 'DESEVE'
                  end>
                Properties.ListOptions.CaseInsensitive = True
                Properties.ListOptions.ShowHeader = False
                Options.Editing = False
                SortIndex = 0
                SortOrder = soAscending
                Width = 342
              end
              object cxvEventosVALEVE: TcxGridDBColumn
                Caption = 'Valor destinado'
                DataBinding.FieldName = 'VALEVE'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.AssignedValues.MinValue = True
                Properties.DisplayFormat = '#,##0.00;-#,##0.00'
                Properties.OnValidate = cxvEventosVALEVEPropertiesValidate
                HeaderAlignmentHorz = taRightJustify
                Width = 108
              end
            end
            object cxgEventosLevel1: TcxGridLevel
              GridView = cxvEventos
            end
          end
        end
        object TPanel
          Left = 722
          Top = 0
          Width = 335
          Height = 580
          Align = alLeft
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Ctl3D = True
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 1
          object Label40: TLabel
            Left = 4
            Top = 380
            Width = 45
            Height = 14
            Margins.Bottom = 10
            Alignment = taRightJustify
            Caption = 'Hist'#243'rico:'
          end
          object Panel7: TPanel
            Left = 0
            Top = 0
            Width = 331
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Duplicatas'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 0
          end
          object cxgParcelas: TcxGridCitel
            Left = 0
            Top = 24
            Width = 331
            Height = 345
            Align = alClient
            TabOrder = 1
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxvParcelas: TcxGridDBTableViewCitel
              Navigator.Buttons.CustomButtons = <>
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
              Styles.ContentEven = cxStyle1
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxvParcelasDTAVEN: TcxGridDBColumn
                Caption = 'Vencimento'
                DataBinding.FieldName = 'DTAVEN'
                HeaderAlignmentHorz = taCenter
                Width = 89
              end
              object cxvParcelasVALDUP: TcxGridDBColumn
                Caption = 'Valor'
                DataBinding.FieldName = 'VALDUP'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                HeaderAlignmentHorz = taRightJustify
                Width = 119
              end
            end
            object cxgParcelasLevel1: TcxGridLevel
              GridView = cxvParcelas
            end
          end
          object Panel3: TPanel
            Left = 0
            Top = 455
            Width = 331
            Height = 121
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            object lblCondPgto: TLabel
              Left = 12
              Top = 43
              Width = 55
              Height = 14
              Alignment = taRightJustify
              Caption = 'Cond. Pag.:'
            end
            object lblTemPgtoAntecipado: TLabel
              Left = 182
              Top = 15
              Width = 211
              Height = 17
              AutoSize = False
              Caption = 'Fornecedor possui pgto antec.'
              Font.Charset = ANSI_CHARSET
              Font.Color = 213
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Visible = False
              WordWrap = True
            end
            object lblBcoFor: TLabel
              Left = 27
              Top = 85
              Width = 31
              Height = 14
              BiDiMode = bdLeftToRight
              Caption = 'Conta:'
              ParentBiDiMode = False
            end
            object btnAlterar: TBitBtnLocked
              Left = 200
              Top = 58
              Width = 130
              Height = 22
              Caption = 'Alterar &Duplicatas'
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
                69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
                CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
                A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
                7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
                820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
                A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
                81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
                860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
                A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
                93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
                C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
                BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
                A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
                D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
                D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
                B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
                9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
                DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
                55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
                E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
                6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
                926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
              TabOrder = 1
              TabStop = False
              OnClick = btnAlterarClick
            end
            object mskCndPag: TMaskEditFocus
              Tag = 99
              Left = 66
              Top = 35
              Width = 264
              Height = 22
              CharCase = ecUpperCase
              EditMask = 
                '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
                '99.999.999.999.999.999.999.999.999;0;_'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 98
              TabOrder = 0
              Text = ''
              OnExit = mskCndPagExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object chkPgoAnt: TCheckBox
              Left = 4
              Top = 17
              Width = 138
              Height = 17
              BiDiMode = bdRightToLeft
              Caption = 'Utilizar Pgto Antecipado'
              ParentBiDiMode = False
              TabOrder = 2
              OnClick = chkPgoAntClick
            end
            object btnPgoAnt: TBitBtnLocked
              Left = 147
              Top = 13
              Width = 31
              Height = 22
              Enabled = False
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000130B0000130B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
                300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
                330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
                333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
                339977FF777777773377000BFB03333333337773FF733333333F333000333333
                3300333777333333337733333333333333003333333333333377333333333333
                333333333333333333FF33333333333330003333333333333777333333333333
                3000333333333333377733333333333333333333333333333333}
              NumGlyphs = 2
              TabOrder = 3
              OnClick = btnPgoAntClick
            end
            object chkGerarFinanceiro: TCheckBox
              Tag = 99
              Left = 4
              Top = -2
              Width = 106
              Height = 17
              BiDiMode = bdRightToLeft
              Caption = 'Gerar Financeiro'
              Checked = True
              ParentBiDiMode = False
              State = cbChecked
              TabOrder = 4
              OnClick = chkGerarFinanceiroClick
            end
            object chkVeioBo: TCheckBox
              Left = 116
              Top = -2
              Width = 77
              Height = 17
              BiDiMode = bdRightToLeft
              Caption = 'Veio Boleto'
              ParentBiDiMode = False
              TabOrder = 5
              OnClick = chkVeioBoClick
            end
            object chkDeposi: TCheckBox
              Left = 195
              Top = -2
              Width = 67
              Height = 17
              BiDiMode = bdRightToLeft
              Caption = 'Dep'#243'sito'
              ParentBiDiMode = False
              TabOrder = 6
              OnClick = chkDeposiClick
            end
            object chkImprCP: TCheckBox
              Left = 264
              Top = -2
              Width = 67
              Height = 17
              BiDiMode = bdRightToLeft
              Caption = 'Imprime CP'
              ParentBiDiMode = False
              TabOrder = 7
            end
            object cbxBcoFor: TComboBoxFocus
              Left = 64
              Top = 83
              Width = 264
              Height = 22
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 8
              OnChange = cbxBcoForChange
              OnDropDown = cbxBcoForDropDown
              OnEnter = cbxBcoForEnter
              OnExit = cbxBcoForExit
              OnKeyUp = cbxBcoForKeyUp
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
          object edtHistor: TMemoFocus
            Tag = 99
            AlignWithMargins = True
            Left = 50
            Top = 379
            Width = 281
            Height = 66
            Margins.Left = 50
            Margins.Top = 10
            Margins.Right = 0
            Margins.Bottom = 10
            Align = alBottom
            ScrollBars = ssVertical
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
        end
        object pnlEmpresasRateioDespesas: TPanel
          Left = 477
          Top = 0
          Width = 245
          Height = 580
          Align = alLeft
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Ctl3D = True
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 2
          object Panel8: TPanel
            Left = 0
            Top = 539
            Width = 241
            Height = 37
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
          end
          object Panel9: TPanel
            Left = 0
            Top = 0
            Width = 241
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            Ctl3D = True
            ParentColor = True
            ParentCtl3D = False
            TabOrder = 1
            object Label39: TLabel
              Left = 0
              Top = 11
              Width = 173
              Height = 14
              Align = alBottom
              Alignment = taCenter
              Caption = 'Empresas Para Rateio de Despesas'
            end
          end
          object lstEmpRateioDespesa: TCheckListBox
            Tag = 99
            Left = 0
            Top = 25
            Width = 241
            Height = 514
            Align = alClient
            Columns = 1
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            TabOrder = 2
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 144
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 80
    Top = 288
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 184
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 464
    Top = 200
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object dtsCadFis: TDataSource
    Left = 216
    Top = 184
  end
  object cxStyleRepositoryDetalhes: TcxStyleRepository
    Left = 248
    Top = 184
    PixelsPerInch = 96
    object cxsTituloDetalhes: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
  end
end
