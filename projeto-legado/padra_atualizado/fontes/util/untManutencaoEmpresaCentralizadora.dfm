inherited frmManutencaoEmpresaCentralizadora: TfrmManutencaoEmpresaCentralizadora
  Width = 670
  Height = 676
  Caption = 'Altera'#231#227'o Global para Empresa Centralizadora de Compras'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 670
  ExplicitHeight = 676
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 603
    Width = 664
    TabOrder = 1
    ExplicitTop = 603
    ExplicitWidth = 664
    inherited FlwBotoes: TFlowPanel
      Width = 583
    end
    inherited btnSair: TBitBtnLocked
      Left = 585
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 581
    end
  end
  inherited pnlStatus: TPanel
    Top = 631
    Width = 664
    TabOrder = 2
    ExplicitTop = 631
    ExplicitWidth = 664
    inherited pnlNomeForm: TPanel
      Left = 415
      Width = 249
      ExplicitLeft = 415
      ExplicitWidth = 249
    end
    inherited pnlInfo: TPanel
      Width = 415
      ExplicitWidth = 415
    end
  end
  object pnlContainer: TPanel [3]
    Left = 0
    Top = 0
    Width = 664
    Height = 603
    Align = alClient
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    ParentColor = True
    TabOrder = 0
    object pnlAcoes: TPanel
      Left = 6
      Top = 567
      Width = 652
      Height = 30
      Align = alBottom
      BevelInner = bvLowered
      ParentColor = True
      TabOrder = 2
      ExplicitTop = 563
      object btnVoltar: TBitBtnLocked
        Left = 500
        Top = 2
        Width = 75
        Height = 26
        Align = alRight
        Caption = '&Voltar'
        TabOrder = 2
        Visible = False
        OnClick = btnVoltarClick
        ExplicitLeft = 494
        ExplicitTop = 5
        ExplicitHeight = 25
      end
      object btnConfirma: TBitBtnLocked
        Left = 425
        Top = 2
        Width = 75
        Height = 26
        Align = alRight
        Caption = '&Confirma'
        TabOrder = 1
        Visible = False
        OnClick = btnConfirmaClick
        ExplicitLeft = 419
        ExplicitTop = 5
        ExplicitHeight = 25
      end
      object btnProximo: TBitBtnLocked
        Left = 575
        Top = 2
        Width = 75
        Height = 26
        Align = alRight
        Caption = '&Pr'#243'ximo'
        TabOrder = 0
        OnClick = btnProximoClick
        ExplicitLeft = 569
        ExplicitTop = 5
        ExplicitHeight = 25
      end
    end
    object pnlHeader: TPanel
      Left = 6
      Top = 6
      Width = 652
      Height = 41
      Align = alTop
      BevelInner = bvLowered
      ParentColor = True
      TabOrder = 0
      object lblTitulo: TLabel
        Left = 13
        Top = 5
        Width = 146
        Height = 14
        Caption = 'Empresas Centralizadoras'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblSubTitulo: TLabel
        Left = 27
        Top = 19
        Width = 175
        Height = 14
        Caption = 'Defina as empresas centralizadoras'
      end
    end
    object pnlContent: TPanel
      Left = 6
      Top = 47
      Width = 652
      Height = 520
      Align = alClient
      BevelInner = bvLowered
      ParentColor = True
      TabOrder = 1
      ExplicitHeight = 514
      object pnlTela3: TPanel
        Left = 2
        Top = 2
        Width = 648
        Height = 516
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        ExplicitHeight = 510
        object cxgProdutos: TcxGridCitel
          Left = 0
          Top = 0
          Width = 648
          Height = 451
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          ExplicitHeight = 445
          object cxgProdutosTableView: TcxGridDBTableViewCitel
            OnKeyDown = cxgProdutosTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsProdutos
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.Visible = True
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
            object cxgProdutosTableViewSIMNAO: TcxGridDBColumn
              Caption = 'Atualizar'
              DataBinding.FieldName = 'SIMNAO'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              Options.Filtering = False
              Options.Moving = False
              Width = 55
            end
            object cxgProdutosTableViewCODITE: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CODITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 50
            end
            object cxgProdutosTableViewDESITE: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 218
            end
            object cxgProdutosTableViewREFERE: TcxGridDBColumn
              Caption = 'Refer'#234'ncia'
              DataBinding.FieldName = 'REFERE'
              Options.Editing = False
              Options.Focusing = False
              Width = 102
            end
            object cxgProdutosTableViewDESMAR: TcxGridDBColumn
              Caption = 'Marca'
              DataBinding.FieldName = 'DESMAR'
              Options.Editing = False
              Options.Focusing = False
              Width = 140
            end
            object cxgProdutosTableViewSIGUNI: TcxGridDBColumn
              Caption = 'Un.'
              DataBinding.FieldName = 'SIGUNO'
              Options.Editing = False
              Options.Focusing = False
              Width = 34
            end
          end
          object cxgProdutosLevel: TcxGridLevel
            GridView = cxgProdutosTableView
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 451
          Width = 648
          Height = 65
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          ExplicitTop = 445
          object Label11: TLabel
            Left = 5
            Top = 2
            Width = 148
            Height = 14
            Caption = '[Espa'#231'o] - Marca/Desmarca'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label10: TLabel
            Left = 6
            Top = 37
            Width = 612
            Height = 28
            Caption = 
              'Obs: O fitro serve apenas para marcar e desmarcar itens;  Ao con' +
              'firmar ira modificar todos os itens que est'#227'o marcados para atua' +
              'lizar, mesmo que n'#227'o apare'#231'a no grid por motivo do filtro.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object btnMarcaTodos: TBitBtnLocked
            Left = 5
            Top = 15
            Width = 116
            Height = 22
            Caption = '[ F7 ] Marca Todos'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33333333FF33333333FF333993333333300033377F3333333777333993333333
              300033F77FFF3333377739999993333333333777777F3333333F399999933333
              33003777777333333377333993333333330033377F3333333377333993333333
              3333333773333333333F333333333333330033333333F33333773333333C3333
              330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
              993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
              333333333337733333FF3333333C333330003333333733333777333333333333
              3000333333333333377733333333333333333333333333333333}
            NumGlyphs = 2
            TabOrder = 0
            OnClick = btnMarcaTodosClick
          end
          object btnDesmarcaTodos: TBitBtnLocked
            Left = 121
            Top = 15
            Width = 141
            Height = 22
            Caption = '[ F6 ] Desmarca Todos'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              333333333333333333FF33333333333330003333333333333777333333333333
              300033FFFFFF3333377739999993333333333777777F3333333F399999933333
              3300377777733333337733333333333333003333333333333377333333333333
              3333333333333333333F333333333333330033333F33333333773333C3333333
              330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
              993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
              333333377F33333333FF3333C333333330003333733333333777333333333333
              3000333333333333377733333333333333333333333333333333}
            NumGlyphs = 2
            TabOrder = 1
            OnClick = btnDesmarcaTodosClick
          end
        end
      end
      object pnlTela2: TPanel
        Left = 2
        Top = 2
        Width = 648
        Height = 516
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        ExplicitHeight = 510
        object Label2: TLabel
          Left = 38
          Top = 12
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo:'
        end
        object Label3: TLabel
          Left = 54
          Top = 34
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o:'
        end
        object Label4: TLabel
          Left = 50
          Top = 56
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia:'
        end
        object Label5: TLabel
          Left = 397
          Top = 56
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
        end
        object Label6: TLabel
          Left = 73
          Top = 78
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
        end
        object Label167: TLabel
          Left = 18
          Top = 100
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = 'Grupo de Produto:'
        end
        object Label14: TLabel
          Left = 18
          Top = 122
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = 'Grupo de Compra:'
        end
        object Label31: TLabel
          Left = 311
          Top = 123
          Width = 121
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#237'vel de Giro de Estoque:'
        end
        object Label8: TLabel
          Left = 47
          Top = 144
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
        end
        object Label7: TLabel
          Left = 40
          Top = 166
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'Abrev. Fiscal:'
        end
        object Label9: TLabel
          Left = 10
          Top = 190
          Width = 96
          Height = 14
          Alignment = taRightJustify
          Caption = 'Classifica'#231#227'o de IPI:'
        end
        object ColorLabel1: TColorLabel
          Left = 381
          Top = 190
          Width = 96
          Height = 14
          Caption = '(S)im (N)'#227'o (T)odos'
          CorDestaque = clRed
        end
        object Label13: TLabel
          Left = 318
          Top = 190
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ativo:'
        end
        object lbl50: TLabel
          Left = 182
          Top = 190
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo EX IPI:'
        end
        object mskLinGru: TMaskEditFocus
          Tag = 99
          Left = 108
          Top = 8
          Width = 51
          Height = 22
          CharCase = ecUpperCase
          EditMask = '999.999;0;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          TabOrder = 0
          Text = ''
          OnKeyPress = mskLinGruKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGru: TEditFocus
          Left = 158
          Top = 8
          Width = 319
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
        object edtDesIte: TEditFocus
          Tag = 99
          Left = 108
          Top = 30
          Width = 369
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRefere: TEditFocus
          Tag = 99
          Left = 108
          Top = 52
          Width = 283
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodUni: TEditFocus
          Tag = 99
          Left = 441
          Top = 52
          Width = 36
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 4
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
          Left = 108
          Top = 74
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 5
          OnKeyPress = edtCodMarKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMar: TEditFocus
          Left = 177
          Top = 74
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtPrdGru: TEditFocus
          Tag = 99
          Left = 108
          Top = 96
          Width = 69
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
          MaxLength = 5
          ParentFont = False
          TabOrder = 7
          OnKeyPress = edtPrdGruKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
        object edtDesPrdPro: TEditFocus
          Left = 177
          Top = 96
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 8
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtGruCmp: TEditFocus
          Tag = 99
          Left = 108
          Top = 118
          Width = 69
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
          TabOrder = 9
          OnKeyPress = edtGruCmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtDesGruCmp: TEditFocus
          Left = 177
          Top = 118
          Width = 128
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
        object cmbGiroEstoque: TComboBoxFocus
          Tag = 99
          Left = 436
          Top = 118
          Width = 41
          Height = 22
          Style = csDropDownList
          DropDownCount = 4
          ItemIndex = 0
          MaxLength = 1
          TabOrder = 11
          Items.Strings = (
            ''
            'A'
            'B'
            'C')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtCodFor: TEditFocus
          Tag = 99
          Left = 108
          Top = 140
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 12
          OnKeyPress = edtCodForKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomFor: TEditFocus
          Left = 177
          Top = 140
          Width = 300
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
        object edtCodAbr: TEditFocus
          Tag = 99
          Left = 108
          Top = 162
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 14
          OnKeyPress = edtCodAbrKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesAbr: TEditFocus
          Left = 177
          Top = 162
          Width = 300
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
        object edtClaIPI: TEditFocus
          Tag = 99
          Left = 108
          Top = 184
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtStatus: TEditFocus
          Tag = 99
          Left = 352
          Top = 184
          Width = 25
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 18
          Text = 'T'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object edtExcIpi: TEditFocus
          Tag = 99
          Left = 253
          Top = 184
          Width = 59
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttInteiro
        end
      end
      object pnlTela1: TPanel
        Left = 2
        Top = 2
        Width = 648
        Height = 516
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        ExplicitHeight = 510
        object cxgEmpresas: TcxGrid
          Left = 0
          Top = 0
          Width = 648
          Height = 468
          Align = alClient
          TabOrder = 0
          ExplicitHeight = 465
          object cxgEmpresasDB: TcxGridDBTableView
            OnKeyDown = cxgEmpresasDBKeyDown
            OnKeyPress = cxgEmpresasDBKeyPress
            Navigator.Buttons.CustomButtons = <>
            OnEditKeyPress = cxgEmpresasDBEditKeyPress
            DataController.DataSource = dtsEmpresas
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
            OptionsView.GroupByBox = False
            OptionsView.HeaderHeight = 34
            object cxgEmpresasEmpresa: TcxGridDBColumn
              Caption = 'Empresa'
              DataBinding.FieldName = 'EMP_CODEMP'
              Width = 60
            end
            object cxgEmpresasDescricao: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'EMP_NOMEMP'
              Options.Editing = False
              Styles.Content = cxStyle1
              Width = 244
            end
            object cxgEmpresasEmpresaCentralizada: TcxGridDBColumn
              Caption = 'Empresa Centralizadora'
              DataBinding.FieldName = 'EMP_CODCEN'
              HeaderAlignmentHorz = taCenter
              HeaderAlignmentVert = vaTop
              Width = 82
            end
            object cxgEmpresasEmpCentralDescricao: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'EMP_DESCEN'
              Options.Editing = False
              Styles.Content = cxStyle1
              Width = 258
            end
          end
          object cxgEmpresasLevel1: TcxGridLevel
            GridView = cxgEmpresasDB
          end
        end
        object pnlIteEmbBottom: TPanel
          Left = 0
          Top = 468
          Width = 648
          Height = 48
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          ExplicitTop = 471
          object Label63: TLabel
            Left = 5
            Top = 31
            Width = 193
            Height = 14
            Caption = '[DELETE] - Para apagar um registro.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label125: TLabel
            Left = 5
            Top = 6
            Width = 185
            Height = 14
            Caption = '[INSERT] - Para incluir um registro'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label1: TLabel
            Left = 5
            Top = 18
            Width = 245
            Height = 14
            Caption = '[ENTER] ou [Clique] - Para editar um registro.'
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
  end
  object dtsEmpresas: TDataSource
    Left = 464
    Top = 148
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 416
    Top = 32
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clInactiveCaption
    end
  end
  object dtsProdutos: TDataSource
    Left = 320
    Top = 324
  end
end
