inherited frmCadVincularCep: TfrmCadVincularCep
  Width = 1024
  Height = 780
  Caption = 'Vincular CEP'
  Position = poMainFormCenter
  Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoParentPassthrough]
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 780
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 72
    Top = 32
    Width = 129
    Height = 14
    Caption = 'tevdsfgdsfgsfdsdfsdfsdfs'
  end
  object Splitter1: TSplitter [1]
    Left = 0
    Top = 390
    Width = 1018
    Height = 6
    Cursor = crVSplit
    Align = alTop
  end
  inherited pnlBotoes: TPanel
    Top = 704
    Width = 1018
    TabOrder = 3
    ExplicitTop = 704
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
  end
  inherited pnlStatus: TPanel
    Top = 735
    Width = 1018
    ExplicitTop = 735
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  inherited pgcDados: TPageControl
    Top = 396
    Width = 1018
    Height = 308
    ActivePage = nil
    ExplicitTop = 396
    ExplicitWidth = 1018
    ExplicitHeight = 308
    inherited tbsGeral: TTabSheet
      Caption = ''
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 1010
      ExplicitHeight = 298
      object TPanel
        Left = 0
        Top = 30
        Width = 1010
        Height = 268
        Align = alBottom
        TabOrder = 0
        object dbgVinculosCep: TcxGrid
          Left = 1
          Top = 1
          Width = 1008
          Height = 266
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object dbgVinculosCepView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.GroupByBox = False
          end
        end
      end
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 704
    Width = 1018
    Height = 31
    Align = alBottom
    Color = clGray
    ParentBackground = False
    TabOrder = 5
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 5
      Width = 117
      Height = 22
      Caption = '[ F10 ] Gerar V'#237'nculo'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object pnlBotoesSairExcluir: TPanel
      Left = 832
      Top = 1
      Width = 185
      Height = 29
      Align = alRight
      BevelOuter = bvNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      object btnExcluirVinculo: TBitBtnLocked
        Left = 0
        Top = 5
        Width = 89
        Height = 22
        Caption = '&Excluir V'#237'nculos'
        TabOrder = 0
        OnClick = btnExcluirVinculoClick
      end
      object BitBtnLocked1: TBitBtnLocked
        Left = 100
        Top = 5
        Width = 77
        Height = 22
        Caption = '&Sair'
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B0000000100000001000000520000006B
          0000006B0800106B0800008C080000940800007B100000731800087B180008A5
          1800089C21001094290010A529001084310010A5310018A5310010A539001884
          4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
          4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
          5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
          AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
          BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
          CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
          D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
          DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
          F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
          FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
          FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
          5959595959595959595932514E32323232325959595959595959325266655F5F
          5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
          1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
          21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
          44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
          372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
          4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
          6A4A231B59595959595959592626262626262359595959595959}
        TabOrder = 1
        OnClick = btnSairClick
      end
    end
  end
  object Panel2: TPanel [6]
    Left = 0
    Top = 396
    Width = 1018
    Height = 308
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 2
    object Panel7: TPanel
      Left = 1
      Top = 29
      Width = 1016
      Height = 278
      Align = alClient
      Caption = 'Panel7'
      TabOrder = 1
      object dbgVinculoCEP: TDBGridCitel
        Left = 1
        Top = 1
        Width = 1014
        Height = 276
        Align = alClient
        DataSource = dtsVinculoCep
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit, dgMultiSelect]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgVinculoCEPKeyDown
        CorZebra = clMoneyGreen
        Zebra = True
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'VIN_ESTADO'
            Title.Caption = 'Estado'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VIN_NOMCID'
            Title.Caption = 'Cidade'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VIN_BAIRRO'
            Title.Caption = 'Bairro'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VIN_ENDERE'
            Title.Caption = 'Endere'#231'o'
            Width = 400
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VIN_C_E_P_'
            Title.Caption = 'CEP'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VIN_SECCIO'
            Title.Caption = 'Seccionamento'
            Width = 300
            Visible = True
          end>
      end
    end
    object Panel8: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 28
      Align = alTop
      TabOrder = 0
      object pnlBotoesIncluirCancelar: TPanel
        Left = 830
        Top = 1
        Width = 185
        Height = 26
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object BitBtnLocked2: TBitBtnLocked
          Left = 4
          Top = 2
          Width = 85
          Height = 22
          Caption = '&Incluir'
          TabOrder = 0
          OnClick = BitBtnLocked2Click
        end
        object BitBtnLocked3: TBitBtnLocked
          Left = 95
          Top = 2
          Width = 85
          Height = 22
          Caption = '&Cancelar'
          TabOrder = 1
          OnClick = BitBtnLocked3Click
        end
      end
    end
  end
  object pnlDados: TPanel [7]
    Left = 0
    Top = 0
    Width = 1018
    Height = 390
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object pnlEstadoCidade: TPanel
      Left = 1
      Top = 1
      Width = 505
      Height = 388
      Align = alLeft
      TabOrder = 0
      object Splitter2: TSplitter
        Left = 1
        Top = 176
        Width = 503
        Height = 6
        Cursor = crVSplit
        Align = alTop
      end
      object gpbCidade: TGroupBox
        Left = 1
        Top = 182
        Width = 503
        Height = 205
        Align = alClient
        Caption = ' Cidade '
        TabOrder = 1
        object Panel5: TPanel
          Left = 2
          Top = 38
          Width = 499
          Height = 165
          Align = alClient
          Caption = 'Panel5'
          TabOrder = 1
          object cxgCidades: TcxGrid
            Left = 1
            Top = 1
            Width = 497
            Height = 163
            Align = alClient
            TabOrder = 0
            object cxgCidadesTv: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsCidade
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              object cxgCidadesTvSELECIONADO: TcxGridDBColumn
                DataBinding.FieldName = 'SELECIONADO'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.Alignment = taRightJustify
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Properties.OnChange = cxgCidadesTvSELECIONADOPropertiesChange
                Width = 30
                IsCaptionAssigned = True
              end
              object cxgCidadesTvNome: TcxGridDBColumn
                Caption = 'Cidade'
                DataBinding.FieldName = 'CID_NOMCID'
                Options.Editing = False
                Width = 350
              end
              object cxgCidadesTvCodigo: TcxGridDBColumn
                DataBinding.FieldName = 'CID_CODCID'
                Visible = False
              end
            end
            object cxgCidadesLv: TcxGridLevel
              GridView = cxgCidadesTv
            end
          end
        end
        object edtPesqCidade: TEdit
          Left = 2
          Top = 16
          Width = 499
          Height = 22
          Align = alTop
          CharCase = ecUpperCase
          TabOrder = 0
          OnChange = edtPesqCidadeChange
        end
      end
      object gpbEstado: TGroupBox
        Left = 1
        Top = 1
        Width = 503
        Height = 175
        Align = alTop
        Caption = ' Estado'
        TabOrder = 0
        object Panel3: TPanel
          Left = 2
          Top = 38
          Width = 499
          Height = 135
          Align = alClient
          Caption = 'Panel3'
          TabOrder = 1
          object cxGridEstados: TcxGrid
            Left = 1
            Top = 1
            Width = 497
            Height = 133
            Align = alClient
            TabOrder = 0
            object cxGridEstadosTv: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsUf
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.Deleting = False
              OptionsData.Inserting = False
              object cxGridEstadosTvSELECIONADO: TcxGridDBColumn
                DataBinding.FieldName = 'SELECIONADO'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.Alignment = taRightJustify
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Properties.OnChange = cxGridEstadosTvSELECIONADOPropertiesChange
                Width = 30
                IsCaptionAssigned = True
              end
              object cxGridEstadosTvESTADONOME: TcxGridDBColumn
                Caption = 'Nome do Estado'
                DataBinding.FieldName = 'ESTADO_NOME'
                Options.Editing = False
                Width = 140
              end
              object cxGridEstadosTvUF: TcxGridDBColumn
                Caption = 'UF'
                DataBinding.FieldName = 'ESTADO_UF'
                Options.Editing = False
                Width = 50
              end
            end
            object cxGridEstadosLv: TcxGridLevel
              GridView = cxGridEstadosTv
            end
          end
        end
        object edtPesqEstado: TEdit
          Left = 2
          Top = 16
          Width = 499
          Height = 22
          Align = alTop
          CharCase = ecUpperCase
          TabOrder = 0
          OnChange = edtPesqEstadoChange
        end
      end
    end
    object pnlBairroEndereco: TPanel
      Left = 506
      Top = 1
      Width = 511
      Height = 388
      Align = alClient
      TabOrder = 1
      object spltBairro: TSplitter
        Left = 8
        Top = 200
        Width = 260
        Height = 6
        Align = alNone
      end
      object gpbBairro: TGroupBox
        Left = 1
        Top = 29
        Width = 272
        Height = 173
        Caption = ' Bairro  '
        TabOrder = 0
        object Panel4: TPanel
          Left = 2
          Top = 38
          Width = 268
          Height = 107
          Align = alClient
          Caption = 'Panel4'
          TabOrder = 1
          object cxgBairro: TcxGrid
            Left = 1
            Top = 1
            Width = 266
            Height = 105
            Align = alClient
            TabOrder = 0
            ExplicitLeft = 2
            ExplicitTop = 4
            object cxgBairroTv: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsBairro
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              object cxgBairroTvSELECIONADO: TcxGridDBColumn
                DataBinding.FieldName = 'SELECIONADO'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.Alignment = taRightJustify
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Properties.OnChange = cxgBairroTvSELECIONADOPropertiesChange
                Width = 30
                IsCaptionAssigned = True
              end
              object cxgBairroTvEstado: TcxGridDBColumn
                Caption = 'UF'
                DataBinding.FieldName = 'ESTADO'
                Options.Editing = False
                Width = 40
              end
              object cxgBairroTvBairro: TcxGridDBColumn
                Caption = 'Bairro'
                DataBinding.FieldName = 'NOME_BAIRRO'
                Options.Editing = False
                Width = 380
              end
              object cxgBairroTvCidade: TcxGridDBColumn
                Caption = 'Cidade'
                DataBinding.FieldName = 'NOME_CIDADE'
                Options.Editing = False
                Width = 200
              end
            end
            object cxgBairroLv: TcxGridLevel
              GridView = cxgBairroTv
            end
          end
        end
        object edtPesqBairro: TEdit
          Left = 2
          Top = 16
          Width = 268
          Height = 22
          Align = alTop
          CharCase = ecUpperCase
          TabOrder = 0
          OnChange = edtPesqBairroChange
        end
        object pnlBairro: TPanel
          Left = 2
          Top = 145
          Width = 268
          Height = 26
          Align = alBottom
          Color = 16770261
          ParentBackground = False
          TabOrder = 2
          object btnOpcoesSelecaoBairro: TcxButton
            Left = 3
            Top = 2
            Width = 148
            Height = 22
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            DropDownMenu = popOpcoesSelecaoBairro
            Kind = cxbkDropDownButton
            TabOrder = 0
          end
        end
      end
      object gpbEndereco: TGroupBox
        Left = 1
        Top = 204
        Width = 272
        Height = 182
        Caption = ' Endere'#231'o '
        TabOrder = 1
        object Panel6: TPanel
          Left = 2
          Top = 38
          Width = 268
          Height = 142
          Align = alClient
          Caption = 'Panel6'
          TabOrder = 1
          object Panel9: TPanel
            Left = 1
            Top = 115
            Width = 266
            Height = 26
            Align = alBottom
            TabOrder = 0
            object btnOpcoesSelecao: TcxButton
              Left = 2
              Top = 2
              Width = 148
              Height = 22
              Caption = 'Op'#231#245'es de Sele'#231#227'o'
              DropDownMenu = popOpcoesSelecao
              Kind = cxbkDropDownButton
              TabOrder = 0
            end
          end
          object cxgEndereco: TcxGrid
            Left = 1
            Top = 1
            Width = 266
            Height = 114
            Align = alClient
            TabOrder = 1
            ExplicitLeft = 2
            ExplicitTop = -3
            object cxgEnderecoTv: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsEndereco
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              object cxgEnderecoTvSelecionado: TcxGridDBColumn
                DataBinding.FieldName = 'SELECIONADO'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.Alignment = taRightJustify
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 30
                IsCaptionAssigned = True
              end
              object cxgEnderecoTvEndereco: TcxGridDBColumn
                Caption = 'Endere'#231'o'
                DataBinding.FieldName = 'NOME_ENDERECO'
                Options.Editing = False
                Width = 380
              end
              object cxgEnderecoTvBairro: TcxGridDBColumn
                Caption = 'Bairro'
                DataBinding.FieldName = 'NOME_BAIRRO'
                Options.Editing = False
                Width = 260
              end
              object cxgEnderecoTvCidade: TcxGridDBColumn
                Caption = 'Cidade'
                DataBinding.FieldName = 'NOME_CIDADE'
                Options.Editing = False
                Width = 160
              end
              object cxgEnderecoTvUf: TcxGridDBColumn
                Caption = 'UF'
                DataBinding.FieldName = 'ESTADO'
                Options.Editing = False
                Width = 40
              end
              object cxgEnderecoTvSeccionamento: TcxGridDBColumn
                Caption = 'Seccionamento'
                DataBinding.FieldName = 'SECCIONAMENTO'
                Options.Editing = False
                Width = 180
              end
            end
            object cxgEnderecoLv: TcxGridLevel
              GridView = cxgEnderecoTv
            end
          end
        end
        object edtPesqEndereco: TEdit
          Left = 2
          Top = 16
          Width = 268
          Height = 22
          Align = alTop
          CharCase = ecUpperCase
          TabOrder = 0
          OnChange = edtPesqEnderecoChange
        end
      end
      object gpbCep: TGroupBox
        Left = 276
        Top = 31
        Width = 228
        Height = 350
        Caption = ' CEP '
        TabOrder = 2
        object Panel10: TPanel
          Left = 2
          Top = 38
          Width = 224
          Height = 310
          Align = alClient
          Caption = 'Panel6'
          TabOrder = 1
          object Panel11: TPanel
            Left = 1
            Top = 283
            Width = 222
            Height = 26
            Align = alBottom
            TabOrder = 0
            object cxButton1: TcxButton
              Left = 2
              Top = 2
              Width = 148
              Height = 22
              Caption = 'Op'#231#245'es de Sele'#231#227'o'
              DropDownMenu = popOpcoesSelecaoCep
              Kind = cxbkDropDownButton
              TabOrder = 0
            end
          end
          object cxgEnderecoCep: TcxGrid
            Left = 1
            Top = 1
            Width = 222
            Height = 282
            Align = alClient
            TabOrder = 1
            ExplicitTop = -3
            object cxgEnderecoCepTv: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsEnderecoCEP
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              object cxgEnderecoCepTvSelecionado: TcxGridDBColumn
                DataBinding.FieldName = 'SELECIONADO'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.Alignment = taRightJustify
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 30
                IsCaptionAssigned = True
              end
              object cxgEnderecoCepTvCEP: TcxGridDBColumn
                Caption = 'CEP'
                DataBinding.FieldName = 'C_E_P'
                Options.Editing = False
                Width = 70
              end
              object cxgEnderecoCepTvEndereco: TcxGridDBColumn
                Caption = 'Endere'#231'o'
                DataBinding.FieldName = 'NOME_ENDERECO'
                Options.Editing = False
                Width = 380
              end
              object cxgEnderecoCepTvBairro: TcxGridDBColumn
                Caption = 'Bairro'
                DataBinding.FieldName = 'NOME_BAIRRO'
                Options.Editing = False
                Width = 250
              end
              object cxgEnderecoCepTvCidade: TcxGridDBColumn
                Caption = 'Cidade'
                DataBinding.FieldName = 'NOME_CIDADE'
                Options.Editing = False
                Width = 160
              end
              object cxgEnderecoCepTvUF: TcxGridDBColumn
                Caption = 'UF'
                DataBinding.FieldName = 'ESTADO'
                Options.Editing = False
                Width = 40
              end
              object cxgEnderecoCepTvSeccionamento: TcxGridDBColumn
                Caption = 'Seccionamento'
                DataBinding.FieldName = 'SECCIONAMENTO'
                Options.Editing = False
                Width = 180
              end
            end
            object cxgEnderecoCepLv: TcxGridLevel
              GridView = cxgEnderecoCepTv
            end
          end
        end
        object edtPesqCep: TEdit
          Left = 2
          Top = 16
          Width = 224
          Height = 22
          Align = alTop
          CharCase = ecUpperCase
          TabOrder = 0
          OnChange = edtPesqCepChange
        end
      end
      object rgFiltro: TRadioGroup
        Left = 1
        Top = 1
        Width = 509
        Height = 31
        Align = alTop
        Caption = ' Filtrar por ? '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Bairro e Endere'#231'o'
          'CEP')
        TabOrder = 3
        OnClick = rgFiltroClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 536
    Top = 360
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 392
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 392
  end
  object dtsUf: TDataSource
    DataSet = cdsUF
    Left = 115
    Top = 65
  end
  object dtsCidade: TDataSource
    DataSet = cdsCidades
    Left = 203
    Top = 272
  end
  object dtsBairro: TDataSource
    DataSet = qryBairro
    Left = 579
    Top = 56
  end
  object dtsEndereco: TDataSource
    DataSet = qryEndereco
    Left = 523
    Top = 248
  end
  object qryBairro: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT UPPER(b.nome) AS NOME_BAIRRO, '
      '       b.id_bairro AS CODIGO_BAIRRO, '
      '       UPPER(c.nome)  AS NOME_CIDADE,'
      '       UPPER(b.id_uf) AS ESTADO,'
      '       0 AS SELECIONADO'
      '   FROM bairro b'
      '   INNER JOIN cidade c ON c.id_cidade = b.id_cidade'
      '  WHERE  b.id_cidade IN (&ID_CIDADE)'
      '/*LIKE*/'
      'ORDER BY b.nome')
    CachedUpdates = True
    Left = 523
    Top = 56
    MacroData = <
      item
        Name = 'ID_CIDADE'
      end>
    object qryBairroNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
    end
    object qryBairroNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
    end
    object qryBairroESTADO: TStringField
      FieldName = 'ESTADO'
    end
    object qryBairroCODIGO_BAIRRO: TIntegerField
      FieldName = 'CODIGO_BAIRRO'
    end
    object qryBairroSELECIONADO: TLargeintField
      FieldName = 'SELECIONADO'
    end
  end
  object qryEndereco: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM( '
      ' SELECT UPPER(e.nome) AS NOME_ENDERECO'
      '      , UPPER(e.seccionamento) AS SECCIONAMENTO'
      '      , UPPER(e.cep) AS C_E_P'
      '      , UPPER(c.nome) AS NOME_CIDADE'
      '      , UPPER(c.id_uf) AS ESTADO '
      '      , UPPER(b.nome) AS NOME_BAIRRO'
      '      , 0 AS SELECIONADO'
      '   FROM endereco e'
      '   INNER JOIN bairro b ON b.id_bairro = e.id_bairro'
      '   INNER JOIN cidade c ON c.id_cidade = b.id_cidade'
      '  WHERE b.id_bairro = :ID_BAIRRO'
      'UNION'
      ' SELECT UPPER(cid.nome) AS NOME_ENDERECO'
      '      , NULL AS SECCIONAMENTO'
      '      , UPPER(cid.cep) AS C_E_P'
      '      , UPPER(cid.nome) AS NOME_CIDADE'
      '      , UPPER(cid.id_uf) AS ESTADO '
      '      , UPPER(cid.nome) AS NOME_BAIRRO   '
      '      , 0 AS SELECIONADO'
      'FROM cidade cid'
      'WHERE cid.id_cidade IN('
      ' SELECT b.id_cidade'
      '   FROM endereco e'
      '   INNER JOIN bairro b ON b.id_bairro = e.id_bairro'
      '   INNER JOIN cidade c ON c.id_cidade = b.id_cidade'
      '  WHERE b.id_bairro = :ID_BAIRRO'
      ')'
      ') AS ENDERECO'
      'WHERE ifnull(C_E_P, "") <> ""'
      ' /*LIKE*/ '
      ' /*FILTRO_GRID*/'
      'ORDER BY NOME_CIDADE, NOME_ENDERECO'
      ' ')
    CachedUpdates = True
    Left = 595
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_BAIRRO'
        Value = nil
      end>
    object qryEnderecoNOME_ENDERECO: TStringField
      FieldName = 'NOME_ENDERECO'
    end
    object qryEnderecoSECCIONAMENTO: TStringField
      FieldName = 'SECCIONAMENTO'
    end
    object qryEnderecoC_E_P: TStringField
      FieldName = 'C_E_P'
    end
    object qryEnderecoNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
    end
    object qryEnderecoESTADO: TStringField
      FieldName = 'ESTADO'
    end
    object qryEnderecoNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
    end
    object qryEnderecoSELECIONADO: TLargeintField
      FieldName = 'SELECIONADO'
    end
  end
  object dtsVinculoCep: TDataSource
    DataSet = cdsVinculoCep
    Left = 184
    Top = 477
  end
  object qryVinculoCep: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT '
      '  * '
      'FROM'
      '  VINREG '
      'WHERE VIN_CODREG = :CODREG '
      '  AND VIN_CODEMP = :CODEMP ')
    Left = 264
    Top = 565
    ParamData = <
      item
        DataType = ftString
        Name = 'CODREG'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'CODEMP'
        ParamType = ptInput
        Value = nil
      end>
    object qryVinculoCepAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryVinculoCepVIN_CODREG: TStringField
      FieldName = 'VIN_CODREG'
    end
    object qryVinculoCepVIN_CODEMP: TStringField
      FieldName = 'VIN_CODEMP'
    end
    object qryVinculoCepVIN_ESTADO: TStringField
      FieldName = 'VIN_ESTADO'
    end
    object qryVinculoCepVIN_NOMCID: TStringField
      DisplayWidth = 40
      FieldName = 'VIN_NOMCID'
      Size = 40
    end
    object qryVinculoCepVIN_BAIRRO: TStringField
      FieldName = 'VIN_BAIRRO'
      Size = 60
    end
    object qryVinculoCepVIN_ENDERE: TStringField
      FieldName = 'VIN_ENDERE'
      Size = 150
    end
    object qryVinculoCepVIN_C_E_P_: TStringField
      FieldName = 'VIN_C_E_P_'
    end
    object qryVinculoCepVIN_SECCIO: TStringField
      FieldName = 'VIN_SECCIO'
      Size = 40
    end
  end
  object dspVinculoCep: TUniDataSetProvider
    DataSet = qryVinculoCep
    Options = []
    Left = 144
    Top = 549
  end
  object popOpcoesSelecao: TPopupMenu
    Left = 673
    Top = 430
    object mnuDesmarcarTodos: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = mnuDesmarcarTodosClick
    end
    object mnuSelecionarTodos: TMenuItem
      Caption = 'Selecionar Todos'
      OnClick = mnuSelecionarTodosClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuInverterSelecao: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = mnuInverterSelecaoClick
    end
  end
  object cdsVinculoCep: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspVinculoCep'
    Left = 105
    Top = 478
    object cdsVinculoCepVIN_ESTADO: TStringField
      FieldName = 'VIN_ESTADO'
    end
    object cdsVinculoCepVIN_NOMCID: TStringField
      FieldName = 'VIN_NOMCID'
      Size = 40
    end
    object cdsVinculoCepVIN_BAIRRO: TStringField
      FieldName = 'VIN_BAIRRO'
      Size = 60
    end
    object cdsVinculoCepVIN_ENDERE: TStringField
      FieldName = 'VIN_ENDERE'
      Size = 150
    end
    object cdsVinculoCepVIN_C_E_P_: TStringField
      FieldName = 'VIN_C_E_P_'
    end
    object cdsVinculoCepVIN_SECCIO: TStringField
      FieldName = 'VIN_SECCIO'
      Size = 40
    end
    object cdsVinculoCepAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
  object popOpcoesSelecaoBairro: TPopupMenu
    Left = 801
    Top = 430
    object mnuDesmarcarTodosBairro: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = mnuDesmarcarTodosBairroClick
    end
    object mnuSelecionarTodosBairro: TMenuItem
      Caption = 'Selecionar Todos'
      OnClick = mnuSelecionarTodosBairroClick
    end
    object MenuItem3: TMenuItem
      Caption = '-'
    end
    object mnuInverterSelecaoBairro: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = mnuInverterSelecaoBairroClick
    end
  end
  object cdsUF: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 86
    Top = 65
    object cdsUFESTADO_NOME: TStringField
      FieldName = 'ESTADO_NOME'
    end
    object cdsUFESTADO_UF: TStringField
      FieldName = 'ESTADO_UF'
    end
    object cdsUFSELECIONADO: TLargeintField
      FieldName = 'SELECIONADO'
    end
  end
  object cdsCidades: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 158
    Top = 273
    object cdsCidadesCID_NOMCID: TStringField
      FieldName = 'CID_NOMCID'
    end
    object cdsCidadesCID_CODCID: TIntegerField
      FieldName = 'CID_CODCID'
    end
    object cdsCidadesSELECIONADO: TLargeintField
      FieldName = 'SELECIONADO'
    end
  end
  object qryEnderecoCEP: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM( '
      ' SELECT UPPER(e.nome) AS NOME_ENDERECO'
      '      , UPPER(e.seccionamento) AS SECCIONAMENTO'
      '      , UPPER(e.cep) AS C_E_P'
      '      , UPPER(c.nome) AS NOME_CIDADE'
      '      , UPPER(c.id_uf) AS ESTADO '
      '      , UPPER(b.nome) AS NOME_BAIRRO'
      '      , 0 AS SELECIONADO'
      '   FROM endereco e'
      '   INNER JOIN bairro b ON b.id_bairro = e.id_bairro'
      '   INNER JOIN cidade c ON c.id_cidade = b.id_cidade'
      '  WHERE c.id_cidade in (&ID_CIDADE)'
      'UNION'
      ' SELECT UPPER(cid.nome) AS NOME_ENDERECO'
      '      , NULL AS SECCIONAMENTO'
      '      , UPPER(cid.cep) AS C_E_P'
      '      , UPPER(cid.nome) AS NOME_CIDADE'
      '      , UPPER(cid.id_uf) AS ESTADO '
      '      , UPPER(cid.nome) AS NOME_BAIRRO   '
      '      , 0 AS SELECIONADO'
      'FROM cidade cid'
      'WHERE cid.id_cidade IN('
      ' SELECT b.id_cidade'
      '   FROM endereco e'
      '   INNER JOIN bairro b ON b.id_bairro = e.id_bairro'
      '   INNER JOIN cidade c ON c.id_cidade = b.id_cidade'
      '  WHERE c.id_cidade in (&ID_CIDADE)'
      ')'
      ') AS ENDERECO'
      'WHERE ifnull(C_E_P, "") <> ""'
      ' &FILTRO_CEP'
      'ORDER BY NOME_CIDADE, C_E_P, NOME_ENDERECO'
      ' ')
    CachedUpdates = True
    Left = 867
    Top = 152
    MacroData = <
      item
        Name = 'ID_CIDADE'
      end
      item
        Name = 'FILTRO_CEP'
      end>
    object qryEnderecoCEPSELECIONADO: TLargeintField
      FieldName = 'SELECIONADO'
    end
    object StringField3: TStringField
      FieldName = 'C_E_P'
    end
    object StringField1: TStringField
      FieldName = 'NOME_ENDERECO'
    end
    object StringField6: TStringField
      FieldName = 'NOME_BAIRRO'
    end
    object StringField4: TStringField
      FieldName = 'NOME_CIDADE'
    end
    object StringField5: TStringField
      FieldName = 'ESTADO'
    end
    object StringField2: TStringField
      FieldName = 'SECCIONAMENTO'
    end
  end
  object dtsEnderecoCEP: TDataSource
    DataSet = qryEnderecoCEP
    Left = 867
    Top = 104
  end
  object popOpcoesSelecaoCep: TPopupMenu
    Left = 801
    Top = 489
    object mnuDesmarcarTodosCep: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = mnuDesmarcarTodosCepClick
    end
    object mnuSelecionarTodosCep: TMenuItem
      Caption = 'Selecionar Todos'
      OnClick = mnuSelecionarTodosCepClick
    end
    object MenuItem4: TMenuItem
      Caption = '-'
    end
    object mnuInverterSelecaoCep: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = mnuInverterSelecaoCepClick
    end
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    PopupMenus = <>
    Left = 68
    Top = 279
  end
end
