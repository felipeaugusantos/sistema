inherited frmEntEnderecamentoProduto: TfrmEntEnderecamentoProduto
  Left = 195
  Top = 179
  Width = 1233
  Height = 730
  Caption = 'Endere'#231'amento do Produto'
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 1233
  ExplicitHeight = 730
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 587
    Width = 1217
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Visible = False
    ExplicitLeft = 8
    ExplicitTop = 350
    ExplicitWidth = 1267
  end
  inherited pnlBotoes: TPanel
    Top = 625
    Width = 1217
    Height = 50
    ExplicitTop = 625
    ExplicitWidth = 1217
    ExplicitHeight = 50
    inherited FlwBotoes: TFlowPanel
      Width = 1214
      Height = 46
      Align = alLeft
      ExplicitWidth = 1214
      ExplicitHeight = 46
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 117
        ExplicitWidth = 117
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 117
        Width = 103
        ExplicitLeft = 117
        ExplicitWidth = 103
      end
      object btnConfirma: TBitBtnLocked
        Left = 220
        Top = 0
        Width = 109
        Height = 22
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 329
        Top = 0
        Width = 117
        Height = 22
        Caption = '[F9] Imprimir Itens'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
          8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
          93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
          9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
          678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
          8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
          E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
          8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
          EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
          C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
          C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
          D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
          9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
          B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
          BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
          C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
          C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
          AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnImprimirClick
      end
      object btnLocFis: TBitBtnLocked
        Left = 446
        Top = 0
        Width = 117
        Height = 22
        Caption = '[F7] Cad. Loc. F'#237'sicas'
        TabOrder = 4
        OnClick = btnLocFisClick
      end
      object btnCadArm: TBitBtnLocked
        Left = 563
        Top = 0
        Width = 117
        Height = 22
        Caption = '[F8] Cad. Armaz'#233'ns'
        TabOrder = 5
        OnClick = btnCadArmClick
      end
      object btnEntregasPendentes: TBitBtnLocked
        Left = 680
        Top = 0
        Width = 161
        Height = 22
        Caption = '[ F4 ] Entrega Futura Pendente'
        TabOrder = 6
        Visible = False
        OnClick = btnEntregasPendentesClick
      end
      object btnUmArm: TBitBtnLocked
        Left = 841
        Top = 0
        Width = 244
        Height = 22
        Caption = '[F11] Informar um armaz'#233'm para todos os itens'
        TabOrder = 7
        OnClick = btnUmArmClick
      end
      object btnEndArm: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 236
        Height = 22
        Caption = '[F6] Distribuir quantidade entre armaz'#233'ns'
        TabOrder = 8
        OnClick = btnEndArmClick
      end
      object btnMarDes: TBitBtnLocked
        Left = 236
        Top = 22
        Width = 173
        Height = 22
        Caption = '[Shift + Seta ] Marca / Desmarca'
        TabOrder = 9
        Visible = False
        OnClick = btnMarDesClick
      end
      object btnReqComprasVinculadas: TBitBtnLocked
        Left = 409
        Top = 22
        Width = 232
        Height = 22
        Caption = '[ F12 ] Requisi'#231#245'es de Compras Vinculadas'
        TabOrder = 10
        OnClick = btnReqComprasVinculadasClick
      end
      object btnQtdEti: TBitBtnLocked
        Left = 641
        Top = 22
        Width = 134
        Height = 22
        Caption = 'Qtd. Etiquetas '
        TabOrder = 11
        OnClick = btnQtdEtiClick
      end
      object btnEtiPro: TBitBtnLocked
        Left = 775
        Top = 22
        Width = 134
        Height = 22
        Caption = 'Imprimir Etiquetas'
        TabOrder = 12
        OnClick = btnEtiProClick
      end
      object btnDefineLoteEntFut: TBitBtnLocked
        Left = 909
        Top = 22
        Width = 209
        Height = 22
        Caption = '[F2] Manuten'#231#227'o Ent.Fut. Falta de Produto'
        TabOrder = 13
        OnClick = btnDefineLoteEntFutClick
      end
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 1120
      Top = 23
      Width = 92
      Height = 23
      Margins.Top = 21
      Margins.Bottom = 2
      Align = alRight
      ExplicitLeft = 1120
      ExplicitTop = 23
      ExplicitWidth = 92
      ExplicitHeight = 23
    end
  end
  inherited pnlStatus: TPanel
    Top = 675
    Width = 1217
    ExplicitTop = 675
    ExplicitWidth = 1217
    inherited pnlNomeForm: TPanel
      Left = 1046
      ExplicitLeft = 1046
    end
    inherited pnlInfo: TPanel
      Width = 1046
      ExplicitWidth = 1046
    end
  end
  inherited pnlHeader: TPanel
    Width = 1217
    Height = 34
    ExplicitWidth = 1217
    ExplicitHeight = 34
    object lblNotEle: TLabel
      Left = 10
      Top = 13
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pesq. Documento:'
    end
    object lblTipDoc: TLabel
      Left = 639
      Top = 8
      Width = 123
      Height = 14
      Caption = 'Documento Cancelado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object edtDocumento: TEditFocus
      Left = 147
      Top = 5
      Width = 486
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object btnPesDoc: TBitBtnLocked
      Left = 105
      Top = 5
      Width = 41
      Height = 22
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
      TabOrder = 0
      OnClick = btnPesDocClick
      OnEnter = btnPesDocEnter
    end
  end
  inherited pnlTail: TPanel
    Top = 590
    Width = 1217
    Height = 0
    Enabled = False
    Visible = True
    ExplicitTop = 590
    ExplicitWidth = 1217
    ExplicitHeight = 0
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 74
    Width = 1217
    Height = 371
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OnCellClick = dbgConsultaCellClick
    OnEnter = dbgConsultaEnter
    OnExit = dbgConsultaExit
    OnKeyDown = dbgConsultaKeyDown
    OnKeyPress = dbgConsultaKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'FDO_CODITE'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODBAR'
        ReadOnly = True
        Title.Caption = 'Cod. Barras'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODFAB'
        ReadOnly = True
        Title.Caption = 'C'#243'd. F'#225'brica'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESMAR'
        Title.Caption = 'Marca'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FDO_DESCRI'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 205
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FDO_REFERE'
        ReadOnly = True
        Title.Caption = 'Refer'#234'ncia'
        Width = 71
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'UNI_SIGUNI'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Unidade'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_NVLGIR'
        ReadOnly = True
        Title.Caption = 'N'#237'vel do Giro'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FDO_QTDITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Quant.'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDPAC'
        Title.Caption = ' Qtd. pacotes'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'QTDFRA'
        Title.Caption = ' Qtd. Fracionada'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ITE_SALDOS'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo Estoq.'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ARMAZE'
        ReadOnly = True
        Title.Caption = 'Armaz'#233'm'
        Width = 184
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AMZDES'
        Title.Caption = 'Descr. do Armazem'
        Width = 121
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_LOCFIS'
        Title.Caption = 'Loc. Fisica'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOT_DTAVAL'
        ReadOnly = True
        Title.Caption = 'Data Validade'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_TAMLCF'
        Title.Caption = 'Tamanho Loc. Fisica'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_LOCSUP'
        Title.Caption = 'Loc. Super Est.'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_TAMLCS'
        Title.Caption = 'Tamanho Loc. Super Est.'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDEFA'
        ReadOnly = True
        Title.Caption = 'EF. Ag. Cliente'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDEFF'
        ReadOnly = True
        Title.Caption = 'EF. Falta'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEFSER'
        Title.Caption = ' N'#250'mero S'#233'rie'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'PESOIT'
        Title.Caption = 'Peso Bruto'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EXPALT'
        Title.Caption = 'Altura'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EXPLAR'
        Title.Caption = 'Largura'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EXPPRO'
        Title.Caption = 'Profundidade'
        Width = 82
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 34
    Width = 1217
    ExplicitTop = 34
    ExplicitWidth = 1217
  end
  object prgProgresso: TProgressBar [7]
    Left = 0
    Top = 590
    Width = 1217
    Height = 12
    Align = alBottom
    Smooth = True
    TabOrder = 6
    Visible = False
  end
  object pnlGarantia: TPanel [8]
    Left = 0
    Top = 602
    Width = 1217
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 8
    object shpGarantia: TShape
      Left = 8
      Top = 3
      Width = 16
      Height = 16
      Brush.Color = clRed
    end
    object lblGarantia: TLabel
      Left = 30
      Top = 4
      Width = 209
      Height = 14
      Caption = 'Produto referente a garantia (Refugo) '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQtdEtiquetas: TLabel
      Left = 833
      Top = 3
      Width = 105
      Height = 14
      Caption = 'Quantidade etiquetas:'
      Visible = False
    end
    object lblEtiqueta: TLabel
      Left = 1014
      Top = 3
      Width = 120
      Height = 14
      Alignment = taCenter
      Caption = 'Etiqueta n'#227'o selecionada'
      Visible = False
    end
    object edtQtdEti: TEditFocus
      Tag = 99
      Left = 943
      Top = 0
      Width = 50
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      Text = '1'
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
  end
  object ntbLote: TNotebook [9]
    Left = 0
    Top = 445
    Width = 1217
    Height = 142
    Align = alBottom
    TabOrder = 7
    object TPage
      Left = 0
      Top = 0
      Caption = 'pgCadastroLote'
      object Panel2: TPanel
        Left = 665
        Top = 0
        Width = 552
        Height = 121
        Align = alRight
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object cxgLotes: TcxGrid
          Left = 0
          Top = 0
          Width = 288
          Height = 121
          Align = alClient
          TabOrder = 0
          object cxvlotes: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Nemhum lote encontrado>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object cxvlotesNUMLOT: TcxGridDBColumn
              Caption = 'Marcar'
              DataBinding.FieldName = 'MARCAD'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ImmediatePost = True
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              Properties.OnChange = cxvlotesNUMLOTPropertiesChange
              HeaderAlignmentHorz = taCenter
              Width = 62
            end
            object cxvlotesMARCAD: TcxGridDBColumn
              Caption = 'N'#250'mero do Lote'
              DataBinding.FieldName = 'NUMLOT'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 145
            end
            object cxvlotesQTDREG: TcxGridDBColumn
              Caption = 'Qtd. Produtos'
              DataBinding.FieldName = 'QTDREG'
              Visible = False
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 79
            end
          end
          object cxgLotesLevel1: TcxGridLevel
            GridView = cxvlotes
          end
        end
        object Panel3: TPanel
          Left = 288
          Top = 0
          Width = 264
          Height = 121
          Align = alRight
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object btnMarLotMarcados: TBitBtnLocked
            Left = 6
            Top = 24
            Width = 243
            Height = 25
            Caption = 'Preencher o lote nos registros marcados'
            TabOrder = 0
            OnClick = btnMarLotMarcadosClick
          end
          object btmMarLotTodos: TBitBtnLocked
            Left = 6
            Top = 52
            Width = 243
            Height = 25
            Caption = 'Preencher o lote em todos os registros'
            TabOrder = 1
            OnClick = btmMarLotTodosClick
          end
          object MemoFocus1: TMemoFocus
            Left = 6
            Top = 83
            Width = 243
            Height = 36
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Lines.Strings = (
              'O preenchimento '#233' feito somente se o produto '
              'possuir o lote selecionado.')
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            StyleElements = [seBorder]
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
            Texto = 
              'O preenchimento '#233' feito somente se o produto <<csq>>possuir o lo' +
              'te selecionado.<<csq>>'
          end
        end
      end
      object pnlInfWms: TPanel
        Left = 0
        Top = 121
        Width = 1217
        Height = 21
        Align = alBottom
        BevelOuter = bvNone
        Caption = 
          'Pressione [Enter] sobre o produto para distribuir a quantidade e' +
          'ntre os Lotes (Localiza'#231#227'o F'#237'sica)'
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        Visible = False
      end
      object dbgArmazens: TDBGridCitel
        Left = 0
        Top = 0
        Width = 665
        Height = 121
        Align = alClient
        BorderStyle = bsNone
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDrawColumnCell = dbgArmazensDrawColumnCell
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'NUMLOT'
            Title.Caption = 'Armaz'#233'm'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AMZDES'
            Title.Caption = 'Descr. do Armaz'#233'm'
            Width = 105
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LOCFIS'
            Title.Caption = 'Localiza'#231#227'o F'#237'sica'
            Width = 108
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SALDOS'
            Title.Alignment = taRightJustify
            Title.Caption = 'Saldo'
            Width = 61
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CAPACI'
            Title.Alignment = taRightJustify
            Title.Caption = 'Capacidade'
            Width = 87
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QTDITE'
            Title.Alignment = taRightJustify
            Title.Caption = 'A transferir'
            Width = 134
            Visible = True
          end>
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'pgRastreamentoLote'
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxgRastreamentoLote: TcxGridCitel
        Left = 0
        Top = 0
        Width = 509
        Height = 142
        Align = alLeft
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgRastreamentoLoteTBV: TcxGridDBTableViewCitel
          OnKeyDown = cxgRastreamentoLoteTBVKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsRastreamentoLote
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
          object cxgRastreamentoLoteNUMERO_LOTE: TcxGridDBColumn
            Caption = 'Lote Fornecedor'
            DataBinding.FieldName = 'NUMERO_LOTE'
            Options.Editing = False
            Options.Focusing = False
            Width = 279
          end
          object cxgRastreamentoLoteQUANTIDADE_ETIQUETAS: TcxGridDBColumn
            Caption = 'Quantidade Etiquetas'
            DataBinding.FieldName = 'QUANTIDADE_ETIQUETAS'
            Options.Editing = False
            Options.Focusing = False
            Width = 133
          end
          object cxgRastreamentoLoteEXCLUIR: TcxGridDBColumn
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Caption = '[F2] Excluir'
                Default = True
                Kind = bkText
                Width = 75
              end>
            Properties.ViewStyle = vsButtonsOnly
            Options.ShowEditButtons = isebAlways
            Width = 80
          end
        end
        object cxgRastreamentoLoteLVL: TcxGridLevel
          GridView = cxgRastreamentoLoteTBV
        end
      end
      object pnlRastreamentoLote: TPanel
        Tag = -1
        Left = 509
        Top = 0
        Width = 708
        Height = 142
        Align = alClient
        TabOrder = 0
        object pnlDadosLoteRastreamento: TPanel
          Left = 14
          Top = 4
          Width = 421
          Height = 135
          BevelKind = bkTile
          BevelOuter = bvNone
          TabOrder = 0
          object Label1: TLabel
            Left = 36
            Top = 19
            Width = 105
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Lote Fornecedor:'
          end
          object Label2: TLabel
            Left = 36
            Top = 47
            Width = 105
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Quantidade Etiquetas:'
          end
          object edtLoteRastreamento: TEditFocus
            Tag = 99
            Left = 147
            Top = 16
            Width = 213
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
          object edtQuantidadeEtiquetasLoteRastreamento: TCurrencyEditFocus
            Tag = 99
            Left = 147
            Top = 44
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = '0'
            StyleFocused.Color = clInfoBk
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            Width = 93
          end
          object pnlInformacaoLoteRastreamento: TPanel
            Left = 0
            Top = 111
            Width = 417
            Height = 20
            Align = alBottom
            BevelOuter = bvNone
            Caption = 
              'Pressione [ F1 ] sobre o produto para informar o(s) lote(s) de r' +
              'astreamento'
            Color = clInfoBk
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = 15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 2
            StyleElements = [seBorder]
          end
          object btnAdicionarLoteRastreamento: TBitBtnLocked
            Left = 147
            Top = 72
            Width = 213
            Height = 25
            Caption = 'Adicionar Lote Rastreamento'
            TabOrder = 3
            OnClick = btnAdicionarLoteRastreamentoClick
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 752
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 720
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 464
    Top = 232
  end
  inherited qryConsulta: TUniQuery
    Left = 508
    Top = 276
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 588
    Top = 204
  end
  inherited cdsConsulta: TUniClientDataSet
    DisableStringTrim = True
    AfterOpen = cdsConsultaAfterOpen
    AfterScroll = cdsConsultaAfterScroll
    Left = 268
    Top = 236
  end
  inherited dtsConsulta: TDataSource
    Left = 240
    Top = 136
  end
  object dtsRastreamentoLote: TDataSource
    Left = 36
    Top = 464
  end
  object tmrClose: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrCloseTimer
    Left = 888
    Top = 192
  end
end
