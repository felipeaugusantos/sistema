inherited frmConsolidacaoDeAdiantamentoDeValores: TfrmConsolidacaoDeAdiantamentoDeValores
  Width = 900
  Height = 800
  Caption = 'Consolida'#231#227'o de Adiantamento de Valores'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 900
  ExplicitHeight = 800
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 729
    Width = 894
    Height = 26
    ExplicitTop = 729
    ExplicitWidth = 894
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 890
      Height = 22
      TabOrder = 2
      ExplicitWidth = 890
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 811
      Top = 1
      ExplicitLeft = 811
      ExplicitTop = 1
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 1
      Width = 117
      Height = 22
      Caption = '[F10 ] Confirma'
      Enabled = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 755
    Width = 894
    ExplicitTop = 755
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 723
      ExplicitLeft = 723
    end
    inherited pnlInfo: TPanel
      Width = 723
      ExplicitWidth = 723
    end
  end
  object grpDadosNE: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 894
    Height = 57
    Align = alTop
    TabOrder = 3
    StyleElements = [seFont, seBorder]
    object lblDocumento: TLabel
      Left = 6
      Top = 11
      Width = 54
      Height = 14
      Caption = 'Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEspecie: TLabel
      Left = 108
      Top = 11
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblSerie: TLabel
      Left = 148
      Top = 11
      Width = 25
      Height = 14
      Caption = 'S'#233'rie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel
      Left = 179
      Top = 11
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
    object lblForNot: TLabel
      Left = 436
      Top = 11
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDocumento: TEditFocus
      Tag = 99
      Left = 6
      Top = 25
      Width = 100
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspecie: TEditFocus
      Left = 108
      Top = 25
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 1
      Text = 'NF'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtSerie: TEditFocus
      Left = 148
      Top = 25
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 179
      Top = 25
      Width = 29
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
      TabOrder = 3
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
      Left = 209
      Top = 25
      Width = 225
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtForNot: TEditFocus
      Tag = 99
      Left = 436
      Top = 25
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnKeyPress = edtForNotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesForNot: TEditFocus
      Left = 494
      Top = 25
      Width = 366
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlContainer: TPanel [3]
    Left = 0
    Top = 57
    Width = 894
    Height = 672
    Align = alClient
    Enabled = False
    ParentColor = True
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 1
      Top = 344
      Width = 892
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      Color = clMedGray
      ParentColor = False
      ExplicitTop = 393
    end
    object pnlContainerDuplicatas: TPanel
      Left = 1
      Top = 1
      Width = 892
      Height = 343
      Align = alClient
      Caption = 'Duplicatas'
      ParentColor = True
      TabOrder = 0
      object cxDuplicatas: TcxGrid
        Left = 1
        Top = 1
        Width = 890
        Height = 261
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = #39
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        LockedStateImageOptions.Text = 'Por favor, aguarde...'
        object cxDupView: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxDupViewCustomDrawCell
          DataController.DataSource = dtsDuplicatas
          DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftCompare]
          DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir.'
          OptionsView.GroupByBox = False
          Bands = <
            item
              Caption = 'Duplicatas em Aberto do Fornecedor'
              Width = 835
            end>
          object cxColDuplicata: TcxGridDBBandedColumn
            Caption = 'Duplicata'
            DataBinding.FieldName = 'DUPLIC'
            Options.Editing = False
            Width = 279
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxColSerie: TcxGridDBBandedColumn
            Caption = 'S'#233'rie'
            DataBinding.FieldName = 'SERIE_'
            Options.Editing = False
            Width = 34
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxColEmpresa: TcxGridDBBandedColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'CODEMP'
            Width = 64
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxColDtaCad: TcxGridDBBandedColumn
            Caption = 'Data Cadastro'
            DataBinding.FieldName = 'DTACAD'
            Width = 109
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxColDtaVen: TcxGridDBBandedColumn
            Caption = 'Data Vencimento'
            DataBinding.FieldName = 'DTAVEN'
            Width = 99
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxColCheque: TcxGridDBBandedColumn
            Caption = 'Cheque?'
            DataBinding.FieldName = 'USACHQ'
            HeaderAlignmentHorz = taCenter
            Width = 50
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxColBoleto: TcxGridDBBandedColumn
            Caption = 'Boleto?'
            DataBinding.FieldName = 'VEIOBO'
            HeaderAlignmentHorz = taCenter
            Width = 50
            Position.BandIndex = 0
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxColValDuplicata: TcxGridDBBandedColumn
            Caption = 'Vr. Duplicata'
            DataBinding.FieldName = 'VALDUP'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            Width = 136
            Position.BandIndex = 0
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object cxColDupMarcado: TcxGridDBBandedColumn
            DataBinding.FieldName = 'MARCADO'
            Visible = False
            Position.BandIndex = 0
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
        end
        object cxDupLvl: TcxGridLevel
          GridView = cxDupView
        end
      end
      object Panel3: TPanel
        Left = 1
        Top = 262
        Width = 890
        Height = 80
        Align = alBottom
        ParentColor = True
        TabOrder = 0
        object Panel4: TPanel
          Left = 129
          Top = 1
          Width = 760
          Height = 78
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object DBText1: TDBText
            Left = 0
            Top = 26
            Width = 760
            Height = 25
            Align = alTop
            DataField = 'HISTOR'
            DataSource = dtsDuplicatas
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
            ExplicitTop = 39
            ExplicitWidth = 578
          end
          object DBText2: TDBText
            Left = 0
            Top = 13
            Width = 760
            Height = 13
            Align = alTop
            DataField = 'CODPOR'
            DataSource = dtsDuplicatas
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ExplicitTop = 26
            ExplicitWidth = 734
          end
          object DBText3: TDBText
            Left = 0
            Top = 51
            Width = 760
            Height = 13
            Align = alTop
            DataField = 'CODEVE'
            DataSource = dtsDuplicatas
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 96
            ExplicitTop = 69
          end
          object DBText4: TDBText
            Left = 0
            Top = 0
            Width = 760
            Height = 13
            Align = alTop
            DataField = 'CODCTA'
            DataSource = dtsDuplicatas
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 734
          end
          object lblValTotSelDuplicatas: TLabel
            Left = 0
            Top = 65
            Width = 760
            Height = 13
            Align = alBottom
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 32
          end
        end
        object Panel8: TPanel
          Left = 1
          Top = 1
          Width = 128
          Height = 78
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object lblTotSelDuplicatas: TLabel
            Left = 0
            Top = 65
            Width = 128
            Height = 13
            Align = alBottom
            Caption = 'Total Sele'#231#227'o:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 127
          end
          object Label6: TLabel
            Left = 0
            Top = 26
            Width = 128
            Height = 13
            Align = alTop
            Caption = 'Portador.....:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 127
          end
          object Label7: TLabel
            Left = 0
            Top = 13
            Width = 128
            Height = 13
            Align = alTop
            Caption = 'Evento.......: '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 136
          end
          object Label8: TLabel
            Left = 0
            Top = 0
            Width = 128
            Height = 13
            Align = alTop
            Caption = 'Plano Contas.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 127
          end
          object Label1: TLabel
            Left = 0
            Top = 39
            Width = 128
            Height = 13
            Align = alTop
            Caption = 'Hist'#243'rico....:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 127
          end
        end
        object btnMarcarDuplicatas: TBitBtnLocked
          Left = 705
          Top = 2
          Width = 173
          Height = 19
          Caption = '[ F5 ] Marca/Desmarca'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          TabOrder = 0
          OnClick = btnMarcarDuplicatasClick
        end
      end
    end
    object pnlAdiantamentos: TPanel
      Left = 1
      Top = 349
      Width = 892
      Height = 322
      Align = alBottom
      Caption = 'Adiatamentos'
      ParentColor = True
      TabOrder = 1
      object Panel5: TPanel
        Left = 1
        Top = 241
        Width = 890
        Height = 80
        Align = alBottom
        ParentColor = True
        TabOrder = 0
        object Panel6: TPanel
          Left = 129
          Top = 1
          Width = 760
          Height = 78
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object DBText5: TDBText
            Left = 0
            Top = 0
            Width = 760
            Height = 13
            Align = alTop
            DataField = 'CODCTA'
            DataSource = dtsAdiantamentos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ExplicitTop = 8
            ExplicitWidth = 732
          end
          object DBText6: TDBText
            Left = 0
            Top = 13
            Width = 760
            Height = 13
            Align = alTop
            DataField = 'CODEVE'
            DataSource = dtsAdiantamentos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ExplicitTop = 21
            ExplicitWidth = 732
          end
          object DBText7: TDBText
            Left = 0
            Top = 26
            Width = 760
            Height = 13
            Align = alTop
            DataField = 'CODPOR'
            DataSource = dtsAdiantamentos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ExplicitTop = 34
            ExplicitWidth = 732
          end
          object DBText8: TDBText
            Left = 0
            Top = 39
            Width = 760
            Height = 25
            Align = alTop
            DataField = 'HISTOR'
            DataSource = dtsAdiantamentos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object lblValTotSelAdiantamentos: TLabel
            Left = 0
            Top = 65
            Width = 760
            Height = 13
            Align = alBottom
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 32
          end
        end
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 128
          Height = 78
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Label13: TLabel
            Left = 0
            Top = 39
            Width = 128
            Height = 13
            Align = alTop
            Caption = 'Hist'#243'rico....:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 127
          end
          object Label14: TLabel
            Left = 0
            Top = 26
            Width = 128
            Height = 13
            Align = alTop
            Caption = 'Portador.....:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 127
          end
          object Label15: TLabel
            Left = 0
            Top = 13
            Width = 128
            Height = 13
            Align = alTop
            Caption = 'Evento.......: '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 136
          end
          object Label16: TLabel
            Left = 0
            Top = 0
            Width = 128
            Height = 13
            Align = alTop
            Caption = 'Plano Contas.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 127
          end
          object lblTotSelAdiantamentos: TLabel
            Left = 0
            Top = 65
            Width = 128
            Height = 13
            Align = alBottom
            Caption = 'Total Sele'#231#227'o:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 127
          end
        end
        object btnMarcarAdiantamento: TBitBtnLocked
          Left = 705
          Top = 2
          Width = 173
          Height = 19
          Caption = '[ ESPA'#199'O ] Marca/Desmarca'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          TabOrder = 2
          OnClick = btnMarcarAdiantamentoClick
        end
      end
      object cxAdiantamentos: TcxGrid
        Left = 1
        Top = 1
        Width = 890
        Height = 240
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = #39
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        LockedStateImageOptions.Text = 'Por favor, aguarde...'
        object cxAdtView: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxAdtViewCustomDrawCell
          DataController.DataSource = dtsAdiantamentos
          DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftCompare]
          DataController.Filter.OnChanged = cxAdtViewDataControllerFilterChanged
          DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir.'
          OptionsView.GroupByBox = False
          Bands = <
            item
              Caption = 'Adiantamentos Dispon'#237'veis do Fornecedor'
              Width = 835
            end>
          object cxColAdtDuplicata: TcxGridDBBandedColumn
            Caption = 'Duplicata'
            DataBinding.FieldName = 'DUPLIC'
            Options.Editing = False
            Width = 279
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxColAdtSerie: TcxGridDBBandedColumn
            Caption = 'S'#233'rie'
            DataBinding.FieldName = 'SERIE_'
            Options.Editing = False
            Width = 34
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxColAdtEmpresa: TcxGridDBBandedColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'CODEMP'
            Width = 64
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxColAdtDtaCad: TcxGridDBBandedColumn
            Caption = 'Data Cadastro'
            DataBinding.FieldName = 'DTACAD'
            Width = 109
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxColAdtDtaVen: TcxGridDBBandedColumn
            Caption = 'Data Vencimento'
            DataBinding.FieldName = 'DTAVEN'
            Width = 99
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxColAdtCheque: TcxGridDBBandedColumn
            Caption = 'Cheque?'
            DataBinding.FieldName = 'USACHQ'
            HeaderAlignmentHorz = taCenter
            Width = 50
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxColAdtBoleto: TcxGridDBBandedColumn
            Caption = 'Boleto?'
            DataBinding.FieldName = 'VEIOBO'
            HeaderAlignmentHorz = taCenter
            Width = 50
            Position.BandIndex = 0
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxColAdtValDup: TcxGridDBBandedColumn
            Caption = 'Vr. Duplicata'
            DataBinding.FieldName = 'VALDUP'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            Width = 136
            Position.BandIndex = 0
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object cxColMarcado: TcxGridDBBandedColumn
            DataBinding.FieldName = 'MARCADO'
            Visible = False
            Position.BandIndex = 0
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
        end
        object cxAdtLvl: TcxGridLevel
          GridView = cxAdtView
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 656
    Top = 464
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 736
    Top = 472
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 472
  end
  object dtsDuplicatas: TDataSource
    Left = 21
    Top = 130
  end
  object dtsAdiantamentos: TDataSource
    Left = 40
    Top = 432
  end
end
