inherited frmControleQualidadeProducao: TfrmControleQualidadeProducao
  Width = 735
  Height = 600
  Caption = 'Controle de Qualidade de Produ'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 735
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 729
    TabOrder = 2
    ExplicitTop = 527
    ExplicitWidth = 729
    inherited FlwBotoes: TFlowPanel
      Width = 725
      ExplicitTop = 2
      ExplicitWidth = 725
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
        ModalResult = 0
      end
      object btnImprimirLaudo: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 120
        Height = 22
        Align = alLeft
        Caption = '&Imprimir Laudo'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFB3B1B2FF00FFFF00FFFF00FF9A99999A9999A4A1
          A2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB3B1B2B3B1B2DEDCDCAB
          A9A95553546F6D6EAEACACD2D0D1E0DFDF9A9999FF00FFFF00FFFF00FFFF00FF
          B3B1B2B3B1B2FBFBFBFFFFFFE0DEDFB2B0B05F5E603131333131344F4D4F8180
          819A9999A4A1A2FF00FFA7A4A5B3B1B2F4F2F3FFFFFFF2F0F0D6D5D5B3B1B2A4
          A1A1ACA9AA9E9D9D7E7D7D5655573536383635378D8B8CFF00FFB0ADAEEEEDED
          EBEBEBCCCACAB9B7B7C4C2C2D0CFCFB7B5B5ABA8A9A8A6A6ACA9AAAFADADA4A1
          A28584849A9999FF00FFAAA7A8BFBDBEB7B5B5C1C0C0D5D5D5DCDDDDF1F1F0F4
          F2F4E4E3E3D2D1D1BFBDBDAFADAEA9A6A6ACA9AAA4A1A2FF00FFA7A4A5C0BFC0
          D5D4D4D9D9D9D5D5D5E9E9E9DCDADAB5BDB5CCCBCBD7D9DADFDFDFDDDDDDD3D2
          D2C6C6C6ADACACFF00FFFF00FFB0AEAFDBDCDCDADADAE4E4E4D5D3D3C5C1C4B8
          DCBAC9D1CBD2BAB5BFB7B6BBB9BAC4C2C3D0CFCFBBB9BAFF00FFFF00FFFF00FF
          B0AEAFCFCDCDC0BFBFC2C1C1EAEAEAF8F6F6F2F1F2F1E8E6E4E1E1D8D8D8C4C4
          C4A9A6A7FF00FFFF00FFFF00FFFF00FFFF00FFB0AEAFE1E3E3D6D6D7B1B3B4CA
          CDCFDDDFE0DEE2E2DFDFDFD3D2D3C0BFBFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFCEBE8FAE7DEEED5CCEAD4CCE9D8D4E6DDD9DBD9D8AAA8AAFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD9B3B1FFE6D9FFDACCFF
          D1C0FFC9B6FFC2AEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFD9B3B1FFE5D9FFD8CBFED0C1FFCAB7F9BBA8FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD9B3B1FFE5D9FFD8CBFE
          D0C1FEC8B6FBC1AEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFD9B3B1FBE7DFFFE3D8FFD9CCFFD3C2FDC8B6FABFAEFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD9B3B1D9B3B1D9B3B1D9B3B1F6
          BFB1F6BFB1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        Visible = False
        OnClick = btnImprimirLaudoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 650
      Top = 2
      ExplicitLeft = 650
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 729
    TabOrder = 3
    ExplicitTop = 555
    ExplicitWidth = 729
    inherited pnlNomeForm: TPanel
      Left = 558
      ExplicitLeft = 558
    end
    inherited pnlInfo: TPanel
      Width = 558
      ExplicitWidth = 558
    end
  end
  object pnlProdutos: TPanel [3]
    Left = 0
    Top = 0
    Width = 729
    Height = 173
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 55
      Width = 86
      Height = 14
      Caption = 'Produto Acabado:'
    end
    object Label5: TLabel
      Left = 536
      Top = 55
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Referencia:'
    end
    object Label3: TLabel
      Left = 45
      Top = 10
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Ordem:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 60
      Top = 34
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 14
      Top = 94
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sub-Item Resina:'
    end
    object Bevel1: TBevel
      Left = 1
      Top = 72
      Width = 727
      Height = 10
      Shape = bsBottomLine
    end
    object Label6: TLabel
      Left = 378
      Top = 94
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 39
      Top = 140
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = '% Utilizado:'
    end
    object Label8: TLabel
      Left = 170
      Top = 140
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicio:'
    end
    object Label9: TLabel
      Left = 301
      Top = 140
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hora Inicio:'
    end
    object Label21: TLabel
      Left = 4
      Top = 117
      Width = 91
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sub-Item Pigmento:'
    end
    object Label22: TLabel
      Left = 378
      Top = 117
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDesIte: TEditFocus
      Left = 167
      Top = 51
      Width = 362
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 99
      Top = 51
      Width = 67
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'PRO_CODITE'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtRefere: TEditFocus
      Left = 595
      Top = 51
      Width = 118
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtOrdPro: TEditFocus
      Tag = 99
      Left = 99
      Top = 6
      Width = 115
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtOrdProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttInteiro
    end
    object dbeCodCli: TDBEditFocus
      Left = 99
      Top = 30
      Width = 67
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'PRO_CODCLI'
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesCli: TEditFocus
      Left = 167
      Top = 29
      Width = 362
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object dbeIteRes: TDBEditFocus
      Tag = 99
      Left = 99
      Top = 90
      Width = 67
      Height = 22
      DataField = 'PRO_ITERES'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 1
      OnKeyPress = dbeIteResKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtDesRes: TEditFocus
      Left = 167
      Top = 90
      Width = 205
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Left = 439
      Top = 90
      Width = 67
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 507
      Top = 90
      Width = 206
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object dbePerRes: TDBEditFocus
      Tag = 99
      Left = 99
      Top = 136
      Width = 67
      Height = 22
      DataField = 'PRO_PERRES'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaIni: TDBEditFocus
      Tag = 99
      Left = 225
      Top = 136
      Width = 72
      Height = 22
      DataField = 'PRO_DTAINI'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeHraIni: TDBEditFocus
      Tag = 99
      Left = 355
      Top = 136
      Width = 42
      Height = 22
      DataField = 'PRO_HRAINI'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeItePig: TDBEditFocus
      Tag = 99
      Left = 99
      Top = 113
      Width = 67
      Height = 22
      DataField = 'PRO_ITEPIG'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = dbeItePigKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtDesPig: TEditFocus
      Left = 167
      Top = 113
      Width = 205
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtForPig: TEditFocus
      Left = 439
      Top = 113
      Width = 67
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object edtNomForPig: TEditFocus
      Left = 507
      Top = 113
      Width = 206
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object PageControl: TPageControl [4]
    Left = 0
    Top = 173
    Width = 729
    Height = 354
    ActivePage = tbsAnalise
    Align = alClient
    Enabled = False
    TabOrder = 1
    OnChange = PageControlChange
    object tbsAnalise: TTabSheet
      Caption = 'An'#225'lises de Controle de Qualidade'
      object pnlAnalise: TPanel
        Left = 0
        Top = 0
        Width = 721
        Height = 325
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object cxgTanPro: TcxGridCitel
          Left = 0
          Top = 0
          Width = 721
          Height = 301
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgTanProTableView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = True
            Destaque = True
            CorZebra = clMoneyGreen
            object cxgTanProTableViewCODIGO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CODIGO'
              Options.Editing = False
              Options.Focusing = False
              Options.Sorting = False
              Width = 45
            end
            object cxgTanProTableViewDESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESCRI'
              Options.Editing = False
              Options.Focusing = False
              Options.Sorting = False
              Width = 338
            end
            object cxgTanProTableViewSTA_01: TcxGridDBColumn
              AlternateCaption = '93'
              Caption = 'Status (1'#186' Turno)'
              DataBinding.FieldName = 'STA_01'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                ''
                'AP'
                'AC'
                'RP'
                'NA')
              Options.Sorting = False
              Width = 100
            end
            object cxgTanProTableViewSTA_02: TcxGridDBColumn
              AlternateCaption = '93'
              Caption = 'Status (2'#186' Turno)'
              DataBinding.FieldName = 'STA_02'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                ''
                'AP'
                'AC'
                'RP'
                'NA')
              Options.Sorting = False
              Width = 100
            end
            object cxgTanProTableViewSTA_03: TcxGridDBColumn
              AlternateCaption = '93'
              Caption = 'Status (3'#186' Turno)'
              DataBinding.FieldName = 'STA_03'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                ''
                'AP'
                'AC'
                'RP'
                'NA')
              Options.Sorting = False
              Width = 100
            end
          end
          object cxgTanProLevel: TcxGridLevel
            GridView = cxgTanProTableView
          end
        end
        object pnlAnaliseLeg: TPanel
          Left = 0
          Top = 301
          Width = 721
          Height = 24
          Align = alBottom
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 1
          object Label11: TLabel
            Left = 5
            Top = 6
            Width = 576
            Height = 14
            Caption = 
              '**LEGENDA: AP-APROVADO  /  AC-APROVADO CONDICIONALMENTE  /  RP-R' +
              'EPROVADO  /  NA-N'#195'O APLIC'#193'VEL  '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
    end
    object tbsEspTecnicas: TTabSheet
      Caption = 'An'#225'lises de Especifica'#231#245'es T'#233'cnicas'
      ImageIndex = 1
      object pnlEspTecnicas: TPanel
        Left = 0
        Top = 0
        Width = 721
        Height = 325
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object pnlTopEteMat: TPanel
          Left = 0
          Top = 0
          Width = 721
          Height = 53
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          OnExit = pnlTopEteMatExit
          object lbl23: TLabel
            Left = 392
            Top = 7
            Width = 78
            Height = 14
            Caption = 'Valor (2'#186' Turno)'
          end
          object Label12: TLabel
            Left = 305
            Top = 7
            Width = 78
            Height = 14
            Caption = 'Valor (1'#186' Turno)'
          end
          object Label13: TLabel
            Left = 7
            Top = 7
            Width = 68
            Height = 14
            Caption = 'Espec'#237'fica'#231#227'o'
          end
          object Label14: TLabel
            Left = 479
            Top = 7
            Width = 78
            Height = 14
            Caption = 'Valor (3'#186' Turno)'
          end
          object edtValSt2: TEditFocus
            Tag = 99
            Left = 392
            Top = 24
            Width = 85
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
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.0000'
          end
          object btnAdicionaEtePro: TBitBtnLocked
            Left = 565
            Top = 24
            Width = 72
            Height = 22
            Caption = '&Adicionar'
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
            OnClick = btnAdicionaEteProClick
          end
          object btnCancelaEtePro: TBitBtnLocked
            Left = 639
            Top = 24
            Width = 72
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
            OnClick = btnCancelaEteProClick
          end
          object edtValSt1: TEditFocus
            Tag = 99
            Left = 305
            Top = 24
            Width = 85
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
            ParentFont = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.0000'
          end
          object edtCodEte: TEditFocus
            Tag = 99
            Left = 7
            Top = 24
            Width = 51
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 3
            TabOrder = 0
            OnKeyPress = edtCodEteKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesEte: TEditFocus
            Left = 59
            Top = 24
            Width = 244
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtValSt3: TEditFocus
            Tag = 99
            Left = 479
            Top = 24
            Width = 85
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
            ParentFont = False
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.0000'
          end
        end
        object cxgEtePro: TcxGridCitel
          Left = 0
          Top = 53
          Width = 721
          Height = 248
          Align = alClient
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgEteProTableView: TcxGridDBBandedTableViewCitel
            OnDblClick = cxgEteProTableViewDblClick
            OnKeyDown = cxgEteProTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxgEteProTableViewCustomDrawCell
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
            Bands = <
              item
                Caption = 'Especifica'#231#245'es'
                Width = 372
              end
              item
                Caption = '1'#186' Turno'
              end
              item
                Caption = '2'#186' Turno'
              end
              item
                Caption = '3'#186' Turno'
              end>
            Zebra = True
            Destaque = True
            DestacarRegistro = False
            CorZebra = clMoneyGreen
            object cxgEteProTableViewCODETE: TcxGridDBBandedColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CODETE'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 46
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxgEteProTableViewDESCRI: TcxGridDBBandedColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESCRI'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 216
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxgEteProTableViewVALMIN: TcxGridDBBandedColumn
              Caption = 'M'#237'nimo'
              DataBinding.FieldName = 'VALMIN'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 56
              Position.BandIndex = 0
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxgEteProTableViewVALMAX: TcxGridDBBandedColumn
              Caption = 'M'#225'ximo'
              DataBinding.FieldName = 'VALMAX'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 54
              Position.BandIndex = 0
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxgEteProTableViewVALOR1: TcxGridDBBandedColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'VALOR1'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Position.BandIndex = 1
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxgEteProTableViewSTA_01: TcxGridDBBandedColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STA_01'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 45
              Position.BandIndex = 1
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxgEteProTableViewVALOR2: TcxGridDBBandedColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'VALOR2'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Position.BandIndex = 2
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxgEteProTableViewSTA_02: TcxGridDBBandedColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STA_02'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 45
              Position.BandIndex = 2
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxgEteProTableViewVALOR3: TcxGridDBBandedColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'VALOR3'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Position.BandIndex = 3
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxgEteProTableViewSTA_03: TcxGridDBBandedColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STA_03'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 45
              Position.BandIndex = 3
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
          end
          object cxgEteProLevel: TcxGridLevel
            GridView = cxgEteProTableView
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 301
          Width = 721
          Height = 24
          Align = alBottom
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 2
          object Label15: TLabel
            Left = 5
            Top = 6
            Width = 240
            Height = 14
            Caption = '**LEGENDA: AP-APROVADO  /  RP-REPROVADO'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
    end
    object tbsObserv: TTabSheet
      Caption = 'Observa'#231#245'es / Resumo'
      ImageIndex = 2
      object pnlObserv: TPanel
        Left = 0
        Top = 0
        Width = 721
        Height = 325
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 0
          Top = 168
          Width = 721
          Height = 3
          Cursor = crVSplit
          Align = alTop
          ExplicitTop = 77
          ExplicitWidth = 257
        end
        object Label17: TLabel
          Left = 0
          Top = 82
          Width = 721
          Height = 14
          Cursor = crHandPoint
          Align = alTop
          Alignment = taCenter
          Caption = 'Observa'#231#245'es (Clique aqui para exibir/ocultar)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Layout = tlCenter
          OnClick = Label17Click
          ExplicitWidth = 247
        end
        object mmoObsQua: TDBMemoFocus
          Left = 0
          Top = 96
          Width = 721
          Height = 72
          Align = alTop
          DataField = 'PRO_OBSQUA'
          ScrollBars = ssBoth
          TabOrder = 0
          Visible = False
          OnKeyPress = mmoObsQuaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object cxgResumo: TcxGridCitel
          Left = 0
          Top = 171
          Width = 721
          Height = 130
          Align = alClient
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgResumoTableView: TcxGridDBBandedTableViewCitel
            OnDblClick = cxgEteProTableViewDblClick
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxgEteProTableViewCustomDrawCell
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
            Bands = <
              item
                Caption = 'Especifica'#231#245'es'
                Width = 260
              end
              item
                Caption = '1'#186' Turno'
              end
              item
                Caption = '2'#186' Turno'
              end
              item
                Caption = '3'#186' Turno'
              end
              item
                Caption = 'Total'
              end>
            Zebra = True
            Destaque = True
            DestacarRegistro = False
            CorZebra = clMoneyGreen
            object cxgResumoTableViewCODETE: TcxGridDBBandedColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CODETE'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 42
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxgResumoTableViewDESCRI: TcxGridDBBandedColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESCRI'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 138
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxgResumoTableViewVALMIN: TcxGridDBBandedColumn
              Caption = 'M'#237'nimo'
              DataBinding.FieldName = 'VALMIN'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 50
              Position.BandIndex = 0
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object cxgResumoTableViewVALMAX: TcxGridDBBandedColumn
              Caption = 'M'#225'ximo'
              DataBinding.FieldName = 'VALMAX'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 46
              Position.BandIndex = 0
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object cxgResumoTableViewVALOR1: TcxGridDBBandedColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'VALOR1'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Position.BandIndex = 1
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxgResumoTableViewSTA_01: TcxGridDBBandedColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STA_01'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 45
              Position.BandIndex = 1
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxgResumoTableViewVALOR2: TcxGridDBBandedColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'VALOR2'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Position.BandIndex = 2
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxgResumoTableViewSTA_02: TcxGridDBBandedColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STA_02'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 45
              Position.BandIndex = 2
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxgResumoTableViewVALOR3: TcxGridDBBandedColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'VALOR3'
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Position.BandIndex = 3
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxgResumoTableViewSTA_03: TcxGridDBBandedColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STA_03'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Grouping = False
              Options.Moving = False
              Options.Sorting = False
              Width = 45
              Position.BandIndex = 3
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxgResumoTableViewVALORT: TcxGridDBBandedColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'VALORT'
              Position.BandIndex = 4
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxgResumoTableViewSTA_TT: TcxGridDBBandedColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STA_TT'
              Width = 45
              Position.BandIndex = 4
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
          end
          object cxgResumoLevel: TcxGridLevel
            GridView = cxgResumoTableView
          end
        end
        object Panel2: TPanel
          Left = 0
          Top = 301
          Width = 721
          Height = 24
          Align = alBottom
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 2
          object Label16: TLabel
            Left = 5
            Top = 6
            Width = 240
            Height = 14
            Caption = '**LEGENDA: AP-APROVADO  /  RP-REPROVADO'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 721
          Height = 82
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 3
          object Label4: TLabel
            Left = 39
            Top = 10
            Width = 32
            Height = 14
            Alignment = taRightJustify
            Caption = 'Sopro:'
          end
          object Label18: TLabel
            Left = 143
            Top = 9
            Width = 60
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtd. Fardos:'
          end
          object Label19: TLabel
            Left = 275
            Top = 9
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Validade:'
          end
          object Label10: TLabel
            Left = 5
            Top = 59
            Width = 66
            Height = 14
            Alignment = taRightJustify
            Caption = 'Respons'#225'vel:'
          end
          object Label20: TLabel
            Left = 28
            Top = 34
            Width = 43
            Height = 14
            Alignment = taRightJustify
            Caption = 'Emiss'#227'o:'
          end
          object dbeSopro: TDBEditFocus
            Left = 73
            Top = 6
            Width = 62
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_SOPRO_'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeQtdFar: TDBEditFocus
            Left = 205
            Top = 6
            Width = 62
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_QTDFAR'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeValida: TDBEditFocus
            Left = 321
            Top = 6
            Width = 86
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_VALIDA'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRespon: TDBEditFocus
            Tag = 99
            Left = 73
            Top = 54
            Width = 334
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_RESPON'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeEmiLau: TDBEditFocus
            Tag = 99
            Left = 73
            Top = 29
            Width = 334
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_EMILAU'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbcCmpOri: TDBCheckBox
            Left = 413
            Top = 6
            Width = 265
            Height = 32
            Caption = 
              'O Laudo do Fornecedor Comprova a Origem do Material Utilizado na' +
              ' Produ'#231#227'o dos Frascos?'
            DataField = 'PRO_CMPORI'
            TabOrder = 3
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            WordWrap = True
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 36
    Top = 380
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 200
    Top = 380
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 116
    Top = 380
  end
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42552.576417372700000000
    ReportOptions.LastChange = 42555.393770393500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      
        '  intSequen : Integer;                                          ' +
        '  '
      ''
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  intSequen := 0;                '
      'end;'
      ''
      'procedure Memo36OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Inc(intSequen);'
      
        '  TfrxMemoView(Sender).Text := IntToStr(intSequen);             ' +
        '                                                               '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 368
    Top = 434
    Datasets = <
      item
        DataSet = frxDBEmpres
        DataSetName = 'frxDBEmpres'
      end
      item
        DataSet = frxDBMovPro
        DataSetName = 'frxDBMovPro'
      end
      item
        DataSet = frxDBResumo
        DataSetName = 'frxDBResumo'
      end
      item
        DataSet = frxDBTanPro
        DataSetName = 'frxDBTanPro'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 154.960730000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        object Shape1: TfrxShapeView
          Width = 718.110700000000000000
          Height = 49.133890000000000000
        end
        object imgLogo: TfrxPictureView
          Left = 2.000000000000000000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 45.354360000000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo2: TfrxMemoView
          Align = baCenter
          Left = 207.874150000000000000
          Top = 19.897650000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CERTIFICADO DE AN'#193'LISE')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 642.638220000000000000
          Top = 19.118120000000000000
          Width = 75.590600000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo3: TfrxMemoView
          Top = 49.133889999999990000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'CLIENTE:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 60.472480000000000000
          Top = 49.133889999999990000
          Width = 521.575140000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."CODCLI"] - [frxDBMovPro."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 582.047620000000000000
          Top = 49.133889999999990000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'CERTIFICADO N'#186)
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Top = 64.252010000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'PRODUTO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 60.472480000000000000
          Top = 64.252010000000000000
          Width = 521.575140000000100000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."CODITE"] - [frxDBMovPro."DESITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 582.047620000000000000
          Top = 64.252010000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."CODPRO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Top = 79.370130000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'SOPRO N'#186':')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 60.472480000000000000
          Top = 79.370130000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBMovPro."SOPRO_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 117.165430000000000000
          Top = 79.370130000000000000
          Width = 30.992125984251970000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'LOTE:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmLote: TfrxMemoView
          Left = 148.157480310000000000
          Top = 79.370130000000000000
          Width = 86.551181100000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 234.653680000000000000
          Top = 79.370130000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'NOTA FISCAL:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 302.685220000000000000
          Top = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."NUMDOC"] - [frxDBMovPro."ESPDOC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo15: TfrxMemoView
          Left = 442.866420000000000000
          Top = 79.370130000000000000
          Width = 70.299212600000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'QTD. FARDOS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 512.897960000000000000
          Top = 79.370130000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."QTDFAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 551.252320000000100000
          Top = 79.370130000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'QTD. PRODUZIDO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 638.181510000000000000
          Top = 79.370130000000000000
          Width = 79.370130000000010000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBMovPro."QTDPRO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Top = 94.488250000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'DATA DE FABRICA'#199#195'O:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 117.165430000000000000
          Top = 94.488250000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."DTAPRO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 279.685220000000000000
          Top = 94.488250000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'VALIDADE:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 340.157700000000000000
          Top = 94.488250000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."VALIDA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 442.205010000000000000
          Top = 94.488250000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'C'#211'DIGO DO PRODUTO:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 555.590910000000000000
          Top = 94.488250000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."REFERE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Top = 109.606370000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'AN'#193'LISES:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 60.472480000000000000
          Top = 109.606370000000000000
          Width = 657.638220000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            
              'TESTE LOCAL CONFORME ESPECIFICA'#199#213'ES T'#201'CNICAS EXIGIDAS PELO CONTR' +
              'OLE DE QUALIDADE')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Top = 124.724490000000000000
          Width = 18.897650000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'IT')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 18.897650000000000000
          Top = 124.724490000000000000
          Width = 287.244280000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ESPECIFICA'#199#213'ES DAS DIMENS'#213'ES')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 306.141930000000000000
          Top = 124.724490000000000000
          Width = 56.692950000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ESCALA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 362.834880000000000000
          Top = 124.724490000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ESPECIFICADO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 506.457020000000000000
          Top = 124.724490000000000000
          Width = 71.811070000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR'
            'ENCONTRADO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 578.268090000000000000
          Top = 124.724490000000000000
          Width = 68.031540000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESULTADO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 646.299630000000000000
          Top = 124.724490000000000000
          Width = 71.811070000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'M'#201'TODO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 362.834880000000000000
          Top = 139.842610000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'M'#205'NIMO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 434.425480000000000000
          Top = 139.842610000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'M'#193'XIMO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 75.590599999999970000
          Top = 0.220469999999998800
          Width = 566.929500000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE QUALIDADE')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 76.370130000000000000
          Height = 49.133890000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 234.330860000000000000
        Width = 718.110700000000000000
        DataSet = frxDBResumo
        DataSetName = 'frxDBResumo'
        RowCount = 0
        Stretched = True
        object Memo36: TfrxMemoView
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo36OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '00')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 18.897650000000000000
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBResumo."DESCRI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 306.141930000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBResumo."ESCALA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 506.457020000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBResumo."VALORT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 578.268090000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBResumo."STA_TT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 646.299630000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBResumo."METODO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 362.834880000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBResumo."VALMIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 434.425480000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBResumo."VALMAX"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 313.700990000000000000
        Width = 718.110700000000000000
        DataSet = frxDBTanPro
        DataSetName = 'frxDBTanPro'
        RowCount = 0
        Stretched = True
        object Memo44: TfrxMemoView
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo36OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '00')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 18.897650000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBTanPro."DESCRI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo48: TfrxMemoView
          Left = 578.268090000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBTanPro."STA_01"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 646.299630000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[<frxDBTanPro."METODO">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 362.834880000000000000
          Width = 215.433210000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'TESTE PRATICO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 600.945270000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBTanPro."STA_02"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 623.622450000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBTanPro."STA_03"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 279.685220000000000000
        Width = 718.110700000000000000
        object Memo51: TfrxMemoView
          Left = 578.268090000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '1'#186' T')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Left = 600.945270000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '2'#186' T')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo53: TfrxMemoView
          Left = 623.622450000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '3'#186' T')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 188.976500000000000000
        Top = 359.055350000000000000
        Width = 718.110700000000000000
        object Memo54: TfrxMemoView
          Width = 158.740260000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'MAT'#201'RIA PRIMA UTILIZADA:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 158.740260000000000000
          Width = 559.370440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'PEAD: [frxDBMovPro."DESRES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 158.740260000000000000
          Top = 15.118119999999980000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'PIGMENTA'#199#195'O %:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 245.669450000000000000
          Top = 15.118119999999980000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."PERRES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 306.141930000000000000
          Top = 15.118119999999980000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Left = 430.866420000000000000
          Top = 15.118119999999980000
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."NOMFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Top = 30.236240000000010000
          Width = 510.236550000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            
              'O LAUDO DO FORNECEDOR COMPROVA A ORGIEM DO MATERIAL UTILIZADO NA' +
              ' PRODU'#199#195'O DOS FRASCOS?')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          Left = 510.236550000000000000
          Top = 30.236240000000010000
          Width = 207.874150000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[ X ] SIM'
            '[y] N'#195'O')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo62: TfrxMemoView
          Top = 60.472480000000010000
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            
              'CERTIFICADO EMITIDO ELETRONICAMENTE, DISPENSANDO A NECESSIDADE D' +
              'E ASSINATURAS')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Top = 90.708720000000030000
          Width = 464.882190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'EMISS'#195'O DO LAUDO: [frxDBMovPro."EMILAU"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo64: TfrxMemoView
          Left = 464.882190000000000000
          Top = 90.708720000000030000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'DATA ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 506.457020000000000000
          Top = 90.708720000000030000
          Width = 173.858380000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = 'dd '#39'de'#39' MMMM '#39'de'#39' yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."DTAINI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo66: TfrxMemoView
          Top = 105.826840000000000000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'RESPONS'#193'VEL PELA LIBERA'#199#195'O DE PRODU'#199#195'O: [frxDBMovPro."RESPON"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo67: TfrxMemoView
          Top = 120.944960000000000000
          Width = 279.685220000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '                                         RESULTADO DAS AN'#193'LISES:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo68: TfrxMemoView
          Left = 279.685220000000000000
          Top = 120.944960000000000000
          Width = 438.425480000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -27
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[RESULTADO]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo69: TfrxMemoView
          Top = 165.741454320000000000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            
              'LEGENDA:   AP = APROVADO    AC = APROVADO CONDICIONALMENTE     R' +
              'P = REPROVADO    NA = N'#195'O APLIC'#193'VEL')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo73: TfrxMemoView
          Left = 680.315400000000000000
          Top = 90.708720000000030000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBMovPro."HRAINI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 56.692950000000000000
        Top = 608.504330000000000000
        Width = 718.110700000000000000
        object Memo71: TfrxMemoView
          Align = baWidth
          Top = 5.779530000000023000
          Width = 718.110700000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBEmpres."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Align = baWidth
          Top = 17.897650000000000000
          Width = 718.110700000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'ENDERE'#199'O: [frxDBEmpres."EMP_ENDERE"], [frxDBEmpres."EMP_ENDNUM"]' +
              ' - [frxDBEmpres."EMP_BAIRRO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Align = baWidth
          Top = 30.015769999999970000
          Width = 718.110700000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'CEP: [frxDBEmpres."EMP_C_E_P_"] - CIDADE: [frxDBEmpres."CID_NOMC' +
              'ID"] - [frxDBEmpres."CID_ESTADO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
      end
    end
  end
  object frxDBMovPro: TfrxDBDataset
    UserName = 'frxDBMovPro'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 36
    Top = 434
  end
  object frxDBTanPro: TfrxDBDataset
    UserName = 'frxDBTanPro'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 116
    Top = 434
  end
  object frxDBResumo: TfrxDBDataset
    UserName = 'frxDBResumo'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 200
    Top = 434
  end
  object frxDBEmpres: TfrxDBDataset
    UserName = 'frxDBEmpres'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 280
    Top = 434
  end
end
