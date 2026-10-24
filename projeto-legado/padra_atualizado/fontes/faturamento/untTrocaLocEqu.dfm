inherited frmTrocaEquipamento: TfrmTrocaEquipamento
  Width = 1194
  Height = 794
  Caption = 'Troca de Equipamentos'
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitTop = -135
  ExplicitWidth = 1194
  ExplicitHeight = 794
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 682
    Width = 1188
    Height = 8
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 8
    ExplicitTop = 393
  end
  inherited pnlBotoes: TPanel
    Top = 737
    Width = 1188
    ExplicitTop = 737
    ExplicitWidth = 1188
    inherited FlwBotoes: TFlowPanel
      Width = 1184
      ExplicitWidth = 1184
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 111
        Height = 22
        Caption = '&[F10] Confirma'
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
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnAlterarCobranca: TBitBtnLocked
        Left = 111
        Top = 0
        Width = 162
        Height = 22
        Caption = '[F2] Alterar Cobran'#231'a'
        TabOrder = 1
        OnClick = btnAlterarCobrancaClick
      end
      object blnImprimirAditivo: TBitBtnLocked
        Left = 273
        Top = 0
        Width = 162
        Height = 22
        Caption = '[F6] Imprimir Aditivo Contrato'
        TabOrder = 2
        OnClick = blnImprimirAditivoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1105
      Top = 0
      ExplicitLeft = 1105
      ExplicitTop = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 721
    Width = 1188
    ExplicitTop = 721
    ExplicitWidth = 1188
    inherited pnlNomeForm: TPanel
      Left = 1017
      ExplicitLeft = 1017
    end
    inherited pnlInfo: TPanel
      Width = 1017
      ExplicitWidth = 1017
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1188
    Height = 59
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    object lblNumCon: TLabel
      Left = 228
      Top = 7
      Width = 99
      Height = 14
      Caption = 'N'#250'mero do Contrato:'
    end
    object lblTroca: TLabel
      Left = 80
      Top = 33
      Width = 31
      Height = 14
      Caption = 'Troca:'
    end
    object lblNumPed: TLabel
      Left = 74
      Top = 8
      Width = 35
      Height = 14
      Caption = 'Pedido:'
    end
    object edtNumCon: TEditFocus
      Tag = 99
      Left = 330
      Top = 4
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 1
      OnKeyPress = edtNumConKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttInteiro
    end
    object edtNroTrc: TEditFocus
      Tag = 99
      Left = 114
      Top = 29
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      OnKeyPress = edtNroTrcKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttInteiro
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 114
      Top = 5
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnKeyPress = edtNumPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
  end
  object pnlDadosContrato: TPanel [4]
    Left = 0
    Top = 59
    Width = 1188
    Height = 85
    Align = alTop
    TabOrder = 3
    object lblCodCli: TLabel
      Left = 14
      Top = 11
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblCodVen: TLabel
      Left = 14
      Top = 35
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
    end
    object lblEntCli: TLabel
      Left = 14
      Top = 59
      Width = 61
      Height = 14
      Caption = 'Localiza'#231#227'o:'
    end
    object edtLocalizacao: TEditFocus
      Tag = 99
      Left = 78
      Top = 56
      Width = 581
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomCli: TEditFocus
      Tag = 99
      Left = 143
      Top = 8
      Width = 516
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
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
    object edtNomVen: TEditFocus
      Tag = 99
      Left = 143
      Top = 32
      Width = 516
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
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
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 78
      Top = 8
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 78
      Top = 32
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
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
  end
  object pnlEntrada: TPanel [5]
    Left = 0
    Top = 144
    Width = 1188
    Height = 538
    Align = alClient
    TabOrder = 4
    ExplicitHeight = 567
    object Splitter3: TSplitter
      Left = 1
      Top = 121
      Width = 1186
      Height = 5
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 116
    end
    object pnTituloEntrada: TPanel
      Left = 1
      Top = 1
      Width = 1186
      Height = 18
      Align = alTop
      Caption = 'ENTRADA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnlAcessoriosEntrada: TPanel
      Left = 1
      Top = 126
      Width = 1186
      Height = 411
      Align = alClient
      TabOrder = 1
      ExplicitHeight = 440
      object lblAcessoriosEquipamento: TLabel
        Left = 1
        Top = 1
        Width = 1184
        Height = 14
        Align = alTop
        Caption = '  Acess'#243'rios do Equipamento:'
        Layout = tlCenter
        ExplicitWidth = 143
      end
      object cxGridAcessoriosEntrada: TcxGridCitel
        Left = 1
        Top = 15
        Width = 1184
        Height = 395
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitHeight = 424
        object cxGridDBTableViewAcessorios: TcxGridDBTableViewCitel
          OnKeyDown = cxGridDBTableViewAcessoriosKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxGridDBTableViewAcessoriosCustomDrawCell
          DataController.DataSource = dtsAcessoriosEntrada
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
          OptionsView.ShowEditButtons = gsebAlways
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridDBTableViewAcessoriosEQD_SEQACL: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'EQD_SEQACL'
            Options.Editing = False
            Width = 76
          end
          object cxGridDBTableViewAcessoriosEQD_DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'EQD_DESCRI'
            Options.Editing = False
            Width = 267
          end
          object cxGridDBTableViewAcessoriosEQD_QTDACL: TcxGridDBColumn
            Caption = 'Qtd. Por Equipamento'
            DataBinding.FieldName = 'EQD_QTDACL'
            Options.Editing = False
            Width = 110
          end
          object cxGridDBTableViewAcessoriosEQA_QTDTOT: TcxGridDBColumn
            Caption = 'Qtde.Total'
            DataBinding.FieldName = 'EQA_QTDTOT'
          end
          object cxGridDBTableViewAcessoriosEQD_DTAIPE: TcxGridDBColumn
            Caption = 'Inspe'#231#227'o de Entrada'
            DataBinding.FieldName = 'EQD_DTAIPE'
            Options.Editing = False
            VisibleForEditForm = bFalse
            Width = 112
          end
          object cxGridDBTableViewAcessoriosEQD_AVARIA: TcxGridDBColumn
            Caption = 'Avaria?'
            DataBinding.FieldName = 'EQD_AVARIA'
            Options.Editing = False
            Width = 45
          end
          object cxGridDBTableViewAcessoriosEQD_OBSIPE: TcxGridDBColumn
            Caption = 'Observa'#231#227'o'
            DataBinding.FieldName = 'EQD_OBSIPE'
            Options.Editing = False
            Width = 320
          end
          object cxGridDBTableViewAcessoriosEQD_CONFER: TcxGridDBColumn
            Caption = 'Conferente'
            DataBinding.FieldName = 'EQD_CONFER'
            Options.Editing = False
            Width = 180
          end
          object cxGridDBTableViewAcessoriosEQD_SUPERV: TcxGridDBColumn
            Caption = 'Supervisor'
            DataBinding.FieldName = 'EQD_SUPERV'
            Options.Editing = False
            Width = 180
          end
          object cxGridDBTableViewAcessoriosEQD_MARDES: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_MARDES'
            Visible = False
            Options.Editing = False
          end
          object cxGridDBTableViewAcessoriosEQD_IPEREA: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_IPEREA'
            Visible = False
            Options.Editing = False
          end
        end
        object cxGridAcessoriosEntradaLeve1: TcxGridLevel
          GridView = cxGridDBTableViewAcessorios
        end
      end
    end
    object pnlEquipamentoEntrada: TPanel
      Left = 1
      Top = 19
      Width = 1186
      Height = 102
      Align = alTop
      TabOrder = 2
      object lblEquipamento: TLabel
        Left = 1
        Top = 1
        Width = 1184
        Height = 14
        Align = alTop
        Caption = '  Equipamentos do Contrato - Entrada'
        Layout = tlCenter
        ExplicitWidth = 179
      end
      object cxgrdEquipamentosEntrada: TcxGridCitel
        Left = 1
        Top = 15
        Width = 1184
        Height = 86
        Align = alClient
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgrdEquipamentosEntradaView: TcxGridDBTableViewCitel
          OnKeyDown = cxgrdEquipamentosEntradaViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgrdEquipamentosEntradaViewCustomDrawCell
          DataController.DataSource = dtsEqlDetEntrada
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
          OptionsView.ShowEditButtons = gsebAlways
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgrdEquipamentosEntradaViewEQD_SEQEQL: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'EQD_SEQEQL'
            Options.Editing = False
            Width = 76
          end
          object cxgrdEquipamentosEntradaViewEQL_DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'EQL_DESCRI'
            Options.Editing = False
            Width = 267
          end
          object cxgrdEquipamentosEntradaViewEQL_NSERIE: TcxGridDBColumn
            Caption = 'N'#250'mero de S'#233'rie'
            DataBinding.FieldName = 'EQL_NSERIE'
            Options.Editing = False
            Width = 90
          end
          object cxgrdEquipamentosEntradaViewEQD_QTDEQU: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'EQD_QTDEQU'
          end
          object cxgrdEquipamentosEntradaViewEQD_DTAIPE: TcxGridDBColumn
            Caption = 'Inspe'#231#227'o de Entrada'
            DataBinding.FieldName = 'EQD_DTAIPE'
            Options.Editing = False
            VisibleForCustomization = False
            VisibleForEditForm = bFalse
            Width = 110
          end
          object cxgrdEquipamentosEntradaViewEQD_AVARIA: TcxGridDBColumn
            Caption = 'Avaria?'
            DataBinding.FieldName = 'EQD_AVARIA'
            Options.Editing = False
            Width = 45
          end
          object cxgrdEquipamentosEntradaViewEQD_OBSIPE: TcxGridDBColumn
            Caption = 'Observa'#231#245'es'
            DataBinding.FieldName = 'EQD_OBSIPE'
            Options.Editing = False
            Width = 320
          end
          object cxgrdEquipamentosEntradaViewEQD_CONFER: TcxGridDBColumn
            Caption = 'Conferente'
            DataBinding.FieldName = 'EQD_CONFER'
            Options.Editing = False
            Width = 180
          end
          object cxgrdEquipamentosEntradaViewEQD_SUPERV: TcxGridDBColumn
            Caption = 'Supervisor'
            DataBinding.FieldName = 'EQD_SUPERV'
            Options.Editing = False
            Width = 180
          end
          object cxgrdEquipamentosEntradaViewEQD_MARDES: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_MARDES'
            Visible = False
            Options.Editing = False
          end
          object cxgrdEquipamentosEntradaViewEQD_IPEREA: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_IPEREA'
            Visible = False
            HeaderGlyphAlignmentVert = vaTop
            Options.Editing = False
          end
        end
        object cxgrdEquipamentosEntradaLvl: TcxGridLevel
          GridView = cxgrdEquipamentosEntradaView
        end
      end
    end
  end
  object pnlSaida: TPanel [6]
    Left = 0
    Top = 690
    Width = 1188
    Height = 0
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 5
    ExplicitTop = 711
    object Splitter2: TSplitter
      Left = 1
      Top = 155
      Width = 1186
      Height = 5
      Cursor = crVSplit
      Align = alTop
    end
    object pnlTituloSaida: TPanel
      Left = 1
      Top = 1
      Width = 1186
      Height = 18
      Align = alTop
      Caption = 'SA'#205'DA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnlEquipamentosSaida: TPanel
      Left = 1
      Top = 19
      Width = 1186
      Height = 136
      Align = alTop
      TabOrder = 1
      object lblEquipamentosSaida: TLabel
        Left = 1
        Top = 1
        Width = 1184
        Height = 14
        Align = alTop
        Caption = '  Equipamentos do Contrato - Sa'#237'da'
        Layout = tlCenter
        ExplicitWidth = 169
      end
      object pnlEquipamento: TPanel
        Left = 1
        Top = 15
        Width = 1184
        Height = 41
        Align = alTop
        TabOrder = 0
        DesignSize = (
          1184
          41)
        object lblCodEql: TLabel
          Left = 11
          Top = 14
          Width = 64
          Height = 14
          Caption = 'Equipamento:'
        end
        object edtCodEql: TEditFocus
          Tag = 99
          Left = 77
          Top = 11
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtCodEqlKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesEql: TEditFocus
          Tag = 99
          Left = 143
          Top = 11
          Width = 938
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 67
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
        object btnAdicionar: TBitBtnLocked
          Left = 1087
          Top = 11
          Width = 93
          Height = 24
          Anchors = [akTop, akRight]
          Caption = 'Adicionar'
          TabOrder = 2
          OnClick = btnAdicionarClick
        end
      end
      object cxGridEquipamentoSaida: TcxGridCitel
        Left = 1
        Top = 56
        Width = 1184
        Height = 79
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgrdEquipamentosSaida: TcxGridDBTableViewCitel
          OnKeyDown = cxgrdEquipamentosSaidaKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgrdEquipamentosSaidaCustomDrawCell
          DataController.DataSource = dtsEqlDetSaida
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
          OptionsView.ShowEditButtons = gsebAlways
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgrdEquipamentosSaidaViewEQD_SEQEQL: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'EQD_SEQEQL'
            Options.Editing = False
            Width = 76
          end
          object cxgrdEquipamentosSaidaViewEQL_DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'EQL_DESCRI'
            Options.Editing = False
            Width = 267
          end
          object cxgrdEquipamentosSaidaViewEQL_NSERIE: TcxGridDBColumn
            Caption = 'N'#250'mero de S'#233'rie'
            DataBinding.FieldName = 'EQL_NSERIE'
            Options.Editing = False
            Width = 90
          end
          object cxgrdEquipamentosSaidaViewEQD_QTDEQU: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'EQD_QTDEQU'
          end
          object cxgrdEquipamentosSaidaViewEQD_DTAIPS: TcxGridDBColumn
            Caption = 'Inspe'#231#227'o de Sa'#237'da'
            DataBinding.FieldName = 'EQD_DTAIPS'
            Options.Editing = False
            VisibleForCustomization = False
            VisibleForEditForm = bFalse
            Width = 110
          end
          object cxgrdEquipamentosSaidaViewEQD_OBSIPS: TcxGridDBColumn
            Caption = 'Observa'#231#245'es'
            DataBinding.FieldName = 'EQD_OBSIPS'
            Options.Editing = False
            Width = 365
          end
          object cxgrdEquipamentosSaidaViewEQD_CONFER: TcxGridDBColumn
            Caption = 'Conferente'
            DataBinding.FieldName = 'EQD_CONFER'
            Options.Editing = False
            Width = 180
          end
          object cxgrdEquipamentosSaidaViewEQD_SUPERV: TcxGridDBColumn
            Caption = 'Supervisor'
            DataBinding.FieldName = 'EQD_SUPERV'
            Options.Editing = False
            Width = 180
          end
          object cxgrdEquipamentosSaidaViewEQD_MARDES: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_MARDES'
            Visible = False
            Options.Editing = False
          end
          object cxgrdEquipamentosSaidaViewEQD_IPSREA: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_IPSREA'
            Visible = False
            Options.Editing = False
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxgrdEquipamentosSaida
        end
      end
    end
    object pnlAcessoriosSaida: TPanel
      Left = 1
      Top = 160
      Width = 1186
      Height = 17
      Align = alClient
      TabOrder = 2
      object lblAcessoriosSaida: TLabel
        Left = 1
        Top = 1
        Width = 1184
        Height = 14
        Align = alTop
        Caption = '  Acess'#243'rios do Equipamento:'
        Layout = tlCenter
        ExplicitWidth = 143
      end
      object cxGridAcessoriosSaida: TcxGridCitel
        Left = 1
        Top = 15
        Width = 1184
        Height = 1
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgrdAcessoriosSaida: TcxGridDBTableViewCitel
          OnKeyDown = cxgrdAcessoriosSaidaKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgrdAcessoriosSaidaCustomDrawCell
          DataController.DataSource = dtsAcessoriosSaida
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
          OptionsView.ShowEditButtons = gsebAlways
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridDBTableViewAcessoriosSaidaEQD_SEQACL: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'EQD_SEQACL'
            Options.Editing = False
            Width = 76
          end
          object cxGridDBTableViewAcessoriosSaidaEQD_DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'EQD_DESCRI'
            Options.Editing = False
            Width = 267
          end
          object cxGridDBTableViewAcessoriosSaidaEQD_QTDACL: TcxGridDBColumn
            Caption = 'Qtd. Por Equipamento'
            DataBinding.FieldName = 'EQD_QTDACL'
            Options.Editing = False
            Width = 112
          end
          object cxGridDBTableViewAcessoriosSaidaEQA_QTDTOT: TcxGridDBColumn
            Caption = 'Qtde.Total'
            DataBinding.FieldName = 'EQA_QTDTOT'
          end
          object cxGridDBTableViewAcessoriosSaidaEQD_DTAIPS: TcxGridDBColumn
            Caption = 'Inspe'#231#227'o de Sa'#237'da'
            DataBinding.FieldName = 'EQD_DTAIPS'
            Options.Editing = False
            VisibleForEditForm = bFalse
            Width = 112
          end
          object cxGridDBTableViewAcessoriosSaidaEQD_OBSIPS: TcxGridDBColumn
            Caption = 'Observa'#231#245'es'
            DataBinding.FieldName = 'EQD_OBSIPS'
            Options.Editing = False
            Width = 365
          end
          object cxGridDBTableViewAcessoriosSaidaEQD_CONFER: TcxGridDBColumn
            Caption = 'Conferente'
            DataBinding.FieldName = 'EQD_CONFER'
            Options.Editing = False
            Width = 180
          end
          object cxGridDBTableViewAcessoriosSaidaEQD_SUPERV: TcxGridDBColumn
            Caption = 'Supervisor'
            DataBinding.FieldName = 'EQD_SUPERV'
            Options.Editing = False
            Width = 180
          end
          object cxGridDBTableViewAcessoriosSaidaEQD_MARDES: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_MARDES'
            Visible = False
            Options.Editing = False
          end
          object cxGridDBTableViewAcessoriosSaidaEQD_IPSREA: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_IPSREA'
            Visible = False
            Options.Editing = False
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxgrdAcessoriosSaida
        end
      end
    end
  end
  object pnlTotais: TPanel [7]
    Left = 0
    Top = 690
    Width = 1188
    Height = 31
    Align = alBottom
    TabOrder = 6
    object Label10: TLabel
      Left = 9
      Top = 8
      Width = 97
      Height = 14
      Caption = 'Cobran'#231'a inspe'#231#227'o:'
    end
    object edtVlrTotIpe: TEditFocus
      Left = 108
      Top = 4
      Width = 103
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      NumbersOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 688
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 8
  end
  object cdsAcessoriosEntrada: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EQD_QTDACL'
        DataType = ftFloat
      end
      item
        Name = 'EQD_OPEIPS'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_SUPIPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_OBSIPS'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_OBSIPE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_SEQEQL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_SEQACL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_STTIPS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_STTIPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_SEQCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_DTAIPE'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_AVARIA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_CONFER'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'EQD_SUPERV'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'EQD_MARDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_DESCRI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ACL_CODITE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ACL_DESITE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_VALIPE'
        DataType = ftFloat
      end
      item
        Name = 'EQD_SEQDET'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_IPEREA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQA_QTDTOT'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'cdsAcessoriosIndex1'
      end>
    Params = <>
    StoreDefs = True
    Left = 696
    Top = 66
    object cdsAcessoriosEntradaEQD_SEQEQL: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsAcessoriosEntradaEQD_OPEIPS: TStringField
      FieldName = 'EQD_OPEIPS'
    end
    object cdsAcessoriosEntradaEQD_SUPIPE: TStringField
      DisplayWidth = 100
      FieldName = 'EQD_SUPIPE'
    end
    object cdsAcessoriosEntradaEQD_OBSIPS: TStringField
      FieldName = 'EQD_OBSIPS'
      Size = 0
    end
    object cdsAcessoriosEntradaEQD_OBSIPE: TStringField
      DisplayWidth = 70
      FieldName = 'EQD_OBSIPE'
    end
    object cdsAcessoriosEntradaEQD_QTDACL: TFloatField
      FieldName = 'EQD_QTDACL'
    end
    object cdsAcessoriosEntradaEQD_SEQCON: TStringField
      FieldName = 'EQD_SEQCON'
    end
    object tr: TStringField
      DisplayWidth = 20
      FieldName = 'EQD_STTIPE'
    end
    object cdsAcessoriosEntradaEQD_STTIPS: TStringField
      FieldName = 'EQD_STTIPS'
    end
    object cdsAcessoriosEntradaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsAcessoriosEntradaEQD_SEQACL: TStringField
      FieldName = 'EQD_SEQACL'
    end
    object cdsAcessoriosEntradaEQD_DTAIPE: TDateTimeField
      FieldName = 'EQD_DTAIPE'
    end
    object cdsAcessoriosEntradaEQD_AVARIA: TStringField
      FieldName = 'EQD_AVARIA'
    end
    object cdsAcessoriosEntradaEQD_CONFER: TStringField
      DisplayWidth = 70
      FieldName = 'EQD_CONFER'
      Size = 70
    end
    object cdsAcessoriosEntradaEQD_SUPERV: TStringField
      DisplayWidth = 70
      FieldName = 'EQD_SUPERV'
      Size = 70
    end
    object cdsAcessoriosEntradaEQD_MARDES: TStringField
      FieldName = 'EQD_MARDES'
    end
    object cdsAcessoriosEntradaEQD_DESCRI: TStringField
      DisplayWidth = 100
      FieldName = 'EQD_DESCRI'
      Size = 100
    end
    object cdsAcessoriosEntradaACL_CODITE: TStringField
      FieldName = 'ACL_CODITE'
    end
    object cdsAcessoriosEntradaACL_DESITE: TStringField
      FieldName = 'ACL_DESITE'
    end
    object cdsAcessoriosEntradaEQD_VALIPE: TFloatField
      FieldName = 'EQD_VALIPE'
    end
    object cdsAcessoriosEntradaEQD_SEQDET: TStringField
      FieldName = 'EQD_SEQDET'
    end
    object cdsAcessoriosEntradaEQD_IPEREA: TStringField
      FieldName = 'EQD_IPEREA'
    end
    object cdsAcessoriosEntradaEQA_QTDTOT: TFloatField
      FieldName = 'EQA_QTDTOT'
    end
  end
  object cdsEqlDetEntrada: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EQD_SEQEQL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_DESCRI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQL_NSERIE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_DTAIPE'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_AVARIA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_OBSIPE'
        DataType = ftMemo
      end
      item
        Name = 'EQD_CONFER'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'EQD_SUPERV'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'EQD_MARDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQA_MARDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_CODITE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_DESITE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_VALIPE'
        DataType = ftFloat
      end
      item
        Name = 'EQD_SEQDET'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_IPEREA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_QTDEQU'
        DataType = ftFloat
      end
      item
        Name = 'EQD_EQUTRC'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = cdsEqlDetEntradaAfterScroll
    Left = 694
    Top = 118
    object cdsEqlDetEntradaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object StringField1: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsEqlDetEntradaEQL_NSERIE: TStringField
      FieldName = 'EQL_NSERIE'
    end
    object cdsEqlDetEntradaEQL_DESCRI: TStringField
      DisplayWidth = 100
      FieldName = 'EQL_DESCRI'
      Size = 100
    end
    object cdsEqlDetEntradaEQD_DTAIPE: TDateTimeField
      FieldName = 'EQD_DTAIPE'
    end
    object cdsEqlDetEntradaEQD_AVARIA: TStringField
      FieldName = 'EQD_AVARIA'
    end
    object cdsEqlDetEntradaEQD_OBSIPE: TMemoField
      DisplayWidth = 70
      FieldName = 'EQD_OBSIPE'
      BlobType = ftMemo
    end
    object cdsEqlDetEntradaEQD_SUPERV: TStringField
      DisplayWidth = 70
      FieldName = 'EQD_SUPERV'
      Size = 70
    end
    object cdsEqlDetEntradaEQD_CONFER: TStringField
      DisplayWidth = 70
      FieldName = 'EQD_CONFER'
      Size = 70
    end
    object cdsEqlDetEntradaEQD_MARDES: TStringField
      FieldName = 'EQD_MARDES'
    end
    object cdsEqlDetEntradaEQA_MARDES: TStringField
      FieldName = 'EQA_MARDES'
    end
    object cdsEqlDetEntradaEQL_CODITE: TStringField
      FieldName = 'EQL_CODITE'
    end
    object cdsEqlDetEntradaEQL_DESITE: TStringField
      DisplayWidth = 100
      FieldName = 'EQL_DESITE'
    end
    object cdsEqlDetEntradaEQD_VALIPE: TFloatField
      FieldName = 'EQD_VALIPE'
    end
    object cdsEqlDetEntradaEQD_SEQDET: TStringField
      FieldName = 'EQD_SEQDET'
    end
    object cdsEqlDetEntradaEQD_IPEREA: TStringField
      FieldName = 'EQD_IPEREA'
    end
    object cdsEqlDetEntradaEQD_QTDEQU: TFloatField
      FieldName = 'EQD_QTDEQU'
    end
    object cdsEqlDetEntradaEQD_EQUTRC: TStringField
      FieldName = 'EQD_EQUTRC'
    end
  end
  object dtsAcessoriosEntrada: TDataSource
    DataSet = cdsAcessoriosEntrada
    Left = 800
    Top = 66
  end
  object dtsEqlDetEntrada: TDataSource
    DataSet = cdsEqlDetEntrada
    Left = 801
    Top = 119
  end
  object cdsEqlDetSaida: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EQD_SEQEQL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_NSERIE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_DTAIPE'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_AVARIA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_OBSIPE'
        DataType = ftMemo
      end
      item
        Name = 'EQD_CONFER'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'EQD_SUPERV'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'EQD_MARDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQA_MARDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_CODITE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_DESITE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_DTAIPS'
        DataType = ftTimeStamp
      end
      item
        Name = 'EQD_OBSIPS'
        DataType = ftMemo
      end
      item
        Name = 'EQD_VALIPE'
        DataType = ftFloat
      end
      item
        Name = 'EQL_DESCRI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_IPSREA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_QTDEQU'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = cdsEqlDetEntradaAfterScroll
    Left = 694
    Top = 174
    object StringField2: TStringField
      FieldName = 'AUTOINCREM'
    end
    object StringField3: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object StringField4: TStringField
      FieldName = 'EQL_NSERIE'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'EQD_DTAIPE'
    end
    object StringField6: TStringField
      FieldName = 'EQD_AVARIA'
    end
    object MemoField1: TMemoField
      DisplayWidth = 70
      FieldName = 'EQD_OBSIPE'
      BlobType = ftMemo
    end
    object StringField7: TStringField
      DisplayWidth = 70
      FieldName = 'EQD_SUPERV'
      Size = 70
    end
    object StringField8: TStringField
      DisplayWidth = 70
      FieldName = 'EQD_CONFER'
      Size = 70
    end
    object StringField9: TStringField
      FieldName = 'EQD_MARDES'
    end
    object StringField10: TStringField
      FieldName = 'EQA_MARDES'
    end
    object StringField11: TStringField
      FieldName = 'EQL_CODITE'
    end
    object StringField12: TStringField
      DisplayWidth = 100
      FieldName = 'EQL_DESITE'
    end
    object cdsEqlDetSaidaEQD_DTAIPS: TSQLTimeStampField
      FieldName = 'EQD_DTAIPS'
    end
    object cdsEqlDetSaidaEQD_OBSIPS: TMemoField
      DisplayWidth = 70
      FieldName = 'EQD_OBSIPS'
      BlobType = ftMemo
    end
    object cdsEqlDetSaidaEQD_VALIPE: TFloatField
      FieldName = 'EQD_VALIPE'
    end
    object cdsEqlDetSaidaEQL_DESCRI: TStringField
      DisplayWidth = 100
      FieldName = 'EQL_DESCRI'
      Size = 100
    end
    object cdsEqlDetSaidaEQD_IPSREA: TStringField
      FieldName = 'EQD_IPSREA'
    end
    object cdsEqlDetSaidaEQD_QTDEQU: TFloatField
      FieldName = 'EQD_QTDEQU'
    end
  end
  object dtsEqlDetSaida: TDataSource
    DataSet = cdsEqlDetSaida
    Left = 801
    Top = 175
  end
  object cdsAcessoriosSaida: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EQD_QTDACL'
        DataType = ftFloat
      end
      item
        Name = 'EQD_OPEIPS'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_SUPIPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_OBSIPE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_SEQEQL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_SEQACL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_STTIPS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_STTIPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_SEQCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_DTAIPE'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_AVARIA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_CONFER'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'EQD_SUPERV'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'EQD_MARDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_DESCRI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ACL_CODITE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ACL_DESITE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_DTAIPS'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_OBSIPS'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_IPSREA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQA_QTDTOT'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'cdsAcessoriosIndex1'
      end>
    Params = <>
    StoreDefs = True
    Left = 696
    Top = 250
    object StringField13: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object StringField14: TStringField
      DisplayWidth = 40
      FieldName = 'EQD_OPEIPS'
    end
    object StringField15: TStringField
      DisplayWidth = 100
      FieldName = 'EQD_SUPIPE'
    end
    object StringField17: TStringField
      FieldName = 'EQD_OBSIPE'
    end
    object FloatField1: TFloatField
      FieldName = 'EQD_QTDACL'
    end
    object StringField18: TStringField
      FieldName = 'EQD_SEQCON'
    end
    object StringField19: TStringField
      DisplayWidth = 20
      FieldName = 'EQD_STTIPE'
    end
    object StringField20: TStringField
      FieldName = 'EQD_STTIPS'
    end
    object StringField21: TStringField
      FieldName = 'AUTOINCREM'
    end
    object StringField22: TStringField
      FieldName = 'EQD_SEQACL'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'EQD_DTAIPE'
    end
    object StringField23: TStringField
      FieldName = 'EQD_AVARIA'
    end
    object StringField24: TStringField
      FieldName = 'EQD_CONFER'
      Size = 70
    end
    object StringField25: TStringField
      FieldName = 'EQD_SUPERV'
      Size = 70
    end
    object StringField26: TStringField
      FieldName = 'EQD_MARDES'
    end
    object StringField27: TStringField
      DisplayWidth = 100
      FieldName = 'EQD_DESCRI'
      Size = 100
    end
    object StringField28: TStringField
      FieldName = 'ACL_CODITE'
    end
    object StringField29: TStringField
      FieldName = 'ACL_DESITE'
    end
    object cdsAcessoriosSaidaEQD_DTAIPS: TDateTimeField
      FieldName = 'EQD_DTAIPS'
    end
    object cdsAcessoriosSaidaEQD_OBSIPS: TStringField
      DisplayWidth = 100
      FieldName = 'EQD_OBSIPS'
    end
    object cdsAcessoriosSaidaEQD_IPSREA: TStringField
      FieldName = 'EQD_IPSREA'
    end
    object cdsAcessoriosSaidaEQA_QTDTOT: TFloatField
      FieldName = 'EQA_QTDTOT'
    end
  end
  object dtsAcessoriosSaida: TDataSource
    DataSet = cdsAcessoriosSaida
    Left = 800
    Top = 250
  end
  object PopupMenu1: TPopupMenu
    Left = 776
    Top = 19
  end
end
