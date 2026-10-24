inherited frmManutencaoLocEqu: TfrmManutencaoLocEqu
  Width = 869
  Height = 757
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Manuten'#231#227'o de Inspe'#231#227'o de Libera'#231#227'o de Equipamentos'
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 869
  ExplicitHeight = 757
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 684
    Width = 863
    ExplicitTop = 684
    ExplicitWidth = 863
    inherited FlwBotoes: TFlowPanel
      Width = 859
      ExplicitWidth = 859
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 135
        Height = 25
        Caption = '[ F10 ] &Confirma'
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
        OnClick = btnConfirmarClick
      end
      object btnAlterarInspecao: TBitBtnLocked
        Left = 135
        Top = 0
        Width = 135
        Height = 25
        Caption = '[ F5 ] Alterar Inspe'#231#227'o'
        TabOrder = 1
        OnClick = btnAlterarInspecaoClick
      end
      object btnAlterarCobranca: TBitBtnLocked
        Left = 270
        Top = 0
        Width = 135
        Height = 25
        Caption = '[ F6 ] Alterar Cobran'#231'a'
        TabOrder = 2
        OnClick = btnAlterarCobrancaClick
      end
      object btnCancelarInspecao: TBitBtnLocked
        Left = 405
        Top = 0
        Width = 135
        Height = 25
        Caption = '[ F7 ] Cancelar Inspe'#231#227'o'
        TabOrder = 3
        OnClick = btnCancelarInspecaoClick
      end
      object btnAlterarContrato: TBitBtnLocked
        Left = 540
        Top = 0
        Width = 135
        Height = 25
        Caption = '[ F8 ] Alterar Contrato'
        TabOrder = 4
        OnClick = btnAlterarContratoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 780
      ExplicitLeft = 780
    end
  end
  inherited pnlStatus: TPanel
    Top = 712
    Width = 863
    ExplicitTop = 712
    ExplicitWidth = 863
    inherited pnlNomeForm: TPanel
      Left = 692
      ExplicitLeft = 692
    end
    inherited pnlInfo: TPanel
      Width = 692
      ExplicitWidth = 692
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 863
    Height = 36
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    object lblNumCon: TLabel
      Left = 306
      Top = 8
      Width = 99
      Height = 14
      Caption = 'N'#250'mero do Contrato:'
    end
    object lblNumPed: TLabel
      Left = 156
      Top = 8
      Width = 35
      Height = 14
      Caption = 'Pedido:'
    end
    object Label4: TLabel
      Left = 12
      Top = 10
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object edtNumCon: TEditFocus
      Tag = 99
      Left = 411
      Top = 6
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
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 196
      Top = 6
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 76
      Top = 6
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
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDadosContrato: TPanel [3]
    Left = 0
    Top = 36
    Width = 863
    Height = 85
    Align = alTop
    TabOrder = 3
    DesignSize = (
      863
      85)
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
    object Label3: TLabel
      Left = 787
      Top = 37
      Width = 55
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Qtd. Equip.:'
    end
    object edtLocalizacao: TEditFocus
      Tag = 99
      Left = 78
      Top = 57
      Width = 329
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
      Left = 144
      Top = 8
      Width = 263
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
    object edtNomVen: TEditFocus
      Tag = 99
      Left = 144
      Top = 32
      Width = 263
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
    object edtQtdEqu: TEditFocus
      Tag = 99
      Left = 787
      Top = 54
      Width = 65
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 413
      Top = 6
      Width = 349
      Height = 73
      Anchors = [akTop, akRight]
      Caption = '   Dura'#231#227'o do Contrato   '
      TabOrder = 6
      object Label1: TLabel
        Left = 14
        Top = 22
        Width = 27
        Height = 14
        Caption = 'In'#237'cio:'
      end
      object Label2: TLabel
        Left = 187
        Top = 22
        Width = 41
        Height = 14
        Caption = 'T'#233'rmino:'
      end
      object lblMesIni: TLabel
        Left = 12
        Top = 46
        Width = 52
        Height = 14
        Caption = 'M'#234's Inicial:'
      end
      object lblMesFin: TLabel
        Left = 137
        Top = 46
        Width = 48
        Height = 14
        Caption = 'M'#234's Final:'
      end
      object edtDtaIni: TEditFocus
        Tag = 99
        Left = 47
        Top = 17
        Width = 65
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
      object edtHorIni: TEditFocus
        Tag = 99
        Left = 114
        Top = 17
        Width = 40
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
      object edtDtaFin: TEditFocus
        Tag = 99
        Left = 234
        Top = 17
        Width = 65
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
      object edtHorFin: TEditFocus
        Tag = 99
        Left = 301
        Top = 17
        Width = 40
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
      object edtMesIni: TMaskEditFocus
        Tag = 99
        Left = 70
        Top = 42
        Width = 55
        Height = 22
        Color = 16768952
        Enabled = False
        EditMask = '99/9999'
        MaxLength = 7
        ReadOnly = True
        TabOrder = 4
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtMesFin: TMaskEditFocus
        Tag = 99
        Left = 188
        Top = 42
        Width = 59
        Height = 22
        Color = 16768952
        Enabled = False
        EditMask = '99/9999'
        MaxLength = 7
        ReadOnly = True
        TabOrder = 5
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
  end
  object pnlPrincipal: TPanel [4]
    Left = 0
    Top = 121
    Width = 863
    Height = 563
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object Splitter1: TSplitter
      AlignWithMargins = True
      Left = 3
      Top = 326
      Width = 857
      Height = 7
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      ExplicitTop = 242
      ExplicitWidth = 852
    end
    object pnlSaida: TPanel
      Left = 0
      Top = 0
      Width = 863
      Height = 323
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object pnlTitSaida: TPanel
        Left = 0
        Top = 0
        Width = 863
        Height = 17
        Align = alTop
        Caption = 'Sa'#237'da'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object pnlEquipamentoSaida: TPanel
        Left = 0
        Top = 17
        Width = 863
        Height = 160
        Align = alTop
        TabOrder = 1
        object pnlTitEquSaida: TPanel
          Left = 1
          Top = 1
          Width = 861
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = '  Equipamentos do Contrato - Sa'#237'da'
          TabOrder = 0
        end
        object cxGridEquipamentosSaida: TcxGridCitel
          Left = 1
          Top = 25
          Width = 861
          Height = 134
          Align = alClient
          TabOrder = 1
          OnEnter = cxGridEquipamentosSaidaEnter
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxGrdEquipamentosSaidaView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
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
            object cxGrdEquipamentosSaidaViewAUTOINCREM: TcxGridDBColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
              Options.Editing = False
            end
            object cxGrdEquipamentosSaidaViewEQD_SEQEQL: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'EQD_SEQEQL'
              Options.Editing = False
            end
            object cxGrdEquipamentosSaidaViewEQL_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'EQL_DESCRI'
              Options.Editing = False
            end
            object cxGrdEquipamentosSaidaViewEQL_NSERIE: TcxGridDBColumn
              Caption = 'N'#250'mero de S'#233'rie'
              DataBinding.FieldName = 'EQL_NSERIE'
              Options.Editing = False
            end
            object cxGrdEquipamentosSaidaViewEQD_QTDEQU: TcxGridDBColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'EQD_QTDEQU'
            end
            object cxGrdEquipamentosSaidaViewEQD_DTAIPS: TcxGridDBColumn
              Caption = 'Inspecao Sa'#237'da'
              DataBinding.FieldName = 'EQD_DTAIPS'
              Options.Editing = False
              Options.ShowEditButtons = isebNever
            end
            object cxGrdEquipamentosSaidaViewEQD_CNDIPS: TcxGridDBColumn
              Caption = 'Em perfeitas condi'#231#245'es?'
              DataBinding.FieldName = 'EQD_CNDIPS'
              Options.Editing = False
              Width = 130
            end
            object cxGrdEquipamentosSaidaViewEQD_OBSIPS: TcxGridDBColumn
              Caption = 'Observa'#231#245'es'
              DataBinding.FieldName = 'EQD_OBSIPS'
              Options.Editing = False
            end
            object cxGrdEquipamentosSaidaViewEQD_CONFER: TcxGridDBColumn
              Caption = 'Conferente'
              DataBinding.FieldName = 'EQD_CONFER'
              Options.Editing = False
            end
            object cxGrdEquipamentosSaidaViewEQD_SUPERV: TcxGridDBColumn
              Caption = 'Supervisor'
              DataBinding.FieldName = 'EQD_SUPERV'
              Options.Editing = False
            end
            object cxGrdEquipamentosSaidaViewEQD_MARDES: TcxGridDBColumn
              DataBinding.FieldName = 'EQD_MARDES'
              Visible = False
            end
            object cxGrdEquipamentosSaidaViewEQA_MARDES: TcxGridDBColumn
              DataBinding.FieldName = 'EQA_MARDES'
              Visible = False
            end
          end
          object cxGridLevel2: TcxGridLevel
            GridView = cxGrdEquipamentosSaidaView
          end
        end
      end
      object pnlDocumentoSaida: TPanel
        Left = 0
        Top = 291
        Width = 863
        Height = 32
        Align = alBottom
        Alignment = taLeftJustify
        TabOrder = 2
        DesignSize = (
          863
          32)
        object lblDocumentoSaida: TLabel
          Left = 14
          Top = 8
          Width = 107
          Height = 14
          Anchors = [akLeft, akTop, akRight]
          Caption = ' Documento de Envio: '
        end
        object btnCancelarDocSaida: TBitBtnLocked
          Left = 371
          Top = 4
          Width = 171
          Height = 25
          Caption = 'Efetuar Cancelamento'
          TabOrder = 0
          OnClick = btnCancelarDocSaidaClick
        end
      end
      object pnlAcessoriosSaida: TPanel
        Left = 0
        Top = 177
        Width = 863
        Height = 114
        Align = alClient
        TabOrder = 3
        object pnlDescricaoAcessorioSaida: TPanel
          Left = 1
          Top = 1
          Width = 861
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = '  Acess'#243'rios do Equipamento: '
          TabOrder = 0
        end
        object cxGridAcessoriosSaida: TcxGridCitel
          Left = 1
          Top = 25
          Width = 861
          Height = 88
          Align = alClient
          TabOrder = 1
          OnEnter = cxGridAcessoriosSaidaEnter
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxGridAcessoriosSaidaView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
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
            object cxGridAcessoriosSaidaViewAUTOINCREM: TcxGridDBColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
              Options.Editing = False
            end
            object cxGridAcessoriosSaidaViewEQD_SEQEQL: TcxGridDBColumn
              DataBinding.FieldName = 'EQD_SEQEQL'
              Visible = False
              Options.Editing = False
            end
            object cxGridAcessoriosSaidaViewEQD_SEQACL: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'EQD_SEQACL'
              Options.Editing = False
            end
            object cxGridAcessoriosSaidaViewEQD_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'EQD_DESCRI'
              Options.Editing = False
            end
            object cxGridAcessoriosSaidaViewEQD_QTDACL: TcxGridDBColumn
              Caption = 'Qtd. Por Equipamento'
              DataBinding.FieldName = 'EQD_QTDACL'
              Options.Editing = False
            end
            object cxGridAcessoriosSaidaViewEQA_QTDTOT: TcxGridDBColumn
              Caption = 'Qtde.Total'
              DataBinding.FieldName = 'EQA_QTDTOT'
            end
            object cxGridAcessoriosSaidaViewEQD_DTAIPS: TcxGridDBColumn
              Caption = 'Inspe'#231#227'o de Sa'#237'da'
              DataBinding.FieldName = 'EQD_DTAIPS'
              Options.Editing = False
              Options.ShowEditButtons = isebNever
            end
            object cxGridAcessoriosSaidaViewEQD_CNDIPS: TcxGridDBColumn
              Caption = 'Avarias?'
              DataBinding.FieldName = 'EQD_CNDIPS'
              Options.Editing = False
            end
            object cxGridAcessoriosSaidaViewEQD_OBSIPS: TcxGridDBColumn
              Caption = 'Observa'#231#245'es'
              DataBinding.FieldName = 'EQD_OBSIPS'
              Options.Editing = False
              Width = 604
            end
            object cxGridAcessoriosSaidaViewEQD_CONFER: TcxGridDBColumn
              Caption = 'Conferente'
              DataBinding.FieldName = 'EQD_CONFER'
              Options.Editing = False
            end
            object cxGridAcessoriosSaidaViewEQD_SUPERV: TcxGridDBColumn
              Caption = 'Supervisor'
              DataBinding.FieldName = 'EQD_SUPERV'
              Options.Editing = False
            end
            object cxGridAcessoriosSaidaViewEQD_MARDES: TcxGridDBColumn
              DataBinding.FieldName = 'EQD_MARDES'
              Visible = False
            end
          end
          object cxGridAcessoriosSaidaLvl: TcxGridLevel
            GridView = cxGridAcessoriosSaidaView
          end
        end
      end
    end
    object pnlEntrada: TPanel
      Left = 0
      Top = 336
      Width = 863
      Height = 227
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      TabOrder = 1
      object pnlTitEntrada: TPanel
        Left = 0
        Top = 0
        Width = 863
        Height = 17
        Align = alTop
        Caption = 'Entrada'
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
        Left = 0
        Top = 173
        Width = 863
        Height = 22
        Align = alClient
        TabOrder = 1
        object pnlDescricaoAcessorioEntrada: TPanel
          Left = 1
          Top = 1
          Width = 861
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = '  Acess'#243'rios do Equipamento: '
          TabOrder = 0
        end
        object cxGridAcessoriosEntrada: TcxGridCitel
          Left = 1
          Top = 25
          Width = 861
          Height = 8
          Align = alClient
          TabOrder = 1
          OnEnter = cxGridAcessoriosEntradaEnter
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxGridAcessoriosEntradaView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
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
            object cxGridAcessoriosEntradaViewAUTOINCREM: TcxGridDBColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
              Options.Editing = False
            end
            object cxGridAcessoriosEntradaViewEQD_SEQCON: TcxGridDBColumn
              DataBinding.FieldName = 'EQD_SEQCON'
              Visible = False
              Options.Editing = False
            end
            object cxGridAcessoriosEntradaViewEQD_SEQEQL: TcxGridDBColumn
              DataBinding.FieldName = 'EQD_SEQEQL'
              Visible = False
              Options.Editing = False
            end
            object cxGridAcessoriosEntradaViewEQD_SEQACL: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'EQD_SEQACL'
              Options.Editing = False
            end
            object cxGridAcessoriosEntradaViewEQD_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'EQD_DESCRI'
              Options.Editing = False
            end
            object cxGridAcessoriosEntradaViewEQD_QTDACL: TcxGridDBColumn
              Caption = 'Qtd. Por Equipamento'
              DataBinding.FieldName = 'EQD_QTDACL'
              Options.Editing = False
            end
            object cxGridAcessoriosEntradaViewEQA_QTDTOT: TcxGridDBColumn
              Caption = 'Qtde.Total'
              DataBinding.FieldName = 'EQA_QTDTOT'
            end
            object cxGridAcessoriosEntradaViewEQD_DTAIPE: TcxGridDBColumn
              Caption = 'Inspe'#231#227'o de Entrada'
              DataBinding.FieldName = 'EQD_DTAIPE'
              Options.Editing = False
              Options.ShowEditButtons = isebNever
            end
            object cxGridAcessoriosEntradaViewEQD_OBSIPE: TcxGridDBColumn
              AlternateCaption = '604'
              Caption = 'Observa'#231#245'es'
              DataBinding.FieldName = 'EQD_OBSIPE'
              Options.Editing = False
            end
            object cxGridAcessoriosEntradaViewEQD_CONFER: TcxGridDBColumn
              Caption = 'Conferente'
              DataBinding.FieldName = 'EQD_CONFER'
              Options.Editing = False
            end
            object cxGridAcessoriosEntradaViewEQD_SUPERV: TcxGridDBColumn
              Caption = 'Supervisor'
              DataBinding.FieldName = 'EQD_SUPERV'
              Options.Editing = False
            end
            object cxGridAcessoriosEntradaViewEQD_AVAIPE: TcxGridDBColumn
              Caption = 'Avaria?'
              DataBinding.FieldName = 'EQD_AVAIPE'
            end
            object cxGridAcessoriosEntradaViewEQD_VALIPE: TcxGridDBColumn
              Caption = 'Cobran'#231'a'
              DataBinding.FieldName = 'EQD_VALIPE'
              Options.Editing = False
            end
            object cxGridAcessoriosEntradaViewEQD_MARDES: TcxGridDBColumn
              DataBinding.FieldName = 'EQD_MARDES'
              Visible = False
            end
          end
          object cxGridLevel3: TcxGridLevel
            GridView = cxGridAcessoriosEntradaView
          end
        end
      end
      object pnlEquipamentoEntrada: TPanel
        Left = 0
        Top = 17
        Width = 863
        Height = 156
        Align = alTop
        Caption = 'pnlEquipamentoEntrada'
        TabOrder = 2
        object cxGridEquipamentosEntrada: TcxGridCitel
          Left = 1
          Top = 25
          Width = 861
          Height = 130
          Align = alClient
          TabOrder = 0
          OnEnter = cxGridEquipamentosEntradaEnter
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxGridEquipamentosEntradaView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
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
            object cxGridEquipamentosEntradaViewAUTOINCREM: TcxGridDBColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
              Options.Editing = False
            end
            object cxGridEquipamentosEntradaViewEQD_SEQEQL: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'EQD_SEQEQL'
              Options.Editing = False
            end
            object cxGridEquipamentosEntradaViewEQL_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'EQL_DESCRI'
              Options.Editing = False
            end
            object cxGridEquipamentosEntradaViewEQL_NSERIE: TcxGridDBColumn
              Caption = 'N'#250'mero de S'#233'rie'
              DataBinding.FieldName = 'EQL_NSERIE'
              Options.Editing = False
            end
            object cxGridEquipamentosEntradaViewEQD_QTDEQU: TcxGridDBColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'EQD_QTDEQU'
            end
            object cxGridEquipamentosEntradaViewEQD_DTAIPE: TcxGridDBColumn
              Caption = 'Inspe'#231#227'o de Entrada'
              DataBinding.FieldName = 'EQD_DTAIPE'
              Options.Editing = False
              Options.ShowEditButtons = isebNever
            end
            object cxGridEquipamentosEntradaViewEQD_OBSIPE: TcxGridDBColumn
              Caption = 'Observa'#231#245'es'
              DataBinding.FieldName = 'EQD_OBSIPE'
              Options.Editing = False
            end
            object cxGridEquipamentosEntradaViewEQD_CONFER: TcxGridDBColumn
              Caption = 'Conferente'
              DataBinding.FieldName = 'EQD_CONFER'
              Options.Editing = False
            end
            object cxGridEquipamentosEntradaViewEQD_SUPERV: TcxGridDBColumn
              Caption = 'Supervisor'
              DataBinding.FieldName = 'EQD_SUPERV'
              Options.Editing = False
            end
            object cxGridEquipamentosEntradaViewEQD_AVAIPE: TcxGridDBColumn
              Caption = 'Avaria?'
              DataBinding.FieldName = 'EQD_AVAIPE'
            end
            object cxGridEquipamentosEntradaViewEQD_VALIPE: TcxGridDBColumn
              Caption = 'Cobran'#231'a'
              DataBinding.FieldName = 'EQD_VALIPE'
              Options.Editing = False
            end
            object cxGridEquipamentosEntradaViewEQD_MARDES: TcxGridDBColumn
              DataBinding.FieldName = 'EQD_MARDES'
              Visible = False
            end
            object cxGridEquipamentosEntradaViewEQA_MARDES: TcxGridDBColumn
              DataBinding.FieldName = 'EQA_MARDES'
              Visible = False
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridEquipamentosEntradaView
          end
        end
        object pnltitEquEntrada: TPanel
          Left = 1
          Top = 1
          Width = 861
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = '  Equipamentos do Contrato - Entrada'
          TabOrder = 1
        end
      end
      object pnlDocumentoEntrada: TPanel
        Left = 0
        Top = 195
        Width = 863
        Height = 32
        Align = alBottom
        Alignment = taLeftJustify
        TabOrder = 3
        DesignSize = (
          863
          32)
        object lblDocumentoEntrada: TLabel
          Left = 14
          Top = 7
          Width = 119
          Height = 14
          Anchors = [akLeft, akTop, akRight]
          Caption = ' Documento de Retorno: '
        end
        object btnCancelarDocEntrada: TBitBtnLocked
          Left = 371
          Top = 3
          Width = 171
          Height = 25
          Caption = 'Efetuar Cancelamento'
          TabOrder = 0
          OnClick = btnCancelarDocEntradaClick
        end
      end
    end
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
        Size = 20
      end
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
        Name = 'EQD_STTIPS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_SEQACL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_SEQCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_DTAIPS'
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
        Name = 'EQD_CNDIPS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_OBSIPS'
        DataType = ftMemo
      end
      item
        Name = 'EQD_ATUIPS'
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
    Left = 160
    Top = 306
    object cdsAcessoriosSaidaEQD_SEQEQL: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsAcessoriosSaidaEQD_OPEIPS: TStringField
      FieldName = 'EQD_OPEIPS'
    end
    object cdsAcessoriosSaidaEQD_QTDACL: TFloatField
      FieldName = 'EQD_QTDACL'
    end
    object cdsAcessoriosSaidaEQD_SEQCON: TStringField
      FieldName = 'EQD_SEQCON'
    end
    object cdsAcessoriosSaidaEQD_STTIPS: TStringField
      FieldName = 'EQD_STTIPS'
    end
    object cdsAcessoriosSaidaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsAcessoriosSaidaEQD_SEQACL: TStringField
      FieldName = 'EQD_SEQACL'
    end
    object cdsAcessoriosSaidaEQD_AVARIA: TStringField
      FieldName = 'EQD_AVARIA'
    end
    object cdsAcessoriosSaidaEQD_CONFER: TStringField
      FieldName = 'EQD_CONFER'
    end
    object cdsAcessoriosSaidaEQD_SUPERV: TStringField
      FieldName = 'EQD_SUPERV'
    end
    object cdsAcessoriosSaidaEQD_MARDES: TStringField
      FieldName = 'EQD_MARDES'
    end
    object cdsAcessoriosSaidaEQD_DESCRI: TStringField
      DisplayWidth = 70
      FieldName = 'EQD_DESCRI'
    end
    object cdsAcessoriosSaidaEQD_DTAIPS: TDateTimeField
      FieldName = 'EQD_DTAIPS'
    end
    object cdsAcessoriosSaidaEQD_CNDIPS: TStringField
      FieldName = 'EQD_CNDIPS'
    end
    object cdsAcessoriosSaidaEQD_OBSIPS: TMemoField
      FieldName = 'EQD_OBSIPS'
      BlobType = ftMemo
    end
    object cdsAcessoriosSaidaEQD_ATUIPS: TStringField
      FieldName = 'EQD_ATUIPS'
    end
    object cdsAcessoriosSaidaEQA_QTDTOT: TFloatField
      FieldName = 'EQA_QTDTOT'
    end
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
        Name = 'EQD_DTAIPS'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_OBSIPS'
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
        Name = 'EQD_CNDIPS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_NUMENV'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_ESPENV'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_EMPENV'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_SERENV'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_ATUIPS'
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
    AfterScroll = cdsEqlDetSaidaAfterScroll
    Left = 158
    Top = 238
    object cdsEqlDetSaidaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object StringField1: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsEqlDetSaidaEQL_NSERIE: TStringField
      FieldName = 'EQL_NSERIE'
    end
    object cdsEqlDetSaidaEQL_DESCRI: TStringField
      DisplayWidth = 70
      FieldName = 'EQL_DESCRI'
    end
    object cdsEqlDetSaidaEQD_DTAIPS: TDateTimeField
      FieldName = 'EQD_DTAIPS'
    end
    object cdsEqlDetSaidaEQD_OBSIPS: TMemoField
      DisplayWidth = 100
      FieldName = 'EQD_OBSIPS'
      BlobType = ftMemo
    end
    object cdsEqlDetSaidaEQD_SUPERV: TStringField
      FieldName = 'EQD_SUPERV'
    end
    object cdsEqlDetSaidaEQD_CONFER: TStringField
      FieldName = 'EQD_CONFER'
    end
    object cdsEqlDetSaidaEQD_MARDES: TStringField
      FieldName = 'EQD_MARDES'
    end
    object cdsEqlDetSaidaEQA_MARDES: TStringField
      FieldName = 'EQA_MARDES'
    end
    object cdsEqlDetSaidaEQD_CNDIPS: TStringField
      FieldName = 'EQD_CNDIPS'
    end
    object cdsEqlDetSaidaEQD_NUMENV: TStringField
      FieldName = 'EQD_NUMENV'
    end
    object cdsEqlDetSaidaEQD_ESPENV: TStringField
      FieldName = 'EQD_ESPENV'
    end
    object cdsEqlDetSaidaEQD_SERENV: TStringField
      FieldName = 'EQD_SERENV'
    end
    object cdsEqlDetSaidaEQD_EMPENV: TStringField
      FieldName = 'EQD_EMPENV'
    end
    object cdsEqlDetSaidaEQD_ATUIPS: TStringField
      FieldName = 'EQD_ATUIPS'
    end
    object cdsEqlDetSaidaEQD_QTDEQU: TFloatField
      FieldName = 'EQD_QTDEQU'
    end
  end
  object dtsAcessoriosSaida: TDataSource
    DataSet = cdsAcessoriosSaida
    Left = 280
    Top = 306
  end
  object dtsEqlDetSaida: TDataSource
    DataSet = cdsEqlDetSaida
    Left = 281
    Top = 239
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
        Name = 'EQD_VALIPE'
        DataType = ftFloat
      end
      item
        Name = 'EQD_NUMRET'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_ESPRET'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_EMPRET'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_SERRET'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_ATUIPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_AVAIPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_CODCLI'
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
    Left = 150
    Top = 398
    object StringField2: TStringField
      FieldName = 'AUTOINCREM'
    end
    object StringField3: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object StringField4: TStringField
      FieldName = 'EQL_NSERIE'
    end
    object StringField5: TStringField
      DisplayWidth = 70
      FieldName = 'EQL_DESCRI'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'EQD_DTAIPE'
    end
    object MemoField1: TMemoField
      DisplayWidth = 100
      FieldName = 'EQD_OBSIPE'
      BlobType = ftMemo
    end
    object StringField6: TStringField
      FieldName = 'EQD_SUPERV'
    end
    object StringField7: TStringField
      FieldName = 'EQD_CONFER'
    end
    object StringField8: TStringField
      FieldName = 'EQD_MARDES'
    end
    object StringField9: TStringField
      FieldName = 'EQA_MARDES'
    end
    object cdsEqlDetEntradaEQD_VALIPE: TFloatField
      FieldName = 'EQD_VALIPE'
    end
    object cdsEqlDetEntradaEQD_NUMRET: TStringField
      FieldName = 'EQD_NUMRET'
    end
    object cdsEqlDetEntradaEQD_ESPRET: TStringField
      FieldName = 'EQD_ESPRET'
    end
    object cdsEqlDetEntradaEQD_EMPRET: TStringField
      FieldName = 'EQD_EMPRET'
    end
    object cdsEqlDetEntradaEQD_SERRET: TStringField
      FieldName = 'EQD_SERRET'
    end
    object cdsEqlDetEntradaEQD_ATUIPE: TStringField
      FieldName = 'EQD_ATUIPE'
    end
    object cdsEqlDetEntradaEQD_AVAIPE: TStringField
      FieldName = 'EQD_AVAIPE'
    end
    object cdsEqlDetEntradaEQD_CODCLI: TStringField
      FieldName = 'EQD_CODCLI'
    end
    object cdsEqlDetEntradaEQD_QTDEQU: TFloatField
      FieldName = 'EQD_QTDEQU'
    end
  end
  object cdsAcessoriosEntrada: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EQD_QTDACL'
        DataType = ftFloat
      end
      item
        Name = 'EQD_SUPIPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_OBSIPE'
        DataType = ftMemo
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
        Name = 'EQD_VALIPE'
        DataType = ftFloat
      end
      item
        Name = 'EQD_ATUIPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_AVAIPE'
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
    Left = 152
    Top = 498
    object cdsAcessoriosEntradaEQD_VALIPE: TFloatField
      FieldName = 'EQD_VALIPE'
    end
    object cdsAcessoriosEntradaEQD_OBSIPE: TMemoField
      DisplayWidth = 100
      FieldName = 'EQD_OBSIPE'
      BlobType = ftMemo
    end
    object cdsAcessoriosEntradaEQD_DESCRI: TStringField
      DisplayWidth = 70
      FieldName = 'EQD_DESCRI'
      Size = 100
    end
    object cdsAcessoriosEntradaEQD_MARDES: TStringField
      DisplayWidth = 100
      FieldName = 'EQD_MARDES'
    end
    object cdsAcessoriosEntradaEQD_CONFER: TStringField
      FieldName = 'EQD_CONFER'
    end
    object cdsAcessoriosEntradaEQD_AVARIA: TStringField
      FieldName = 'EQD_AVARIA'
    end
    object cdsAcessoriosEntradaEQD_SUPERV: TStringField
      FieldName = 'EQD_SUPERV'
    end
    object cdsAcessoriosEntradaEQD_DTAIPE: TDateTimeField
      FieldName = 'EQD_DTAIPE'
    end
    object cdsAcessoriosEntradaEQD_SEQACL: TStringField
      FieldName = 'EQD_SEQACL'
    end
    object cdsAcessoriosEntradaEQD_STTIPE: TStringField
      FieldName = 'EQD_STTIPE'
    end
    object cdsAcessoriosEntradaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsAcessoriosEntradaEQD_SEQCON: TStringField
      FieldName = 'EQD_SEQCON'
    end
    object cdsAcessoriosEntradaEQD_QTDACL: TFloatField
      FieldName = 'EQD_QTDACL'
    end
    object cdsAcessoriosEntradaEQD_SUPIPE: TStringField
      FieldName = 'EQD_SUPIPE'
    end
    object cdsAcessoriosEntradaEQD_SEQEQL: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsAcessoriosEntradaEQD_ATUIPE: TStringField
      FieldName = 'EQD_ATUIPE'
    end
    object cdsAcessoriosEntradaEQD_AVAIPE: TStringField
      FieldName = 'EQD_AVAIPE'
    end
    object cdsAcessoriosEntradaEQA_QTDTOT: TFloatField
      FieldName = 'EQA_QTDTOT'
    end
  end
  object dtsEqlDetEntrada: TDataSource
    DataSet = cdsEqlDetEntrada
    Left = 273
    Top = 399
  end
  object dtsAcessoriosEntrada: TDataSource
    DataSet = cdsAcessoriosEntrada
    Left = 280
    Top = 498
  end
end
