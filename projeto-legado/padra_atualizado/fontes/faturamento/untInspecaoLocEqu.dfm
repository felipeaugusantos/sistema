inherited frmInspecaoLocEqu: TfrmInspecaoLocEqu
  Width = 850
  Height = 531
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Inspe'#231#227'o para loca'#231#227'o de equipamentos'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 850
  ExplicitHeight = 531
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 458
    Width = 844
    TabOrder = 3
    ExplicitTop = 458
    ExplicitWidth = 844
    inherited FlwBotoes: TFlowPanel
      Width = 840
      ExplicitWidth = 840
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
    end
    inherited btnSair: TBitBtnLocked
      Left = 761
      ExplicitLeft = 761
    end
  end
  inherited pnlStatus: TPanel
    Top = 486
    Width = 844
    TabOrder = 4
    ExplicitTop = 486
    ExplicitWidth = 844
    inherited pnlNomeForm: TPanel
      Left = 673
      ExplicitLeft = 673
    end
    inherited pnlInfo: TPanel
      Width = 673
      ExplicitWidth = 673
      object btnShowTrace: TSpeedButton
        Left = 671
        Top = 0
        Width = 23
        Height = 22
      end
      object btnHideTrace: TSpeedButton
        Left = 671
        Top = 0
        Width = 23
        Height = 22
      end
    end
  end
  object pnlBotoesSQLTrace: TPanel [2]
    Left = 0
    Top = 305
    Width = 844
    Height = 41
    TabOrder = 5
    object lblNSQLTrace: TLabel
      Left = 781
      Top = 0
      Width = 3
      Height = 14
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 844
    Height = 34
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    object lblNumCon: TLabel
      Left = 308
      Top = 7
      Width = 99
      Height = 14
      Caption = 'N'#250'mero do Contrato:'
    end
    object lblNumPed: TLabel
      Left = 152
      Top = 7
      Width = 35
      Height = 14
      Caption = 'Pedido:'
    end
    object Label1: TLabel
      Left = 12
      Top = 10
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object edtNumCon: TEditFocus
      Tag = 99
      Left = 410
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
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 193
      Top = 4
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
  object pnlDadosContrato: TPanel [4]
    Left = 0
    Top = 34
    Width = 844
    Height = 163
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblCodCli: TLabel
      Left = 14
      Top = 9
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblCodVen: TLabel
      Left = 14
      Top = 33
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
    end
    object lblEntCli: TLabel
      Left = 14
      Top = 57
      Width = 61
      Height = 14
      Caption = 'Localiza'#231#227'o:'
    end
    object lblQtde: TLabel
      Left = 499
      Top = 94
      Width = 99
      Height = 14
      Caption = 'Qtde. Equipamentos:'
    end
    object edtCodCli: TDBEditFocus
      Tag = 99
      Left = 78
      Top = 6
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'EQL_CODCLI'
      DataSource = dtsContrato
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtNomCli: TDBEditFocus
      Tag = 99
      Left = 143
      Top = 6
      Width = 516
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'CLI_NOMCLI'
      DataSource = dtsContrato
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
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TDBEditFocus
      Tag = 99
      Left = 78
      Top = 30
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'EQL_CODVEN'
      DataSource = dtsContrato
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TDBEditFocus
      Tag = 99
      Left = 143
      Top = 30
      Width = 516
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OPE_NOMOPE'
      DataSource = dtsContrato
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
      TipoTexto = ttAlfanumerico
    end
    object grbDuracao: TGroupBox
      Left = 14
      Top = 74
      Width = 419
      Height = 77
      Caption = '   Dura'#231#227'o do Contrato   '
      TabOrder = 5
      object pnlDuracaoDiariaHoras: TPanel
        Left = 2
        Top = 16
        Width = 415
        Height = 27
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lblInicio: TLabel
          Left = 8
          Top = 11
          Width = 27
          Height = 14
          Caption = 'In'#237'cio:'
        end
        object lblTermino: TLabel
          Left = 186
          Top = 8
          Width = 41
          Height = 14
          Caption = 'T'#233'rmino:'
        end
        object edtDtaIni: TDBEditFocus
          Tag = 99
          Left = 62
          Top = 5
          Width = 65
          Height = 22
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'EQL_DTAINI'
          DataSource = dtsContrato
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtHorIni: TDBEditFocus
          Tag = 99
          Left = 128
          Top = 5
          Width = 40
          Height = 22
          Color = 16768952
          DataField = 'EQL_HORINI'
          DataSource = dtsContrato
          Enabled = False
          MaxLength = 5
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtDtaFin: TDBEditFocus
          Tag = 99
          Left = 230
          Top = 5
          Width = 65
          Height = 22
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'EQL_DTAFIN'
          DataSource = dtsContrato
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtHorFin: TDBEditFocus
          Tag = 99
          Left = 296
          Top = 5
          Width = 40
          Height = 22
          Color = 16768952
          DataField = 'EQL_HORFIN'
          DataSource = dtsContrato
          Enabled = False
          MaxLength = 5
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlDuracaoMensal: TPanel
        Left = 2
        Top = 43
        Width = 415
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lblMesIni: TLabel
          Left = 7
          Top = 6
          Width = 52
          Height = 14
          Caption = 'M'#234's Inicial:'
        end
        object lblMesFin: TLabel
          Left = 179
          Top = 6
          Width = 48
          Height = 14
          Caption = 'M'#234's Final:'
        end
        object edtMesIni: TMaskEditFocus
          Tag = 99
          Left = 62
          Top = 2
          Width = 57
          Height = 22
          Color = 16768952
          Enabled = False
          EditMask = '99/9999'
          MaxLength = 7
          ReadOnly = True
          TabOrder = 0
          Text = '  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtMesFin: TMaskEditFocus
          Tag = 99
          Left = 230
          Top = 2
          Width = 59
          Height = 22
          Color = 16768952
          Enabled = False
          EditMask = '99/9999'
          MaxLength = 7
          ReadOnly = True
          TabOrder = 1
          Text = '  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
    end
    object edtQtde: TDBEditFocus
      Tag = 99
      Left = 604
      Top = 91
      Width = 55
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'EQL_QTDEQU'
      DataSource = dtsContrato
      Enabled = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtLocalizacao: TDBEditFocus
      Tag = 99
      Left = -42
      Top = -170
      Width = 581
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'ETC_ENDENT'
      DataSource = dtsContrato
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object grpDetalhesEquipamentos: TGroupBox [5]
    Left = 0
    Top = 197
    Width = 844
    Height = 108
    Align = alClient
    Caption = '   Equipamentos do Contrato   '
    TabOrder = 2
    object grdItens: TcxGridCitel
      Left = 2
      Top = 16
      Width = 840
      Height = 69
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdItensView: TcxGridDBTableViewCitel
        OnKeyDown = grdItensViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsEqlDet
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
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdItensEQD_SEQEQL: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'EQD_SEQEQL'
          Options.Editing = False
          Width = 100
        end
        object grdItensEQL_DESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'EQL_DESCRI'
          Options.Editing = False
          Width = 350
        end
        object grdItensEQL_NSERIE: TcxGridDBColumn
          Caption = 'N'#250'mero de S'#233'rie'
          DataBinding.FieldName = 'EQL_NSERIE'
          Options.Editing = False
          Width = 120
        end
        object grdItensEQD_QTDEQU: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'EQD_QTDEQU'
        end
        object grdItensEQD_STTIPS: TcxGridDBColumn
          Caption = 'Inspe'#231#227'o de sa'#237'da'
          DataBinding.FieldName = 'EQD_STTIPS'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = '+'
              Default = True
              Kind = bkText
            end>
          Properties.ReadOnly = True
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = grdItensEQD_STTIPSPropertiesButtonClick
          Width = 150
        end
        object grdItensEQD_STTIPE: TcxGridDBColumn
          Caption = 'Inspe'#231#227'o de entrada'
          DataBinding.FieldName = 'EQD_STTIPE'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = '+'
              Default = True
              Kind = bkText
            end>
          Properties.ReadOnly = True
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = grdItensEQD_STTIPEPropertiesButtonClick
          Width = 150
        end
      end
      object grdItensLvl: TcxGridLevel
        GridView = grdItensView
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 85
      Width = 840
      Height = 21
      Align = alBottom
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '   Pressione [ENTER] para realizar a inspe'#231#227'o de um equipamento'
      TabOrder = 1
    end
  end
  object grpDetalhesAcessorios: TGroupBox [6]
    Left = 0
    Top = 305
    Width = 844
    Height = 153
    Align = alBottom
    Caption = '   Acess'#243'rios do Equipamento do Contrato   '
    TabOrder = 6
    object cxGridAcessorios: TcxGridCitel
      Left = 2
      Top = 16
      Width = 840
      Height = 120
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridDBTableViewAcessorios: TcxGridDBTableViewCitel
        OnKeyDown = cxGridDBTableViewAcessoriosKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsAcessorios
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
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridDBColumnEQD_SEQACL: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'EQD_SEQACL'
          Options.Editing = False
          Width = 100
        end
        object cxGridDBColumnDESCRICAO: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRICAO'
          Options.Editing = False
          Width = 350
        end
        object cxGridDBColumnEQD_QTDACL: TcxGridDBColumn
          Caption = 'Qtd. Por Equipamento'
          DataBinding.FieldName = 'EQD_QTDACL'
          Options.Editing = False
        end
        object cxGridDBColumnEQA_QTDTOT: TcxGridDBColumn
          Caption = 'Qtde.Total'
          DataBinding.FieldName = 'EQA_QTDTOT'
        end
        object cxGridDBColumnEQD_STTIPS: TcxGridDBColumn
          Caption = 'Inspe'#231#227'o de sa'#237'da'
          DataBinding.FieldName = 'EQD_STTIPS'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = '+'
              Default = True
              Kind = bkText
            end>
          Properties.ReadOnly = True
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = cxGridDBColumnEQD_STTIPSPropertiesButtonClick
          Width = 150
        end
        object cxGridDBColumnEQD_STTIPE: TcxGridDBColumn
          Caption = 'Inspe'#231#227'o de entrada'
          DataBinding.FieldName = 'EQD_STTIPE'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = '+'
              Default = True
              Kind = bkText
            end>
          Properties.ReadOnly = True
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = cxGridDBColumnEQD_STTIPEPropertiesButtonClick
          Width = 150
        end
      end
      object cxGridAcessoriosLeve1: TcxGridLevel
        GridView = cxGridDBTableViewAcessorios
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 136
      Width = 840
      Height = 15
      Align = alBottom
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '   Pressione [ENTER] para realizar a inspe'#231#227'o de um acess'#243'rio'
      TabOrder = 1
    end
  end
  object dtsContrato: TDataSource
    Left = 744
    Top = 138
  end
  object dtsEqlDet: TDataSource
    DataSet = cdsEqlDet
    Left = 748
    Top = 86
  end
  object dtsAcessorios: TDataSource
    DataSet = cdsAcessorios
    Left = 744
    Top = 34
  end
  object cdsAcessorios: TUniClientDataSet
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
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQA_QTDTOT'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 680
    Top = 34
    object cdsAcessoriosEQD_SEQEQL: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsAcessoriosEQD_OPEIPS: TStringField
      FieldName = 'EQD_OPEIPS'
    end
    object cdsAcessoriosEQD_SUPIPE: TStringField
      FieldName = 'EQD_SUPIPE'
    end
    object cdsAcessoriosEQD_OBSIPS: TStringField
      FieldName = 'EQD_OBSIPS'
      Size = 0
    end
    object cdsAcessoriosEQD_OBSIPE: TStringField
      FieldName = 'EQD_OBSIPE'
    end
    object cdsAcessoriosEQD_QTDACL: TFloatField
      FieldName = 'EQD_QTDACL'
    end
    object cdsAcessoriosEQD_SEQCON: TStringField
      FieldName = 'EQD_SEQCON'
    end
    object tr: TStringField
      FieldName = 'EQD_STTIPE'
    end
    object cdsAcessoriosEQD_STTIPS: TStringField
      FieldName = 'EQD_STTIPS'
    end
    object cdsAcessoriosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsAcessoriosEQD_SEQACL: TStringField
      FieldName = 'EQD_SEQACL'
    end
    object cdsAcessoriosDESCRICAO: TStringField
      DisplayWidth = 100
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object cdsAcessoriosEQA_QTDTOT: TFloatField
      FieldName = 'EQA_QTDTOT'
    end
  end
  object cdsEqlDet: TUniClientDataSet
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
        Name = 'EQD_QTDEQU'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = cdsEqlDetAfterScroll
    Left = 678
    Top = 86
    object StringField1: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsEqlDetEQL_NSERIE: TStringField
      FieldName = 'EQL_NSERIE'
    end
    object cdsEqlDetEQL_DESCRI: TStringField
      DisplayWidth = 100
      FieldName = 'EQL_DESCRI'
      Size = 100
    end
    object cdsEqlDetEQD_STTIPS: TStringField
      FieldName = 'EQD_STTIPS'
    end
    object cdsEqlDetEQD_STTIPE: TStringField
      FieldName = 'EQD_STTIPE'
    end
    object cdsEqlDetAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsEqlDetEQD_QTDEQU: TFloatField
      FieldName = 'EQD_QTDEQU'
    end
  end
end
